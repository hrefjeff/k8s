# KillerCoda Tricks

## Expose a service that will allow you to download a file from killercoda

You can use a simple HTTP server, such as `nginx`, to serve the file

1. Create a directory and change permissions

```bash
mkdir /path/to/your/file/directory
chmod -R 755 /path/to/your/file/directory
```

2. Create an nginx pod that will act as a file server

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: file-server
  labels:
    app: file-server
spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
      volumeMounts:
        - name: file-storage
          mountPath: /usr/share/nginx/html
  volumes:
    - name: file-storage
      hostPath:
        path: /path/to/your/file/directory  # Change this to the file location in your environment.
        type: Directory
```

3. Create svc to expose nginx pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: file-server
  labels:
    app: file-server
spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
      volumeMounts:
        - name: file-storage
          mountPath: /usr/share/nginx/html
  volumes:
    - name: file-storage
      hostPath:
        path: /root/files  # Change this to the file location in your environment.
        type: Directory
```

4. Curl the file to get the download

```sh
# For example, if your node IP is `192.168.1.2` and NodePort is `32456`
curl http://192.168.1.2:32456/your-tar-file.tar
```
