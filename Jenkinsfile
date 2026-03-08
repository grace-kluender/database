pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "gracekluender/database"
        DOCKER_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Container Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Security Scan') {
            steps {
                sh 'docker scout cves $DOCKER_IMAGE:$DOCKER_TAG || true'
            }
        }

        stage('Container Push') {
            when {
                anyOf {
                    expression { env.GIT_BRANCH == 'origin/develop' }
                    expression { env.GIT_BRANCH == 'origin/main' }
                    expression { env.GIT_BRANCH.startsWith('origin/release') }
                }
            }
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    sh '''
                    echo $PASSWORD | docker login -u $USERNAME --password-stdin
                    docker push $DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }

        stage('Deploy Dev') {
            when { branch 'develop' }
            steps {
                echo "Deploying database to Dev"
            }
        }

        stage('Deploy Staging') {
            when { branch pattern: "release/*", comparator: "GLOB" }
            steps {
                echo "Deploying database to Staging"
            }
        }

        stage('Deploy Production') {
            when { branch 'main' }
            steps {
                input message: "Approve production database deployment?"
                echo "Deploying database to Production"
            }
        }

    }
}