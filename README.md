# **NOTE**: This repository is now obsolete. Changes to the `traefik` configuration must be done in https://github.com/c4dt/ansible-config and deployed with Ansible.

# Traefik setup

This repository contains the [traefik](https://docs.traefik.io/) setup for the C4DT services.

## Services

The services currently fronted by traefik are:

* apache
* cryptpad
* synapse (matrix)
* conode-stainless (for stainless demo)
* drynx-leader (for drynx demo)
* cas (for omniledger-CAS authentication)

In order to avoid mounting `/var/run/docker.sock` directory in the traefik container, a separate container is used that acts as a proxy and blocks dangerous requests, as suggested [here](https://medium.com/@containeroo/traefik-2-0-paranoid-about-mounting-var-run-docker-sock-22da9cb3e78c).

![Traefik configuration](traefik-network.png?raw=true "Traefik configuration")

The traefik and apache docker containers, as well as the traefik configuration to expose apache, drynx-leader and cas are defined in this repository.
The traefik configuration for cryptpad, matrix and the stainless demo are defined in their respective docker configuration files:

* cryptpad: `/home/cryptpad/cryptpad/docker-compose.yml`
* matrix: `/home/matrix/synapse/docker-compose.yml`
* stainless demo: https://github.com/c4dt/service-stainless/blob/master/scripts/run_docker.sh

## Update

The steps to follow in order to update the configuration are:

* Update the files in this repository as needed.
* Commit and push.
* If the apache docker is affected:
```
$ docker-compose build
$ docker-compose push
```
* Log into `c4dtsrv1`, user `traefik`.
```
$ cd traefik-docker
$ docker-compose down
$ git pull
$ docker-compose pull
$ docker-compose up -d
```
