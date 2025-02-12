 1. *Installing Helm:*
Download and install Helm with the following commands: 
     curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/hel...
     chmod +x get_helm.sh
     ./get_helm.sh
     helm --version  

2. *Adding the Kubernetes Dashboard Helm Repository:*
Add the repository and verify it:   
     helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
     helm repo list    

3. *Installing Kubernetes Dashboard Using Helm:*
Install it in the `kubernetes-dashboard` namespace:     
     helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
     kubectl get pods,svc -n kubernetes-dashboard  

4. *Accessing the Dashboard:*
Expose the dashboard using a NodePort:     
     kubectl expose deployment kubernetes-dashboard-kong --name k8s-dash-svc --type NodePort --port 443 --target-port 8443 -n kubernetes-dashboard
