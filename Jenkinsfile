pipeline {
    agent {
        docker {
            image '34.77.252.64:8123/dev:0.1.0'
        }
    }

    stages {
        stage ('Copy source with GIT') {
            step {
                sh 'git clone https://github.com/Hallerus/boxfuse-origin.git /tmp/boxfuse'
            }

        }

        stage ('Build and deploy artifact to Nexus') {
            step {
                sh 'mvn --file /tmp/boxfuse clean deploy'
            }
        }

        stage ('Make Docker image') {
            step {
                sh 'docker build --tag=prod /tmp'
                sh 'docker tag prod 34.77.252.64:8123/prod:1 && docker login 34.77.252.64:8123 -u doc -p 123 && docker push 34.77.252.64:8123/prod:1'
            }
        }

        stage ('Run Docker on PROD') {
            step {
                sh 'ssh 35.228.253.106 <<EOF
                docker login 34.77.252.64:8123 -u doc -p 123 &&
                docker pull 34.77.252.64:8123/prod:1 &&
                docker stop $( docker ps -q) &&
                docker run -d -p 8080:8080 34.77.252.64:8123/prod:1
                EOF'
            }
        }
    }
}

/