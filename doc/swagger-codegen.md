# Notes about generating Angular from OpenAPI

## Tutorials

[Use swagger to generate API client as an Angular library](https://medium.com/sohoffice/the-api-first-strategy-use-swagger-to-generate-api-client-as-an-angular-library-66964ea43587)

## Prerequisites

* create an Angular library as subproject

```
cd springboot-angular-starter/app
rm -rf projects/api-swagger-client/src
```

```
# from [BUG]missing swagger input or config
#      https://github.com/swagger-api/swagger-codegen/issues/6442
# 
cd ../../..

git clone https://github.com/swagger-api/swagger-codegen.git
cd swagger-codegen
git checkout 3.0.0
# after this build as you please
mvn clean package

java -jar ./modules/swagger-codegen-cli/target/swagger-codegen-cli.jar \
  generate -i http://localhost:8080/v3/api-docs -l typescript-angular \
  -o ../springboot-angular-starter/app/projects/api-swagger-client/src
```

```
cd ../springboot-angular-starter/app
ng build api-swagger-client
```
