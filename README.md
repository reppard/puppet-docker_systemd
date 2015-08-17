# docker_systemd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with docker_systemd](#setup)
    * [What docker affects](#what-docker_systemd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with docker_systemd](#beginning-with-docker_systemd)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module configures Docker containers on Red Hat systems which use systemd.

## Module Description

This module provides more comprehensive systemd service configuration in order
to support container dependencies and more sophisticated usage patterns, such
as data volume containers.

## Setup

### What docker_systemd affects

TODO

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **Optional**

TODO

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

### Beginning with docker_systemd

TODO

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

TODO

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

TODO

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This module targets Red Hat Linux systems capable of running Docker:

* RHEL 7+
* CentOS 7+
* Fedora 20+

## Development

TODO

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

TODO

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
