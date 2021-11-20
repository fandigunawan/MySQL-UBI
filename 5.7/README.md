# MYSQL 5.7
Based off the Docker file from mysql/mysql-docker including an entrypoint and healthcheck.

Dockerfile modified to install mysql-community-server-minimal and mysql-shell RPMs directly, without using the mysql-community yum server. Manually added and imported RPM-GPG-KEY-mysql.

Modified Dockerfile to configure mysql for console output. This was required because the entrypoint script is unable to modify /etc/my.cnf as a non-root user. Note, this used to be configurable but now is not configurable.

Healthcheck and entrypoint scripts modified to place healthcheck.cnf and mysql-init-complete under /var/run/mysqld/ so that they may be run by a non-root user.

Added LICENSE from:
https://raw.githubusercontent.com/mysql/mysql-server/5.7/LICENSE

MYSQL Server Version: 5.7.31-1

## Overview

### MYSQL
Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

This is a release of MySQL, an SQL database server.

License information can be found in the LICENSE file.

In test packages where this file is renamed README-test, the license
file is renamed LICENSE-test.

This distribution may include materials developed by third parties.
For license and attribution notices for these materials,
please refer to the LICENSE file.

For further information on MySQL or additional documentation, visit
  http://dev.mysql.com/doc/

For additional downloads and the source of MySQL, visit
  http://dev.mysql.com/downloads/

MySQL is brought to you by the MySQL team at Oracle.

The helm chart below bootstraps a single node MySQL deployment on a Kubernetes cluster using the Helm package manager.

### Prerequisites

    Kubernetes 1.10+ with Beta APIs enabled
    PV provisioner support in the underlying infrastructure

## Usage

The values-ironbank.yaml file located [here](https://repo1.dsop.io/dsop/charts/tree/master/stable/mysql/5.7.31-1) provides a sample configuration and can replace the values.yaml in the standard Helm chart (also provided in this repository). Please see the following links for more information regarding configration options for production-ready deployments.

Additional configuration documentation can be found [here](https://github.com/helm/charts/tree/master/stable/mysql) for the helm chart usage and options.

## Volumes

The standard location for the volume is `/var/lib/mysql`. Further confiugration details can be specified and additional documentation on Kubernetes volumes can be found [here](https://kubernetes.io/docs/concepts/storage/volumes/) with details about each section in the volume definition that can be specified.

## TLS

TLS is enabled for client connections to the server, you will need to add the CA certificates and secrets to the cluster AND in the Helm chart linked above for that to work. Alternatively, you can turn off TLS, but this is highly insecure and will allow the traffic to be captured on the wire in clear text.

## Configuration

Configuration changes can be made in `/etc/mysql/mysql.conf.d/mysqld.cnf` and `/etc/mysql/mysql.conf.d/`. Thse changes can be added in the helm chart prior to deployment for ease of setup
