ARG BASE_IMAGE=redhat/ubi8
ARG BASE_TAG=8.5
FROM ${BASE_IMAGE}:${BASE_TAG}

COPY LICENSE /licenses/mysql

WORKDIR /

ENV MYSQL_MAJOR=5.7

COPY *.rpm /opt/
COPY RPM-GPG-KEY-mysql /etc/pki/rpm-gpg/
COPY RPM-GPG-KEY-CentOS-Official /etc/pki/rpm-gpg/
COPY scripts/docker-entrypoint.sh scripts/healthcheck.sh /

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Official && \
    yum install -y --nogpgcheck /opt/*.rpm openssl && \
    yum update -y && \
    yum clean all && \
    mkdir /docker-entrypoint-initdb.d && \
    rm -f /opt/*rpm && \
    rm -f /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql && \
    rm -f /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Official && \
    chmod 755 /healthcheck.sh /docker-entrypoint.sh && \
    chown -R mysql:mysql /var/lib/mysql

COPY config/my.cnf /etc/my.cnf

ENTRYPOINT ["/docker-entrypoint.sh"]
HEALTHCHECK CMD /healthcheck.sh
EXPOSE 3306 33060
CMD ["mysqld"]

# Use a non root user
USER mysql
