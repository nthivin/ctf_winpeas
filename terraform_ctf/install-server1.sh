#!/bin/bash

set -e

dhclient
apt-get -y update
apt-get -y install cloud-init python3 git python3-django ufw gunicorn
apt-get -y install python3-pip python3-dev  gcc nginx
#  postgresql postgresql-server-dev-all postgresql-contrib
ufw default allow outgoing
ufw default deny incoming
ufw allow 8000
ufw enable

# user creation
mkdir /home/garytheplumber
git clone -b WebApp https://github.com/nthivin/ctf_winpeas.git /home/garytheplumber/
cd /home/garytheplumber/PlomberApp

# # postgres psql
# # CREATE DATABASE databasename;
# # CREATE USER username WITH PASSWORD 'Passw0rd';
# # ALTER ROLE username SET client_encoding TO 'utf8';
# # ALTER ROLE username SET default_transaction_isolation TO 'read committed';
# # ALTER ROLE username SET timezone TO 'Europe';
# # GRANT ALL PRIVILEGES ON DATABASE databasename TO garytheplumber;

echo "server {

  server_name 127.0.0.1 yourhost@example.com;
  access_log /var/log/nginx/domain-access.log;

  location / {
    proxy_pass_header Server;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_set_header X-Forwarded-For  $remote_addr;
    proxy_set_header X-Scheme $scheme;
    proxy_connect_timeout 10;
    proxy_read_timeout 10;

    # This line is important as it tells nginx to channel all requests to port 8000.
    # We will later run our wsgi application on this port using gunicorn.
    proxy_pass http://127.0.0.1:8000/;
  }

}

" > /etc/nginx/sites-enabled/default


gunicorn -b 127.0.0.1:8000 --pid /tmp/gunicorn.pid --daemon core.wsgi
