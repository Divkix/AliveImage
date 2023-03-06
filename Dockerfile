# Build Stage: Build bot using the alpine image
FROM golang:1.20-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=`go env GOHOSTOS` GOARCH=`go env GOHOSTARCH` go build -o out/aliveimage

# Run Stage: Run bot using the bot and doppler binary copied from build stage
FROM alpine:3.17
COPY --from=builder /app/out/aliveimage /
CMD ["/aliveimage"]
