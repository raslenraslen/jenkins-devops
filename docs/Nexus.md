# DAY-7 | Nexus Repository Manager

## **Introduction**

Nexus Repository Manager est un outil central pour la gestion des **artifacts** (éléments de build comme les fichiers JAR, WAR, ou autres librairies) dans un environnement DevOps.

- **Rôle principal :** Stocker et gérer les artifacts (binaires, dépendances, bibliothèques) de manière sûre et centralisée.
- **Pourquoi l'utiliser :**
  - Éviter de télécharger plusieurs fois les mêmes dépendances depuis internet.
  - Réduire les temps de build.
  - Garantir la cohérence des versions utilisées dans tous les environnements (local, test, production).

---

## **Rôle dans un pipeline CI/CD**

1. **Centralisation des artifacts :**
   - Nexus agit comme un "hub" où tous les artifacts sont stockés.
   - Exemples d’artifacts : fichiers JAR, WAR, images Docker.

2. **Gestion des dépendances :**
   - Les dépendances (par ex. Maven ou npm) sont téléchargées une seule fois, puis mises en cache dans Nexus.
   - Si internet n'est pas accessible, Nexus fournit les dépendances stockées localement.

3. **Versioning :**
   - Nexus garde un historique des versions des artifacts, permettant de revenir à une version précédente si besoin.

4. **Collaboration et accès contrôlé :**
   - Nexus permet de définir qui peut publier ou accéder aux artifacts (contrôle par utilisateur/équipe).

5. **Intégration avec Jenkins :**
   - Dans un pipeline Jenkins, Nexus est utilisé pour :
     - **Publier** des artifacts après un build.
     - **Récupérer** des dépendances avant le build.

---

## **Exemple de Scénario Réel**

Une équipe travaille sur une application composée de plusieurs microservices. Chaque service utilise des dépendances et produit des artifacts comme des fichiers JAR ou WAR. Voici comment Nexus est utile :

### **1. Centralisation des fichiers**
- Tous les fichiers binaires (éléments de build) sont publiés dans Nexus.
- Les développeurs peuvent accéder aux fichiers directement depuis Nexus sans devoir les reconstruire.

### **2. Contrôle des versions**
- Nexus garde une copie de chaque version des artifacts.
- Ex : Si une nouvelle version introduit un bug, l’équipe peut revenir à la version précédente.

### **3. Accélération des builds**
- Nexus met en cache les dépendances de Maven, npm, ou autres outils. Ainsi, au lieu de télécharger les dépendances à chaque fois depuis internet, elles sont directement accessibles dans Nexus.

---

## **Installation de Nexus**

### **1. Prérequis**
- **Java Development Kit (JDK) :**
  - Assure-toi que Java est installé sur ton système.
  - Commande pour vérifier :
    ```bash
    java -version
    ```

### **2. Installer Nexus avec Docker**
1. **Commande pour démarrer Nexus :**
   ```bash
   docker run -d --name nexus -p 8081:8081 sonatype/nexus3
   ```
2. **Accéder à Nexus :**
   - Ouvre un navigateur et tape : `http://localhost:8081`
   - Connecte-toi avec les informations d’administration disponibles dans :
     ```bash
     /nexus-data/admin.password
     ```

---

## **Configuration Maven avec Nexus**

Pour permettre à Maven de publier des artifacts dans Nexus, voici les configurations à ajouter :

### **1. pom.xml**

```xml
<distributionManagement>
  <repository>
    <id>maven-releases</id>
    <url>http://localhost:8081/repository/maven-releases/</url>
  </repository>
  <snapshotRepository>
    <id>maven-snapshots</id>
    <url>http://localhost:8081/repository/maven-snapshots/</url>
  </snapshotRepository>
</distributionManagement>
```

### **2. settings.xml**

```xml
<settings>
  <servers>
    <server>
      <id>maven-releases</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
    <server>
      <id>maven-snapshots</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
  </servers>
</settings>
```
- **Note :** Change `admin` et `admin123` avec tes identifiants Nexus.

---

## **Pipeline Jenkins avec Nexus**

Exemple d’un pipeline pour publier des artifacts dans Nexus :

```groovy
pipeline {
    agent any

    tools {
        jdk 'jdk11'
        maven 'maven3'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/<your-repo>'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Publish to Nexus') {
            steps {
                configFileProvider([configFile(fileId: 'settings-file-id', variable: 'MAVEN_SETTINGS')]) {
                    sh 'mvn -s $MAVEN_SETTINGS clean deploy'
                }
            }
        }
    }
}
```

- **Explication :**
  - **`configFileProvider`** : Fournit le fichier `settings.xml` configuré pour Nexus.
  - **`mvn clean deploy`** : Publie les artifacts dans Nexus.

---

## **Résumé**

1. **Pourquoi Nexus ?**
   - Centralise les dépendances et les artifacts.
   - Permet de réutiliser des artifacts sans les reconstruire.
   - Gère les versions pour garantir la traçabilité.

2. **Pipeline avec Nexus :**
   - Construire (build) des fichiers.
   - Publier les fichiers dans Nexus.
   - Accélérer les builds avec des dépendances en cache.

Avec ce fichier, tu pourras toujours te rappeler comment utiliser Nexus dans tes projets ! 😊

