FROM maven:3-jdk-11 as builder

WORKDIR /project/
COPY . .
RUN ./maven_dot_m2/make_settings.sh && \
    if [ -f ./maven_dot_m2/settings.xml ] ; then \
        mkdir -p /root/.m2 && \
        cp ./maven_dot_m2/settings.xml /root/.m2/settings.xml ; \
    fi
RUN mvn -q clean package


FROM openjdk:11-slim

RUN apt-get -y update && apt-get -y upgrade
RUN mkdir /app && mkdir /app/config

# Create appuser
RUN adduser --system --no-create-home appuser && chown -R appuser /app
USER appuser

COPY --from=builder /project/target/app.jar /app/

WORKDIR /app
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java  $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar"]
