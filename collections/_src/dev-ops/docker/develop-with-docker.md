---
layout: page
title: Developing with Docker
permalink: /docker/develop-with-docker
---

- TOC
{:toc}

---

- Install docker from official website 

```bash
docker pull mysql:5.6 # pulls image from Docker Hub (puclic repo)
docker images


docker run hello-world
docker run mysql:5.6 # docker pull + docker start
docker run -d redis # detached mode : prints container id in output
docker run -p 8000:80 redis # port binding : 8000 (host) => 80 (docker)
docker run --name redis-latest redis # container name

docker start <container-id>
docker ps       # running containers
docker stop <container-id>
docker ps -a    # all containers : running + stopped

docker run -d -p 6000:6379 --name redis-older redis:4.0
```

- `docker run` creates a new container from image and start it
- `docker start` used for existing docker container

## Debugging

```bash
# docker logs
docker logs <container_id or name>

# interactive terminal to log into docker container
docker exec -it <container_id or name> /bin/bash
docker exec -it <container_id or name> /bin/sh # if container doesn't have bash, try sh
pwd
ls
env
exit

docker inspect <container_id or name>
```

## Build Image from Dockerfile

```bash
# Dockerfile
FROM ubuntu:16.04
RUN echo "welcome to dockerfile"
```

```bash
# builds image from dockerfile
docker build -t local-mysql .
```

