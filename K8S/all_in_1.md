# K8S ALL IN 1 
# With minikube
### (ConfigMaps, Deployments, Services)
#
#
### For this example we're going to:
    - Create a Cluster in minikube.
    - Create the namespaces (todo-list).
    - Create a configMap for stats.yaml file.
    - Create a configMap for back-end.yaml file.
    - Create a configMap for front-end.yaml file.
    - Deploy stats.yaml file
    - Deploy mongo-db.yaml file
    - Deploy back-end.yaml file
    - Deploy front-end.yaml file
    - Expose the app on local host

Before starting, fork  the following repo by falconcr
    https://github.com/falconcr/kubernetes-todo-app

#### Create a Cluster in minikube.

To create a cluster in Minikube install all the packages to use it:

https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download

Before installing all, run the following command to initialize the cluster:

    minikube start
    
Verify if the cluster was created with the following command: 

    kubectl get pods -A

You should to see something like this:

    kube-system   coredns-6f6b679f8f-5m7qw           1/1     Running   0             39m
    kube-system   etcd-minikube                      1/1     Running   0             39m
    kube-system   kube-apiserver-minikube            1/1     Running   0             39m
    kube-system   kube-controller-manager-minikube   1/1     Running   0             39m
    kube-system   kube-proxy-bm8r8                   1/1     Running   0             39m
    kube-system   kube-scheduler-minikube            1/1     Running   0             39m
    kube-system   storage-provisioner                1/1     Running   1 (39m ago)   39m
    
#### Create the namespaces (todo-list).

Let`s create a NameSpace to deploy the app, with the following command:

    kubectl create ns todo-list
        
Verify if the namespace was created with the following command: 

    kubectl get ns

#### Create a configMap for stats.yaml file.

The stats.yaml file contained some variables, that were not recommended use in the base code, that why you should create a new yaml file with the following content:

```yaml
apiVersion: v1
kind: ConfigMap
metadata: 
  name: todo-configmap
data:
  STATS_QUEUE_URI : "amqp://stats-queue"
  REDIS_HOST : "stats-cache"
  REDIS_PORT : "6379"
```

This yaml file is simply a ConfigMap for some variables, then run the following command to deploy the ConfigMap

    kubectl apply -f configmap.yaml -n todo-list
    
Verify if the ConfigMap was created with the following command: 

    kubectl get configmaps -n todo-list

#### Create a configMap for back-end.yaml file.

The back-end.yaml file contained some variables, that were not recommended use in the base code, that why you should use configmap.yaml file that we created in the last step, unique with the following content:

```yaml
apiVersion: v1
kind: ConfigMap
metadata: 
  name: todo-configmap-db
data:
  MONGO_CONNECTION_STRING : "mongodb://todos-db"
```

This yaml file is simply a ConfigMap for some variables, then run the following command to deploy the ConfigMap

    kubectl apply -f configmap.yaml -n todo-list
    
Verify if the ConfigMap was created with the following command: 

    kubectl get configmap -n todo-list
#### Create a configMap for front-end.yaml file.
The front-end.yaml file contained some variables, that were not recommended use in the base code, that why you should use configmap.yaml file that we created in the last step, unique with the following content:

```yaml
apiVersion: v1
kind: ConfigMap
metadata: 
  name: todo-configmap-front
data:
  STATS_QUEUE_URI : "amqp://stats-queue"
