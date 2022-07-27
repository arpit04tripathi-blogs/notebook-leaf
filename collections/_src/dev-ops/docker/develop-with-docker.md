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
docker run hello-world

# Dockerfile
FROM ubuntu:16.04
RUN echo "welcome to dockerfile"

docker build -t local-mysql .   # builds image from dockerfile
docker pull mysql:5.6           # pulls image from Docker Hub (puclic repo)
docker images

# new container
docker run mysql:5.6 # docker pull + docker start
docker run -d redis # runs in detached mode and prints container id in output
docker run -d -p 80:80 image service myapp

docker ps       # running containers
docker ps -a    # all containers : running + stopped

docker stop <container-id>
docker start <container-id>

# host port 6000 --> container port 6379
docker run -d -p 6000:6379 --name redis-older redis:4.0
docker logs <container_id or name>

# interactive terminal to log into docker container
docker exec -it <container_id or name> /bin/bash
```
