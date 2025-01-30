
# Kubernetes : Introduction et Concepts de Base

## 1. C'est quoi Kubernetes ? 

kubernetes ou k8s est un outil qui permet de gerer les conteneurs .. il peremt de automatiser le déploiement, la mise à l'échelle (scaling) et la gestion des applications conteneurisées.

##  2. sans le kubernetes ?   

imagine que tu es en trein de gerer un site web dans un conteneur docker 
sans la k8s si un conteneur tombe en panne tu dois le reparer manuelleement 
Si ton site web devient trop populaire, tu dois ajouter des conteneurs manuellement pour gérer la charge.
Tu dois surveiller en permanence pour t'assurer que tout fonctionne bien.

## avec la kubernetes 

Si ton conteneur plante, Kubernetes le redémarre tout seul.
Si ton site web devient trop populaire, Kubernetes crée automatiquement des copies du conteneur pour gérer la charge.
Kubernetes surveille tout pour toi, et tu n'as pas besoin d'intervenir.


## source  
le k8s est créé par Google .. mais il est managed maintenant par CNCF

