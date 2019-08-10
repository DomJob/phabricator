FROM ubuntu:18.04

RUN apt update && apt upgrade -y
RUN export DEBIAN_FRONTEND=noninteractive && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

RUN apt install -y git perl lighttpd php7.2 php7.2-fpm php7.2-cgi php7.2-mysql php7.2-mbstring php7.2-iconv php7.2-curl php7.2-apcu php7.2-zip php7.2-gd

COPY ./files/php.ini /etc/php/7.2/fpm/php.ini
COPY ./files/lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY ./files/15-fastcgi-php.conf /etc/lighttpd/conf-available/15-fastcgi-php.conf

COPY ./files/upgrade /bin/
COPY ./files/reload /bin/

WORKDIR /opt/

RUN git clone https://github.com/phacility/libphutil.git \
 && git clone https://github.com/phacility/arcanist.git \
 && git clone https://github.com/phacility/phabricator.git

WORKDIR /opt/phabricator/

RUN lighttpd-enable-mod fastcgi \
 && lighttpd-enable-mod fastcgi-php

CMD echo "Starting PHP-FPM service..." && service php7.2-fpm start && echo "Done!" \
 && echo "Starting lighttpd service..." && service lighttpd start && echo "Done!" \
 && echo "All services started. Please wait a few seconds before accessing the web service." \
 && tail -f /dev/null
