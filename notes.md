# Services

The way Kubernetes allows applications to be exposed to outside users

## Nodeport

All terminology is from the perspective of the Service

The Nodeport service is called as such because it listens to a port on the node and forwards that request to a pod within the cluster

Valid node ports are from 30,000-32,767

https://www.bogotobogo.com/DevOps/Docker/Docker_Kubernetes_Service_IP_and_Service_Type.php

```bash
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4

kubectl expose deployment < NAME-OF-DEPLOYMENT > --name=nodeport --port=80 --target-port=8080 --type=NodePort

kubectl port-forward --address 0.0.0.0 svc/nodeport 31213:80 &
```
