# Docker Apt Cacher

Simple docker image for apt-cacher-ng, run with docker-compose :

```
version: "3"
services:
  apt-cacher-ng:
    image: registry.robespierre.lan:80/apt-cacher-ng
    container_name: apt-cacher-ng
    restart: unless-stopped
    ports:
      - "192.168.42.23:3142:3142"
```
