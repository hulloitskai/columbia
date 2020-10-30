# flux

## Setup

### Installation

[`flux`](https://fluxcd.io) should be installed in the
namespace `flux`. Use the guide at
[`docs.fluxcd.io`](https://github.com/weaveworks/flux/blob/master/site/helm-get-started.md)
for reference.

Prepare the namespace `flux`:

```bash
kubectl create namespace flux
```

Install the `flux` chart as follows:

```bash
helm repo add fluxcd https://charts.fluxcd.io && \
helm upgrade flux fluxcd/flux \
  --install \
  --namespace default \
  --version 1.5.0 \
  --atomic \
  --values ./flux.values.yaml
```

Install the `helm-operator` chart as follows:

```bash
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/1.2.0/deploy/crds.yaml && \
helm upgrade helm-operator fluxcd/helm-operator \
  --install \
  --namespace default \
  --version 1.2.0 \
  --atomic \
  --values ./helm-operator.values.yaml
```

### Git Integration

Ensure that the `flux`'s SSH key is added to this repository,
[as per the docs](https://github.com/weaveworks/flux/blob/master/site/fluxctl.md#add-an-ssh-deploy-key-to-the-repository):

```bash
fluxctl identity # get public key
```
