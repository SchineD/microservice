# Starter project for Spring Boot and Angular with Docker Smart CI

This project is a [Spring
Boot](https://spring.io/projects/spring-boot) backend
application with [Angular](https://angular.io/) frontend.

## Creating a new repository from this starter

* Read the docs of [Docker Smart CI](https://stp-test.wien.gv.at/docker-smart-ci/)

* Create the new repository (e.g. `my-new-app`) in Bitbucket. Leave it empty, don't 
  add a README. You should see instructions titled _Let's put some bits in your bucket_.
  Keep it open, but don't do it now

* Check out [this starter](https://bitbucket.org/ma14pace/springboot-angular-starter/) 
  with `git clone https://bitbucket.org/ma14pace/springboot-angular-starter.git my-new-app`
  under the new name (here: `my-new-app`)

* Change into that new directory

* Remove the old remote: `git remote remove origin`

* Add the new remote: `git remote add origin https://bitbucket.org/ma14pace/my-new-app.git`,
  replacing `my-new-app` with the name of your project

* Add another remote to a development repo (optional)

* Push to the new repository: `git push -u origin master`

## Before you start coding

Springboot, the generation of the OpenAPI docs and Angular are all
problematic when run behind a reverse proxy like Standard Portal.
In order to fix this, the portal application name has to be 
coded into some files. 

We assume the following:

1. The project's git repo has the same name as the portal
   application
1. The repo has been checked out under its default name, which 
   is also the portal application name

Now, before doing anything else,

1. Change into the root of the checked out repo
1. Run `./portal/bin/init_portal_application.sh <app-name>` (e.g. `my-new-app`)

This command generates a few files

ORIGINAL FILE                                              | GENERATED FILE                             | CAN EDIT GENERATED
-----------------------------------------------------------|--------------------------------------------|-------------------
app/src/index.template.html                                | app/src/index.html                         | -
api/src/main/resources/application_template.yml            | api/src/main/resources/application.yml     | -
docker-compose-template.yml                                | docker-compose.yml                         | -
portal/bin/init_portal_application.sh (embedded in script) | portal/default.conf                        | -
portal/bin/init_portal_application.sh (embedded in script) | portal/headers.conf                        | -

Without the generated files, the application can't be built. So this is a prerequisite.

`./portal/bin/init_portal_application.sh` is also started on the CI server. Therefore:

Never edit one of the generated files. The changes would not be visible
in production! Always edit the **original file** instead.

## Before you try this application as-is 

This application does a few things, and it is very
useful to understand what they are and how they are
accomplished. It is recommended to not immediately
modify the application, but first to understand it
in its current form. Think of this as a tutorial.
Following it makes everything else much easier.

### What the application does

Let's begin with the basic functions. 
This is an [Angular](https://angular.io/)
_Single Page Application_ (aka "the frontend") with a [Spring
Boot](https://spring.io/projects/spring-boot) backend.

The frontend communicates with the backend via HTTP. The backend
can loosely be called a REST service, although it does
not strictly adhere to the formal definition of REST.

As to the project structure, unsurprisingly the frontend
is in `./app` and the backend is in `./api`.
Further below we'll look deeper into project
structure and how and where to change what.

The backend has a sample collections of cats, not
backed by a database but instead by a simple list.

There is also an automatically generated [OpenAPI](https://www.openapis.org/)
documentation of the backend, also known as [Swagger
Docs](https://swagger.io/specification/).

  
### Prerequisites

* A current Docker CE (18.09+). A current Docker for Desktop on Mac is fine. Docker for Desktop
  on Windows 10 might work, but has not been tested. On Windows, a CentOS 7 VM is a safe bet.

* Java 8+ (but why not 11+?)

* Maven 3 

* node.js (12+)

* a Javascript package manager
  * npm comes with node

* an Editor or, even better, an IDE

## Initial steps

1. If you haven't run `./portal/bin/init_portal_application.sh` yet, now would be a good time

1. Open the project with an IDE 
   * In IntelliJ IDEA, "open" the project directory. IntelliJ IDEA will prompt you to
     allow importing the Maven project
   * Instructions for other IDEs will follow
   * An IDE is not strictly necessary, so you're perfectly welcome to use just `vi` or `emacs`

1. Open a terminal window (Terminal 1)

1. Run the backend in Terminal 1. 
   1. Spring Boot compiles a Java micro-service down to a single JAR
      with everything embedded, Tomcat server included. In IntelliJ IDEA (and likely in
      other typical IDEs as well) just "run" 
      `api/src/main/java/at/gv/wien/m01/pace/api/BackendApplication.java`. 
      This is normally an action from the context menu. The IDE will compile the project 
      and run the JAR file containing the class.

   1. The other option is to compile and run from the commandline
      * `mvn package` will compile the Java sources and build a JAR file
      * `java -jar api/target/app.jar` will run the JAR in the foreground. Logs
        will go to STDOUT, right as Docker apps should do. Hold on, it's not a Docker
        app yet, but we'll get there soon

1. Open a terminal window (Terminal 2)

1. Build the frontend in Terminal 2. Run first
   
   1. `(cd app ; ng build)`
   
   and then
   
   1. `(cd app ; ng serve)`

1. In Terminal 2 type `./portal/bin/start_dev_portal.sh`. This starts a docker container with an 
   [NGINX web server](https://www.nginx.com/). This container is named `dev-portal`. 
   In our local outside-of-docker development environment it will stand in for 
   StandardPortal, the authenticating reverse proxy, that the application will run behind 
   in production. 

## A first look

In a web browser navigate to [the
frontend](http://localhost:8096/springboot-angular-starter/app). You
should see the generic Angular starter app. It does not access the backend yet.

![The frontend](doc/img/app-01-app.png)

The [API
docs](http://localhost:8096/springboot-angular-starter/app/api/swagger-ui/index.html?url=/springboot-angular-starter/api/v3/api-docs)
shows the OpenAPI documentation for the backend.

![The API docs](doc/img/app-02-api.png)


## What we have done so far

The `dev-portal` is configured to listen on
port 8096. It serves the frontend from `/app/dist/app`,
which is mapped as a directory volume into
`/usr/share/nginx/html/springboot-angular-starter`.
It also acts as a proxy, delegating
`/springboot-angular-starter/app/api/` to
[http://localhost:8080](http://localhost:8080).
That's the port, where the backend listens.

![Running locally with dev-portal](doc/img/dev-portal.png)

The configuration of `dev-portal` is in
`portal/default-dev-server.conf` and
`portal/headers.conf`. Both have been created by
`./portal/bin/init_portal_application.sh`, in order to use the
project directory's name as URL prefix.

`header.conf` contains the definitions of faked
Standard Portal headers. They are static (meaning
they don't change from request to request), but
they are a viable substitute for offline use.

This is the best we can do. Admittedly it would be fine
to be able to run the React development server via `npm
start` or `yarn start`, but the development server
can't cope with URL prefixes. It's an open bug, there
is an open pull request, but it has not been merged
yet. Once the React team fixes that, we will provide
support for the development server as well. For now,
you have to make a production build to see changes.

## Running a local docker-compose app with fake portal

The next step is bringing us closer to the "real thing". We are
going to run everything in a docker-compose app.

You may notice, that initially we had three compose files:

* `docker-compose-template.yml` is not used directly, but 
  `./portal/bin/init_portal_application.sh` uses it to create 
  `docker-compose.yml`. This is the main file with the service
  structure, that will be used in production

* `docker-compose-test.yml` is an overlay file that overrides
   an environment file for testing

* `docker-compose-dev.yml` is the overlay file that we use 
  on the development host
  
The generated `docker-compose.yml` defines two services, `app`
and `api`. From the compose file it is not obvious, but when we
look into the referenced Dockerfiles, we see that `app` is an
NGINX serving the React frontend, and `api` is a Java image running
the Spring Boot JAR.

This is already the configuration that we will run in production.
In production we have a Standard Portal, thus we need no portal
simulation. So who will play the role of portal now?

It's the job of `docker-compose-dev.yml`. It defines a third service
`portal`, that again does the portal simulation and also includes
`portal/headers.conf`. In production, the "real" portal will
run outside of the docker-compose enclosure, while in development we
run it inside of it. That's an arbitrary choice. We could as well
have used a different configuration for `dev-portal`. Anyway, here's
what we get:

![Running locally with docker-compose](doc/img/dev-docker.png)

* [Angular app](http://localhost:8097/springboot-angular-starter/app/)
* [API spec](http://localhost:8097/springboot-angular-starter/app/api/swagger-ui/index.html?url=/springboot-angular-starter/app/api/v3/api-docs)

## Running a local docker-compose app with real portal

Another option, here not realized, is to run the compose app with
`docker-compose.yml` only. We have no portal simulation, but instead
we use the real thing, the test instance of Standard Portal.

There are a few things that have to be done to achieve that, and you
can't do all of them yourself:

* The application has to be configured in the TEST zone of 
  Standard Portal. In is true nature, the portal is nothing but a 
  reverse proxy. It can relay requests to servers inside our firewall, 
  but it can also relay them to a host in your domain. We can do that,
  but changes may take a day.
  
* Standard Portal doesn't just talk to everyone. Your server needs a 
  server certificate issued by our CA. We do that, but a certificate 
  takes a day. You see a pattern here.
  
* We require you to make your SSL terminator refuse connections from 
  everything but our portal servers. You can check our portal's client 
  certificate or you can restrict connections to our outgoing IPs.

If we do all that, we end up with something like this:

![Running locally with docker-compose and stp-test](doc/img/dev-stp-test.png)

## How shall we develop?

The quickest turn-around times can be achieved with the first
variant. The backend runs in our IDE, the frontend is directly made
with `yarn run build`, `dev-portal` serves the frontend and proxies to
the backend. We would do most development this way.

The second variant, running in `docker-compose` with plugged-on
portal fake, is much more tedious, because after source changes we
have to rebuild the docker images. That takes time.

Still, in the end it has to run in docker, and we have to get the
Dockerfiles and `docker-compose-template.yml` right. We also don't
have to use this all the time and for every change. Remember: what
we have right now already works with the Docker Smart CI process. If
we only change things in the frontend or in the Java sources of the
backend, these changes won't break the build. Therefore, we can
simply rely on the fact that every push into our Bitbucket
repository starts a build. Once the build is finished, the app will
have been deployed on a test server. If the build brakes, you get an
email with the log.

Setting your site up with our certificate and configuring your app
in our portal can be done. We have it done in the past and it is 
the closest thing to production that you can get. It's the slowest and
most clumsy configuration though. Let's try to do that if we must,
but not as a default.

## More ideas

A static simulation of portal headers is good for simple things.
Headers carry user information, so if you want to test multi-user
and probably with different access rights, you might be tempted to
vote for the real portal.

Let's consider variants though:

* You could run two different instances of `dev-portal` on 
  different ports and with two different headers includes. This
  perfectly simulates two users

* You could run the same `dev-portal` with a modified config and two
  server configurations on different ports

* you could go fancy, load an extension language like Lua into 
  `dev-portal`, and there you could switch "identities" based on some
  incoming header value.

There are plenty of options to stay independent and agile, and still 
to be able to stay close to the real thing.
