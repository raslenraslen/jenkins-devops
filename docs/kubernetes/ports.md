 ## Résumé des ports
Port	Composant	Rôle
6443/tcp :	API Server:  	Point d'entrée pour les commandes et requêtes Kubernetes.

2379/tcp :	etcd (client-serveur) : 	Communication entre l'API Server et etcd.
2380/tcp : 	etcd (inter-nœuds) : 	Réplication des données entre les nœuds etcd.
10250/tcp : 	Kubelet	  : Communication avec l'API Server et exposition des métriques.
10251/tcp : 	Kube-scheduler	 : Exposition des métriques et des endpoints de santé.
10252/tcp : 	Kube-controller-manager : 	Exposition des métriques et des endpoints de santé.
10255/tcp  : 	Kubelet (métriques HTTP)  : 	Exposition des métriques en mode non sécurisé (optionnel).
