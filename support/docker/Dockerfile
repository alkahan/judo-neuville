ARG HUGO_VERSION=0.74.3

FROM alpine AS builder
ARG HUGO_VERSION


RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -O /tmp/hugo.tar.gz
RUN tar xf /tmp/hugo.tar.gz

RUN mkdir -p /usr/src/app

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN /hugo


FROM alpine

RUN apk add --no-cache rsync

RUN mkdir -p /usr/src/
COPY --from=builder /usr/src/app/public /usr/src/app
COPY support/docker/app-start /usr/bin/app-start
COPY htaccess /usr/src/app/.htaccess
RUN chmod 644 /usr/src/app/.htaccess

CMD [ "/usr/bin/app-start" ]
