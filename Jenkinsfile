#!/usr/bin/env groovy

pipeline {
    agent any
    
    stages {
        stage('master'){
            steps {
                checkout scm
                bash "build_container.sh"
                bash "control_webapp.sh -a restart"
            }
        }
    }
}
