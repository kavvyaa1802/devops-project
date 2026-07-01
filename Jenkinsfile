pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'Java21'
    }

    environment {
        SONAR_PROJECT_KEY = 'demo-webapp'
        TOMCAT_URL = 'http://localhost:8081'
        APP_URL = 'http://100.49.158.149:8081/demo-webapp/'
        SONAR_URL = 'http://100.49.158.149:9000/dashboard?id=demo-webapp'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
        timeout(time: 20, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                echo '📦 Checking out source code...'
                checkout scm
                script {
                    env.GIT_COMMIT_MSG = sh(
                        script: 'git log -1 --pretty=%B',
                        returnStdout: true
                    ).trim()
                    env.GIT_AUTHOR = sh(
                        script: 'git log -1 --pretty=%an',
                        returnStdout: true
                    ).trim()
                }
                echo "📝 Commit: ${env.GIT_COMMIT_MSG}"
                echo "👤 Author: ${env.GIT_AUTHOR}"
            }
        }

        stage('Build') {
            steps {
                echo '🔨 Building with Maven...'
                sh 'mvn clean package -DskipTests'
            }
            post {
                success { echo '✅ Build succeeded' }
                failure { error '❌ Build failed — stopping pipeline' }
            }
        }

        stage('Test & Coverage') {
            steps {
                echo '🧪 Running unit tests + JaCoCo coverage...'
                sh 'mvn verify'
            }
            post {
                always {
                    junit testResults: 'target/surefire-reports/*.xml',
                          allowEmptyResults: true
                }
                success { echo '✅ All tests passed' }
                failure { error '❌ Tests failed — stopping pipeline' }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo '🔍 Running SonarQube analysis...'
                withSonarQubeEnv('SonarQube') {
                    sh '''
                        mvn sonar:sonar \
                          -Dsonar.projectKey=demo-webapp \
                          -Dsonar.projectName=demo-webapp \
                          -Dsonar.host.url=http://localhost:9000 \
                          -Dsonar.token=sqp_e2d3a5363477db7cb5fb8b01053170e541700a25 \
                          -Dsonar.java.binaries=target/classes \
                          -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                echo '🚦 Checking SonarQube Quality Gate...'
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
            post {
                success { echo '✅ Quality Gate passed' }
                failure { error '❌ Quality Gate failed — deployment blocked!' }
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
                    sh '''
                        RESULT=$(curl -s -u "$TOMCAT_USER:$TOMCAT_PASS" \
                          -T target/demo-webapp.war \
                          "http://localhost:8081/manager/text/deploy?path=/demo-webapp&update=true")
                        echo "Tomcat response: $RESULT"
                        echo "$RESULT" | grep -q "^OK" || exit 1
                    '''
                }
            }
            post {
                success { echo "✅ Deployed! Live at ${env.APP_URL}" }
                failure { error '❌ Deployment failed' }
            }
        }

        stage('Smoke Test') {
            steps {
                echo '🔥 Running smoke test on deployed app...'
                sh '''
                    sleep 5
                    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
                        http://localhost:8081/demo-webapp/)
                    echo "HTTP Response Code: $HTTP_CODE"
                    if [ "$HTTP_CODE" != "200" ]; then
                        echo "❌ Smoke test failed! App returned $HTTP_CODE"
                        exit 1
                    fi
                    echo "✅ Smoke test passed! App is live and responding."
                '''
            }
        }
    }

    post {
        success {
            echo """
            ╔══════════════════════════════════════════╗
            ║     🎉 PIPELINE SUCCEEDED 🎉              ║
            ╠══════════════════════════════════════════╣
            ║  App URL  : ${env.APP_URL}
            ║  Sonar    : ${env.SONAR_URL}
            ║  Build    : #${env.BUILD_NUMBER}
            ║  Author   : ${env.GIT_AUTHOR}
            ╚══════════════════════════════════════════╝
            """
        }
        failure {
            echo """
            ╔══════════════════════════════════════════╗
            ║     💥 PIPELINE FAILED 💥                 ║
            ╠══════════════════════════════════════════╣
            ║  Build    : #${env.BUILD_NUMBER}
            ║  Check console output for details
            ╚══════════════════════════════════════════╝
            """
        }
        always {
            echo '🧹 Cleaning up workspace...'
            cleanWs()
        }
    }
}
