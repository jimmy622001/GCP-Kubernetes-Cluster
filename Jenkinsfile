pipeline {
    agent any
    environment {
        GCP_PROJECT_ID = 'd-nbi-mikai-d6c'
        GKE_CLUSTER_NAME = 'mkai-cluster'
        GKE_CLUSTER_ZONE = 'europe-west1-b'
        GITLAB_CREDENTIALS_ID = '8ff0388f-8f5e-439b-b749-d76acd7253eb' // GitLab ssh key
        GCP_CREDENTIALS_ID = '5ac642d0-6a82-43b1-89d6-1ed092db6766' // GKE Service Account
        
    }

    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    checkout scmGit(branches: [[name: "*/${env.BRANCH_NAME}"]],
                                    extensions: [],
                                    userRemoteConfigs: [[url: 'git@35.241.229.130:ads/mkai/mkai-infrastructure.git', credentialsId: "${GITLAB_CREDENTIALS_ID}"]])
                }
            }
        }

        stage('Authenticate to GCP') {
            steps {
                script {
                    try {
                        withCredentials([file(credentialsId: "${GCP_CREDENTIALS_ID}", variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                            sh "gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"
                            sh "gcloud config set project ${GCP_PROJECT_ID}"
                            sh "gcloud auth list"
                        }
                    } catch (Exception e) {
                        echo "An error occurred during GCP authentication: ${e.getMessage()}"
                        currentBuild.result = 'FAILURE'
                        error("GCP authentication failed")
                    }
                }
            }
        }

        stage('Initializing Terraform') {
             steps {
                 script {
                     dir('GKE') {
                         sh 'terraform init'
                     }
                 }
             }
         }

        stage('Formatting Terraform Code') {
             steps {
                 script {
                     dir('GKE') {
                         sh 'terraform fmt -recursive'
                     }
                 }
             }
         }

        stage('Validating Terraform') {
             steps {
                 script {
                     dir('GKE') {
                         sh 'terraform validate'
                     }
                 }
             }
         }

        stage('Previewing the Infrastructure') {
             steps {
                 script {
                     dir('GKE') {
                         sh 'terraform plan'
                     }
                 }
             }
         }

        stage('Creating/Destroying a GKE Cluster') {
             steps {
                 script {
                     dir('GKE') {
                         try {
                             sh 'terraform refresh'
                             sh 'terraform apply --auto-approve'
                             //sh 'terraform destroy --auto-approve'
                         } catch (Exception e) {
                             echo "An error occurred while creating/destroying the GKE cluster: ${e.getMessage()}"
                             currentBuild.result = 'FAILURE'
                             error("GKE cluster creation failed")
                         }
                     }
                 }
             }
         }

        stage('Update Kubeconfig') {
            steps {
                script {
                    sh "gcloud container clusters get-credentials ${GKE_CLUSTER_NAME} --zone ${GKE_CLUSTER_ZONE} --project ${GCP_PROJECT_ID}"
                }
            }
        }

        stage('Initializing Helm') {
            steps {
                script {
                    // Add the Bitnami repo
                    sh 'helm repo add bitnami https://charts.bitnami.com/bitnami'
                                     
                    // Update helm repositories
                    sh 'helm repo update'
                }
            }
        }

        stage('Check Helm Installation') {
            steps {
                script {
                    try {
                        def helmVersion = sh(script: 'helm version --short', returnStdout: true).trim()
                        echo "Helm is installed. Version: ${helmVersion}"
                    } catch (Exception e) {
                        echo "Helm is not installed or not in PATH"
                        error("Helm check failed: ${e.message}")
                    }
                }
            }
        }


        stage('Build and Push Images') {
            steps {
                script {
                    sh '''
                        echo "Configuring Docker to use Google Cloud credentials..."
                        gcloud auth configure-docker europe-west1-docker.pkg.dev
                    '''
                    
                    sh '''
                        echo "Building and pushing images using Docker Compose..."
                        docker-compose -f Application/docker-compose.yml build
                        docker-compose -f Application/docker-compose.yml push
                    '''
                }
            }
        }



//         stage("Deploying Application") {
//             steps {
//                 script {
//                     withCredentials([file(credentialsId: "${GCP_CREDENTIALS_ID}", variable: 'GCP_CREDENTIALS_FILE')]) {
//                         sh "gcloud auth activate-service-account --key-file=${GCP_CREDENTIALS_FILE}"
//                         sh "gcloud config set project ${GCP_PROJECT_ID}"
//
//                         dir('Application') {
//                             sh "ls -la"
//                             if (fileExists('k8s')) {
//                                 sh "ls -la k8s"
//                                 sh "ls -la k8s"
//                             } else {
//                                 error("k8s directory does not exist in Application directory.")
//                             }
//
//                             try {
//                                 sh "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml"
//                                 sh "kubectl apply -f k8s/deployment.yml "
//                                 sh "kubectl apply -f k8s/ingress.yml "
//                             } catch (Exception e) {
//                                 echo "Error during deployment: ${e.getMessage()}"
//                                 currentBuild.result = 'FAILURE'
//                                 error("Deployment failed")
//                             }
                        }
                    }
                }
            }
        }
    }
}