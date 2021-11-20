#!/bin/bash

wget https://repo.mysql.com/RPM-GPG-KEY-mysql
wget -O mysql-community-server.rpm https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-server-8.0.26-1.el8.x86_64.rpm
wget -O mysql-community-libs.rpm https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-libs-8.0.26-1.el8.x86_64.rpm
wget -O mysql-community-common.rpm https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-common-8.0.26-1.el8.x86_64.rpm
wget -O mysql-community-client.rpm https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-client-8.0.26-1.el8.x86_64.rpm
wget -O mysql-community-client-plugins.rpm https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-client-plugins-8.0.26-1.el8.x86_64.rpm
wget -O numactl-libs.rpm http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/numactl-libs-2.0.12-13.el8.x86_64.rpm
wget https://www.centos.org/keys/RPM-GPG-KEY-CentOS-Official

