---
layout: page
title: Docker Network
permalink: /docker/network
---

- TOC
{:toc}

---

- Docker creates its own isolated docker network where containers are running.
- Containers in same Docker Network can communicate with each-other just with the `container name` without needing `host:port`
- Docker provides some default network

```bash
docker network ls
# create new network
docker network create my-network
# run container in specific network my-network
docker run -d -p 6000:6379 -e <env_var> --name local-redis --net my-network redis
```
