FROM ubuntu
RUN apt-get -y update && update apt-get upgrade
RUN apt-get -y install apache2 libapache2-mod-cgi
RUN a2enmod cgi
COPY cgi-bin/ /usr/lib/cgi-bin/
COPY html/ /var/www/html/
RUN chmod +x /usr/lib/cgi-bin/*.sh

CMD ["apache2ctl", "-D", "FOREGROUND"]

