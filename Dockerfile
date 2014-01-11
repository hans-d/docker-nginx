FROM ubuntu:12.04
MAINTAINER Hans Donner <hans.donner@pobox.com>

ENV DEBIAN_FRONTEND noninteractive

# update base
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y

# add repo
RUN apt-get -y install python-software-properties
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update

# install nginx
RUN apt-get -y install nginx

# config nginx
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.org

# config container
VOLUME ["/data", "/var/log"]
RUN rm -Rf /etc/nginx/sites-enabled/default /var/log/nginx
RUN echo 'include /data/conf/nginx/*;' > /etc/nginx/conf.d/docker.conf

EXPOSE 80 443

CMD [ -d /data/conf/nginx ] || mkdir -p /data/conf/nginx; [ -d /var/log/nginx ] || mkdir /var/log/nginx; nginx -g "daemon off;"
