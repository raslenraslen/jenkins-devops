## Le fichier YAML :


`````bash

apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token  # Type de secret, un jeton pour un ServiceAccount
metadata:
  name: mysecretname  # Le nom du Secret
  annotations:
    kubernetes.io/service-account.name: myserviceaccount  # Le nom du ServiceAccount lié au jeton


``````


Un ServiceAccount dans Kubernetes utilise un jeton d'authentification pour prouver son identité lorsqu'il interagit avec le cluster
