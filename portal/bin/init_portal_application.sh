#!/bin/bash

cd "$(dirname "$(dirname "$(dirname "$0")")")"

if [[ -z "$1" ]] ; then
  PORTAL_APPLICATION_NAME="$(basename "$(pwd)")"
  echo -e "\nDerived portal application name '${PORTAL_APPLICATION_NAME}' from project directory"
else
  PORTAL_APPLICATION_NAME="$(echo -n "$1" | tr -d /)"
  echo -e "\nUsing portal application name '${PORTAL_APPLICATION_NAME}' from commandline"
fi

echo -e "\nTemplating files:"
echo "* set base URL for Angular app (app/src/index.html)"
cat app/src/index.template.html | \
  sed -e 's/{{ PORTAL_APPLICATION_NAME }}/'${PORTAL_APPLICATION_NAME}'\/app\//' > app/src/index.html

echo "* set backend proxy for Angular development server (app/backend-proxy.conf.json)"
cat app/backend-proxy.conf-template.json | \
  sed -e 's/{{ PORTAL_APPLICATION_NAME }}/'${PORTAL_APPLICATION_NAME}'\/app/' > app/backend-proxy.conf.json

echo "* patch 'ng serve --base-href=' for live serving (app/package.json)"
if [[ "$(uname)" == 'Darwin' ]] ; then
  sed -i '' -e 's/ng serve --base-href=[^ ][^ ]*/ng serve --base-href=\/'${PORTAL_APPLICATION_NAME}'\/app\//' app/package.json
else
  sed -i -e 's/ng serve --base-href=[^ ][^ ]*/ng serve --base-href=\/'${PORTAL_APPLICATION_NAME}'\/app\//' app/package.json
fi


echo "* create backend's application.yml (api/src/main/resources/application.yml)"
cat api/src/main/resources/application_template.yml | \
  sed -e 's/{{ PORTAL_APPLICATION_NAME }}/'${PORTAL_APPLICATION_NAME}'\/app/' > api/src/main/resources/application.yml

echo "* create docker-compose.yml"
cat docker-compose-template.yml | \
  sed -e 's/{{ PORTAL_APPLICATION_NAME }}/'${PORTAL_APPLICATION_NAME}'/g' > docker-compose.yml

echo "* create a config file for portal simulation in docker-compose-dev.yml (portal/default.conf)"
cat > $(pwd)/portal/default.conf <<__EOF
server {
    listen       80;
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
    location /${PORTAL_APPLICATION_NAME}/app/ {

        include /etc/nginx/conf.d/headers.conf;

        proxy_pass   http://app.docker:80/;

        proxy_set_header X-Forwarded-Proto "http";
        proxy_set_header X-Forwarded-Prefix "/${PORTAL_APPLICATION_NAME}/app/api";
        proxy_set_header X-Forwarded-Port "8097";
        proxy_set_header Host "localhost";
    }
}
__EOF

echo "* create header include file for the portal simulations (portal/headers.conf)"
cat > $(pwd)/portal/headers.conf <<__EOF
proxy_set_header X-PORTAL-APPLICATION	    "${PORTAL_APPLICATION_NAME}";
proxy_set_header X-PORTAL-AUTH	          "Standardportal";
proxy_set_header X-PORTAL-DOMAIN	        "wien1";
proxy_set_header X-PORTAL-ROLE	          "_no_role";
proxy_set_header X-PORTAL-SECURITY-LEVEL	"4";
proxy_set_header X-PORTAL-UID	            "1:magwien.gv.at/jsa0001";
proxy_set_header X-PORTAL-USER	          "jsa0001";
proxy_set_header X-PORTAL-ZONE	          "EXTERN";
proxy_set_header X-PORTAL-ZONE-STATUS	    "Dev";
proxy_set_header X-PVP-BPK	              "PV:kjlhdfskjlsdfhfgzgzueukjj4o=";
proxy_set_header X-PVP-GID	              "AT:L9:1:magwien.gv.at/jsa0001";
proxy_set_header X-PVP-GIVEN-NAME	        "Joe";
proxy_set_header X-PVP-MAIL	              "joe.sample@wien.gv.at";
proxy_set_header X-PVP-ORIG-HOST	        "localhost";
proxy_set_header X-PVP-ORIG-SCHEME	      "http";
proxy_set_header X-PVP-ORIG-URI	          "/${PORTAL_APPLICATION_NAME}/api/whomai";
proxy_set_header X-PVP-OU	                "MA 01";
proxy_set_header X-PVP-OU-GV-OU-ID	      "AT:VKZ:L9-M01";
proxy_set_header X-PVP-OU-OKZ	            "L9-M01";
proxy_set_header X-PVP-PARTICIPANT-ID	    "AT:VKZ:L9";
proxy_set_header X-PVP-PRINCIPAL-NAME	    "Sample";
proxy_set_header X-PVP-ROLES	            "access()";
proxy_set_header X-PVP-SECCLASS	          "2";
proxy_set_header X-PVP-TEL	              "+43 1 4000 99999";
proxy_set_header X-PVP-TXID	              "100527$2hqnb@lxstportal70:8009";
proxy_set_header X-PVP-USERID	            "wien1.jsa0001@wien.gv.at";
proxy_set_header X-PVP-VERSION	          "2.1";
proxy_set_header X-TXID	                  "100527$2hqnb@lxstportal70:8009";
__EOF


exit 0
