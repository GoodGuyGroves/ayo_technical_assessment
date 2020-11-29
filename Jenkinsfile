#!/usr/bin/env groovy

pipeline {
    agent any
    environment {
        PATH = "${PATH}:/usr/local/bin/"
    }
    stages {
        stage('master'){
            steps {
                checkout scm
                sh "./build_container.sh"
                sh "./control_webapp.sh -a restart"
            }
        }
    }
}
