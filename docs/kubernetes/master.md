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

bash
````
sudo apt-mark hold kubeadm kubelet kubectl
````

