pipeline {
    agent {
        docker {
           image '35.228.116.96:8123/dev:0.5.4'
           args '-v /var/run/docker.sock:/var/run/docker.sock -u root:root'
        }
    }
    
    stages {
        stage ('Copy source with GIT') {
            steps {
                sh 'rm -rf /tmp/boxfuse'
                sh 'cd /tmp && ls -al'
                sh 'git clone https://github.com/Hallerus/boxfuse-origin.git /tmp/boxfuse'
            }
        }

        stage ('Confugure, Build and deploy artifact to Nexus') {
            steps {
                sh 'mv -f /tmp/settings.xml /etc/maven'
                sh 'mvn --file /tmp/boxfuse/pom.xml clean deploy'
            }
        }

        stage ('Make Docker image and push to Nexus') {
            steps {
                sh 'cp -f /tmp/boxfuse/target/hello-1.0.war /tmp'
                sh 'docker build --tag=prod /tmp'
                sh 'docker login 35.228.116.96:8123 -u doc -p 123 && docker tag prod 35.228.116.96:8123/prod:1 && docker push 35.228.116.96:8123/prod:1'
            }
        }

        stage ('Run Docker on PROD') {
            steps {
            sh 'ssh-keyscan -H 34.88.115.101 >> ~/.ssh/known_hosts'
            sh '''ssh 34.88.115.101 << EOF
sudo docker system prune -f
sudo docker ps -q | xargs docker kill 
sudo docker pull 35.228.116.96:8123/prod:1
sudo docker run -d -p 8080:8080 35.228.116.96:8123/prod:1                
EOF'''
            }
        }
    }
}

