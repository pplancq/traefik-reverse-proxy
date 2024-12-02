# Traefik Reverse Proxy Example

## Objective

This repository provides an example of using Traefik as a reverse proxy for a development environment.
Traefik is a modern and flexible reverse proxy that simplifies the management of routes and SSL certificates for your applications.

## Prerequisites

- Docker installed on your machine
- Docker Compose installed

## Installation

1. Clone this repository to your local machine:
```bash
git clone https://github.com/pplancq/traefik-reverse-proxy.git
cd traefik-reverse-proxy
```

2. Start the services with Docker Compose:
```bash
docker-compose up -d
```

## Usage

### Accessing Services

- **Traefik Dashboard**: Accessible via http://localhost:9000

### Adding New Services

To add new services to your Traefik configuration, follow these steps:

1. Create a `docker-compose.yml` file in the new service's project.
2. Add the network definition in the `docker-compose.yml` file:
```yaml
networks:
 traefik:
   name: traefik
```

3. Add the service definition in the `docker-compose.yml` file and configure the Traefik labels.
Note that the default exposure of Docker containers is disabled in Traefik, so you need to add the appropriate labels.

Example:
```yaml
  my-service:
    image: my-service-image
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.my-service.rule=Host(`my-service.localhost`)"
      - "traefik.http.services.my-service.loadbalancer.server.port=80"
    networks:
      - traefik
```

4. Start the Docker Compose services:
```bash
docker-compose up -d
```

### SSL Certificate

The container initializes a self-signed SSL certificate for `localhost`.
The rootCA used is automatically copied to the `rootCert` folder of the project so you can add it to your browser to avoid security warnings.

## Open Ports

- **Port 80**: HTTP
- **Port 443**: HTTPS

## Resources

- [Official Traefik Documentation](https://doc.traefik.io/traefik/)
- [Docker](https://docs.docker.com)
- [Docker Compose](https://docs.docker.com/compose/)
