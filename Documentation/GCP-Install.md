#### GCP Configuration Included

##### this template will build a Ubuntu Jenkins Server in a new VPC with one public and one private subnet (can be increased if needed)

A Nat gateway has been created for the private subnet.
the Jenkins-Server can be configured to connect to Github or Gitlab both cloud and self hosted depending on the configuration for CICD pipeline with SSH or Personal Access Token.
The SSH setup process is as follows:
To set up a CI/CD pipeline from Jenkins to GitHub using SSH, you'll need to install and configure several Jenkins plugins. Here's a list of the essential plugins and some optional ones that can enhance your workflow: [1]
Ensure all services are installed on Jenkins server especially kubectl
Install sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin

To start the build using Terraform first a bucket has to be created.
The bucket name that has been configured to use for remote state files = "mkai" this can be changed to anything but then each backend.tf file must be adjusted accordingly.
#########################################################################################################################################################

##### API Services that need to be enabled in GCP:

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