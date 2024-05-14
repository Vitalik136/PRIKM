pipeline {
    agent any

    environment {
        DOCKER_IMAGE = ' vitalik136/prikm'
    }

    stages {
        stage('Start') {
            steps {
                echo 'Lab_4: start for monitoring'
            }
        }

        stage('Image build') {
            steps {
                sh "docker build -t prikm:latest ."
                sh "docker tag prikm $DOCKER_IMAGE:latest"
                sh "docker tag prikm $DOCKER_IMAGE:$BUILD_NUMBER"
            }
            post{
                failure {
                    script {
                        // Send Telegram notification on success
                        telegramSend message: "Job Name: ${env.JOB_NAME}\nBuild #${env.BUILD_NUMBER} with branch '${env.GIT_BRANCH}' is ${currentBuild.currentResult}\nFailure stage: '${env.STAGE_NAME}'"
                    }
                }
            }
        }

        stage('Push to registry') {
            steps {
                withDockerRegistry([ credentialsId: "dockerhub_token", url: "" ])
                {
                    sh "docker push $DOCKER_IMAGE:latest"
                    sh "docker push $DOCKER_IMAGE:$BUILD_NUMBER"
                }
            }
            post{
                failure {
                    script {
                        // Send Telegram notification on success
                        telegramSend message: "Job Name: ${env.JOB_NAME}\nBuild #${env.BUILD_NUMBER} with branch '${env.GIT_BRANCH}' is ${currentBuild.currentResult}\nFailure stage: '${env.STAGE_NAME}'"
                    }
                }
            }
        }

        stage('Deploy image'){
            steps{
                sh "docker stop \$(docker ps | grep '$DOCKER_IMAGE' | awk '{print \$1}') || true"
                sh "docker container prune --force"
                sh "docker image prune --force"
                sh "docker run -d -p 80:80 $DOCKER_IMAGE"
            }
            post{
                failure {
                    script {
                        // Send Telegram notification on success
                        telegramSend message: "Job Name: ${env.JOB_NAME}\nBuild #${env.BUILD_NUMBER} with branch '${env.GIT_BRANCH}' is ${currentBuild.currentResult}\nFailure stage: '${env.STAGE_NAME}'"
                    }
                }
            }
        }
    }
    post{
        success{
            script{
                // Send Telegram notification on success
                telegramSend message: "Job Name: ${env.JOB_NAME}\nBuild #${env.BUILD_NUMBER} with branch '${env.GIT_BRANCH}' is ${currentBuild.currentResult}"
            }
        }
    }
   
}
