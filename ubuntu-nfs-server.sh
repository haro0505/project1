#!/bin/bash
apt update
apt install -y nfs-server
systemctl status nfs-server
echo "/nfs-shared 172.16.0.0/12(rw,sync)" >> /etc/exports
systemctl restart nfs-server
systemctl enable nfs-server
apt install -y  amazon-ec2-utils
ec2-metadata -o | cut -d ' ' -f 2 > /nfs-shared/list.txt
chmod -R 777 /nfs-shared/
