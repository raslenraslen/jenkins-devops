## 📌 Scénario : Déploiement du Gestionnaire d’Employés sur Kubernetes 🚀
Tu travailles sur une application de gestion des employés 📊 où les RH peuvent ajouter, modifier, supprimer des employés, suivre les absences, et calculer les heures travaillées. Maintenant, tu veux déployer ton application sur Kubernetes pour garantir sa disponibilité et sa scalabilité.


##  Étape 1 : Tu envoies la demande

Tu écris un fichier de configuration (YAML) qui dit :

➡️ "Je veux déployer mon application de gestion des employés avec 3 copies (Pods) pour qu'elle soit disponible tout le temps."

Puis, tu lances la commande :

kubectl apply -f gestion-employes.yaml

C’est comme si tu envoyais une demande officielle à Kubernetes.


## 2️⃣ Étape 2 : Kubernetes vérifie ta demande

Dès que ta demande arrive :

✅ L’API Server la reçoit et vérifie si tu as bien le droit de déployer une application.

✅ Si tout est bon, il enregistre les infos dans etcd (un peu comme une base de données centrale pour Kubernetes).

## 3️⃣ Étape 3 : Kubernetes trouve où déployer ton application

💡 Le Scheduler (planificateur) regarde les serveurs disponibles (nœuds Kubernetes).

🔍 Il choisit le meilleur serveur pour héberger ton application (par exemple, celui qui a assez de mémoire et de CPU).

📝 Il enregistre sa décision dans etcd.



