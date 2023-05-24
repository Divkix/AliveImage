# Build Stage: Build bot using the golang image
FROM golang:1.20-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=`go env GOHOSTOS` GOARCH=`go env GOHOSTARCH` go build -o out/aliveimage

# Final Stage: Use a smaller base image and only include necessary files
FROM scratch
COPY --from=builder /app/out/aliveimage /app/aliveimage
EXPOSE 8080
CMD ["/app/aliveimage"]
