#!/bin/sh

ansible-playbook -i "localhost," -c local /docker-entrypoint.yml \
  --extra-vars "apache2_enable_php=$APACHE2_ENABLE_PHP"

ansible-playbook -i "localhost," -c local /phpipam-entrypoint.yml \
  --extra-vars "phpipam_db_host=$PHPIPAM_DB_HOST phpipam_db_name=$PHPIPAM_DB_NAME \
  phpipam_db_pass=$PHPIPAM_DB_PASS phpipam_db_user=$PHPIPAM_DB_USER"

exec supervisord -n
