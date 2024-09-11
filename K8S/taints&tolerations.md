# TAINS & TOLERATIONS
## 

To start this practice, you should verify if any type of K8s and Kubectl are installed on your system.

Let's create a cluster supported by the following yaml:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    image: kindest/node:v1.31.0
  - role: worker
    image: kindest/node:v1.31.0
  - role: worker  
    image: kindest/node:v1.31.0 
```

Now run the following command:

    kind create cluster -n <cluster-name> --config <file.yaml-name> 


We just create a cluster with the nodes: control-panel, worker and worker2, to verify if the cluster was correct install, run the following command and you could see the nodes install in your cluster:

    kubectl get nodes 
    
Now, lets apply a taint in worker2 node, with the following command:

    kubectl taint nodes <nodename-worker2> <key>=value:effect
    
for this example we gonna use the following values:
    
    kubectl taint nodes k8s4devs-worker2 cloud-station=true:NoSchedule
    
Some info:

| Flag      | type | Description     |
| :---        |    :----:   |          ---: |
| key      | text       | identifier   |
| value   | Text        |  data associate whit the key    |
| effect   | NoSchedule        | This effect means that new pods will not be scheduled on a node that has this taint, unless the pod has a matching toleration     |
| effect   | PreferNoSchedule      | To avoid scheduling pods on nodes with this taint|
| effect   |   Noexecute      | Evicts existing pods that don't tolerate the taint and prevents new ones from being scheduled.      |
    
Now to create a pod in the tainted node, create a nano, and paste the followwing text:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: brave-pod
spec:
  containers:
    - name: nginx-pod
      image: nginx
  tolerations:
    - key: "cloud-station"
      operator: "Equal"
      value: "true"
      effect: "NoSchedule"
```

To apply this configuration run the following command:

    kubectl apply -f <fiel.yaml>
    
If you wanna see the  pod info run:

    kubectl describe pods
    
Then you can see if the pod is running in the tainted node.

Just to make a test, you could try to create another pod as the following:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: no-tolerant-pod
spec:
  containers:
    - name: nginx-pod
      image: nginx
```

You can see that the no tolerant pod wasn`t execute 
