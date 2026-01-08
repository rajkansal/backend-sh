pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/rajkansal/backend-sh'
            }
        }

        stage('Deploy Backend') {
            steps {
                sh '''
                chmod +x backend.sh
                ./backend.sh
                '''
            }
        }
    }

    post {
        success {
            echo '🎉 Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
}
