Les Roles dans Kubernetes définissent les permissions pour les utilisateurs humains ou les ServiceAccounts.

## Qu'est-ce qu'un Role ?

Un Role est comme un règlement ou un contrat qui décrit ce qu'un utilisateur (ou une application) peut faire dans un namespace spécifique.

## Que peut faire un Role ?

Il définit quelles ressources dans Kubernetes une personne ou une application peut accéder, par exemple, des pods, des services, des secrets, des configmaps, etc.

Il spécifie aussi quelles actions (ou verbes) l'utilisateur peut effectuer sur ces ressources, comme lire, créer, mettre à jour, ou supprimer.

`````

apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: app-role  # Nom du Role
  namespace: webapps  # Le namespace où ce rôle est appliqué
rules:
  - apiGroups:
      - ""
      - apps
      - autoscaling
      - batch
      - extensions
      - policy
      - rbac.authorization.k8s.io
    resources:
      - pods
      - secrets
      - configmaps
      - deployments
      - services
      # Liste de toutes les ressources auxquelles ce rôle accède
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
    # Quelles actions sont permises sur ces ressources

``````

## explication de fichier yaml 

rules :   C'est la partie la plus importante du rôle. Elle définit les ressources et les actions autorisées.

## apiGroups :
 
 apiGroups fait référence à différents groupes d'API Kubernetes. Les API Kubernetes sont organisées en groupes, chacun ayant un ensemble de ressources qu'il gère.

Par exemple :

Le groupe apps contient des ressources comme deployments, replicasets, statefulsets, etc.

Le groupe "" (une chaîne vide) représente les ressources de base, comme les pods, les services, les namespaces, etc.


## resources 

2. resources :

resources définit quelles ressources Kubernetes ce rôle peut gérer. Ces ressources peuvent être des objets comme pods, secrets, deployments, etc.

Exemple de ressources que tu pourrais trouver :

pods : Les instances de tes applications dans Kubernetes.

secrets : Des objets contenant des informations sensibles (comme des mots de passe).

deployments : Les configurations pour déployer des applications dans Kubernetes.

## verbs 

Les verbs sont les actions autorisées sur les ressources. Cela définit ce que l'utilisateur ou le ServiceAccount peut faire avec ces ressources.

Les verbes les plus courants sont :

get : Lire ou obtenir une ressource (exemple : lire un pod pour voir son état).

list : Lister toutes les ressources d'un certain type (exemple : lister tous les pods dans un namespace).

create : Créer une nouvelle ressource (exemple : créer un nouveau pod).

update : Mettre à jour une ressource existante (exemple : mettre à jour un déploiement avec une nouvelle version d'image).

delete : Supprimer une ressource (exemple : supprimer un pod).

```` bash
verbs: ["get", "list", "create", "update", "delete"]
````


## Si tu veux lier ce Role à un ServiceAccount :

Pour utiliser ce rôle avec un ServiceAccount spécifique ou un utilisateur, tu devras créer un RoleBinding ou ClusterRoleBinding.
