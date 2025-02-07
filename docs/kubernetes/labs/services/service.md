## il ya 2 types de service ClusterIp et NodePort 

ClusterIP = Accès uniquement à l’intérieur du cluster. 🚀

NodePort = Accès depuis l'extérieur du cluster. 🌍

LoadBalancer = Accès via un équilibreur de charge (Cloud). 


````bash

kubectl create service clusterip myapp --tcp=80:80

````


Avec un sélecteur, seuls les Pods correspondant à ce sélecteur sont ajoutés au service.


Sans sélecteur, aucun Pod n'est ajouté par défaut.


## les objectif de la creation d'un service 


1️⃣ Donner une IP fixe aux pods 🆔

Comme on l’a dit, les pods peuvent redémarrer et changer d’IP.

Un Service leur donne une IP stable pour que d’autres pods ou utilisateurs puissent toujours les atteindre.

2️⃣ Permettre la communication entre les pods 🔄


Problème : Un pod frontend (site web) veut parler à un pod backend (API).

Solution : Le Service permet au frontend d’accéder au backend sans se soucier des IP qui changent.


3️⃣ Répartir le trafic entre plusieurs pods (Load Balancing) ⚖

Kubernetes peut créer plusieurs pods pour la même application (replicas: 3).

Le Service répartit les requêtes entre ces pods pour éviter qu’un seul soit surchargé.
