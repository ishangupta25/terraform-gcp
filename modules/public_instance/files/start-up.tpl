#!/bin/bash

apt-get update
#install jenkins
sudo apt-get install default-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
apt-get update
apt-get install jenkins -y
systemctl start jenkins
#install ansible
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible -y
