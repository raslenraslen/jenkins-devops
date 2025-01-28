#!/bin/bash

# Script d'installation de Trivy

# Mettre à jour le système
sudo apt-get update

# Installer wget et gnupg si non installés
sudo apt-get install -y wget gnupg

# Ajouter la clé publique de Trivy
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

# Ajouter le dépôt Trivy au sources.list
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

# Mettre à jour les sources
sudo apt-get update

# Installer Trivy
sudo apt-get install -y trivy

# Confirmer l'installation
if command -v trivy &> /dev/null
then
    echo "Trivy a été installé avec succès !"
    trivy --version
else
    echo "Erreur : Trivy n'a pas été installé. Vérifiez les logs ci-dessus."
fi
