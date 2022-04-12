pipeline {
  agent any 
  stages {
    stage("Build project") {
      steps {
        sh("make build")
        
      }
    }

    stage("Push to dockerhub") {
      steps {
        sh("make push")
      }
    }

  }
}