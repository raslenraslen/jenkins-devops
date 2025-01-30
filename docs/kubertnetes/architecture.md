## architecture des kubernetes 

Dans Kubernetes, il y a deux types de nœuds (qui sont en fait des machines virtuelles) :

Nœud Master (ou Control Plane)

Nœud Worker

# le noeud Master
Le Nœud Master est comme le "cerveau" du système. Il gère les nœuds Worker et contrôle tout.
Il indique aux nœuds Worker quelles applications exécuter et où les exécuter.

Les processus principeaux dans le noeud master sont :  Api server , Controller manager , scheduler et le etcd 

## Scheduler :

Rôle : Le Scheduler est responsable de la planification des tâches. Lorsqu'une tâche (comme déployer une application) doit être exécutée, le Scheduler détermine sur quel Nœud Worker la tâche sera effectuée en fonction de la capacité disponible (mémoire, CPU, etc.).
Exemple : Si une application nécessite beaucoup de ressources, le Scheduler va l'envoyer sur un Nœud Worker qui a assez de mémoire et de puissance CPU.

## Controller Manager

Rôle : Le Controller Manager s'assure que l'état actuel du système correspond à l'état souhaité. Si quelque chose ne va pas (par exemple, un Nœud Worker est tombé en panne), le Controller Manager prend les mesures nécessaires pour corriger la situation.
Exemple : Si un Nœud Worker a échoué ou si un pod tombe, le Controller Manager va créer un nouveau pod ou redistribuer les tâches pour que tout fonctionne correctement.

## etcd : 

Rôle : etcd est la base de données distribuée qui stocke l’état actuel de tout le cluster Kubernetes. C’est là où sont enregistrées toutes les informations sur les objets Kubernetes, comme les pods, les services, les configurations, etc.
Exemple : Si tu veux savoir où se trouve un pod ou quelle version d’une application est déployée, cette information est stockée dans etcd.

## Api server 

Imagine une situation dans un bureau :

Tu veux faire quelque chose dans le bureau (par exemple, obtenir des informations ou demander quelque chose à un collègue).
Mais au lieu d’aller directement à chaque collègue, tu passes par un réceptionniste qui va s’assurer que ta demande soit envoyée à la bonne personne dans le bureau.

Maintenant, applique ça à Kubernetes :

Quand tu veux déployer une application ou vérifier l'état du cluster, tu envoies une requête à l'API Server.
L'API Server reçoit ta demande et la transmet à d'autres parties du système pour qu'elles puissent y répondre. Par exemple, il peut envoyer la demande au Scheduler pour savoir où déployer l'application, ou au Controller Manager pour s'assurer que tout est en ordre.

## Les Nœuds Worker : "Là où les applications tournent"

Les Nœuds Worker sont les machines (ou VMs) sur lesquelles les applications sont réellement exécutées. Ce sont eux qui font le travail réel de faire tourner les applications que tu déploies.

 ## Rôle des Nœuds Worker :
Imagine un atelier de travail où les ouvriers (les Nœuds Worker) sont responsables de la production des produits (les applications). Les Nœuds Worker prennent les instructions du Nœud Master et exécutent les applications dedans, un peu comme des ouvriers qui suivent les instructions de leur chef.

##  Container Runtime : L'outil pour gérer les containers
Rôle : Le Container Runtime est le logiciel qui gère les containers. Un container est une sorte d'isolement où ton application tourne, avec toutes ses dépendances nécessaires. Ce processus lance et arrête les containers qui hébergent les applications.

Le Container Runtime peut être des outils comme Docker, containerd, ou d’autres technologies de containerisation.

Exemple : Quand tu demandes à Kubernetes de déployer une application, l'API Server va envoyer l'instruction au Kubelet, qui va ensuite utiliser le Container Runtime pour lancer un container qui va exécuter l'application.

En résumé : Le Container Runtime est l'outil qui fait tourner les containers où tes applications seront exécutées.

##  Kubelet : Le Superviseur
Rôle : Le Kubelet est un superviseur ou agent sur chaque Nœud Worker. Il veille à ce que tout fonctionne correctement sur le Nœud Worker. Il vérifie constamment si les applications sont en cours d’exécution et si elles fonctionnent comme prévu. Si quelque chose ne va pas, il prend des mesures pour réparer cela.

Exemple : Imaginons que tu aies déployé une application avec 3 instances (réplicas). Le Kubelet s’assure qu’il y ait toujours 3 instances en fonctionnement. Si l’une d’elles tombe en panne, le Kubelet peut la redémarrer.

En résumé : Le Kubelet est comme un superviseur qui s'assure que les applications fonctionnent correctement sur le Nœud Worker.

## Kube Proxy : Le gestionnaire du trafic réseau
Rôle : Le Kube Proxy gère le trafic réseau à l’intérieur du cluster. Cela signifie qu'il achemine les requêtes réseau vers les bons containers (applications) qui tournent sur les Nœuds Worker. Il fait en sorte que le réseau interne entre les Nœuds et les applications soit fluide et organisé.

Exemple : Imagine que tu as déployé une API sur un des containers sur un Nœud Worker. Si quelqu’un veut accéder à cette API via une requête réseau (comme une requête HTTP), le Kube Proxy s’assure que la requête arrive au bon container, même si le container se trouve sur un autre Nœud Worker ou est déplacé entre les nœuds.

En résumé : Le Kube Proxy est comme un régulateur du trafic qui dirige les requêtes réseau vers les bonnes applications (containers) dans le cluster Kubernetes.


