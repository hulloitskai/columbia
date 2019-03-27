# columbia

_My personal K8s cluster, configured with code (using
[Flux](https://github.com/weaveworks/flux))._

## Directories

- [`helm`](./helm) – configuration related to the [`helm`](https://helm.sh) and
  `helm-tiller` cluster setup.
- [`flux`](./flux) - configuration related to the
  [`flux`](https://github.com/weaveworks/flux) cluster setup.
- [`sealed-secrets`](./sealed-secrets) – a workbench from which to create
  [sealed secrets](https://github.com/bitnami-labs/sealed-secrets).
- [`cluster`](./cluster) – a GitOps-enabled directory that contains cluster-wide
  resources like `CustomResourseDefinition`s and `ClusterRoleBinding`s.
- [`workloads`](./workloads) – a GitOps-enabled directory that contains
  namespaced resources and Helm releases to be run on-cluster.

## Secrets

Secrets are to be hidden using [`git-secret`](https://git-secret.io), using
the `make secrets-hide` and `make secrets-reveal` commands.
