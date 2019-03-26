# helm-tls

These certificates are used to secure the connection between `helm` and
`helm-tiller`. One such `helm.key.pem` is needed for each client in order
to be able to access the `helm-tiller`, and the one in this directory is for
admin use (by the owner of this repository).

For more information, see
[`helm/docs/tiller_ssl.md`](https://github.com/helm/helm/blob/master/docs/tiller_ssl.md)!

## Installing Helm with TLS

### Configuring `helm-tiller`

From the `helm/tls` directory:

```bash
helm init \
  --tiller-tls \
  --tiller-tls-cert=./tiller.cert.pem \
  --tiller-tls-key=./tiller.key.pem \
  --tiller-tls-verify \
  --tls-ca-cert=./helm/tls/ca.cert.pem
  --tiller-namespace=helm \
  --service-account=helm-tiller
```

### Configuring `helm` CLI:

From the `helm/tls` directory:

```bash
## Link certificates to `~/.helm`:
ln -s $(pwd)/helm.cert.pem $HOME/.helm/cert.pem && \
ln -s $(pwd)/helm.key.pem $HOME/.helm/key.pem && \
ln -s $(pwd)/ca.key.pem $HOME/.helm/ca.pem
```

Add the following to `~/.bashrc`:

```bash
export HELM_HOME="$HOME/.helm"
export HELM_TLS_ENABLE=1
export TILLER_NAMESPACE=helm
```

Make sure everything works—try a command, like `helm ls`!

## Certificate Expiry

The following certificates expire at the following times:

- `tiller.cert.pem` — 3650 days after creation (`26-03-19`).
- `helm.cert.pem` — 3650 days after creation (`26-03-19`).

In order to replace the `helm-tiller` certificate, you'll need to edit the
`tiller-secret` secret on the `helm` namespace, and add the new `base64`-encoded
certificate-key pair to it.
