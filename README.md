# VALE-docker - Docker Plugin for netmap-enabled CNFs

Simple network plugin for Docker Engine that enables netmap on containers.

It uses veth interfaces to connect containers to the host network, and [vale](https://www.freebsd.org/cgi/man.cgi?query=vale&sektion=4&n=1) switch to connect containers to each other.

The code of the driver is forked from [jacekkow/docker-plugin-pyveth](https://github.com/jacekkow/docker-plugin-pyveth).

## Installation

```bash
sudo cp vale_docker.json /etc/docker/plugins
docker-compose up
```
