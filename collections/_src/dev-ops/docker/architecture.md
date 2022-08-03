---
layout: page
title: Architecture
permalink: /docker/architecture
---

- TOC
{:toc}

---

- Technically, Container is Layers of images.
- Mostly Linux Base Image (alpine:3.10), because small in size
- Application image on top

Docker uses a typical client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing Docker containers. The Docker client and daemon communicate via sockets or through a RESTful API.

![]({{site.cdn}}/webservices/docker/docker-architecture-2.png)

![]({{site.cdn}}/webservices/docker/docker-components.png)

![]({{site.cdn}}/webservices/docker/docker-architecture.png)
