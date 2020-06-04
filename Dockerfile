FROM alpine:latest

ENV VER=2.11.1 METHOD=chacha20 PASSWORD=ss123456
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl gzip ca-certificates libc6-compat libgcc libstdc++ \
  && curl -sL https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-amd64-2.11.1.gz | gzip -d gost \
  && chmod a+x gost/gost-linux-amd64

WORKDIR /gost
EXPOSE ${TLS_PORT} $PORT

CMD exec /gost/gost-linux-amd64 -L=tls://:${TLS_PORT}/:$PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT
