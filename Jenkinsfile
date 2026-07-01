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
        TOMCAT_HOME = '/opt/tomcat/apache-tomcat-10.1.56'
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
                withCredentials([usernamePassword(
                    credentialsId: 'tomcat-credentials',
                    usernameVariable: 'TOMCAT_USER',
                    passwordVariable: 'TOMCAT_PASS'
                )]) {
                    sh """
                        curl -u ${TOMCAT_USER}:${TOMCAT_PASS} \
                          -T ${WAR_FILE} \
                          "http://localhost:8081/manager/text/deploy?path=/demo-webapp&update=true"
                    """
                }
            }
            post {
                success { echo '✅ Deployed to http://100.49.158.149:8081/demo-webapp/' }
                failure { echo '❌ Deployment failed' }
            }
        }
    }

    post {
        success {
            echo '🎉 Pipeline complete! http://100.49.158.149:8081/demo-webapp/'
        }
        failure {
            echo '💥 Pipeline failed — check logs above'
        }
    }
}
