## Set up Docker

sudo apt update

sudo apt install docker.io -y

sudo systemctl enable docker

sudo systemctl status docker

sudo systemctl start docker

## Install Kubernetes
## Step 1: Add Kubernetes Signing Key

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg


## Step 2: Add Software Repositories

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt update

## Step 3: Install Kubernetes Tools

sudo apt install kubeadm kubelet kubectl

sudo apt-mark hold kubeadm kubelet kubectl

kubeadm version

## activate necessary ports 

sudo firewall-cmd --permanent --add-port=6443/tcp

sudo firewall-cmd --permanent --add-port=2379-2380/tcp


sudo firewall-cmd --permanent --add-port=10250/tcp

sudo firewall-cmd --permanent --add-port=10251/tcp

sudo firewall-cmd --permanent --add-port=10252/tcp

sudo firewall-cmd --permanent --add-port=10255/tcp

sudo firewall-cmd --reloadCopied!

## Deploy Kubernetes

## Step 1: Prepare for Kubernetes Deployment

sudo swapoff -a

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sudo nano /etc/modules-load.d/containerd.conf  

fi wsto 7ott 

overlay
br_netfilter

pour appliquer la configuration 

sudo modprobe overlay

sudo modprobe br_netfilter

sudo nano /etc/sysctl.d/kubernetes.conf

fi wsto 7ott : 

net.bridge.bridge-nf-call-ip6tables = 1

net.bridge.bridge-nf-call-iptables = 1

net.ipv4.ip_forward = 1

pour appliquer la modification 7ott 

sudo sysctl --system
