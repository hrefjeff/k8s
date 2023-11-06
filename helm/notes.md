# Helm

https://opensource.com/article/20/5/helm-charts

10 min tutorial on helm

* `Chart.yaml` - see the outline of a Helm chart's structure
* `./template` - holds all the configurations for your application that will be deployed into the cluster
* `./charts` - allows you to add dependent charts this appllication/library depends on
* `values.yaml` - Template files are set up with formatting that collects deployment information from this file

## Troubleshooting

I couldn't get to the service deployed within the k8s cluster until I ran `minikube service --all`. There are no networking routes on the host to the service CIDR address until this happens and uses the cluster's IP address as a gateway

## Resources

https://www.devopsschool.com/blog/minikube-tutorials-minikube-tunnel-explained/

https://devopscube.com/create-helm-chart/
