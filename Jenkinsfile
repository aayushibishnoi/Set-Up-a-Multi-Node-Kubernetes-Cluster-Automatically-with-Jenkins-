pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/yourusername/K8sJenkinsAutomation.git', branch: 'main'
            }
        }
        stage('Install Ansible') {
            steps {
                sh 'sudo apt update && sudo apt install -y ansible'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                ansiblePlaybook(
                    playbook: 'ansible/k8s-cluster-setup.yml',
                    inventory: 'ansible/inventory.yml',
                    credentialsId: 'ssh-key-credentials',
                    colorized: true
                )
            }
        }
        stage('Test Cluster') {
            steps {
                sh 'bash test_cluster.sh'
            }
        }
    }
}
