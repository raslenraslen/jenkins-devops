# Mettre à jour les paquets existants
sudo apt-get update -y

# Installer Docker (nécessaire pour Kubernetes)
sudo apt-get install docker.io -y
sudo service docker restart

# Installer kubeadm, kubelet, kubectl via Snap
sudo snap install kubeadm --classic
sudo snap install kubelet --classic
sudo snap install kubectl --classic

# Vérifier les versions installées pour s'assurer que tout est bien installé
kubeadm version
kubectl version --client
kubelet --version
