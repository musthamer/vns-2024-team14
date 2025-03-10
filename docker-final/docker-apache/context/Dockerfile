FROM ubuntu
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install apache2 apache2-utils libapache2-mod-fcgid curl vim mariadb-client redis-tools
RUN apt-get -y install uuid-runtime
COPY cgi-bin/ /usr/lib/cgi-bin/
COPY html/ /var/www/html/
COPY myinit.sh /usr/bin/myinit.sh
RUN chmod +x /usr/bin/myinit.sh
RUN chmod +x /usr/lib/cgi-bin/vns/todo/*
RUN a2enmod cgi

CMD ["/usr/bin/myinit.sh"]

