FROM alpine:3.18
LABEL name="powerdns" version="4.7.4" maintainers="Amin Dandache <amin.dandache@vico-consulting.com>"
# Based on https://hub.docker.com/r/psitrax/powerdns/

ENV MYSQL_DEFAULT_AUTOCONF=true \
    MYSQL_DEFAULT_HOST="mysql" \
    MYSQL_DEFAULT_PORT="3306" \
    MYSQL_DEFAULT_USER="root" \
    MYSQL_DEFAULT_PASS="root" \
    MYSQL_DEFAULT_DB="pdns" \
    DEFAULT_SOA_CONTENT="a.misconfigured.dns.server.invalid hostmaster.@ 0 10800 3600 604800 3600" \
    LOGLEVEL=3 \
    LOG_DNS_QUERIES="no" \
    LOG_DNS_DETAILS="no"

RUN apk add --no-cache \
    bash=5.2.15-r5 \
    mariadb-client=10.11.4-r0 \
    pdns=4.7.4-r0 \
    pdns-backend-mariadb=4.7.4-r0 && \
    mkdir -p /etc/pdns/conf.d && \
    rm -rf /var/cache/apk/*

COPY schema.sql pdns.conf /etc/pdns/
COPY entrypoint.sh /
COPY set_zone.sh /

EXPOSE 53/tcp 53/udp

ENTRYPOINT ["/entrypoint.sh"]
