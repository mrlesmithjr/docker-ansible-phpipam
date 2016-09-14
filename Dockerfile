FROM mrlesmithjr/apache2:alpine

MAINTAINER Larry Smith Jr. <mrlesmithjr@gmail.com>

# Copy Ansible Related Files
COPY config/ansible/ /

ENV APACHE2_ENABLE_PHP="true" \
    PHPIPAM_DB_HOST="db" \
    PHPIPAM_DB_NAME="phpipam" \
    PHPIPAM_DB_PASS="phpipam" \
    PHPIPAM_DB_USER="phpipam"

RUN ansible-playbook -i "localhost," -c local /playbook.yml && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

# Copy Docker Entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
