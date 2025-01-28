# Guide pour Configurer Terraform avec Jenkins et AWS

## Étapes pour Configurer Terraform avec AWS

### 1. Créer un Compte IAM dans AWS

- Accédez à la console AWS.
- Allez dans **IAM** > **Utilisateurs** > **Ajouter un utilisateur**.
- Renseignez un nom pour l'utilisateur.
- Activez **Accès programmatique**.
- Ajoutez les autorisations : utilisez une politique comme **AdministratorAccess** ou une politique personnalisée pour Terraform.
- Terminez et téléchargez les **Access Key** et **Secret Key**.

### 2. Installer Terraform

- Sur ta machine ou serveur Jenkins :
  ```bash
  sudo apt update
  sudo apt install -y wget unzip
  wget https://releases.hashicorp.com/terraform/<version>/terraform_<version>_linux_amd64.zip
  unzip terraform_<version>_linux_amd64.zip
  sudo mv terraform /usr/local/bin/
  terraform -v
  ```
- Remplace `<version>` par la version que tu souhaites installer.

### 3. Créer les Fichiers Terraform

- Exemple de structure :
  ```plaintext
  ├── main.tf
  ├── variables.tf
  ├── terraform.tfvars
  ```

#### main.tf

```hcl
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-south-1"
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count         = var.number_of_instances
  key_name      = var.ami_key_pair_name
  subnet_id     = var.subnet_id
}
```

#### variables.tf

```hcl
variable "access_key" {}
variable "secret_key" {}
variable "ami_id" {}
variable "instance_type" {}
variable "number_of_instances" {}
variable "ami_key_pair_name" {}
variable "subnet_id" {}
```

#### terraform.tfvars

```hcl
access_key = "<TON_ACCESS_KEY>"
secret_key = "<TON_SECRET_KEY>"
ami_id = "ami-12345678"
instance_type = "t2.micro"
number_of_instances = 1
ami_key_pair_name = "ma-cle-aws"
subnet_id = "subnet-12345678"
```

### 4. Ajouter les Clés dans Jenkins Credentials

- Va dans **Manage Jenkins** > **Manage Credentials**.
- Ajoute une nouvelle entrée avec :
  - **Secret Text** : Ajoute l’Access Key et le Secret Key sous deux noms différents, par exemple `AWS_ACCESS_KEY` et `AWS_SECRET_KEY`.

## Pipeline Jenkins avec Terraform

### Exemple de Pipeline

```groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_KEY = credentials('AWS_SECRET_KEY')
    }
    stages {
        stage('Préparation') {
            steps {
                sh 'terraform --version'
                sh 'terraform init'
            }
        }
        stage('Plan') {
            steps {
                sh '''
                terraform plan \
                -var \"access_key=${AWS_ACCESS_KEY}\" \
                -var \"secret_key=${AWS_SECRET_KEY}\" > plan.tfplan
                '''
            }
        }
        stage('Apply') {
            steps {
                sh 'terraform apply -auto-approve plan.tfplan'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
```

### Explication des Stages

1. **Préparation**
   - Initialise Terraform dans le répertoire courant.
2. **Plan**
   - Génère un fichier de plan basé sur les variables et la configuration.
3. **Apply**
   - Applique la configuration.

### Notes Importantes

- Assure-toi que le fichier `terraform.tfstate` est stocké de manière sécurisée (ex. : backend distant comme S3).
- Nettoie toujours les ressources non utilisées pour éviter des coûts inutiles.

### Vérification dans AWS

- Connecte-toi à AWS.
- Vérifie dans **EC2** si l'instance a été créée.

