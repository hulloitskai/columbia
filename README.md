<p align="center">
  <img
    src="./docs/columbia.png"
    width="275px"
    title="'Robot City' by Petr Had (https://dribbble.com/petrhad)"
  />
</p>

# columbia

_A personal K8s cluster, configured with code (using
[Flux](https://fluxcd.io))._

[![UptimeRobot][status-img]][status]

## Directories

- [`deploy`](./deploy) – All the YAML-specified resources that are managed by
  Flux.
- [`sealed-secrets`](./sealed-secrets) – A workbench from which to create
  [sealed secrets](https://github.com/bitnami-labs/sealed-secrets).

## Flux

If Flux is not installed, it needs to be boostrapped:

```bash
flux bootstrap github \
  --components-extra=image-reflector-controller,image-automation-controller \
  --owner=stevenxie \
  --repository=columbia \
  --branch=main \
  --path=deploy \
  --personal \
  --private=false
```

The same command is used to update the Flux system. You can verify the
installation/upgrade status with `flux check`.

## Secrets

Configuration secrets are to be hidden using
[`git-secret`](https://git-secret.io). Reveal secrets using `git secret reveal`,
and hide them using `git secret hide -m`.

Kubernetes secrets should be encrypted using
[`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets), using a
process described in [`sealed-secrets/README.md`](./sealed-secrets/README.md).

[status]: https://status.stevenxie.me
[status-img]: https://img.shields.io/uptimerobot/ratio/m782295595-128aab6d398761c64ab1b883.svg
