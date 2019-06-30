FROM node:10.16.0-alpine

ARG VERSION=6.2.0

ADD https://github.com/sx1989827/DOClever/archive/${VERSION}.tar.gz /
RUN echo "{}" > /DOClever-${VERSION}/config.json && sed -i "s/baseUrl:\"http:\/\//baseUrl:location.protocol+\"\/\//g" /DOClever-${VERSION}/Client/dist/vendor.bundle.js && sed -i "s/host:\"http:\/\//host:location.protocol+\"\/\//g" /DOClever-${VERSION}/Client/dist/vendor.bundle.js

VOLUME /DOClever/upload
EXPOSE 10000
WORKDIR /DOClever-${VERSION}
ENTRYPOINT ["node", "Server/bin/www", "--file", "/DOClever/upload", "--port", "10000"]
