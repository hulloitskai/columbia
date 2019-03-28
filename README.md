<p align="center">
  <img
    src="./docs/columbia.png"
    width="275px"
    title="'Robot City' by Petr Had (https://dribbble.com/petrhad)"
  />
</p>

# columbia

_My personal K8s cluster, configured with code (using
[Flux](https://github.com/weaveworks/flux))._

[![UptimeRobot][status-img]][status]

## Directories

- [`cluster`](./cluster) – a GitOps-enabled directory that contains cluster-wide
  resources like `CustomResourseDefinitions` and `ClusterRoleBindings`.
- [`workloads`](./workloads) – a GitOps-enabled directory that contains
  namespaced resources and Helm releases to be run on-cluster.
- [`sealed-secrets`](./sealed-secrets) – a workbench from which to create
  [sealed secrets](https://github.com/bitnami-labs/sealed-secrets).
- [`helm`](./helm) – configuration related to the [`helm`](https://helm.sh) and
  `helm-tiller` cluster setup.
- [`flux`](./flux) – configuration related to the
  [`flux`](https://github.com/weaveworks/flux) cluster setup.

## Secrets

Configuration secrets are to be hidden using
[`git-secret`](https://git-secret.io), using the `make secrets-hide` and
`make secrets-reveal` commands.

K8s `Secret` resources should be encrypted using
[`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets), using a
process described in [`sealed-secrets/README.md`](./sealed-secrets/README.md).

[status]: https://status.stevenxie.me
[status-img]: https://img.shields.io/uptimerobot/ratio/m782295595-128aab6d398761c64ab1b883.svg
