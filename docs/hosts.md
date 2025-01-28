# Fichier d'inventaire Ansible : /etc/ansible/hosts

# Définir des groupes de serveurs
[webservers]  # Groupe des serveurs web
web1 ansible_host=192.168.1.10 ansible_user=root
web2 ansible_host=192.168.1.11 ansible_user=root

[dbservers]  # Groupe des serveurs de base de données
db1 ansible_host=192.168.1.20 ansible_user=admin
db2 ansible_host=192.168.1.21 ansible_user=admin

# Paramètres globaux pour tous les serveurs
[all:vars]
ansible_ssh_private_key_file=/path/to/private/key  # Chemin vers la clé SSH
ansible_python_interpreter=/usr/bin/python3       # Version de Python à utiliser

# Exemple de serveur unique sans groupe
single_host ansible_host=192.168.1.30 ansible_user=root
