# sealed-secrets

This directory serves as a workbench from which to create
[sealed secrets](https://github.com/bitnami-labs/sealed-secrets).

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
