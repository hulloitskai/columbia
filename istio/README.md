# istio

## Multicluster Configuration

`columbia` is configured to connect to the external clusters using
self-signed certificates to verify authenticity.

### Generating certificates

Follow the instructions from
[`istio/samples/certs`](https://github.com/istio/istio/tree/cbd43192bc84ae135b4008ebb143aeca8681fb43/samples/certs#generating-certificates-for-bootstrapping-multicluster-chain-of-trust):

```bash
make root-ca # generate root CA certs

# For each cluster:
make $NAME-certs # generate intermediate CA certs
```

### Installing certificates

Install the certificates according to the
[instructions from the docs](https://istio.io/docs/setup/kubernetes/install/multicluster/gateways/#deploy-the-istio-control-plane-in-each-cluster):

```bash
cd $NAME # enter cluster-certs dir

kubectl create secret generic cacerts -n istio-system \
  --from-file=ca-cert.pem \
  --from-file=ca-key.pem \
  --from-file=root-cert.pem \
  --from-file=cert-chain.pem \
  --dry-run \
  -o yaml | kubeseal \
    --cert ../../sealed-secrets/cert.pem \
    --format yaml | pbcopy
```
