FROM ubuntu
RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install vim tree iproute2 curl w3m ncat less procps sudo
RUN apt-get -y install redis redis-tools
RUN mkdir /run/redis && chown redis: /run/redis
COPY myinit.sh /usr/bin/
RUN chmod +x /usr/bin/myinit.sh
COPY redis.conf /etc/redis/redis.conf
RUN chown redis:redis /etc/redis/redis.conf
VOLUME /var/lib/redis

CMD ["/usr/bin/myinit.sh"]

