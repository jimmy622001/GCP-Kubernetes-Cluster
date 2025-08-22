# CI/CD Pipeline Setup with Jenkins

This document provides instructions for setting up a CI/CD pipeline on a Jenkins server for integration with a Git repository.

## Prerequisites

- Jenkins installed and running on a server.
- Jenkins accessible via a web browser.
- Administrative access to Jenkins for plugin management and job creation.
- Access to the Git repository.

## Step 1: Jenkins Installation and Configuration

1. **Install Jenkins**
    - Download Jenkins from the [official website](https://www.jenkins.io/).
    - Follow the installation guide specific to your OS.

2. **Start Jenkins**
    - Access Jenkins at `http://localhost:8080` from your browser.

3. **Install Necessary Plugins**
    - Navigate to `Manage Jenkins` -> `Manage Plugins`.
    - Install the "Git", "GitLab Plugin" (or "GitHub Plugin" for GitHub repos), and "Pipeline" plugins.

## Step 2: Create a Jenkins Pipeline Job

1. **Create a New Pipeline Job**
    - Go to the Jenkins dashboard, click `New Item`.
    - Enter a job name, select `Pipeline`, and click `OK`.

2. **Configure the Pipeline**
    - Under "Pipeline" select `Pipeline script from SCM`.
    - Choose `Git` as the SCM and provide your repository URL.
    - Configure repository credentials if required.

## Step 3: Configure Build Triggers

1. **Set Build Triggers**
    - In "Build Triggers," select appropriate options:
        - Check `Poll SCM` for scheduled checks.
        - Use `Build when a change is pushed to GitLab` for webhooks if using GitLab.
      
## Alternative if webhooks are not available due to crumbs issue or other. (ssl not available)

1. **Set Build Trigger in Application (Gitlab)**
    - In "Project/Settings/Integrations" select Jenkins Add on and configure trigger:
        - Enable Integration.
        - Trigger = Push or Merge Request or Tag Push (select appropriate)
        - Add Jenkins Server Url.....
        - Enable SSl Verification
        - Add Project Name from Jenkins Task
        - Add Username.
        

## Step 4: Define the Pipeline Script

1. **Create a Jenkinsfile** (Jenkinsfile already present in the Application for this task)
    - Add a `Jenkinsfile` to your repository root.
    - In the configuration of the task if using ssh then add repository url as git@.....
    - Branch Specifier - select branch to build from.

## Step 5: Build and Monitor the Pipeline

1. **Trigger the Pipeline**
    - In Jenkins, select your pipeline job and click `Build Now`.

2. **Monitor Build Status**
    - Track the build process and view console outputs for errors or logs.

## Optional: Set Up Notifications

1. **Configure Notifications**
    - Setup email, Slack, or other notification systems under "Post-build Actions" for alerts on build status.