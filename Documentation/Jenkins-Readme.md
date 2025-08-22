### This documentation provides instructions for setting up a Jenkins server.

# Jenkins Server Installation (Ubuntu)

## Manual Installation (Automated see below with script use)

## Install Jenkins

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

###########################################################################################################

#### Automate the installation of the applications on the Jenkins server using the jenkins-startup-script.sh

should the automation script not run automatically as it is made to do then

1. login to the Jenkins Server using ssh console
2. upload the jenkins-startup-script.sh file to the server
3. chmod +x ./jenkins-startup-script.sh
4. run ./jenkins-startup-script.sh
5. install make on the jenkins server 

#############################################################################################################

##### Jenkins Server Essential plugins:

Git plugin
This is the core plugin for Git integration in Jenkins. [2]
It allows Jenkins to clone repositories and interact with Git.

GitHub plugin
Provides deeper integration with GitHub, including webhook support.

Credentials plugin
Manages credentials for various purposes, including SSH keys.

SSH Credentials plugin
Allows you to store SSH private keys in Jenkins for authentication. [3]

Optional but recommended plugins:

Pipeline plugin
Supports creating pipelines as code, which is a modern best practice for CI/CD.

GitHub Branch Source plugin
Automatically discovers branches and pull requests from GitHub.

Blue Ocean plugin
Provides a modern, visual interface for Jenkins pipelines.

Workspace Cleanup plugin
Helps keep your Jenkins workspace clean between builds.
################################################################################################################################################

##### To install these plugins:

Go to "Manage Jenkins" > "Manage Plugins"
Go to the "Available" tab
Search for each plugin and check the box next to it
Click "Install without restart" at the bottom of the page
After installation, you'll need to configure Jenkins to use SSH for Git: (or Personal/Group Access Token if ssh is not needed)
Generate an SSH key pair if you haven't already.
Add the public key to your Git account.
In Jenkins, go to "Manage Jenkins" > "Manage Credentials"
Add a new credential of type "SSH Username with private key"
Paste your private key into the appropriate field.
Then, when setting up your Jenkins job or pipeline:
Use the Git plugin to specify your repository URL (use the SSH URL from GitHub or Gitlab).
Select the SSH credential you created for authentication.

################################################################################################################################################



