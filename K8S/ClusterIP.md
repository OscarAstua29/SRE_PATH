# ClusterIP 
### For this example we're going to:
    - Create a Cluster.
    - Create the namespaces (namespace-1 & namespace-2).
    - Create a deployment in each namespace with 3 nginx containers.
    - Create a ClusterIP service to communicate between the two deployments
    - Verify the communication
    
## Create a Cluster

We need to create a yaml file with the following info:

```ymal
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    image: kindest/node:v1.31.0
    extraPortMappings:
    - containerPort: 3080
      hostPort: 3080
      listenAddress: "0.0.0.0"
      protocol: TCP
  - role: worker
    image: kindest/node:v1.31.0
  - role: worker  
    image: kindest/node:v1.31.0

```
Now run the following command to create the cluster:

    kind create cluster -n <cluster-name> --config <file.yaml-name> 

We just create a cluster with the nodes: control-panel, worker and worker2, to verify if the cluster was correct created, run the following command and you could see the nodes install in your cluster:

    kubectl get nodes 
    
## Create namespaces

To create the namespaces use the following commnad:

    kubectl create ns namespace-1
    kubectl create ns namespace-2
    
To verify if the namespaces were created run the following command:

    kubectl get ns
    
## Create a deployment in each namespace with 3 nginx containers
    
We need to create a yaml file with the following info:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx-deployment
  name: nginx-deployment
  namespace: namespace-1
spec:
  progressDeadlineSeconds: 600
  replicas: 3
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx-deployment
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-deployment
    spec:
      containers:
      - image: nginx:1.26.1
        imagePullPolicy: IfNotPresent
        name: nginx
        ports:
        - containerPort: 80
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
```
And apply the ymal with the following command:
    
    kubectl apply -f <yamlfiel.yaml>

To verify that the deployment was created correctly run the following command:

    kubectl get depoy -n namespace-1


Now use the same yaml file to create the deployment in the other namespace. Repeat the latest steps, but just change the namespace value to:
```yaml
        namespace: namespace-2
```
An also to verify the deployment in namespace-2 run:

    kubectl get depoy -n namespace-2

## Create a ClusterIP service to communicate between the two deployments.

Create a yaml file with the following info to create a services:

```yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: nginx-deployment
  name: nginx-clusterip-svc-ns1
  namespace: namespace-1
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx-deployment
  type: ClusterIP
```

To verify that the service was created correctly run the following command:

    kubectl get svc -n namespace-1

Now use the same yaml file to create the deployment in the other namespace. Repeat the latest steps, but just change the name and namespace value to:

```yaml
  name: nginx-clusterip-svc-ns2
  namespace: namespace-2
  ```
An also to verify the service in namespace-2 run:

    kubectl get svc -n namespace-1

## Verify the communication

Run the following command to create a busybox pod in namespace-1 :

    kubectl run busybox --image=busybox -n namespace-1 --restart=Never --rm -it -- /bin/sh

now run the following command to verify if communication with namespaces-2 is available:

    wget -qO- http://nginx-clusterip-svc-ns2.namespace-2
    
you should see something like this:

```hmtl
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

