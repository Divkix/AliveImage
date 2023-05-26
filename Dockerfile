# Build Stage: Build bot using the golang image
FROM golang:1.20-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=`go env GOHOSTOS` GOARCH=`go env GOHOSTARCH` go build -o out/aliveimage

# Final Stage: Use a smaller base image and only include necessary files
FROM scratch
COPY --from=builder /app/out/aliveimage /app/aliveimage
ENV API_LISTEN_PORT=8080
EXPOSE $API_LISTEN_PORT
CMD ["/app/aliveimage"]

HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl --fail http://localhost:$API_LISTEN_PORT/status || exit 1

LABEL org.opencontainers.image.authors="Divanshu Chauhan <divkix@divkix.me>"
LABEL org.opencontainers.image.url="https://divkix.me"
LABEL org.opencontainers.image.source="https://github.com/divkix/aliveimage"
LABEL org.opencontainers.image.title="Alive Image"
LABEL org.opencontainers.image.description="Basic go app & docker image with simple json response."
LABEL org.opencontainers.image.vendor="Divkix"
