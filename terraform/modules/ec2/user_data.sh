#!/bin/bash

apt update -y

apt install docker.io -y
apt install docker-compose -y
apt install apache2 -y

systemctl start docker
systemctl enable docker
systemctl start apache2
systemctl enable apache2

usermod -aG docker ec2-user