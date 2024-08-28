# Prod cluster app installs

1. Flux - provides kustomizations and 
2. Metallb

https://metallb.universe.tf/installation/
https://metallb.universe.tf/configuration/ 

# Deployed a django app in k8s cluster w/ nginx & postgres

https://collabnix.com/kubernetes-on-docker-desktop-in-2-minutes/
https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0
https://mattsegal.dev/nginx-django-reverse-proxy-config.html

Amazing resources. Explains django reverse proxy and a great utility that visualizes k8s resources

# Kubernetes the hard way

https://github.com/kelseyhightower/kubernetes-the-hard-way/tree/master

https://www.youtube.com/watch?v=Z-Pxl84WNGo

# Debugging tips

`journalctl -u containerd -e`

-u - unit
-e - jump to end of journal

# Output with kubectl

https://kubernetes.io/docs/reference/kubectl/cheatsheet/ great resource

`master $ kubectl create namespace test-123 --dry-run -o yaml`

will yield

```yaml
apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: null
  name: test-123
spec: {}
status: {}

```

`kubectl run nginx --image=nginx --dry-run=client -o yaml > nginx-pod.yaml`

will yyield

# Services

The way Kubernetes allows applications to be exposed to outside users

## Nodeport

All terminology is from the perspective of the Service

The Nodeport service is called as such because it listens to a port on the node and forwards that request to a pod within the cluster

Valid node ports are from 30,000-32,767

https://www.bogotobogo.com/DevOps/Docker/Docker_Kubernetes_Service_IP_and_Service_Type.php

```bash
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4

kubectl expose deployment < NAME-OF-DEPLOYMENT > --name=FirstNodeportSvc --port=80 --target-port=8080 --type=NodePort

kubectl port-forward --address 0.0.0.0 svc/FirstNodeportSvc 31213:80 &
```

Explanation

1. `kubectl port-forward`: This is a kubectl command used to forward one or more local ports to a pod. It's useful for accessing applications in a Kubernetes cluster from your local machine.

1. `--address 0.0.0.0`: By default, port-forward binds only to 127.0.0.1, which means it can only be accessed from the local machine. The --address 0.0.0.0 flag changes this behavior to bind to all network interfaces. This makes the forwarded port accessible from external machines. However, be cautious when using this, as it exposes the port to the entire network.

1. `svc/hello-minikube`: This specifies the target for port forwarding. In this case, it's a service named hello-minikube. Typically, port-forward is used with pods, but it can also be used with services, deployments, and replicasets.

1. `31183:8080`: This defines the port mapping:

* `31183`: This is the local port on your machine.
* `8080`: This is the port on the hello-minikube service in the Kubernetes cluster.

    With this mapping, any traffic sent to port 31183 on your local machine will be forwarded to port 8080 on the hello-minikube service in the cluster.

1. `&`: This is a shell command to run the kubectl port-forward command in the background. This allows you to continue using the terminal without waiting for the command to complete.

In summary, this command forwards traffic from port 31183 on all network interfaces of your local machine to port 8080 on the hello-minikube service in the Kubernetes cluster

# Deploying a django app to a k8s cluster

https://mattermost.com/blog/orchestrate-django-application-with-kubernetes/
