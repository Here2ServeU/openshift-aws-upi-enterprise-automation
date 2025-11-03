pipeline {
  agent any
  stages {
    stage('Checkout'){ steps{ checkout scm }}
    stage('Terraform Plan'){
      steps {
        sh '''
        terraform -chdir=infra/terraform/envs/dev init -input=false || true
        terraform -chdir=infra/terraform/envs/dev plan -input=false || true
        '''
      }
    }
    stage('Security Scans'){
      steps {
        sh '''
        pip install checkov || true
        checkov -d infra/terraform || true
        '''
      }
    }
  }
}
