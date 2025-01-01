# Intégration d'OWASP Dependency Check dans un Projet Maven

Ce guide explique comment utiliser **OWASP Dependency Check** pour analyser les vulnérabilités dans les dépendances d'un projet Maven.

---

## **Étapes Suivies**

### **1. Créer un Répertoire pour le Projet**
Créez un dossier ou clonez le dépôt existant :
```bash
git clone https://github.com/raslenraslen/application-pipeline.git
```
Naviguez dans le répertoire cloné :
```bash
cd application-pipeline
```

### **2. Compiler le Projet Maven**
Assurez-vous que Maven est installé sur votre système. Si ce n'est pas le cas, installez-le :
```bash
sudo apt install maven -y
```

Ensuite, exécutez la commande Maven pour nettoyer et compiler le projet :
```bash
mvn clean package
```

---

### **3. Télécharger OWASP Dependency Check**
Téléchargez l'archive zip de Dependency Check :
```bash
wget https://github.com/jeremylong/DependencyCheck/releases/download/v11.1.1/dependency-check-11.1.1-release.zip
```

Extrayez le contenu de l'archive :
```bash
unzip dependency-check-11.1.1-release.zip
```
Naviguez dans le dossier décompressé :
```bash
cd dependency-check
```

Supprimez le fichier zip pour nettoyer votre espace de travail :
```bash
rm -f ../dependency-check-11.1.1-release.zip
```

---

### **4. Lancer l'Analyse OWASP Dependency Check**
Exécutez la commande suivante pour analyser les dépendances du projet :
```bash
./bin/dependency-check.sh \
  --out /home/raslen/Desktop/tutorial-environment/application_pipeline/application-pipeline \
  --scan /home/raslen/Desktop/tutorial-environment/application_pipeline/application-pipeline/target
```

- **`--out`** : Chemin où les rapports seront générés.
- **`--scan`** : Chemin du répertoire contenant les fichiers à analyser.

Vous pouvez naviguer vers le dossier contenant le rapport pour vérifier les résultats :
```bash
cd /home/raslen/Desktop/tutorial-environment/application_pipeline/application-pipeline
ls
```

---

## **Rapport OWASP Dependency Check**
OWASP Dependency Check génère un fichier **HTML** et d'autres rapports dans le chemin spécifié. Ouvrez le fichier HTML dans un navigateur pour examiner les vulnérabilités détectées.

---

## **Problèmes Courants**
1. **Problèmes d'installation de Maven**
   - Assurez-vous que Maven est correctement installé :
     ```bash
     sudo apt install maven -y
     ```

2. **Problèmes avec Dependency Check**
   - Vérifiez que le chemin de sortie (**`--out`**) et le chemin d'analyse (**`--scan`**) sont corrects.
   - Assurez-vous que le dossier cible (à analyser) contient les fichiers compilés.

3. **Rapports non disponibles**
   - Naviguez dans le dossier défini par **`--out`** pour localiser les rapports générés.
   - Vérifiez les permissions du dossier si les rapports ne sont pas créés.

---

## **Résumé**
En suivant ces étapes, vous avez intégré OWASP Dependency Check dans votre projet Maven pour analyser les dépendances et identifier les vulnérabilités potentielles. Cela améliore la sécurité et la fiabilité de votre application.

