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
RUN addgroup "unprivuser" && \
    adduser -S -u 1000 -h /home/unprivuser -s /bin/bash "unprivuser" && \
    chown -R unprivuser:unprivuser /app && \
    echo -e "//registry.npmjs.org/:_authToken=$(echo ${NPMTOKEN})\nprogress=false" > ~/.npmrc

WORKDIR /app

# Sharp is installed via package.json here
# Private npm credentials are then always removed
RUN npm install ; \
    rm -f ~/.npmrc

# Simple test that shows that sharp is installed and produces output
RUN echo -e '"use strict";\nconst sharp = require( "sharp" );\nconsole.log( sharp );' > sharp_test.js && \
    node sharp_test.js

USER unprivuser

CMD [ "npm", "run", "start" ]
