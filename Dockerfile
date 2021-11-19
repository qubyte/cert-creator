FROM alpine:3

WORKDIR /src
RUN apk add --update openssl && rm -rf /var/cache/apk/*

COPY script.sh script.sh
COPY cert.conf.template cert.conf.template

ENTRYPOINT ["./script.sh"]
