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

