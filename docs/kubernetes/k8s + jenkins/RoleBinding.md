## C'est quoi un Rolebinding 

un RoleBinding assigne un Role (qui définit des permissions sur des ressources) à un ServiceAccount, permettant à ce dernier d'effectuer des actions sur les ressources dans un namespace donné.

## Comment cela fonctionne ?

Le RoleBinding lie un Role à un ServiceAccount.

Le Role spécifie quelles actions peuvent être effectuées sur quelles ressources dans Kubernetes.

Le RoleBinding donne au ServiceAccount (ici jenkins) l'accès aux ressources selon les permissions définies dans le Role.

``````bash

apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: my-new-app-role-binding
  namespace: new-namespace  # Nouveau namespace
subjects:
- kind: ServiceAccount
  name: new-service-account  # Nouveau ServiceAccount
  namespace: new-namespace   # Nouveau namespace
roleRef:
  kind: Role
  name: new-app-role  # Nouveau Role
  apiGroup: rbac.authorization.k8s.io

``````
