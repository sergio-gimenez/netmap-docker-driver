# VALE-docker - Docker Plugin for netmap-enabled CNFs

Simple network plugin for Docker Engine that enables netmap on containers.

It uses veth interfaces to connect containers to the host network, and [vale](https://www.freebsd.org/cgi/man.cgi?query=vale&sektion=4&n=1) switch to connect containers to each other.

The code of the driver is forked from [jacekkow/docker-plugin-pyveth](https://github.com/jacekkow/docker-plugin-pyveth).

The idea behind this plugin is similar to what the default bridge driver does, but instead of using a an in-kernel bridge as a layer 2 switch, it uses a netmap enabled switch (vale). Note also that the veth pairs are set in netmap mode.

An important take here is to know that if netmap is using the `veth` patched driver, NF using the kernel stack will not work. They will only work if sending traffic using the netmap API. If the NF wants to use the traditional socket API, then netmap will need to be used with the generic `netmap` driver.

![docker_netmap_diagram](img/docker_netmap_diagram.png)

## Installation

### "Debug" Mode

While developing the plugin, I find it useaful to run it as a normal docker container.

To do so, we need first to make sure Docker daeamon can see the container as a plugin (as said in [docs](https://docs.docker.com/engine/extend/plugin_api/#plugin-discovery)).

To do so, we just need to run the following:

```bash
sudo cp vale_docker.json /etc/docker/plugins
```

Then, we can build the container and run it using docker-compose:

```bash
docker-compose -f rina-docker-plugin.yml up
```

### "Production" Mode

Plugin is packaged as [Docker Engine-managed plugin](https://docs.docker.com/engine/extend/).
Check out [plugin page on Docker Hub](https://hub.docker.com/p/jacekkow/pyveth).

To install it simply run:

```bash
docker plugin install sergiogimenez/vale:latest
```

In order to test this module in development environment, you can build it by following [Docker Engine documentation](https://docs.docker.com/engine/extend/#developing-a-plugin).

You can also use `package.sh` helper script which will perform all the steps (including installation) automatically.

## Test

Run two containers: one as a trafic generator (`txc`) and one as a traffic sink (`rxc`).

```bash
docker-compose -f simple-netmap-sender.yml up
```
