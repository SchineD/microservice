#!/bin/bash

cd "$(dirname "$(dirname "$(dirname "$0")")")"

BACKEND_CONFIG_FILE=api/src/main/resources/application.yml

if [[ ! -f "${BACKEND_CONFIG_FILE}" ]] ; then
  echo "${BACKEND_CONFIG_FILE} does not exist, please run bin/init_portal_application.sh"
  exit 1
fi

# find out what "localhost" means and how to reach it from a container
if [[ "$(uname)" == "Darwin" ]] ; then
  PROXY_PASS="http://docker.for.mac.localhost:8080/"
  PORT_SPEC='-p 8096:8096'
else
  PROXY_PASS="http://localhost:8080/"
  PORT_SPEC='--network host'
fi

# find out what the portal application name is -->    does include a portal role             split on / take first part
PORTAL_APPLICATION_NAME=$(grep portal.application.name "${BACKEND_CONFIG_FILE}" | cut -d: -f2 | cut -d/ -f1 | tr -d ' \n')

# create a config file for dev-portal
cat > $(pwd)/portal/default-dev-server.conf <<__EOF
server {
    listen       8096;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy api services to api
    #
    location /${PORTAL_APPLICATION_NAME}/app/api/ {

        include /etc/nginx/conf.d/headers.conf;

        proxy_pass   ${PROXY_PASS};

        proxy_set_header X-Forwarded-Proto "http";
        proxy_set_header X-Forwarded-Prefix "/${PORTAL_APPLICATION_NAME}/app/api";
        proxy_set_header X-Forwarded-Port "8096";
        proxy_set_header Host "localhost";

    }

    # proxy api services to React development server
    #
    location /${PORTAL_APPLICATION_NAME}/app/ {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
__EOF

docker run --rm --name dev-portal \
  -d \
  -v "$(pwd)/portal/default-dev-server.conf:/etc/nginx/conf.d/default.conf" \
  -v "$(pwd)/portal/headers.conf:/etc/nginx/conf.d/headers.conf" \
  -v "$(pwd)/app/dist/app:/usr/share/nginx/html/${PORTAL_APPLICATION_NAME}/app" \
  ${PORT_SPEC} \
  nginx:1.17-alpine

docker inspect -f "{{ .Name }}" dev-portal

exit 0
