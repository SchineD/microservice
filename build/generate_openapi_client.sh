#!/usr/bin/env bash

cd "$(dirname "$(dirname "$0")")"

PORT=8080
JAR=$(echo -n "./build/swagger-codegen-cli-"*".jar" | cut -d' ' -f1) # we want only one
TARGET_DIR="./app/projects/api-swagger-client/src"

rm -rf "${TARGET_DIR}_old"
mv "${TARGET_DIR}" "${TARGET_DIR}_old"

echo -e "\nGenerate API library project in ${TARGET_DIR}"
java -jar "${JAR}" generate \
  -i "http://localhost:${PORT}/v3/api-docs" \
  -l typescript-angular \
  -o "${TARGET_DIR}"

if [ ! -f "${TARGET_DIR}/.swagger-codegen/VERSION" ] ; then
  echo "ERROR: Generating in ${TARGET_DIR} failed"
  rm -rf "${TARGET_DIR}"
  mv "${TARGET_DIR}_old" "${TARGET_DIR}"
  exit 1
else
  rm -rf "${TARGET_DIR}_old"
fi

echo "Make URL in service relative"
SERVICE=$(echo -n "${TARGET_DIR}/api/"*".service.ts")
mv "${SERVICE}" "${SERVICE}.orig"
sed -e "s/protected basePath = '[^'][^']*';/protected basePath = '.\/api\/';/" < "${SERVICE}.orig" > "${SERVICE}"

echo "Fix Original, fails under 'strict'"
MODULE=$(echo -n "${TARGET_DIR}/api.module.ts")
mv "${MODULE}" "${MODULE}.orig"
sed -e "s/Configuration): ModuleWithProviders/Configuration): ModuleWithProviders<any>/" < "${MODULE}.orig" > "${MODULE}"

echo "Build generated library project"
(cd app; ng build api-swagger-client)

echo "Done"
exit 0