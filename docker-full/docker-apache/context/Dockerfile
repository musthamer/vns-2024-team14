FROM ubuntu:latest
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install apache2 apache2-utils libapache2-mod-cgi curl vim mariadb-client redis-tools

COPY cgi-bin/ /usr/lib/cgi-bin/
COPY html/ /var/www/html/
RUN chmod +x /usr/lib/cgi-bin/vns/todo/*
RUN chmod +x /usr/lib/cgi-bin/vns/login/*
RUN a2enmod cgi

CMD ["apache2ctl", "-D", "FOREGROUND"]

