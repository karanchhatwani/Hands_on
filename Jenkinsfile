pipeline {
    agent any

   
        stages {
            stage('Build') {
             steps {
                
                sh 'whoami'
                sh 'sudo kubectl apply -f /root/sidecar/secret.yaml'
                sh 'sudo kubectl apply -f /root/sidecar/pod.yaml'
            }
        }
}
}






