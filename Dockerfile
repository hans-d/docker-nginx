FROM ubuntu:12.04
MAINTAINER Hans Donner <hans.donner@pobox.com>

ENV DEBIAN_FRONTEND noninteractive

# everything up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y

# install system components
RUN apt-get -y install python-software-properties

# install nginx
RUN add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    apt-get -y install nginx

# adjust default config
RUN rm -Rf /etc/nginx/sites-enabled/default

# install php5 with some packages
RUN add-apt-repository -y ppa:ondrej/php5 && \
    apt-get update && \
    apt-get -y install php5-fpm php5-cli php5-mysql php5-gd

# add scripts and install dependencies
RUN mkdir /docker
ADD scripts /docker/scripts
RUN chmod +x /docker/scripts/*

# extra config on volume
VOLUME /data
RUN echo 'include /data/nginx/*;' > /etc/nginx/conf.d/docker.conf

# logging to volume
RUN rm -Rf /var/log/nginx
VOLUME /var/log

# expose ports
EXPOSE 80 443

# entrypoint
ENTRYPOINT ["/docker/scripts/start"]
