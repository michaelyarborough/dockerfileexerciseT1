pipeline {

    agent any
 environment {
       DOCKERHUB=credentials('DOCKERHUB')
    }
    

    stages {

         stage('Init') {

            steps { sh '''
                ssh -i ~/.ssh/id_rsa jenkins@10.154.0.26 << EOF
                docker rm -f $(docker ps -qa) || true
                docker network create new-network || true
                '''
            }

        }

        stage('Build') {

            steps {

                sh 'docker build -t michaelyarborough/flask-app-jenk:v${BUILD_NUMBER} .'

                sh 'docker build -t michaelyarborough/mynginx-jenk:v${BUILD_NUMBER} -f Dockerfile.nginx .'

            }

        }

        stage('Deploy') {

            steps { sh '''
                    ssh -i ~/.ssh/id_rsa jenkins@10.154.0.26 << EOF
                    docker run -d --name flask-app --network new-network flask-app:latest
                    docker run -d -p 80:80 --name mynginx --network new-network mynginx:latest
                '''
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
                docker push michaelyarborough/flask-app-jenk:latest || true
                docker push michaelyarborough/flask-app-jenk:v${BUILD_NUMBER} || true
                docker push michaelyarborough/mynginx-jenk:latest || true
                docker push michaelyarborough/mynginx-jenk:v${BUILD_NUMBER} || true
                '''
            }

        }
    }

}
