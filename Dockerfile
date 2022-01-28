FROM alpine

RUN apk add --no-cache curl

RUN curl -L https://fly.io/install.sh | sh

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
