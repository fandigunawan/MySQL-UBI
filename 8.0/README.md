# mysql

This docker codes are modified from [IronBank repository](https://repo1.dso.mil/dsop/opensource/mysql/mysql8).
RedHat UBI 8 is retrieved from DOcker Hub instead of from DSO's registry.

## Build
- Install Python 3 and Docker
- Install [hardening importer](https://github.com/fandigunawan/hardening-importer) which was mirrored from [here](https://git.jharmison.com/jharmison/hardening-importer)
- Run `hardening import` in Dockerfile and hardening_manifest.yaml directory.
- Run `docker build -t mysql-ubi:8`

## Original notes
Based off the Docker file from [mysql/mysql-docker](https://github.com/mysql/mysql-docker/tree/abe70cbbd8b6b4275ee6d82dd6adb0c8cd7cde94/8.0) including an entrypoint and healthcheck.

Dockerfile modified to install `mysql-community-server-minimal` and
`mysql-shell` RPMs directly, without using the [mysql-community yum server](https://repo.mysql.com/yum/).
Manually added and imported `RPM-GPG-KEY-mysql`.

Modified Dockerfile to configure mysql for console output. This was
required because the entrypoint script is unable to modify /etc/my.cnf
as a non-root user. Note, this used to be configurable but now is not configurable.

Healthcheck and entrypoint scripts modified to place healthcheck.cnf
and mysql-init-complete under /var/run/mysqld/ so that they may be run
by a non-root user.

## Kubernetes Deployment

### Volume Mount

Due to the nature of this container not running with privileged permissions it is not able `chown` a directory even if it has read/write permissions. This requires the container to run with a security context of 27.

```yaml
# Add this to your pod spec to configure the right pod and volume permissions
securityContext:
  fsGroup: 27
  runAsGroup: 27
  runAsUser: 27
```

### MySQL User

Part of the mysql security is to restrict users to certain IP addresses, this includes the root user. By default the root user connections will only be permitted from localhost, all other connections will get the error `Host ''xxx.xx.xxx.xxx'' is not allowed to connect to this MySQL server`. There are two options to fix this issue 

- Not Recommended: when creating the container add the environment variable `MYSQL_ROOT_HOST` and set it to `%`
- Recommended: when creating the container add the following environment variables.
  - `MYSQL_USER` - The user of the database
  - `MYSQL_PASSWORD` - The password of the created user
  - `MYSQL_DATABASE` - The database that user has access to

When following the recommended approach the container will create the MYSQL_USER and allow it to connect from all IP addresses.

Added LICENSE from:
https://raw.githubusercontent.com/mysql/mysql-server/8.0/LICENSE
