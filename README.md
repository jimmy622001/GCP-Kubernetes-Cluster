# GKEMilitary

# this template will build a Ubuntu Jenkins Server in a new VPC with one public and one private subnet (can be increased if needed)

A Nat gateway has been created for the private subnet.
the Jenkins-Server can be configured to connect to Github or Gitlab both cloud and self hosted depending on the configuration for CICD pipeline with SSH or Personal Access Token.
The SSH setup process is as follows:
To set up a CI/CD pipeline from Jenkins to GitHub using SSH, you'll need to install and configure several Jenkins plugins. Here's a list of the essential plugins and some optional ones that can enhance your workflow: [1]
Ensure all services are installed on Jenkins server especially kubectl
Install sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin

To start the build using Terraform first a bucket has to be created.
The bucket name that has been configured to use for remote state files = "mkai" this can be changed to anything but then each backend.tf file must be adjusted accordingly.
#########################################################################################################################################################

# API Services that need to be enabled in GCP:

1. GKE Cluster Communication
   Kubernetes Engine API: Required for creating and managing GKE clusters.
2. Jenkins Server Communication
   Compute Engine API: If Jenkins is running on Compute Engine, this API will be necessary for any interactions with VM instances.
   Cloud Storage API: If you need to store artifacts or logs in Google Cloud Storage.
   Cloud Pub/Sub API: If you are using Pub/Sub for messaging between Jenkins and other services.
   Cloud SQL: Google Cloud SQL is a hosted and fully managed relational database service on Google's infrastructure.
3. Database Connectivity
   Cloud SQL API: If you are using Cloud SQL for your databases, this API is essential for managing and connecting to your Cloud SQL instances.
   Firestore API: If you are using Firestore as your database.
   BigQuery API: If you need to connect to BigQuery for data analytics.
4. Additional Services
   Identity and Access Management (IAM) API: To manage permissions related to your services.
   Service Management API: To manage and monitor your services.
5. Database Migration API:Manage Cloud Database Migration Service resources on Google Cloud Platform.
   ##################################################################################################################################################

# Automate the installation of the applications on the Jenkins server using the jenkins-startup-script.sh

should the automation script not run automatically as it is made to do then

1. login to the Jenkins Server using ssh console
2. upload the jenkins-startup-script.sh file to the server
3. chmod +x ./jenkins-startup-script.sh
4. run ./jenkins-startup-script.sh
5. install make on the jenkins server 

##################################################################################################################################################

# Essential plugins:

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

# To install these plugins:

Go to "Manage Jenkins" > "Manage Plugins"
Go to the "Available" tab
Search for each plugin and check the box next to it
Click "Install without restart" at the bottom of the page
After installation, you'll need to configure Jenkins to use SSH for GitHub: (or pat if ssh is not needed)
Generate an SSH key pair if you haven't already.
Add the public key to your GitHub account.
In Jenkins, go to "Manage Jenkins" > "Manage Credentials"
Add a new credential of type "SSH Username with private key"
Paste your private key into the appropriate field.
Then, when setting up your Jenkins job or pipeline:
Use the Git plugin to specify your repository URL (use the SSH URL from GitHub).
Select the SSH credential you created for authentication.

################################################################################################################################################
=======
# Mkai Infrastructure



## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin http://35.241.229.130/ads/mkai/mkai-infrastructure.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](http://35.241.229.130/ads/mkai/mkai-infrastructure/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Set auto-merge](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

