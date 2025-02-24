pipeline {
    agent { label "agent1" }

    stages {
        stage("Checkstyle") {
            when {
                changeRequest() 
            }
            steps {
                dir("./spring-petclinic") {
                    script {
                        sh "./mvnw checkstyle:checkstyle"
                    }
                    archiveArtifacts artifacts: "checkstyle-result.xml"
                }
            }
        }

        stage("Test") {
            when {
                changeRequest()  
            }
            steps {
                dir("./spring-petclinic") {
                    script {
                        sh "./mvnw test"
                    }
                }
            }
        }

        stage("Build") {
            when {
                changeRequest()  
            }
            steps {
                dir("./spring-petclinic") {
                    script {
                        sh "./mvnw clean install"
                    }
                }
            }
        }

        stage("Create Docker Image for Change Request") {
            when {
                changeRequest()  
            }
            steps {
                script {
                    def gitCommit = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    withCredentials([usernamePassword(credentialsId: "docker-login", usernameVariable: "DOCKER_USER", passwordVariable: "DOCKER_PASSWORD")]) {
                        sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASSWORD}"
                        sh "docker build -t ${DOCKER_USER}/mr:${gitCommit} ."
                        sh "docker push ${DOCKER_USER}/mr:${gitCommit}"
                    }
                }
            }
        }

        stage("Create Docker Image for Main") {
            when {
                branch "main"  
            }
            steps {
                script {
                    def gitCommit = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    withCredentials([usernamePassword(credentialsId: "docker-login", usernameVariable: "DOCKER_USER", passwordVariable: "DOCKER_PASSWORD")]) {
                        sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASSWORD}"
                        sh "docker build -t ${DOCKER_USER}/main:${gitCommit} ."
                        sh "docker push ${DOCKER_USER}/main:${gitCommit}"
                    }
                }
            }
        }
    }
}
