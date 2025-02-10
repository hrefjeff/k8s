```bash
# List all images running after doing a helm install
kubectl get pods -n <NAMESPACE> -o yaml | grep image: | sed -r 's/^.*image: (.+)/\1/' | sort | uniq

# Mass change local images to push to harbor
podman images | grep -V TAG | awk '{print $1":"$2}' | while read -r i; do podman tag $i $(sed 's%localhost%<IP OF HARBOR INSTANCE>/spectro-images%' <<< "$i"); done
```
