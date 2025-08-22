# CI/CD Configuration: Jenkins and GitLab

This documentation provides instructions for setting up a Jenkins server, a GitLab server, and configuring a CI/CD pipeline between them for local deployment.

## Setting Up Jenkins Server

### Install Jenkins

1. Download Jenkins from the [official website](https://www.jenkins.io/download/).
2. For Debian/Ubuntu, run the following commands:
   ```bash
   wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
   sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
   sudo apt-get update
   sudo apt-get install jenkins
   ```

### Start Jenkins

- Start Jenkins:
  ```bash
  sudo systemctl start jenkins
  ```
- Enable Jenkins to start on boot:
  ```bash
  sudo systemctl enable jenkins
  ```

### Access Jenkins

- Access Jenkins at `http://localhost:8080`.
- Unlock Jenkins using the password from `/var/lib/jenkins/secrets/initialAdminPassword`.

### Install Required Plugins

- Navigate to Jenkins Dashboard > Manage Jenkins > Manage Plugins.
- Install plugins like Git, GitLab, and Docker.

### Configure Environment Variables

- Go to Jenkins Dashboard > Manage Jenkins > Configure System.
- Set necessary environment variables.

## Setting Up GitLab Server

### Install GitLab

1. Download the GitLab package from [official docs](https://about.gitlab.com/install/).
2. For Debian/Ubuntu, run:
   ```bash
   curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
   sudo EXTERNAL_URL="http://gitlab.example.com" apt-get install gitlab-ce
   ```

### Configure and Start GitLab

- Edit `/etc/gitlab/gitlab.rb` for customizations.
- Reconfigure and start GitLab:
  ```bash
  sudo gitlab-ctl reconfigure
  sudo gitlab-ctl start
  ```

### Access GitLab

- Access at `http://gitlab.example.com` to complete setup.

## Setting Up CI/CD Pipeline

### Configure SSH Access

- Generate SSH key on Jenkins:
  ```bash
  ssh-keygen -t rsa -b 4096 -C "jenkins@example.com"
  ```
- Add Jenkins's public key to GitLab Deploy Keys.

### Alternative Authentication

- Use GitLab Personal Access Token.
- Store securely in Jenkins credentials.

### Create Jenkins Pipeline

- Create a `Jenkinsfile` in your GitLab repository.
- Define pipeline stages: Build, Test, Deploy.

### Configure Jenkins to Poll GitLab

- Use GitLab plugin for job triggers on push events.

### Update Jenkins Management Tools

- Regularly update through Jenkins Dashboard > Manage Jenkins > Plugin Manager.

## Jenkinsfile Example

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                // your build commands
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                // your test commands
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // your deploy commands
            }
        }
    }
}
```

This guide provides a foundational setup for a local Jenkins and GitLab CI/CD pipeline.