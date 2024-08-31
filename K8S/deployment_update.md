# Deploy and update in K8S
## 

To start this practice, you should verify if any type of K8s and Kubectl are installed on your system.

Let's create a namespace with the following command:

    kubectl create ns <namespace name>    #recommended cloudstation
    
Now verify that your namespace was created correctly by running the following command:

    kubectl get ns
    
Now, to create the deploy in your namespace, you could do it in two ways, the imperative way or the declarative way. In this case we will use the imperative way, so create a deploy and copy the pod configuration in nano yaml file anywhere running the following command:

    kubectl create deploy nginx-deployment --image=nginx:1.26.1 --replicas=3 -n cloudstation  --dry-run=client -oyaml > deployment.yaml

Also to apply the deployment run the following command:

    kubectl apply -f deployment.yaml
    
to get the deployment configuration in yaml file run the following command:
    
    kubectl get deployment nginx-deployment -n cloudstation -oyaml > deployment.yaml
    
Now open the deployment.yaml file with the following command:

    nano deployment.yaml
    
In yaml file you should see something similar to the  following:

    apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"creationTimestamp":null,"labels":{"app":"nginx-deployment"},">
  creationTimestamp: "2024-08-31T07:25:25Z"
  generation: 1
  labels:
    app: nginx-deployment
  name: nginx-deployment
  namespace: cloudstation
  resourceVersion: "28248"
  uid: adb99ad9-ed26-4b87-8640-07b9acf21d0d
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
        imagePullPolicy: Always
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 3
  conditions:
     - lastTransitionTime: "2024-08-31T07:25:27Z"
    lastUpdateTime: "2024-08-31T07:25:27Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
      - lastTransitionTime: "2024-08-31T07:25:25Z"
    lastUpdateTime: "2024-08-31T07:25:27Z"
    message: ReplicaSet "nginx-deployment-5959b5b5c9" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 3
  replicas: 3
  updatedReplicas: 3

Remember if you make any change save it in the file by typing ctrl + o, after that press ENTER, and to exit to the nano mode type ctrl+x

To create an image with new api's version run the following command:

kubectl set image deployment/nginx-deployment nginx=nginx:1.27.1 -n cloudstation --record
    
To verify that the pod was created correctly, run the following command: 

    kubectl get pods -n <namespace>

Another commands:

##Describe

    kubectl descripe pods <podname> -n <namespace>

##Logs

    kubectl logs <podname> -n <namespace>
