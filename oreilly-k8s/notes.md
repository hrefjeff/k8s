# Resources found on Oreily


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

## Istio Lab

```bash
# Get images running in all pods
kubectl get pods -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{en
d}{end}' |  tr -s '[[:space:]]' '\n'
# Get istio ingress IP
export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}') && echo $INGRESS_HOST
# Get istio ingress port
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}') && echo $INGRESS_PORT
# Echo the url and port
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT && echo $GATEWAY_URL
# Gateway is a CRD. So it is a resource we can get
kubectl get gateway

# Grep more efficiently
kubectl get destinationrules reviews -o yaml | grep -B2 -A20 "host: reviews"
```

## Networking

https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/troubleshooting-cni-plugin-related-errors/ 
