#!/bin/bash

# Mise à jour des paquets existants
echo "Mise à jour des paquets..."
sudo apt update -y

# Installation des dépendances nécessaires
echo "Installation des dépendances..."
sudo apt install -y gnupg software-properties-common curl

# Ajout de la clé GPG de HashiCorp
echo "Ajout de la clé GPG de HashiCorp..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo tee /etc/apt/trusted.gpg.d/hashicorp.asc

# Ajout du dépôt HashiCorp
echo "Ajout du dépôt HashiCorp..."
sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Mise à jour de la liste des paquets
echo "Mise à jour des paquets..."
sudo apt update -y

# Installation de Terraform
echo "Installation de Terraform..."
sudo apt install -y terraform

# Vérification de l'installation
echo "Vérification de l'installation..."
terraform -v
