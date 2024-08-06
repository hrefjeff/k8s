# Nginx Ingress Lab

When creating a webapp, you'd create the deployment and the service that
exposes the webapp. However, it is only accessible within the cluster.
To test it out, run a `curl` command when you `exec` into a container

Most Kubernetes as a Service (KaaS) offerings will have an opinionate ingress
controller installed, but in many cases (such as with Minikube), the choice of
ingress controller is up to you.

## Commands for lab

```bash
less webapps.yaml | tee
kubectl apply -f webapps.yaml
kubectl run curler --image=radial/busyboxplus:curl --command -- sleep 3600
kubectl exec -it curler --curl http://webapp1-svc
curl -v http://webapp1-svc # will not resolve. error

# Install NGINX service proxy ingress controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm repo list

# Install ingress
VERSION=4.2.0
helm install my-ingresser ingress-nginx/ingress-nginx \
  --version $VERSION \
  --set controller.service.externalIPs={FILL IN THIS IP OF CONTROL PLANE}
kubectl get nodes -o wide | grep -C1 "FILL IN THIS IP OF CONTROL PLANE"
kubectl get pods -l app.kubernetes.io/name=ingress-nginx # check if running appropriately

export HTTP_NODE_PORT=80
export NODE_NAME=$(kubectl --namespace default get nodes -o jsonpath="{.items[0].status.addresses[1].address}")
export INGRESS_URL=http://$NODE_NAME:$HTTP_NODE_PORT
echo $INGRESS_URL/some-service # display typical call
curl $INGRESS_URL/webapp1 | grep -C1 404 # still fails because no routes are set

kubectl get ingress # display current ingress rules
kubectl apply -f ingress-single.yaml
curl $INGRESS_URL/webapp1 # will work
curl $INGRESS_URL/unknown # will not work because /unknown is not defined
kubectl delete -f ingress-single.yaml

export TRY_HOST=*.nasa.gov
envsubst < ingress-single-with-host.yaml | kubectl apply -f - # Apply yaml with host as *.nasa.gov
kubectl get ingress # will display ingress with *.nasa.gov
kubectl describe ingress
curl -H "Host: my-app.test.com" $INGRESS_URL/webapp1 # access first svc
# Doesn't work because the host does not match any of the ingress rules
export TRY_HOST=*.test.com
envsubst < ingress-single-with-host.yaml | kubectl apply -f -
kubectl get ingress
kubectl describe ingress
curl -H "Host: my-app.test.com" $INGRESS_URL/webapp1 # success
curl -H "Host: my-app.test.com" $INGRESS_URL/unknown # fail
curl -H "Host: my-app.test.com" $INGRESS_URL/webapp2 # fail
kubectl delete ingress routes-with-host

kubectl apply -f ingress-multiple.yaml
curl -H "Host: my-app.test.com" $INGRESS_URL/webapp1 # success
curl -H "Host: my-app.test.com" $INGRESS_URL/webapp2 # success
curl -H "Host: my-app.test.com" $INGRESS_URL/webapp3 # success
curl -H "Host: my-app.test.com" $INGRESS_URL/unknown # resolves to webapp3
kubectl delete -f ingress-multiple.yaml

kubectl apply -f ingress-canary.yaml # 60/40 rule applied to traffic
curl -H "Host: my-app.test.com" $INGRESS_URL/webapp1
```
