---
layout: page
title: Dockerfile
permalink: /docker/dockerfile
---

- TOC
{:toc}

---

- In CICD, Jenkins takes the github repo to perform actions
- At last, it takes the Dockerfile to create the docker image and push it to Container Repository
- `Dockerfile` is like a blueprint to build images

```bash
# start with a base images
FROM node
# set env variables
ENV MONGO_DB_USERNAME=admin \
MONGO_DB_PWD=password
# RUN executes inside the container, so directory is created inside of container
# RUN <any linux commands>
RUN mkdir -p /home/app
# COPY executes on the HOST machine
# COPY source on host -> target on container
COPY . /home/app
ENTRYPOINT ["docker-entrypoint.sh"]
# CMD is entry point command
# as server.js copied to /home/app folder
CMD["node", "/home/app/server.js"]
# node server.js cmd to start node server
```

**CMD vs RUN in Dockerfile**
- you can have multiple RUN commands
- but only 1 CMD command as entrypoint command

## Build image from Dockerfile

```bash
docker build -t my-app:1.0 .
```
