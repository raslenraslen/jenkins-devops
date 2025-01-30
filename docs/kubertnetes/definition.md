
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

## Pourquoi Kubernetes surveille les containers ?

Kubernetes s’assure que ton application fonctionne bien sans intervention humaine. Si un container a un problème, Kubernetes peut :
✅ Le redémarrer s’il plante
✅ Le recréer s’il ne répond plus
✅ Le supprimer s’il ne sert plus

Comment Kubernetes surveille les containers ?
Kubernetes utilise deux types de vérifications automatiques :

1️⃣ Liveness Probe (Test de Vie) 🩺

Vérifie si le container est toujours en cours d’exécution
Exemple : toutes les 10 secondes, Kubernetes vérifie si ton application répond
Si elle ne répond pas, Kubernetes redémarre le container
💡 À quoi ça sert ?

➡️ Évite que ton application reste bloquée si un problème survient (ex: bug, mémoire saturée).

2️⃣ Readiness Probe (Test de Disponibilité) 🚦

Vérifie si ton application est prête à recevoir du trafic
Exemple : un site web peut démarrer, mais il met du temps à charger complètement
Kubernetes attend que l’application soit 100% prête avant d’envoyer des visiteurs
💡 À quoi ça sert ?

➡️ Empêche d’envoyer des utilisateurs vers une application qui n’est pas encore prête.

