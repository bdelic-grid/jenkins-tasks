node("agent1") {
    def app
    def gitCommitShort

    if(env.GIT_BRANCH == "main") {
        stage("Clone repository") {
            checkout scm
        }

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
