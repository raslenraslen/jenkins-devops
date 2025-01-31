## la difference entre kubelet , kubeadm et kubectl 

1. kubeadm :
Qu'est-ce que c'est ?
C'est un outil qui sert à installer et configurer Kubernetes sur les nœuds (machines) du cluster. Il configure le nœud maître, le fait devenir le "chef" du cluster et permet de connecter les nœuds workers au cluster.

Exemple d'utilisation :

Sur le nœud maître : Tu utilises kubeadm init pour créer le cluster Kubernetes.
Sur les nœuds workers : Tu utilises la commande kubeadm join pour ajouter les nœuds workers au cluster.
En résumé : kubeadm est utilisé pour initialiser et rejoindre le cluster Kubernetes. Il sert à "créer" le cluster et à connecter les machines.
