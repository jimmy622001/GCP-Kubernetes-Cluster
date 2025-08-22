# Gitlab Installation (Self Hosted)

### This documentation provides instructions for setting up a GitLab server

## Setting Up GitLab Server

### Install GitLab

1. Download the GitLab package from [official docs](https://about.gitlab.com/install/).
2. For Debian/Ubuntu, run:
   ```bash
   curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
   sudo EXTERNAL_URL="http://gitlab.example.com" apt-get install gitlab-ce
   ```

### Configure and Start GitLab

- Edit `/etc/gitlab/gitlab.rb` for customizations. (such as changing from ip to dns name and also ssl)
- Reconfigure and start GitLab:
  ```bash
  sudo gitlab-ctl reconfigure
  sudo gitlab-ctl start
  ```

### Access GitLab

- Access at `http://gitlab.example.com` to complete setup (or ip address if dns has not been configured yet.

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

### Create Gitlab groups and projects.

- Create Group and Project within it (see documentation CICD-Pipeline for Configuration of CICD)


