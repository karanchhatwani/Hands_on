environment {
  GOOGLE_APPLICATION_CREDENTIALS = credentials('nimble-unison-386200')
}
pipeline {
  agent any
  
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/karanchhatwani/Hands_on.git'
      }
    }
    
    stage('Terraform Init') {
  steps {
    withCredentials([file(credentialsId: 'nimble-unison-386200', variable: 'GCP_CREDENTIALS_FILE')]) {
      sh 'terraform init -var-file=${GCP_CREDENTIALS_FILE}'
    }
  }
 }

stage('Terraform Plan') {
  steps {
    withCredentials([file(credentialsId: 'nimble-unison-386200', variable: 'GCP_CREDENTIALS_FILE')]) {
      sh 'terraform plan -var-file=${GCP_CREDENTIALS_FILE}'
    }
  }
}

stage('Terraform Apply') {
  steps {
    withCredentials([file(credentialsId: 'nimble-unison-386200', variable: 'GCP_CREDENTIALS_FILE')]) {
      sh 'terraform apply -auto-approve -var-file=${GCP_CREDENTIALS_FILE}'
    }
  }
}
