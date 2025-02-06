## create a namespace 

kubectl create namespace picloud

## create a pod inside th namespace picloud 
````bash
kubectl run mypod --name=Nginx:latest  --restart=Always/Never/OnFailure --port=80  --namespace =  picloud  
````
