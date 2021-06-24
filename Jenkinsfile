pipeline {
    agent {
        docker {
            label 'Dev Image on local Nexus repo'
            image 'dev:0.1.0'
            registryUrl 'http://34.77.252.64:8123'
            registryCredentialsId '6ac9b23e-2a6a-45b2-80bf-0a1374f32ed1'
    }
    
    stages {
        stage ('Copy source with GIT') {
            steps {
                sh 'git clone https://github.com/Hallerus/boxfuse-origin.git /tmp/boxfuse'
            }

        }

        stage ('Build and deploy artifact to Nexus') {
            steps {
                sh 'mvn --file /tmp/boxfuse clean deploy'
            }
        }

        stage ('Make Docker image') {
            steps {
                sh 'docker build --tag=prod /tmp'
                sh 'docker tag prod 34.77.252.64:8123/prod:1 && docker login 34.77.252.64:8123 -u admin -p 123 && docker push 34.77.252.64:8123/prod:1'
            }
            withCredentials([usernamePassword(credentialsId: '6ac9b23e-2a6a-45b2-80bf-0a1374f32ed1', passwordVariable: 'password', usernameVariable: 'username')]) {
                sh 'docker login -u $username -p $password '
            }
        }

        stage ('Run Docker on PROD') {
            steps {
                sh '''ssh 35.228.253.106 << EOF
                docker login 34.77.252.64:8123 -u admin -p 123 &&
                docker pull 34.77.252.64:8123/prod:1 &&
                docker stop $( docker ps -q) &&
                docker run -d -p 8080:8080 34.77.252.64:8123/prod:1
                EOF'''
            }
        }
    }
}