## 📌 Scénario : Déploiement du Gestionnaire d’Employés sur Kubernetes 🚀
Tu travailles sur une application de gestion des employés 📊 où les RH peuvent ajouter, modifier, supprimer des employés, suivre les absences, et calculer les heures travaillées. Maintenant, tu veux déployer ton application sur Kubernetes pour garantir sa disponibilité et sa scalabilité.


##  Étape 1 : Tu envoies la demande
Tu écris un fichier de configuration (YAML) qui dit :
➡️ "Je veux déployer mon application de gestion des employés avec 3 copies (Pods) pour qu'elle soit disponible tout le temps."

Puis, tu lances la commande :

bash
Copier
Modifier
kubectl apply -f gestion-employes.yaml
C’est comme si tu envoyais une demande officielle à Kubernetes.
