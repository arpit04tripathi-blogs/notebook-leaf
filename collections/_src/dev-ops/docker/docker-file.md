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
  - available docker file commands - `FROM`, `ENV`, `RUN` etc
  - always called `Dockerfile`
```bash
# start with a base images
FROM node
# set env variables
ENV MONGO_DB_USERNAME=admin \
MONGO_DB_PWD=password
# RUN command executes inside the container
# so directory is created inside of container
# RUN <any linux commands>
RUN mkdir -p /home/app
# COPY executes on the HOST machine
# COPY source on host -> target on container
COPY . /home/app
ENTRYPOINT ["docker-entrypoint.sh"]
# CMD is entry point command
# as server.js copied to /home/app folder
CMD["node", "/home/app/server.js"]
# this is equivalent of `node server.js` on local host machine
```

**CMD vs RUN in Dockerfile**
- you can have multiple RUN commands
- but only 1 CMD command as entrypoint command

## Build image from Dockerfile

```bash
# -t app-name and tag
docker build -t my-app:1.0 .
# . => same dir has Dockerfile

docker ps -a | grep my-app
# filter containers having my-app
```

- every time you change Dockerfile, you need to run docker build command.

