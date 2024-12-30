# Email Notifications Configuration with Jenkins and SendGrid

## **Introduction**
This document explains how to configure email notifications in Jenkins using SendGrid as the email service provider. Email notifications are crucial for informing stakeholders about the status of CI/CD pipelines.

---

## **Steps to Configure Email Notifications**

### **1. Create a SendGrid Account**
- Go to the [SendGrid website](https://sendgrid.com/) and create an account.
- Verify your email address to activate the account.

### **2. Set Up a Verified Sender**
1. In the SendGrid dashboard, navigate to **Sender Authentication**.
2. Click on **Create New Sender**.
3. Fill out the required fields:
   - **From Email**: Use an email address you own (e.g., `raslenm39@gmail.com`).
   - **Reply-To Email**: (Optional) Set it to the same email or another verified email (e.g., `raslenm39@outlook.com`).
   - **Address Details**: Provide accurate details for address verification.
4. After completing the form, you will receive an email to verify the sender. Click on the verification link to finalize the process.

### **3. Generate an API Key**
1. In the SendGrid dashboard, go to **Settings > API Keys**.
2. Click on **Create API Key**.
3. Provide a name for the API key (e.g., `Jenkins Email Notifications`).
4. Assign **Full Access** permissions.
5. Copy the generated API key and save it securely (you won't be able to view it again).

### **4. Configure Jenkins**

#### **Install the Email Extension Plugin**
1. Go to **Manage Jenkins > Plugin Manager**.
2. Search for and install the **Email Extension Plugin**.

#### **Set Up SMTP Configuration**
1. Go to **Manage Jenkins > Configure System**.
2. Under the **Extended E-mail Notification** section:
   - **SMTP Server**: `smtp.sendgrid.net`
   - **Default User E-mail Suffix**: Leave empty or use your domain.
   - **Reply-To Address**: Set to your verified SendGrid email (e.g., `raslenm39@gmail.com`).
   - **SMTP Port**: `587`
   - **Use SMTP Authentication**: Yes
   - **SMTP Username**: `apikey`
   - **SMTP Password**: Paste your SendGrid API key here.
   - **Use TLS**: Yes

#### **Test Email Configuration**
- Scroll down to the "Test configuration by sending test e-mail" section.
- Enter a recipient email address and click **Test Configuration**.
- If everything is configured correctly, you should receive the test email.

---

## **Example Pipeline with Email Notifications**
The following example shows how to add email notifications to your Jenkins pipeline:

```groovy
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
    }

    post {
        always {
            script {
                def jobName = env.JOB_NAME
                def buildNumber = env.BUILD_NUMBER
                def pipelineStatus = currentBuild.result ?: 'SUCCESS'
                def bannerColor = pipelineStatus.toUpperCase() == 'SUCCESS' ? 'green' : 'red'

                def body = """
                    <html>
                        <body>
                            <div style=\"border: 4px solid ${bannerColor}; padding: 10px;\">
                                <h2>${jobName} - Build ${buildNumber}</h2>
                                <div style=\"background-color: ${bannerColor}; padding: 10px;\">
                                    <h3 style=\"color: white;\">Pipeline Status: ${pipelineStatus.toUpperCase()}</h3>
                                </div>
                                <p>Check the <a href=\"${BUILD_URL}\">console output</a>.</p>
                            </div>
                        </body>
                    </html>
                """

                emailext(
                    subject: "${jobName} - Build ${buildNumber} - ${pipelineStatus.toUpperCase()}",
                    body: body,
                    to: 'raslenm39@gmail.com',
                    from: 'raslenm39@gmail.com',
                    replyTo: 'raslenm39@gmail.com',
                    mimeType: 'text/html'
                )
            }
        }
    }
}
```

---

## **Common Errors and Solutions**

### **1. Authentication Failed**
**Error:** `535 Authentication failed: The provided authorization grant is invalid, expired, or revoked.`
- Ensure the API key is correct.
- Verify that the sender email is verified in SendGrid.

### **2. The From Address Does Not Match a Verified Sender Identity**
**Error:** `550 The from address does not match a verified Sender Identity.`
- Ensure the "From Email" in the pipeline script matches the verified sender email in SendGrid.

### **3. Test Email Not Sent**
- Check SMTP settings and ensure the API key is correctly configured.
- Verify network connectivity to `smtp.sendgrid.net`.

---

## **Conclusion**
By following this guide, you can successfully set up email notifications in Jenkins using SendGrid. These notifications are essential for monitoring pipeline statuses and alerting stakeholders about successes or failures in the CI/CD process.

