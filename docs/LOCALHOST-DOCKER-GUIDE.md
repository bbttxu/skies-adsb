# Localhost Docker Guide

## Setup Environment

We make use of docker-compose to manage this container, so do not need to provide variables via the `.env` file. The web app still will attempt to load the file, so we make sure it exists.

```bash
touch src/.env
```

## Build a Docker container containing the skies-adsb project

```bash
docker build -t local-docker-skies-adsb .
```

## Run the container locally

Update your docker-compose.yml file to include the new container you created above.

```yaml
# ...
skies:
  image: local-docker-skies-adsb
  tty: true
  container_name: skies
  restart: always
  ports:
    - 8083:5173
    - 30006:30006
  environment:
    - VITE_DEFAULT_ORIGIN_LATITUDE=${FEEDER_LAT}
    - VITE_DEFAULT_ORIGIN_LONGITUDE=${FEEDER_LONG}
    - VITE_USE_EXISTING_ADSB=readsb:30003
  tmpfs:
    - /run:exec,size=64M
    - /var/log:size=32M
```

This docker-compose.yml snippet sets env variables for the web app. The ports expose the webapp and the websockify proxy.

## Test out the container

```bash
docker-compose up skies
```

## Run the container permanently

```bash
docker-compose up -d skies
```

## Caveats

- Fedora 38 is used as baseimage as it is the latest version that can run on a Raspberry Pi 4
