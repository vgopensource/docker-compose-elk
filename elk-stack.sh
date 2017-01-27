#!/bin/bash

set -u # Variables must be explicit
set -e # If any command fails, fail the whole thing
set -o pipefail

# Make sure SSH knows to use the correct pem

ssh-add ~/.ssh/elk-book-stack.pem

ssh-add -l

# Load the AWS keys

. ./inventory/aws_keys

# provision AWS EC2 machine using Ubuntu AMI

ansible-playbook -i hosts aws-provisioning/ec2-server.yml

# Install Docker and Docker-Compose on EC2 ubuntu instance

ansible-playbook -i hosts configure/install-docker.yml

# Spin up ELK stack on docker container

annsible-playbook -i hosts configure/install-elk.yml

# Install Wordpress App in Container

ansible-playbook -i hosts configure/install-Wordpress.yml