```

This yaml file is simply a ConfigMap for some variables, then run the following command to deploy the ConfigMap

    kubectl apply -f configmap.yaml -n todo-list
    
Verify if the ConfigMap was created with the following command: 

    kubectl get configmap -n todo-list
    
#### Deploy stats.yaml file.

Now run the following command to deploy the stats.yaml file:

    kubectl apply -f stats.yaml -n todo-list
    
Verify if the deployments were created, run the following command: 

    kubectl get pods -n todo-list
  You should to see something like this:
  
    stats-api-5b48b5d9b7-2wvgh     1/1     Running   2 (4m16s ago)   55m
    stats-cache-5f77b57bfc-hljsc   1/1     Running   1 (5m21s ago)   55m
    stats-queue-7f7787874b-qs82c   1/1     Running   1 (5m21s ago)   55m
    stats-worker-8f4f75b8-h5rll    1/1     Running   2 (4m45s ago)   55m
    
Now verify if the services were created, run the following command: 
    
    kubectl get services -n todo-list

  You should to see something like this:
  
    stats-api      ClusterIP      10.109.88.136    <none>        80/TCP         56m
    stats-cache    ClusterIP      10.99.219.18     <none>        6379/TCP       56m
    stats-queue    ClusterIP      10.107.108.189   <none>        5672/TCP       56m

#### Deploy mongo-db.yaml file.

Now run the following command to deploy the mongo-db.yaml file:

    kubectl apply -f mongo-db.yaml -n todo-list
    
Verify if the deployments were created, run the following command: 

    kubectl get pods -n todo-list
  You should to see something like this:
  
    stats-api-5b48b5d9b7-2wvgh     1/1     Running   2 (4m16s ago)   55m
    stats-cache-5f77b57bfc-hljsc   1/1     Running   1 (5m21s ago)   55m
    stats-queue-7f7787874b-qs82c   1/1     Running   1 (5m21s ago)   55m
    stats-worker-8f4f75b8-h5rll    1/1     Running   2 (4m45s ago)   55m
    todos-db-846c9b876f-h7pp4      1/1     Running   1 (9m1s ago)    55m
    
Now verify if the services were created, run the following command: 
    
    kubectl get services -n todo-list

  You should to see something like this:
  
    stats-api      ClusterIP      10.109.88.136    <none>        80/TCP         56m
    stats-cache    ClusterIP      10.99.219.18     <none>        6379/TCP       56m
    stats-queue    ClusterIP      10.107.108.189   <none>        5672/TCP       56m
    todos-db       ClusterIP      10.106.158.55    <none>        27017/TCP      52m
#### Deploy back-end.yaml file.

Now run the following command to deploy the mongo-db.yaml file:

    kubectl apply -f back-end.yaml -n todo-list
    
Verify if the deployments were created, run the following command: 

    kubectl get pods -n todo-list
  You should to see something like this:
  
    database-api-b5cc6d66c-kft9p   1/1     Running   1 (9m1s ago)    47m
    stats-api-5b48b5d9b7-2wvgh     1/1     Running   2 (4m16s ago)   55m
    stats-cache-5f77b57bfc-hljsc   1/1     Running   1 (5m21s ago)   55m
    stats-queue-7f7787874b-qs82c   1/1     Running   1 (5m21s ago)   55m
    stats-worker-8f4f75b8-h5rll    1/1     Running   2 (4m45s ago)   55m
    todos-db-846c9b876f-h7pp4      1/1     Running   1 (9m1s ago)    55m
    
Now verify if the services were created, run the following command: 
    
    kubectl get services -n todo-list

  You should to see something like this:
  
    database-api   ClusterIP      10.103.11.61     <none>        80/TCP         44m
    stats-api      ClusterIP      10.109.88.136    <none>        80/TCP         56m
    stats-cache    ClusterIP      10.99.219.18     <none>        6379/TCP       56m
    stats-queue    ClusterIP      10.107.108.189   <none>        5672/TCP       56m
    todos-db       ClusterIP      10.106.158.55    <none>        27017/TCP      52m
#### Deploy front-end.yaml file.

Now run the following command to deploy the mongo-db.yaml file:

    kubectl apply -f front-end.yaml -n todo-list
    
Verify if the deployments were created, run the following command: 

    kubectl get pods -n todo-list
  You should to see something like this:
  
    database-api-b5cc6d66c-kft9p   1/1     Running   1 (9m1s ago)    47m
    frontend-55f9546849-gxffb      1/1     Running   2 (8m20s ago)   42m
    stats-api-5b48b5d9b7-2wvgh     1/1     Running   2 (4m16s ago)   55m
    stats-cache-5f77b57bfc-hljsc   1/1     Running   1 (5m21s ago)   55m
    stats-queue-7f7787874b-qs82c   1/1     Running   1 (5m21s ago)   55m
    stats-worker-8f4f75b8-h5rll    1/1     Running   2 (4m45s ago)   55m
    todos-db-846c9b876f-h7pp4      1/1     Running   1 (9m1s ago)    55m
    
Now verify if the services were created, run the following command: 
    
    kubectl get services -n todo-list

  You should to see something like this:
  
    database-api   ClusterIP      10.103.11.61     <none>        80/TCP         44m
    frontend       LoadBalancer   10.96.30.252     <pending>     80:30289/TCP   40m
    stats-api      ClusterIP      10.109.88.136    <none>        80/TCP         56m
    stats-cache    ClusterIP      10.99.219.18     <none>        6379/TCP       56m
    stats-queue    ClusterIP      10.107.108.189   <none>        5672/TCP       56m
    todos-db       ClusterIP      10.106.158.55    <none>        27017/TCP      52m
#### Expose the app on local host.

Make sure that all the deployments and services were created and are running, also, make sure that any services is running on 80 port, with the following command:

    sudo netstat -tunl | grep :80

Then let`s create a tunnel to expose the app in the 80 port, with the following commnad:

    minikube tunnel
    
Now open your browser and search for localhost 127.0.0.1

If everything is ok, you should be seeing the app on you browser.

Look for the video, test of functionality in k8s directory
