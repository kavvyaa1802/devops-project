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
                          -Dsonar.projectKey=demo-webapp \
                          -Dsonar.projectName=demo-webapp \
                          -Dsonar.host.url=http://localhost:9000 \
                          -Dsonar.token=sqp_e2d3a5363477db7cb5fb8b01053170e541700a25 \
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
        }

    }

    post {
        success {
            echo '🎉 Pipeline completed! App live at http://100.49.158.149:8081/demo-webapp/'
        }
        failure {
            echo '💥 Pipeline failed — check logs above'
        }
    }
}
