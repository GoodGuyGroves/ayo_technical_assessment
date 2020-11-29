#!/usr/bin/env groovy

pipeline {
    agent any
    
    stages {
        stage('master'){
            steps {
                checkout scm
                sh 'pwd'
                sh 'ls -lrR'
                sh "build_container.sh"
                sh "control_webapp.sh -a restart"
            }
        }
    }
}
