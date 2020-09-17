#!/bin/bash

cd $(dirname $0)

if [[ -z "${http_proxy}" ]] ; then
  exit 0
fi

PROXY=$(echo "${http_proxy}" | cut -d/ -f3)
PROXY_HOST=$(echo ${PROXY} | cut -d: -f1)
PROXY_PORT=$(echo ${PROXY} | cut -d: -f2)

echo "Creating maven settings with proxy ${http_proxy}"

sed -e "s/{{ PROXY_HOST }}/${PROXY_HOST}/" -e "s/{{ PROXY_PORT }}/${PROXY_PORT}/" settings.xml.template > settings.xml

exit $?
