ARG BASE_IMAGE=redhat/ubi8
ARG BASE_TAG=8.5

FROM $BASE_IMAGE:$BASE_TAG
ENV MYSQL_VERSION=8.0.26

COPY LICENSE /licenses/mysql

# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

# MySQL Shell client, optional in a server image. Removed due to outdated
# vendored dependencies (vulnerabilities in pip 19.0.3).

COPY *.rpm /
COPY RPM-GPG-KEY-mysql RPM-GPG-KEY-CentOS-Official /etc/pki/rpm-gpg/

# Install server
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql \
  && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Official \
  && dnf update -y \
  && dnf install --nodoc -y \
      /mysql-community-server.rpm \
      /mysql-community-libs.rpm \
      /mysql-community-common.rpm \
      /mysql-community-client.rpm \
      /mysql-community-client-plugins.rpm \
      /numactl-libs.rpm \
      libpwquality \
      cracklib-dicts \
  && dnf clean all \
  && mkdir /docker-entrypoint-initdb.d \
  && rm /*.rpm \
  && chown -R mysql:mysql /var/lib/mysql

COPY --chown=mysql:mysql scripts/entrypoint.sh scripts/healthcheck.sh /
COPY --chown=mysql:mysql config/my.cnf /etc/my.cnf

ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK CMD /healthcheck.sh
EXPOSE 3306 33060
CMD ["mysqld"]

# moved from entrypoint.sh to Dockerfile to allow entrypoint.sh to run as non-root
RUN sed -i 's/^log-error=/#&/' /etc/my.cnf

# https://github.com/containers/buildah/issues/2202
# According to this GitHub issue, the VOLUME permissions will be changed if a RUN command is after it.
VOLUME /var/lib/mysql

# Use a non root user
USER mysql
