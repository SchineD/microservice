#!/usr/bin/env bash

#set -x

EXIT_CODE=0
BASE="http://127.0.0.1:8098/api"

# wait a few secs, this is Java :)
sleep 20

echo
for URL in \
    ${BASE}/version \
    ${BASE}/cat/all \
; do
    echo -n "### ${URL} : "
    status_code=$(curl --write-out %{http_code} --silent --output /dev/null ${URL})

    echo "Status ${status_code}"

    if [[ ${status_code} -ge 400 ]] ; then
        echo "Calling ${URL} failed!"
        EXIT_CODE=$(expr ${EXIT_CODE} + 1)
    fi
    echo
done

echo -n "### ${BASE}/zone : "
ZONE=$(curl -H "X-PORTAL-ZONE-STATUS: CI_SERVER" -s ${BASE}/zone)
if [[ "${ZONE}" != '{"value":"CI_SERVER"}' ]] ; then
  echo "Reported zone should be '{\"value\":\"CI_SERVER\"}' but is ${ZONE}"
  EXIT_CODE=$(expr ${EXIT_CODE} + 1)
else
  echo "${ZONE}"
fi
echo

if [[ ${EXIT_CODE} -eq 0 ]] ; then
    echo "### SUCCESS"
else
    echo "### FAILURE"
fi

exit ${EXIT_CODE}
