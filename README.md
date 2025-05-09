# Set Up a Multi-Node Kubernetes Cluster Automatically with Jenkins

A project to automate the deployment of a multi-node Kubernetes cluster using Jenkins and Ansible.

# Project Structure
Create the following directory structure:

    k8s-jenkins-automation/
    ├── ansible/
    │   ├── inventory.yml
    │   ├── k8s-cluster-setup.yml
    │   └── roles/
    │       ├── common/
    │       │   └── tasks/
    │       │       └── main.yml
    │       ├── master/
    │       │   └── tasks/
    │       │       └── main.yml
    │       └── worker/
    │           └── tasks/
    │               └── main.yml
    ├── Jenkinsfile
    ├── test_cluster.sh
    └── README.md

## Features
- Automates Kubernetes setup with a Jenkins pipeline.
- Uses Ansible to configure master and worker nodes.
- Installs Docker, kubeadm, kubelet, and kubectl.
- Tests cluster setup and node communication.

## Directory Structure
- `ansible/`: Ansible playbooks and roles.
- `Jenkinsfile`: Jenkins pipeline definition.
- `test_cluster.sh`: Cluster verification script.

## Setup
1. Set up 3 Ubuntu 22.04 VMs (1 master, 2 workers).
2. Install Jenkins: `sudo apt install jenkins`.
3. Install plugins: Ansible, SSH Credentials, Git.
4. Configure SSH credentials in Jenkins.
5. Create a pipeline job with this repository.
6. Run the pipeline to set up the cluster.
7. Test with: `bash test_cluster.sh`.
