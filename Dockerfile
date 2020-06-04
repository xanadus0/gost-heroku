FROM alpine:latest

ENV VER=2.11.1 METHOD=AEAD_CHACHA20_POLY1305 PASSWORD=ss123456
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache wget gzip libc6-compat libgcc libstdc++ \
  && wget https://github.com/ginuerzh/gost/releases/download/v${VER}/gost-linux-amd64-${VER}.gz && gzip -d gost-linux-amd64-${VER}.gz \
  && chmod a+x gost-linux-amd64-${VER}

WORKDIR /
EXPOSE ${TLS_PORT} $PORT

CMD exec /gost-linux-amd64-${VER} -L=tls://:${TLS_PORT}/:$PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT
