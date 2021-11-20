#!/bin/bash

wget https://repo.mysql.com/RPM-GPG-KEY-mysql
wget -O mysql-community-server-minimal.rpm https://repo.mysql.com/yum/mysql-5.7-community/docker/el/7/x86_64/mysql-community-server-minimal-5.7.35-1.el7.x86_64.rpm
wget -O numactl-libs.rpm http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/numactl-libs-2.0.12-13.el8.x86_64.rpm
wget https://www.centos.org/keys/RPM-GPG-KEY-CentOS-Official

