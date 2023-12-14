pipeline {

    agent any
 environment {
       DOCKERHUB=credentials('DOCKERHUB')
    }
    

    stages {

        stage('Build') {

            steps {sh '''

                docker build -t michaelyarborough/flask-app:latest -t michaelyarborough/flask-app:v${BUILD_NUMBER} .
                '''
            }

        }
        stage('DockerPush') {

            steps {
                sh '''
                echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
                docker push michaelyarborough/flask-app-jenk:latest 
                docker push michaelyarborough/flask-app-jenk:v${BUILD_NUMBER}
                '''
            }

        }
        stage('Deploy') {

            steps { sh '''
                    kubectl apply -f ./kubernetes
                    kubectl rollout restart deployment/flask-deployment
                    kubectl rollout restart deployment/nginx-deployment                   
                '''
            }

        }
        stage('CleanUp') {

            steps {

                sh 'docker system prune -f'
                
            }

        }
      
    }

}
