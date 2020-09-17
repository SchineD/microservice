FROM node:14-alpine as builder

RUN apk update && apk add zip
RUN npm install -g @angular/cli

RUN mkdir -p /work
COPY . /work

WORKDIR /work

RUN rm -rf node_modules && npm install && ng build
WORKDIR /work/dist/app
RUN zip -r ../../build.zip .


FROM nginx:1.19-alpine

# based on alpine, user root
RUN apk update && apk upgrade && apk add zip

COPY ./config/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /work/build.zip /usr/share/nginx/html/
WORKDIR /usr/share/nginx/html
RUN unzip -o build.zip && rm -f build.zip
