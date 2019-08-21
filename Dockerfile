FROM nginx:1.17.3-alpine

COPY default.conf /etc/nginx/conf.d/
COPY run.sh /bin/run.sh

RUN wget http://www.mantisbt.org/builds/mantisbt-2.22.0-dev-master-2ccc24f.tar.gz -O /mantis.tar.gz && tar -xf /mantis.tar.gz -C /var && mv /var/mantisbt-2.22.0-dev-master-2ccc24f /var/mantisbt && chown -R nobody:www-data /var/mantisbt && chmod og+r -R /var/mantisbt && chmod og+x /var/mantisbt && rm /mantis.tar.gz && chmod +x /bin/run.sh

RUN apk update && apk add php-fpm php-mbstring php-pgsql php-mysqli php-fileinfo php-session php_json

CMD ["/bin/run.sh"]
