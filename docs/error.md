# Jenkins Pipeline Setup Instructions

This document outlines the steps to set up a Jenkins Pipeline for building and deploying a Java web application. It also includes common mistakes and how to avoid them in the future.

---

## **Pipeline Overview**
The pipeline includes the following stages:
1. **Tool Installation**: Configure tools like Maven and JDK.
2. **Git Checkout**: Clone the source code from a Git repository.
3. **Build**: Use Maven to compile and package the application.
4. **Deploy**: Copy the `.war` file to the Tomcat server.

---

## **Pipeline Script**
Here is the corrected and working pipeline script:

```groovy
pipeline {
    agent any

    tools {
        maven 'Maven3' // Name of the Maven tool configured in Jenkins
        jdk 'JDK17'   // Name of the JDK configured in Jenkins
    }

    stages {
        stage('Tool Install') {
            steps {
                echo 'Setting up tools...'
            }
        }

        stage('Git Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                sh 'sudo cp target/webapp.war /opt/apache-tomcat-9.0.65/webapps/'
            }
        }
    }
}
```

---

## **Key Points to Remember**

### **1. JAVA_HOME Configuration**
- Ensure the JDK path is correctly set in Jenkins.
- Configure it in **Manage Jenkins > Global Tool Configuration**.
- Example path for JDK 17: `/usr/lib/jvm/java-17-openjdk-amd64`.

### **2. Maven Configuration**
- Install Maven and configure it in **Manage Jenkins > Global Tool Configuration**.
- Ensure the correct version is selected in the pipeline.

### **3. Repository Access**
- If the Git repository is private:
  - Add credentials in Jenkins via **Manage Jenkins > Manage Credentials**.
  - Update the pipeline script to use the credentials:
    ```groovy
    checkout([$class: 'GitSCM', branches: [[name: '*/main']],
              userRemoteConfigs: [[url: 'https://github.com/your-repo.git',
                                   credentialsId: 'your-credentials-id']]])
    ```

### **4. Deployment Permissions**
- Avoid `sudo` errors during deployment by updating the `sudoers` file:
  ```
  jenkins ALL=(ALL) NOPASSWD: /bin/cp
  ```
- Alternatively, change the ownership of the Tomcat `webapps` folder:
  ```bash
  sudo chown -R jenkins:jenkins /opt/apache-tomcat-9.0.65/webapps
  ```

### **5. Correct File Paths**
- Ensure the `.war` file path matches your project setup.
- For Maven, the default location is `target/webapp.war`.

### **6. Testing the Pipeline**
- Add a simple test stage to verify that the application is deployed:
  ```groovy
  stage('Test Deployment') {
      steps {
          sh 'curl -I http://localhost:8080/webapp'
      }
  }
  ```

---

## **Common Errors and Solutions**

### **Error: `JAVA_HOME is not defined correctly`**
- Solution: Set `JAVA_HOME` in Jenkins global tools and ensure the correct JDK is selected in the pipeline.

### **Error: `sudo requires a password`**
- Solution: Add `NOPASSWD` for Jenkins in the `sudoers` file.
- Alternatively, change the folder ownership to avoid `sudo` entirely.

### **Error: `No credentials specified` during Git Checkout**
- Solution: Add Git credentials in Jenkins and reference them in the pipeline.

### **Error: `target/webapp.war not found`**
- Solution: Ensure `mvn clean package` runs successfully and generates the `.war` file.

---

## **Steps to Avoid Errors Next Time**
1. Verify the `JAVA_HOME` and Maven paths before running the pipeline.
2. Always test the pipeline script in **Pipeline Syntax Validator** in Jenkins.
3. Use the `echo` command to debug steps in the pipeline.
4. Regularly check permissions on deployment folders.

---

This guide should help prevent common mistakes and streamline your Jenkins Pipeline setup for future projects. 🚀

