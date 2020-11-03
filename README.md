# SWE - Microservice: 12-factor-app

## Start
```
docker-compose up
```
Url: [localhost:80](http://localhost:80)

## 8-Factors

1. Codebase: Tracked by git

2. Dependencies: npm & maven handel dependencies

3. Config: stored in non-code files: application.yml, angular.json

4. Backing Service: (DB-) settings can easily be swapped in application.yml

5. /

6. Stateless: data is persisted in DB. There are no sessions

7. Port Binding: backend listens on port 8080

8. /

9. /

10. Dev-Prod Parity: through usage of docker(-compose) to keep a uniform runtime environment regardless of actual host system

11. /

12. /