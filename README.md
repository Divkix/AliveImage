# Alive Image

[![CI](https://github.com/divideprojects/AliveImage/actions/workflows/ci.yml/badge.svg)](https://github.com/divideprojects/AliveImage/actions/workflows/ci.yml)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/divideprojects/aliveimage?sort=semver)](https://hub.docker.com/r/divideprojects/aliveimage)
![Repo Size](https://img.shields.io/github/repo-size/DivideProjects/aliveimage?style=flat-square)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/divideprojects/aliveimage/latest)](https://hub.docker.com/r/divideprojects/aliveimage)
[![Docker Pulls](https://img.shields.io/docker/pulls/divideprojects/aliveimage)](https://hub.docker.com/r/divideprojects/aliveimage)

A simple docker image based on go and docker that serves a json response with the uptime of the container.

Made using go and docker.

Image available on [Docker Hub](https://hub.docker.com/r/divideprojects/aliveimage) and [Github Container Registry](https://github.com/divideprojects/AliveImage/pkgs/container/aliveimage).

## Environment Variables
 - PORT: The port to serve the response. Default: 80

## Usage

```bash
docker run -d -p 80:80 -e PORT=80 --name aliveImage divideprojects/aliveimage
```

## Build and Run

Build:
```bash
docker build -t aliveimage-local .
```

Run:
```bash
docker run -d -p 80:80 -e PORT=80 --name aliveImage aliveimage-local
```

## Test

```bash
curl localhost
```
By default, the image will serve a json response with the following content: `{"status": "alive", "uptime": "1m 0s"}`
