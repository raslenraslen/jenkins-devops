kubectl get service argocd-server -o yaml > current-argocd-server.yaml
kubectl apply -f current-argocd-server.yaml 

kubectl get secrets
kubectl get secret argocd-initial-admin-secret

kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
