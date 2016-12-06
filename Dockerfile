FROM alpine:edge
MAINTAINER Phil Porada - philporada@gmail.com

RUN echo $'http://alpine.gliderlabs.com/alpine/edge/testing' >> /etc/apk/repositories && \
    apk update && \
    apk upgrade --update-cache --available && \
    apk add nodejs \
        xpdf \
        vips \
        vips-dev \
        python2 \
        git \
        make \
        g++

ADD . /app

# Allow us to get the private npm credentials during the build step
ARG NPMTOKEN

# Sharp is installed via package.json here
# Private npm credentials are then always removed. The npm creds are never able to be cached so security++
RUN addgroup "unprivuser" && \
    adduser -S -u 1000 -h /home/unprivuser -s /bin/sh "unprivuser" && \
    chown -R unprivuser:unprivuser /app && \
    echo -e "//registry.npmjs.org/:_authToken=$(echo ${NPMTOKEN})\nprogress=false" > ~/.npmrc && \
    npm install && \
    rm -f ~/.npmrc

# Simple test that shows that sharp is installed and produces output
RUN echo -e '"use strict";\nconst sharp = require( "sharp" );\nconsole.log( sharp );' > /app/sharp_test.js && \
    node sharp_test.js && \
    rm -f /app/sharp_test.js

WORKDIR /app
USER unprivuser
CMD [ "npm", "run", "start" ]
