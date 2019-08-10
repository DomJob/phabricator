FROM ubuntu:18.04

RUN apt update && apt upgrade -y
RUN export DEBIAN_FRONTEND=noninteractive \
    && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

RUN apt install -y git perl lighttpd mysql-server mysql-client php7.2 php7.2-fpm php7.2-cgi php7.2-mysql php7.2-mbstring php7.2-iconv php7.2-curl php7.2-apcu

COPY ./files/php.ini /etc/php/7.2/fpm/php.ini
COPY ./files/lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY ./files/15-fastcgi-php.conf /etc/lighttpd/conf-available/15-fastcgi-php.conf
COPY ./files/mysql.cnf /etc/mysql/conf.d/
COPY ./files/upgrade /bin/

WORKDIR /opt/

RUN git clone https://github.com/phacility/libphutil.git \
 && git clone https://github.com/phacility/arcanist.git \
 && git clone https://github.com/phacility/phabricator.git

WORKDIR /opt/phabricator/

RUN mysql -e "CREATE USER 'phabricator'@'localhost' IDENTIFIED BY 'phassword';"
 && mysql -e "GRANT ALL PRIVILEGES ON * . * TO 'phabricator'@'localhost';"
 
RUN ./bin/config set mysql.user phabricator
 && ./bin/config set mysql.user phassword
 && ./bin/config set storage.mysql-engine.max-size 0
 && ./bin/config set repository.default-local-path "/var/repo/"

RUN lighttpd-enable-mod fastcgi \
 && lighttpd-enable-mod fastcgi-php

ENTRYPOINT service php7.2-fpm start \
        && service mysql start \
        && service lighttpd start
        && upgrade
