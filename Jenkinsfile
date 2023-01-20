pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
        stage('Poll Code Repository') {
            steps {
                git credentialsId: 'git', url: 'git@github.com:asatyam78/spring-boot-chat-app.git'
            }
        }
        stage('terraform format') {
            when {
                expression {action == 'apply'}
            }
            steps {
                sh 'terraform fmt'
            }
        }
        stage('terraform initialize') {
            when {
                expression {action == 'apply'}
            }
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform validate') {
            when {
                expression {action == 'apply'}
            }
            steps{
                sh 'terraform validate'
            }
        }
        stage('terraform plan') {
            when {
                expression {action == 'apply'}
            }
            steps{
                sh 'terraform plan'
            }
        }
        stage('terraform apply') {
            when {
                expression {action == 'apply'}
            }
            steps{
                sh 'terraform apply --auto-approve'
            }
        }
        stage('terraform destroy') {
            when {
                expression {action == 'destroy'}
            }
            steps{
                script {
                    dir('aks-terraform/') {
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }
}