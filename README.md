Run a simple nginx environment.

- uses the default nginx configuration, and will include everything in ```/data/conf/nginx```

Volumes:
- ```/data```: website
  - ```/data/conf/nginx```: additional configuratioon for nginx
- ```/var/log```: logging
  - ```/var/log/nginx```: output of nginx (as per default configuration) 



Run:
```
sudo docker run -d -p 8000:80 -v /path/to/host/data:/data -v /path/to/host/log:/var/log hansd/nginx
```

example configuration ```/path/to/host/data/conf/nginx/example```:
```
server {
  listen 80 default_server;
  server_name
    localhost
    example

  root /data/www/example;
  index index.html;

  location / {
    try_files $uri $uri/ /index.html;
  }

}
```

Example ```/path/to/host/data/www/example/index.html```:
```
<html>Hello World!</html>
```

Can be accessed via ```http://dockerhost:8000```
