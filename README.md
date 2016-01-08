# docker_systemd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with docker_systemd](#setup)
    * [What docker affects](#what-docker_systemd-affects)
    * [Beginning with docker_systemd](#beginning-with-docker_systemd)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Release Notes](#release-notes)

## Overview

This module configures Docker containers on Red Hat systems which use systemd.

## Module Description

This module provides more comprehensive systemd service configuration in order
to support container dependencies and more sophisticated usage patterns, such
as data volume containers. It also configures systemd service dependencies, so
that Docker containers can be started in the correct order, which is pretty
important for linking containers and sharing volumes.

## Setup

### What docker_systemd affects

This module generates systemd unit files in `/etc/systemd/system`. These unit
files have a prefix of "docker-", followed by the name of the container.

When docker_systemd services are started, the resulting Docker containers will
be stored using Docker's storage driver.

If any Docker images are pulled as a result of running a Docker container,
those images will be stored using Docker's storage driver.

There's currently a gotcha where subsequent changes to systemd unit files may
require a `systemctl daemon-reload` for those changes to take effect.

## Usage

### docker_systemd::container

`docker_systemd::container` configures a standalone Docker container to run
under systemd.

```.puppet
docker_systemd::container { "httpd":
  image => "httpd"
}
```

By default, this configuration enables and starts the container service. The
systemd service is named `docker-httpd`.

The following options are available for `docker_systemd::container`:

  * ensure: Takes any `ensure` value accepted by the `Service` resource type
    (Default `running`).

  * enable: Takes any `enable` value accepted by the `Service` resource type
    (Default `true`).

  * image: The name of the docker image to use.

  * command: Command and arguments to be run by the container.

  * depends: Dependencies on other systemd docker units which need to be
    started before this one.

  * volumes_from: Containers which this container mounts volumes from.

  * link: Containers which this container links to.

  * publish: Ports which should be published by this container.

  * entrypoint: Run this container with a different entrypoint.


### docker_systemd::exec

`docker_systemd::exec` allows a `docker exec` command to be invoked within a `docker_systemd::container`.

```.puppet
docker_systemd::exec { "httpd":
  command => "/bin/ls"
}
```

The above example configures `/bin/ls` to be run from within the container of
the `docker-httpd` service. The docker service for this is named
`docker-httpd-exec`.

### docker_systemd::data_volume_container

`docker_systemd::data_volume_container` configures a systemd unit for a data
volume container. This type of container is only run once at system startup,
and is run using an entrypoint of `/bin/true`. The main purpose of such a
container is to provide volume storage to other containers.

```.puppet
docker_systemd::data_volume_container { "httpd-data":
  image => "httpd"
}
```

The above example creates a data volume container named `httpd-data` from the
`httpd` image. The systemd service for this is named `docker-httpd-data`.

For more information about the data volume container pattern, see the
official Docker documentation for
[Creating and mounting a data volume container](https://docs.docker.com/engine/userguide/dockervolumes/#creating-and-mounting-a-data-volume-container).

## Limitations

This module targets Red Hat Linux systems capable of running Docker:

* RHEL 6.7+
* CentOS 6.7+
* Fedora 20+

This module is not used to create Docker images. If you need to create images, the `puppetlabs/docker_platform` module does that just fine.

## Development

Issues and pull requests can be made at <https://github.com/ajsmith/puppet-docker_systemd>

## Release Notes

### v0.1.1

Initial release.
