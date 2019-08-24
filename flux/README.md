# flux

## Setup

### Installation

[`flux`](https://github.com/weaveworks/flux) should be installed in the
namespace `flux`. Use the guide at
[`flux/site/helm-get-started`](https://github.com/weaveworks/flux/blob/master/site/helm-get-started.md)
for reference.

> `flux` requires `helm` to be installed first. See the
> [docs on installing `helm` with TLS](../helm/README.md).

Prepare the namespace `flux`, and install the `helm-client-certs` secrets:

```bash
kubectl create namespace flux && \
kubectl create secret generic helm-client-certs \
  --namespace flux \
  --from-file tls.key=../helm/flux.key.pem \
  --from-file tls.crt=../helm/flux.cert.pem
```

Install the associated CRDs:

```bash
kubectl apply -f ./crd.yaml
```

Install the chart as follows:

```bash
helm repo add fluxcd https://charts.fluxcd.io && \
helm install \
  --name=flux \
  --namespace=flux \
  -f ./values.yaml \
  --version 0.12.0 \
  --atomic \
  fluxcd/flux
```

The following will need to be added to your `~/.bashrc`:

```bash
export FLUX_FORWARD_NAMESPACE=flux
```

### Git Integration

Ensure that the `flux`'s SSH key is added to this repository,
[as per the docs](https://github.com/weaveworks/flux/blob/master/site/fluxctl.md#add-an-ssh-deploy-key-to-the-repository):

```bash
fluxctl identity # get public key
```
