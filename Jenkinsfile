env.VERSION="3.0.$BUILD_ID"
node {
    try {
        stage('Checkout') {
            checkout scm
        }

        stage('Test') {
            sh 'make docker-test'
        }

        stage('Build') {
            sh 'make docker-build'
        }

        stage('Build docker image') {
            sh "VERSION=$VERSION make build-docker-image"
        }

        stage('Push docker image') {
            sh "VERSION=$VERSION make push-docker-image"
        }
    } catch (e) {
        currentBuild.result = 'FAILED'
    }
}
