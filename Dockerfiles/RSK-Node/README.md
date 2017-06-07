## RSK Dockerfile

This repository contains **Dockerfile** of [RSK Node](http://www.rsk.co/) for [Docker](https://www.docker.com/)'s automated build. Is not published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [dockerfile/Ubuntu:Latest](https://hub.docker.com/_/ubuntu/)


### Installation

1. Install [Docker](https://docs.docker.com/engine/installation/).

2. Build the image from the Dockerfile: 
```bash
docker build -t rsk_node .
``` 

### Usage
```bash
docker run -d --name rsk-node-01  -p 4444:4444 -p 50505:50505 rsk_node
```

