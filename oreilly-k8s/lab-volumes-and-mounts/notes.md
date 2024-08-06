# Volumes and Mounts

https://kubernetes.io/docs/tasks/configure-pod-container/configure-volume-storage/

https://kubernetes.io/docs/concepts/storage/volumes/

https://kubernetes-csi.github.io/docs/drivers.html

## EmptyDir Volume

Since a Pod lifecycle exists on a single Node, then each Pod on a Node stores its files on the Node. The Kubelet takes care of all this file management since it's managing the Pods on the Node. Each emptyDir can typically be found on the Node in /var/lib/kubelet/pods/. However, you should never couple to these files directly. It's a private matter between the Pods and the Kublets, so butt out.

## HostPath Volume

The next layer beyond the Pod is the Node. The worker Node hosts the Pods managed by Kubelet. Pods can use the host file system for file storage; however, it's not very common. Just as Pods and their containers can come and go, so do Nodes. File storage on Nodes is just as ephemeral.

A hostPath volume mounts a file or directory from the host Node's filesystem into your Pod. There are a few reasons you may need this. For instance, an application may need access to the files that are relevant to a specific Node. DaemonSets are objects that declare Pods to run on every Node in a cluster, or at least a designated subset of Nodes. Imagine you have 10 nodes in your cluster dedicated to high-performance algorithms that require GPU processors. With Pod affinity, you can run those important algorithms on these nodes. You may also want to monitor the performance of the GPUs. This is where DaemonSets come in. The applications in DaemonSets can access the metrics, log files, or other file artifacts on the host machine that are important for observability. These special monitoring Pods need access to the Host machine's file system, via the hostPath volume. Any other type of observability pattern may also want to access these file artifacts.

If you try to start forcing a Pod to always target a specific Node then you are fighting against Kubernetes, the scheduler, scalability, resilience, and distributed computing.

## PersistentVolume

The next mount type is at the cluster level.

## Commands

```bash
# starts a container in a Pod, list its file contents, and destroy the Pod
kubectl run -i --tty busybox --image=busybox --restart=Never --rm=true -- ls -la

# Patch svc to non-random port
kubectl patch service demo-web --type='json' --patch='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value":30080}]'
```
