# sealed-secrets

This directory serves as a workbench from which to create
[sealed secrets](https://github.com/bitnami-labs/sealed-secrets).

### Initialization

First, install `sealed-secrets` using the resources in
[`workloads/kube-ssytem/sealed-secrets`](../workloads/kube-system/sealed-secrets/).

This workbench requires a `./cert.pem`, which is the public key provided by
the `sealed-secrets-controller`:

```bash
kubeseal --fetch-cert > ./cert.pem
```

## Usage

Use the [`mksecret.sh`](./mksecret.sh) script in order to create a
`SealedSecret` resource using the public key [`cert.pem`](./cert.pem), which can
only be decrypted by the on-cluster `sealed-secrets-controller`.

**For example:**

```bash
## Create a YAML secret.
$ cat <<EOF > values.yaml
mongo:
  user: mongo-db-user
  password: super-secret-password
EOF

## Create a SealedSecret from 'values.yaml', and copy it.
$ ./mksecret.sh api-release-secret --from-file=values.yaml | pbcopy

## Create a SealedSecret from 'values.yaml', and write it to 'ss.yaml'.
$ ./mksecret.sh api-release-secret --from-file=values.yaml > ss.yaml
```

### Temporary JSON and YAMLs

_All `.yaml` and `.json` files in this directory will be ignored by Git, as
specified in the [`.gitignore`](./.gitignore)._

This is so that temporary files that are created during the secret-creation
process will not be accidentally committed.

### Backing Up Private Key

To back up the private key that the `sealed-secrets-controller` uses to
decrypt `SealedSecret` resources, run the following command:

```bash
kubectl -n sealed-secrets \
  get secrets sealed-secrets-key -o yaml > master.key.yaml
```

> **Do not expose the resulting key!** Anybody with this key can
> decrypt _any_ `SealedSecret` resource.

To restore the private key, run the following command (assuming that the
private key is named `master.key.yaml`):

```bash
kubectl replace -f master.key.yaml && \
kubectl delete pods -n kube-system -l app.kubernetes.io/name=sealed-secrets
```
