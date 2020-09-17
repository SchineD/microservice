#!/bin/bash

cd "$(dirname "$(dirname "$0")")"

./portal/bin/init_portal_application.sh

exit $?
