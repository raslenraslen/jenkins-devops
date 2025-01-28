# Trivy: Scanner de Vulnérabilités pour CI/CD

## Qu'est-ce que Trivy ?
Trivy est un outil open-source de scan de sécurité utilisé pour détecter les **vulnérabilités** et les **mauvaises configurations** dans différents composants d'un projet.

### Fonctionnalités principales :
- Détection des vulnérabilités connues dans :
  - **Images Docker**.
  - **Fichiers locaux** (filesystem).
  - **Dépendances** (Maven, npm, pip, etc.).
  - **Fichiers de configuration** (Kubernetes YAML, Docker Compose).
- Génération de rapports lisibles.
- Intégration facile dans les pipelines CI/CD.

## Installation de Trivy
Pour installer Trivy sur Ubuntu :

```bash
sudo apt-get install wget gnupg
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy
```

## Utilisation de Trivy

### Commandes de base :

#### 1. Scanner un système de fichiers local
La commande `trivy fs` scanne les fichiers d'un projet ou d'un répertoire local.

```bash
trivy fs --format table -o fs.html
```
- **`fs`** : Scanne le système de fichiers.
- **`--format table`** : Génère un rapport sous forme de tableau.
- **`-o fs.html`** : Sauvegarde le rapport dans un fichier HTML.

#### 2. Scanner une image Docker
La commande `trivy image` vérifie les vulnérabilités d'une image Docker.

```bash
trivy image my-app:latest
```

#### 3. Scanner des fichiers de configuration
La commande `trivy config` analyse les fichiers de configuration d'infrastructure (Kubernetes, Docker Compose, etc.).

```bash
trivy config /path/to/configuration/
```

### Exemple d'intégration dans un pipeline CI/CD
Dans un pipeline, Trivy peut automatiser la détection des failles pour chaque commit ou déploiement.

#### Exemple de pipeline Jenkins :
```groovy
stage('Trivy Scan') {
    steps {
        sh 'trivy fs --format table -o fs.html'
        archiveArtifacts artifacts: 'fs.html', fingerprint: true
    }
}
```

## Pourquoi utiliser Trivy dans un pipeline CI/CD ?

1. **Automatisation de la sécurité** : Trivy scanne automatiquement le code pour détecter les failles sans intervention manuelle.
2. **Rapports détaillés** : Il génère des rapports indiquant les vulnérabilités, leur gravité et les correctifs disponibles.
3. **Empêche les déploiements risqués** : Si des failles critiques sont détectées, le pipeline peut être configuré pour s'arrêter.

### Exemple de rapport Trivy
Un rapport généré par Trivy inclut :
- **Nom de la vulnérabilité (CVE)**.
- **Gravité** (Faible, Moyenne, Haute, Critique).
- **Version vulnérable** et **version corrigée**.

#### Exemple de sortie de la commande :
```
+------------------+------------------+-------------------+-------------------+
| VULNERABILITY ID | PACKAGE NAME     | SEVERITY          | FIXED VERSION     |
+------------------+------------------+-------------------+-------------------+
| CVE-2021-44228   | log4j            | CRITICAL          | 2.15.0            |
+------------------+------------------+-------------------+-------------------+
```

## Différence avec OWASP
- **Trivy** : Conçu pour scanner les dépendances, conteneurs, fichiers et configurations.
- **OWASP** : Organisation fournissant des standards et des outils comme OWASP ZAP pour sécuriser les applications web.

Les deux peuvent être utilisés de manière complémentaire.

## Conclusion
Trivy est un outil essentiel pour automatiser la sécurité des applications et des infrastructures dans un pipeline CI/CD. Il aide à identifier rapidement les vulnérabilités et garantit que le code est sécurisé avant d'être déployé.

---
Pour plus d'informations, consultez la [documentation officielle de Trivy](https://aquasecurity.github.io/trivy/).
