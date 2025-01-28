# Résolution du Problème de Permission Docker

Lorsque vous essayez d’exécuter une commande Docker dans un pipeline ou sur votre machine et que vous recevez une erreur comme :

```
ERROR: permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
```

Cela signifie que l'utilisateur n'a pas les permissions nécessaires pour accéder au socket Docker. Voici les étapes pour résoudre ce problème.

---

## **Étape 1 : Ajouter un utilisateur au groupe `docker`**

### **1.1. Créer ou vérifier le groupe Docker**
Docker utilise un groupe UNIX appelé **`docker`** pour accorder l'accès au daemon Docker.

Vérifiez si le groupe existe :
```bash
cat /etc/group | grep docker
```

Si le groupe n'existe pas, créez-le :
```bash
sudo groupadd docker
```

---

### **1.2. Ajouter un utilisateur au groupe Docker**
Pour permettre à un utilisateur d'accéder à Docker sans utiliser **`sudo`**, ajoutez-le au groupe Docker.

Par exemple, pour l'utilisateur courant :
```bash
sudo usermod -aG docker $USER
```

Pour un utilisateur spécifique, comme **`jenkins`** :
```bash
sudo usermod -aG docker jenkins
```

---

## **Étape 2 : Appliquer les modifications**
Les modifications nécessitent une actualisation des groupes.

### **2.1. Recharger les groupes**
Vous pouvez appliquer les changements immédiatement en exécutant :
```bash
newgrp docker
```

### **2.2. Vérifier l'appartenance au groupe Docker**
Vérifiez si l'utilisateur appartient bien au groupe **`docker`** :
```bash
groups
```

Vous devriez voir quelque chose comme :
```
raslen adm cdrom sudo dip plugdev lpadmin lxd sambashare docker
```

---

## **Étape 3 : Tester Docker**
Essayez une commande Docker sans utiliser **`sudo`** :
```bash
docker ps
```
Si cela fonctionne, votre problème est résolu. Sinon, passez à l'étape suivante.

---

## **Étape 4 : Redémarrer la machine (si nécessaire)**
Si le problème persiste, redémarrez votre machine pour appliquer complètement les changements :
```bash
sudo reboot
```

Après le redémarrage, vérifiez à nouveau avec :
```bash
docker ps
```

---

## **Étape 5 : Résoudre les permissions pour Jenkins**
Si vous utilisez Docker dans un pipeline Jenkins, vous devez vous assurer que l'utilisateur **`jenkins`** a également les permissions nécessaires.

1. **Ajouter l'utilisateur Jenkins au groupe Docker :**
   ```bash
   sudo usermod -aG docker jenkins
   ```

2. **Redémarrer le service Jenkins :**
   ```bash
   sudo systemctl restart jenkins
   ```

3. **Tester dans Jenkins :**
   Créez une étape Docker dans votre pipeline pour vérifier l'exécution de Docker sans erreurs :
   ```groovy
   stage('Test Docker') {
       steps {
           sh 'docker ps'
       }
   }
   ```

---

## **Résumé**
1. Créez le groupe Docker si nécessaire.
2. Ajoutez votre utilisateur (ou `jenkins`) au groupe Docker.
3. Rechargez les groupes ou redémarrez votre machine.
4. Testez l'accès à Docker sans **`sudo`**.

Avec ces étapes, vous pouvez résoudre les erreurs de permission liées à Docker dans vos pipelines ou sur votre machine locale.

