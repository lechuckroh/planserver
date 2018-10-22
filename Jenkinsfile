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
            sh 'make build-docker-image'
        }
    } catch (e) {
        currentBuild.result = 'FAILED'
    }
}
