pipeline {
    agent {
        docker {
           image '35.228.116.96:8123/dev:0.2.0'
        }
    }
    
    stages {
        stage ('Copy source with GIT') {
            steps {
                sh 'git clone https://github.com/Hallerus/boxfuse-origin.git /tmp/boxfuse'
            }

        }

        stage ('Build and deploy artifact to Nexus') {
            steps {
                sh 'cd /tmp && ls -al'
                sh 'mvn --file /tmp/boxfuse/pom.xml clean deploy'
            }
        }

        stage ('Make Docker image') {
            steps {
                sh 'docker build --tag=prod /tmp'
                sh 'docker tag prod 35.228.116.96:8123/prod:1 && docker login 35.228.116.96:8123 -u admin -p 123 && docker push 35.228.116.96:8123/prod:1'
            }
        }
        /*
        stage ('Run Docker on PROD') {
            steps {
                sh '''ssh 35.228.253.106 << EOF
                docker login 35.228.116.96:8123 -u admin -p 123 && 
                docker pull 35.228.116.96:8123/prod:1 &&
                docker stop $( docker ps -q) &&
                docker run -d -p 8080:8080 35.228.116.96:8123/prod:1
                EOF'''
            }
        }*/
    }
}