pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'Java21'
    }

    environment {
        SONAR_PROJECT_KEY = 'demo-webapp'
        TOMCAT_URL = 'http://localhost:8081'
        WAR_FILE = 'target/demo-webapp.war'
    }

    stages {

        stage('Checkout') {
            steps {
                echo '📦 Checking out source code...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo '🔨 Building with Maven...'
                sh 'mvn clean package -DskipTests'
            }
            post {
                success { echo '✅ Build successful' }
                failure { echo '❌ Build failed' }
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running unit tests...'
                sh 'mvn test'
            }
            post {
                always {
                    junit testResults: 'target/surefire-reports/*.xml', allowEmptyResults: true
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo '🔍 Running SonarQube analysis...'
                withSonarQubeEnv('SonarQube') {
                    sh """
                        mvn sonar:sonar \
                          -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                          -Dsonar.projectName='demo-webapp' \
                          -Dsonar.java.binaries=target/classes
                    """
                }
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                echo '🚀 Deploying to Apache Tomcat...'
                deploy adapters: [
                    tomcat9(
                        credentialsId: 'tomcat-credentials',
                        path: '/demo-webapp',
                        url: "${TOMCAT_URL}"
                    )
                ], contextPath: '/demo-webapp', war: "${WAR_FILE}"
            }
            post {
                success { echo '✅ Deployed successfully to Tomcat' }
                failure { echo '❌ Deployment failed' }
            }
        }

    }

    post {
        success {
            echo '🎉 Pipeline completed successfully! App live at http://100.49.158.149:8081/demo-webapp/'
        }
        failure {
            echo '💥 Pipeline failed — check logs above'
        }
    }
}
