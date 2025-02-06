## create a namespace 

kubectl create namespace picloud

## create a pod inside th namespace picloud 
````bash
kubectl run mypod --name=Nginx:latest  --restart=Always/Never/OnFailure --port=80  --namespace =  picloud  
````
kubectl run pod --name=nginx:latest --restart=Never/always/  --port=80 --namespace= picloud 

##si tu veux voire les events de namesapce picloud 


````bash
kubectl get events -n picloud  
````

## si tu veux sepecififer un pod dans un namesapce 

````bash
kubectl describe pod mypod  -n picloud
````
##  Voir uniquement l'état du pod (Running, Pending, etc.)

````bash
kubectl get pod mypod -n picloud

````

##  Voir les statistiques du pod (CPU et mémoire)


````bash
kubectl top pod mypod -n picloud


````
