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

            steps {sh '''

                docker build -t michaelyarborough/flask-app-jenk:latest -t michaelyarborough/flask-app-jenk:v${BUILD_NUMBER} .
                docker build -t michaelyarborough/mynginx-jenk:latest -t michaelyarborough/mynginx-jenk:v${BUILD_NUMBER} -f Dockerfile.nginx .
                '''
            }

        }

        stage('Deploy') {

            steps { sh '''
                    ssh -i ~/.ssh/id_rsa jenkins@10.154.0.26 << EOF
                    docker run -d --name flask-app --network new-network michaelyarborough/flask-app-jenk
                    docker run -d -p 80:80 --name mynginx --network new-network michaelyarborough/mynginx-jenk
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
                docker push michaelyarborough/flask-app-jenk:latest 
                docker push michaelyarborough/flask-app-jenk:v${BUILD_NUMBER}
                docker push michaelyarborough/mynginx-jenk:latest || true
                docker push michaelyarborough/mynginx-jenk:v${BUILD_NUMBER} || true
                '''
            }

        }
    }

}
