# Oreilly 1st half of 8 hr course


https://artifacthub.io/ charts & operators found here
https://operatorhub.io/

```bash
# to not get any image pull errors
helm install my-app ./app-chart --set image.pullPolicy=Always
```

## Useful commands


```bash
# Get password from secret
export REDIS_PASSWORD=$(kubectl get secret --namespace redis my-redis -o jsonpath="{.data.redis-password}" | base64 --decode)
```
