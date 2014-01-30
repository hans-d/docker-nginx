Nginx docker environment
========================

uses the default nginx configuration, and will include everything in ```/data/nginx```

Versions/Branches
-----------------
(due to current limitations of trusted builds these are seperate docker repos)

- `master` -> `hansd/nginx`
  - only nginx
- `php5` -> `hansd/nginx-php5`
  - nginx with php5


Volumes
-------

- `/data`: website
  - `/data/nginx`: additional configuratioon for nginx
- `/var/log`: logging
  - `/var/log/nginx`: output of nginx (as per default configuration) 

Ports
-----
- `80`, `443`: standard http(s) ports

TODO
----
- auto reload on config change

Run
---
```
sudo docker run -d -p 8000:80 -v /path/to/host/data:/data -v /path/to/host/log:/var/log hansd/nginx-php5
```

Example configuration 
---------------------

Can be accessed via ```http://dockerhost:8000```

### `/path/to/host/data/conf/nginx/example`

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

  # will only work when using hansd/nginx-php5
  location ~ \.php$ {
    try_files $uri =404;
    fastcgi_pass unix:/var/run/php5-fpm.sock;
    fastcgi_index index.php;
    include fastcgi_params;
  }

}
```

### `/path/to/host/data/www/example/index.html`

```
<html>Hello World!</html>
```
