## architecture des kubernetes 

Dans Kubernetes, il y a deux types de nœuds (qui sont en fait des machines virtuelles) :

Nœud Master (ou Control Plane)

Nœud Worker

# le noeud Master
Le Nœud Master est comme le "cerveau" du système. Il gère les nœuds Worker et contrôle tout.
Il indique aux nœuds Worker quelles applications exécuter et où les exécuter.

Les processus principeaux dans le noeud master sont :  Api server , Controller manager , scheduler et le etcd 

Scheduler :

Rôle : Le Scheduler est responsable de la planification des tâches. Lorsqu'une tâche (comme déployer une application) doit être exécutée, le Scheduler détermine sur quel Nœud Worker la tâche sera effectuée en fonction de la capacité disponible (mémoire, CPU, etc.).
Exemple : Si une application nécessite beaucoup de ressources, le Scheduler va l'envoyer sur un Nœud Worker qui a assez de mémoire et de puissance CPU.

Controller Manager

Rôle : Le Controller Manager s'assure que l'état actuel du système correspond à l'état souhaité. Si quelque chose ne va pas (par exemple, un Nœud Worker est tombé en panne), le Controller Manager prend les mesures nécessaires pour corriger la situation.
Exemple : Si un Nœud Worker a échoué ou si un pod tombe, le Controller Manager va créer un nouveau pod ou redistribuer les tâches pour que tout fonctionne correctement.

etcd : 

Rôle : etcd est la base de données distribuée qui stocke l’état actuel de tout le cluster Kubernetes. C’est là où sont enregistrées toutes les informations sur les objets Kubernetes, comme les pods, les services, les configurations, etc.
Exemple : Si tu veux savoir où se trouve un pod ou quelle version d’une application est déployée, cette information est stockée dans etcd.
