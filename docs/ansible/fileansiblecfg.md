
### Configuration d'un fichier `ansible.cfg`

Voici une configuration de base pour le fichier `ansible.cfg`, accompagnée d'explications des modifications :

---

```ini
[defaults]
inventory = ./inventory  # Spécifie le chemin du fichier d'inventaire.
host_key_checking = False  # Désactive la vérification des clés SSH pour éviter les messages d'avertissement.
retry_files_enabled = False  # Empêche la création de fichiers .retry en cas d'échec des tâches.

[privilege_escalation]
become = True  # Active les privilèges élevés (sudo).
become_method = sudo  # Spécifie que sudo doit être utilisé pour l'élévation des privilèges.
become_user = root  # Indique que les tâches doivent être exécutées en tant que root.

[ssh_connection]
control_path = %(directory)s/%%h-%%r  # Configure le chemin pour les connexions persistantes SSH.
pipelining = True  # Améliore les performances en réduisant les connexions SSH par tâche.
```

---

### À quoi sert chaque section ?

#### **Section [defaults]**
- **`inventory`** : Indique à Ansible où se trouve le fichier contenant la liste des serveurs. Cela peut être modifié pour pointer vers un fichier d'inventaire personnalisé.
- **`host_key_checking`** : Évite que Ansible arrête l'exécution si la clé SSH d'un serveur est inconnue. Cela est pratique pour les tests rapides.
- **`retry_files_enabled`** : Supprime les fichiers `.retry` inutiles qui sont générés en cas d'échec.

#### **Section [privilege_escalation]**
- **`become`** : Permet à Ansible d'exécuter des commandes nécessitant des privilèges élevés.
- **`become_method`** : Force l'utilisation de `sudo` pour élever les privilèges.
- **`become_user`** : Les tâches seront exécutées en tant qu'utilisateur `root`.

#### **Section [ssh_connection]**
- **`control_path`** : Précise comment Ansible gère les connexions persistantes pour éviter des erreurs de chemin trop long.
- **`pipelining`** : Améliore la vitesse des tâches en limitant les connexions SSH répétées.

---

Garde ce fichier préconfiguré à portée de main. Si tu as besoin d’aide pour le personnaliser ou pour mieux comprendre une section, je suis là pour t'aider !


scp  .ssh/id_rsa* ubuntu@192.186.100.243:/home/ubuntu/.ssh/*

