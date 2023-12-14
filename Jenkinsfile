pipeline {

    agent any
  

    stages {
        stage('Init') {
            steps {
                script {
                    if (env.GIT_BRANCH == "origin/main") {
                        sh '''
                        kubectl create namespace prod || echo "Namespace prod already exists"
                        '''
                    } else if (env.GIT_BRANCH == "origin/main"){
                        sh '''
                        kubectl create namespace dev || echo "Namespace dev already exists"
                        '''
                    } else {
                        sh'''
                        echo "Environment not Recognised"
                        '''
                    }

                }
                
            }

        }
        stage('Build') {
            steps {
                script {
                    if (env.GIT_BRANCH == "origin/main") {
                        sh '''
                        docker build -t michaelyarborough/flask-app:latest -t michaelyarborough/flask-app:prod-v${BUILD_NUMBER} .
                        '''
                    } else if (env.GIT_BRANCH == "origin/main"){
                        sh '''
                        docker build -t michaelyarborough/flask-app:latest -t michaelyarborough/flask-app:dev-v${BUILD_NUMBER} .
                        '''
                    } else {
                        sh'''
                        echo "Branch not Recognised"
                        '''
                        
                    }

                }
                
            }

        }
        stage('DockerPush') {

            steps {
                 script {
                    if (env.GIT_BRANCH == "origin/main") {
                sh '''
                docker push michaelyarborough/flask-app:latest 
                docker push michaelyarborough/flask-app:prod-v${BUILD_NUMBER}
                '''
                    } else if (env.GIT_BRANCH == "origin/main")
                    sh '''
                     docker push michaelyarborough/flask-app:latest 
                     docker push michaelyarborough/flask-app:dev-v${BUILD_NUMBER}
                    '''
                }
                
            }

        }
        stage('Deploy') {

            steps { 
                script {
                    if (env.GIT_BRANCH == "origin/main") {
                    sh '''
                    kubectl apply -n prod -f ./kubernetes
                    kubectl set image deployment/flask-deployment flask-app=michaelyarborough/flask-duo:prod-v${BUILD_NUMBER} -n prod
                    '''
                    } else if (env.GIT_BRANCH == "origin/main")
                    sh '''
                    kubectl apply -n dev -f ./kubernetes
                    kubectl set image deployment/flask-deployment flask-app=michaelyarborough/flask-duo:dev-v${BUILD_NUMBER} -n dev
                    '''
                }
             
            }

        }
             
    }

}
