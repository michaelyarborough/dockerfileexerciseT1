pipeline {

    agent any
 environment {
       DOCKERHUB=credentials('DOCKERHUB')
    }
    

    stages {

         stage('Init') {

            steps {

                sh 'docker rm -f $(docker ps -qa) || true'

                sh 'docker network create new-network || true'

            }

        }

        stage('Build') {

            steps {

                sh 'docker build -t flask-app .'

                sh 'docker build -t mynginx -f Dockerfile.nginx .'

            }

        }

        stage('Deploy') {

            steps {

                sh 'docker run -d --name flask-app --network new-network flask-app:latest'

                sh 'docker run -d -p 80:80 --name mynginx --network new-network mynginx:latest'

            }

        }
        stage('CleanUp') {

            steps {

                sh 'docker system prune -f'
                
            }

        }
        
        stage('DockerPush') {

            steps {
                sh '''
                echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
                docker push michaelyarborough/flask-app
                docker push michaelyarborough/mynginx
                '''
            }

        }
    }

}
