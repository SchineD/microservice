# Notes about generating Angular from OpenAPI

## Tutorials

[Use swagger to generate API client as an Angular library](https://medium.com/sohoffice/the-api-first-strategy-use-swagger-to-generate-api-client-as-an-angular-library-66964ea43587)

## Initial steps (only once)

First create an Angular library as subproject and delete the source directory. This is, where we will 
generate the library with `swagger-codegen`.

```
cd springboot-angular-starter/app
rm -rf projects/api-swagger-client/src
```

Start the backend in your IDE. It must run on http://localhost:8080/
Go to the main directory and create the bindings

```
cd ../../
./build/generate_openapi_client.sh
```

At the end, the library is built to `dist`. Changes in the library sources
would need a new build to become effective.

```
cd app
ng build api-swagger-client
```

See `app/src/app/whoami/whoami.component.ts` for usage.