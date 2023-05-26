FROM alpine:3.18
COPY aliveimage /
CMD ["/aliveimage"]

HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl --fail http://localhost:$API_LISTEN_PORT/status || exit 1

LABEL org.opencontainers.image.authors="Divanshu Chauhan <divkix@divkix.me>"
LABEL org.opencontainers.image.url="https://divkix.me"
LABEL org.opencontainers.image.source="https://github.com/divkix/aliveimage"
LABEL org.opencontainers.image.title="Alive Image"
LABEL org.opencontainers.image.description="Basic go app & docker image with simple json response."
LABEL org.opencontainers.image.vendor="Divkix"
