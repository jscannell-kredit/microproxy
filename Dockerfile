FROM golang:1.25.10-alpine3.22 AS build

RUN apk add --no-cache curl python3 && \
    apk upgrade --no-cache

WORKDIR /work
COPY . .
RUN go build && go test

FROM alpine:3.22

RUN apk upgrade --no-cache

RUN set -x && \
    addgroup -S -g 1000 microproxy && \
    adduser -S -H -u 1000 microproxy microproxy

COPY --from=build /work/microproxy /usr/bin/microproxy

COPY docker.toml /etc/microproxy/config.toml
RUN chmod 644 /etc/microproxy/config.toml

USER microproxy
EXPOSE 3128

ENTRYPOINT [ "/usr/bin/microproxy", "--config", "/etc/microproxy/config.toml" ]
