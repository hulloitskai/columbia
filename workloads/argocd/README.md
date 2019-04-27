# argocd

## Git Webhooks

To configure a Git webhook secret, edit the `argo-secret` resource:

```bash
kubectl -n argocd edit secret argocd-secret
```

Add the resulting webhook secret in the `stringData` field:

```yaml
apiVersion: v1
kind: Secret
# ...
stringData:
  github.webhook.secret: <webhook-secret>
# ...
```
