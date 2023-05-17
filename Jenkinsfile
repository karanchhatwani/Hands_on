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
        // Initialize Terraform
        sh 'terraform init'
      }
    }
    
    stage('Terraform Plan') {
      steps {
        sh 'terraform plan'
      }
    }
    
    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
  }
}
