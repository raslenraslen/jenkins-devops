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

## Log into the container

````bash
kubectl exec -it <pod-name> -- /bin/bash

````
-i : Pour rendre l'entrée interactive (tu peux taper des commandes).

-t : Pour allouer un terminal (affichage amélioré).

<pod-name> : C'est le nom du pod dans lequel tu veux te connecter. Par exemple, mypod.

-- /bin/bash : Cela indique que tu veux ouvrir un terminal Bash dans le conteneur.


##  6. Retrieve the IP address of the Pod `mypod`.
````bash
kubectl get pods -o wide -n picloud

````


````bash
kubectl get pod mypod -o wide -n picloud


````
