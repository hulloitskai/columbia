# columbia

_My personal K8s cluster, configured with code (using
[Flux](https://github.com/weaveworks/flux))._

## Directories

- [`helm`](./helm) – configuration related to the [`helm`](https://helm.sh) and
  `helm-tiller` cluster setup.

## Secrets

Secrets are to be hidden using [`git-secret`](https://git-secret.io), using
the `make secrets-hide` and `make secrets-reveal` commands.
