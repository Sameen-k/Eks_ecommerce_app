pipeline {
  agent {label 'awsDeploy2'}
  environment{
      DOCKERHUB_CREDENTIALS = credentials('kaedmond24-dockerhub')
      }

    stages {
     
      stage ('Build') {
        steps {
            sh '''
              sudo docker build -f dockerfile.be -t kaedmond24/ecommerce-d9-be .
              sudo docker build -f dockerfile.fe -t kaedmond24/ecommerce-d9-fe .
              '''
          }
        }
      stage ('Login') {
        steps {
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        }
      }
      stage ('Push') {
        steps {
            sh '''
              sudo docker push kaedmond24/ecommerce-d9-be
              sudo docker push kaedmond24/ecommerce-d9-fe
              '''
          }
        }
      stage ('Backend App Deployment') {
        agent {label 'awsDeploy2'}
        steps {
            sh 'kubectl apply -f deployment_be.yaml'
          }
        }
      stage ('Frontend App Deployment') {
        agent {label 'awsDeploy2'}
        steps {
            sh 'kubectl apply -f deployment_fe.yaml'
          }
        }
      stage ('Deploy App Services') {
        agent {label 'awsDeploy2'}
        steps {
            sh 'kubectl apply -f service.yaml'
          }
        }
      stage ('Deploy Ingress') {
        agent {label 'awsDeploy2'}
        steps {
            sh 'kubectl apply -f ingress.yaml '
          }
        }
       }
   }
