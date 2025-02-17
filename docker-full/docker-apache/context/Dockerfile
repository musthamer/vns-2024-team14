FROM ubuntu
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install apache2 apache2-utils
RUN a2enmod cgi
COPY cgi-bin/ /usr/lib/cgi-bin/
COPY html/ /var/www/html/
RUN if [ -d /usr/lib/cgi-bin/ ] && [ -n "$(ls -A /usr/lib/cgi-bin/*.sh 2>/dev/null)" ]; then \  chmod +x /usr/lib/cgi-bin/*.sh; \
    fi 

COPY myinit.sh /usr/bin/
CMD ["/usr/bin/myinit.sh"]

