pipeline {
    agent any
    environment {
        ANSIBLE_SERVER  = "<ansible-server-ip-address>"
    }

    stages {
        stage('copy files to ansible server') {
            steps {
                script {
                    echo "copying all necessary files to ansible control node"
                    sshagent(['<ssh-key-id-credential>']) {
                        sh "scp -o StrictHostKeyChecking=no Ansible/* root@${ANSIBLE_SERVER}:/root"

                        withCredentials([sshUserPrivateKey(credentialsId: "<credentials-id>", keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh 'scp $keyfile root@$ANSIBLE_SERVER:/root/ssh-key.pem'
                        }
                    }
                }
            }
        }
        stage("execute ansible playbook") {
            steps {
                script {
                    echo "calling ansible playbook to configure ec2 instances..."
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.hosts = env.ANSIBLE_SERVER
                    remote.allowAnyHosts = true
                    withCredentials([sshUserPrivateKey(credentialsId: "<credentials-id>", keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                        remote.user = user
                        remote.identityFile =  keyfile
                        sshScript remote: remote, script: "prepare-ansible-server.sh"
                        sshCommand remote: remote, command : "ansible-playbook deploy-docker.yaml"
                    }
                }
            }
        }
    }
}