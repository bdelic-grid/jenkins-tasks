node("agent1") {
    def app

    stage("Clone repository") {
        checkout scm
    }

    if(env.BRANCH_NAME == "main") {
        stage("Build image") {
            app = docker.build("bole1709/main")
        }

        stage("Push image") {
            docker.withRegistry("", "docker_hub_credentials") {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }
        }
    }
    
}
