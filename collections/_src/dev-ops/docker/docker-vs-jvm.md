---
layout: page
title: How Is Docker Different Than JVM?
permalink: /docker/docker-vs-jvm
---

- TOC
{:toc}

---

- The JVM is Java’s solution for application portability across different platforms — but Docker provides a different kind of virtualization that makes use of the guest operating system libraries, not just the Java application.
- When a Docker container is launched, a filesystem is allocated, along with the network/bridge interface and IP address.
- The command (or script) specified in the Dockerfile used to build the underlying Docker image is then executed, and the resulting Linux process runs in isolation.
- As a result, Docker can be used to package an entire JVM along with the JAR or WAR files and other parts of the application into a single container that can run on any Linux host consistently.
- This eliminates some of the challenges associated with making sure that the right JAR file version is used on the right JVM.
- Moreover, CPU and memory resource controls can be used with Docker containers — allowing users to allocate maximum amounts of resources that an application can use.

- A **hypervisor**, also known as a ***virtual machine monitor*** or VMM, is software that creates and runs virtual machines (VMs). A hypervisor allows one host computer to support multiple guest VMs by virtually sharing its resources, such as memory and processing.
- A **container engine** is a piece of software that accepts user requests, including command line options, pulls images, and from the end user's perspective runs the container.
