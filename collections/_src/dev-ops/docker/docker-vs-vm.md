---
layout: page
title: Docker vs Virtual Machine (VM)
permalink: /docker/docker-vs-vm
---

- TOC
{:toc}

---

Operating Systems has 2 layers
1. OS Kernel - communicates with Hardware - CPU, memory etc
2. Applications layer

For example, Multiple versions of linux exist which use same linux kernel but they implement different applications on top of their kernel

## Different levels of absrtaction
- Docker and VM are both virtualization tools
  - Docker : `virtualises Applications layer` of OS while using the kernel of host
  - VM : `Virtualises whole OS` (Applications layer + OS kernel)
- **Size** : Docker image size is much smaller due to this.
  - Docker images in MBs, while Vm are in GBs
- **Speed** : Docker containers start and run much fast.
- **Compatibility** : VM of any OS can run on any OS host

## Why linux based docker containers don't run on windows
- Host - Windows OS (Applications + Kernel)
- Linux based image (Aplpications layer) might not be compatible with Host OS kernel
- Check whether Host can run docker natively, ie. check if your os kernel is compatible with docker images.
- Workaround - Use Docker Toolbox to abstract way kernel to allow host run the docker images

![docker-vs-vm](https://www.researchgate.net/profile/Ling-Hong-Hung/publication/299771559/figure/fig4/AS:359778707623937@1462789336136/A-comparison-of-the-architecture-of-virtual-machines-and-Docker-software.png)

![]({{site.cdn}}/webservices/docker/vm-vs-docker.png)

![7-layers](https://sf.ezoiccdn.com/ezoimgfmt/networkencyclopedia.com/wp-content/uploads/2019/09/application-layer-7-osi-model.jpg?ezimgfmt=ng:webp/ngcb2)

![OSI-7-layers](https://www.imperva.com/learn/wp-content/uploads/sites/13/2020/02/OSI-7-layers.jpg.webp)
