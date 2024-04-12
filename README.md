# Storman (MaxView for Adaptec Controllers)

Based on: [https://github.com/thomashilzendegen/docker-storman/tree/main](https://github.com/thomashilzendegen/docker-storman/tree/main)

StorMan data is stored in `/usr/StorMan` so we have added a vol for the data to persist in the docker-compose

docker-compose.yml
```bash
networks:
  stor_net:
    driver: bridge
volumes:
  stor-data:

services:

  storman:
    env_file: .env
    image: xtekllc/storman:latest
    container_name: storman
    hostname: storman-docker
    privileged: true
    restart: unless-stopped
    ports:
      - 8443:8443/tcp
    networks:
      - stor_net
    volumes:
      - stor-data:/usr/StorMan
```

docker run
```bash
docker run -h storman-docker --privileged --name storman -p 8443:8443/tcp xtekllc/storman:latest
```

## ENV Var (See .env for info)
```bash

# Set the root password
STORMAN_PASS
```

