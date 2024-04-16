pipeline {
    agent any

    stages {
        stage('Start') {
            steps {
                echo 'Lab_2: started by GitHub Webhook'
            }
        }

        stage('Image build') {
            steps {
                sh "docker build -t prikm:latest ."
                sh "docker tag prikm vitalik136/prikm:latest"
                sh "docker tag prikm vitalik136/prikm:$BUILD_NUMBER"
            }
        }

        stage('Push to registry') {
            steps {
                withDockerRegistry([ credentialsId: "dockerhub_token", url: "" ])
                {
                    sh "docker push vitalik136/prikm:latest"
                    sh "docker push vitalik136/prikm:$BUILD_NUMBER"
                }
            }
        }

        stage('Deploy image'){
            steps{
                sh "docker stop \$(docker ps -q) || true"
                sh "docker container prune --force"
                sh "docker image prune --force"
                sh "docker run -d -p 80:80 vitalik136/prikm"
            }
        }
    }   
}
