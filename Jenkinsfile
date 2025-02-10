node {
    def app

    stage("Clone repository") {
        checkout scm
    }

    stage("Build image") {
        app = docker.build("bole1709/main/petclinic")
    }

    stage("Push image") {
        docker.withRegistry("", "docker_hub_credentials") {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
