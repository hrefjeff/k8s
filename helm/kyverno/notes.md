# Kyverno (Greek for "Govern")

Policy manager for k8s

https://kyverno.github.io/kyverno/

https://kyverno.io/docs/introduction/#quick-start

https://kyverno.io/docs/installation/methods/#high-availability

Test policies without having a cluster: https://playground.kyverno.io/#/

# How to Install with Helm

```bash
helm repo add kyverno https://kyverno.github.io/kyverno/
helm install kyverno --namespace kyverno kyverno/kyverno --create-namespace
```
