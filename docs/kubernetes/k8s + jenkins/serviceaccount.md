## Pourquoi utiliser un ServiceAccount dans ce cas ?

Un ServiceAccount donne à une application les permissions nécessaires pour accéder aux ressources Kubernetes.

Si une application doit déployer des pods, gérer des services ou interagir avec d'autres ressources Kubernetes, elle a besoin d'un ServiceAccount pour obtenir ces autorisations.

````bash
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-app-service-account  
  namespace: default  # Namespace où l'application s'exécute, ici "default"

````
