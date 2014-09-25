FROM ubuntu:14.04
MAINTAINER Hans Donner <hans.donner@pobox.com>

ENV DEBIAN_FRONTEND noninteractive

# everything up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y

# install system components
RUN apt-get -y install python-software-properties

# install nginx
RUN echo "deb http://nginx.org/packages/ubuntu/ precise nginx" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62 && \
    apt-get update && \
    apt-get -y install nginx

# adjust default config
RUN rm -Rf /etc/nginx/sites-enabled/default

# add scripts and install dependencies
RUN mkdir /docker
ADD scripts /docker/scripts
RUN chmod +x /docker/scripts/*

# extra config on volume
RUN echo 'include /data/nginx/*;' > /etc/nginx/conf.d/docker.conf

# expose ports
EXPOSE 80 443

# entrypoint
ENTRYPOINT ["/docker/scripts/start"]
