## la difference entre kubelet , kubeadm et kubectl 

## 1. kubeadm :
Qu'est-ce que c'est ?
C'est un outil qui sert à installer et configurer Kubernetes sur les nœuds (machines) du cluster. Il configure le nœud maître, le fait devenir le "chef" du cluster et permet de connecter les nœuds workers au cluster.

Exemple d'utilisation :

Sur le nœud maître : Tu utilises kubeadm init pour créer le cluster Kubernetes.
Sur les nœuds workers : Tu utilises la commande kubeadm join pour ajouter les nœuds workers au cluster.
En résumé : kubeadm est utilisé pour initialiser et rejoindre le cluster Kubernetes. Il sert à "créer" le cluster et à connecter les machines.


## kubectl :
Rôle principal : Il s'agit de l'outil en ligne de commande pour interagir avec le cluster Kubernetes. Il permet d'exécuter des commandes sur le cluster, comme déployer des applications, consulter des logs, vérifier les ressources et plus encore.
Utilisation :
Interagir avec le cluster Kubernetes : kubectl est utilisé pour gérer et contrôler les ressources dans Kubernetes comme les pods, services, déploiements, etc.
Commandes courantes :
kubectl get pods : Pour obtenir la liste des pods exécutés dans le cluster.
kubectl apply -f <file>.yaml : Pour appliquer des configurations de ressources à partir d'un fichier YAML.
kubectl describe pod <pod-name> : Pour obtenir plus de détails sur un pod spécifique.
