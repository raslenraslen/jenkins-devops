# Guide d'installation et de configuration d'un cluster Kubernetes

Ce guide explique comment installer et configurer un cluster Kubernetes sur un nœud `master` et ajouter des nœuds worker. Il couvre l'installation de Docker, la configuration de Kubernetes, l'initialisation du cluster, et l'installation du réseau Calico.


## Étape 1 : Mise à jour du système

Mettez à jour les paquets du système :

```bash
sudo apt update && sudo apt upgrade -y

```
## Étape 2 : Installation de Docker

Installez Docker :

```bash
sudo apt install docker.io -y
```
Démarrez et activez Docker :

```bash

sudo systemctl start docker
sudo systemctl enable docker
```
Vérifiez que Docker fonctionne :

```bash
sudo systemctl status docker
```

## Étape 3 : Configuration de Kubernetes

Ajoutez le dépôt Kubernetes pour la version 1.30 :

````bash

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
Installez les outils Kubernetes (kubeadm, kubelet, kubectl) :
````
````bash
sudo apt install kubeadm kubelet kubectl
````
Marquez ces paquets pour éviter les mises à jour non désirées :

 ````bash

sudo apt-mark hold kubeadm kubelet kubectl
````

## Étape 4 : Configuration du système pour Kubernetes

Désactivez le swap :

````bash

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

````
````
sudo nano /etc/modules-load.d/containerd.conf
````

t7tt fi wsto assemi les modules   (overlay , br_netfilter ) 

appliquer les modifications  

```` bash

sudo modprobe overlay
sudo modprobe br_netfilter

`````

Configurez les paramètres sysctl pour Kubernetes :

Créez ou modifiez le fichier /etc/sysctl.d/kubernetes.conf :

````bash

sudo nano /etc/sysctl.d/kubernetes.conf
````

Ajoutez les lignes suivantes :

````
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
Appliquez les modifications sysctl :
````

```bash

sudo sysctl --system
````


## Étape 5 : Configuration de containerd

Générez la configuration par défaut de containerd :

````bash

sudo containerd config default | sudo tee /etc/containerd/config.toml
````

Modifiez le fichier config.toml pour activer SystemdCgroup :

````bash

sudo nano /etc/containerd/config.toml

````
Remplacez :


SystemdCgroup = false

Par :


SystemdCgroup = true

Redémarrez containerd :

````
sudo systemctl restart containerd

````

## Étape 6 : Ouverture des ports dans le pare-feu

Ouvrez les ports nécessaires pour Kubernetes :

bash

````
sudo firewall-cmd --permanent --add-port=6443/tcp
sudo firewall-cmd --permanent --add-port=2379-2380/tcp
sudo firewall-cmd --permanent --add-port=10250/tcp
sudo firewall-cmd --permanent --add-port=10251/tcp
sudo firewall-cmd --permanent --add-port=10252/tcp
sudo firewall-cmd --permanent --add-port=10255/tcp
sudo firewall-cmd --reload

````

