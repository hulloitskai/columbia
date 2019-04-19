# helm

This directory contains a CA and certificates that are used to secure the
connection between `helm` and `helm-tiller`. One such certificate-key pair (i.e.
`helm.cert.pem` and `helm.key.pem`) is needed for each client to access
`helm-tiller`.

## Creating Certificates

Follow the instructions at
[`helm/docs/tiller_ssl.md`](https://github.com/helm/helm/blob/master/docs/tiller_ssl.md).
You should end up with the following files:

```bash
ca.cert.pem      # CA certificate
ca.key.pem       # CA secret key       [*]
tiller.cert.pem  # tiller public cert
tiller.key.pem   # tiller private key  [*]

## For every client:
[client].cert.pem  # client public cert
[client].key.pem   # client private key  [*]
```

> Take care to secure the files marked with `[*]`!

## Installing Helm with TLS

First, ensure that the `helm` namespace exists, and to configure RBAC for
the `helm-tiller` service account:

```bash
kb apply -f ../workloads/helm/ && \
kb apply -f ../cluster/clusterrolebindings/helm-tiller.yaml
```

### Configuring `helm-tiller`

From the `helm` directory:

```bash
helm init \
  --tiller-tls \
  --tiller-tls-cert=./tiller.cert.pem \
  --tiller-tls-key=./tiller.key.pem \
  --tiller-tls-verify \
  --tls-ca-cert=./ca.cert.pem \
  --tiller-namespace=helm \
  --service-account=helm-tiller
```

### Configuring `helm` CLI:

From the `helm` directory:

```bash
## Link certificates to `~/.helm`:
ln -s $(pwd)/helm.cert.pem $HOME/.helm/cert.pem && \
ln -s $(pwd)/helm.key.pem $HOME/.helm/key.pem
```

Add the following to `~/.bashrc`:

```bash
export HELM_HOME="$HOME/.helm"
export HELM_TLS_ENABLE=1
export TILLER_NAMESPACE=helm
```

Make sure everything works—try a command, like `helm version`!

## Certificate Expiry

The following certificates expire at the following times:

- `tiller.cert.pem` — 3650 days after creation (`26-03-19`).
- `helm.cert.pem` — 3650 days after creation (`26-03-19`).

In order to replace the `helm-tiller` certificate, you'll need to edit the
`tiller-secret` secret on the `helm` namespace, and add the new `base64`-encoded
certificate-key pair to it.
