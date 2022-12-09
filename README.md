# Alive Image

A simple docker image based on go and docker that serves a json response with the uptime of the container.

Made using go and docker.

## Environment Variables
 - PORT: The port to serve the response. Default: 80

## Usage

```bash
docker run -d -p 80:80 -e PORT=80 --name aliveImage divideprojects/aliveimage
```

## Build and Run

Build:
```bash
docker build -t aliveimage .
```

Run:
```bash
docker run -d -p 80:80 -e PORT=80 --name aliveImage aliveimage
```

## Test

```bash
curl localhost
```
By default, the image will serve a json response with the following content: `{"status": "alive", "uptime": "1m 0s"}`
