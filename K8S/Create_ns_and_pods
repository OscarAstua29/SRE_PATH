# Creating a Namespace with pods
## 

To start this practice, you should verify if any type of K8s and Kubectl are installed on your system.

Let's create a namespace with the following command:

    kubectl create ns <namespace name>
    
Now verify that your namespace was created correctly by running the following command:

    kubectl get ns
    
Now, to create pods in your namespace, you could do it in two ways, the imperative way or the declarative way. In this case we will use the declarative way, so create a nano yaml file anywhere running the following command:

    nano <filename>.yaml
    
In yaml file you should copy the following instuctions:

    apiVersion: v1
    kind: Pod
    metadata:
        name: <podname>
        namespace: <namespace_assign_to>
    spec:
     containers:# container you want to include
     - name: container-nginx
       image: nginx:latest
       ports:
       - containerPort: 80
    - name: container-redis
      image: redis:latest
      ports:
      - containerPort: 6379

Remember save the file by typing ctrl + o, after that press ENTER, and to exit to the nano mode type ctrl+x

Finally to execute the yaml file, run the following command:

    kubectl apply -f <filename>.yaml
    
To verify that the pod was created correctly, run the following command: 

    kubectl get pods -n <namespace>

Another commands:

##Describe

    kubectl descripe pods <podname> -n <namespace>

##Logs

    kubectl logs <podname> -n <namespace>
