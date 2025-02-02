kubedadm init --apiserver-avertise-address 192.168.100.38  --pod-network-cidr 10.32.0.0/12
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
kubectl get nodes -owide
sudo kubeadm token create --pront-join-command
