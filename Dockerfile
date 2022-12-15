# Build Stage: Build bot using the alpine image, also install doppler in it
FROM golang:1.19-alpine AS builder
RUN addgroup -S aliveuser \
    && adduser -S -u 10000 -g aliveuser aliveuser
RUN apk add -U --no-cache ca-certificates
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=`go env GOHOSTOS` GOARCH=`go env GOHOSTARCH` go build -o out/aliveimage

# Run Stage: Run bot using the bot and doppler binary copied from build stage
FROM alpine:3.17
COPY --from=builder /app/out/aliveimage /
CMD ["/aliveimage"]
