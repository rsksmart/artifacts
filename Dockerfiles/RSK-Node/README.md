## RSK Dockerfile

This repository contains **Dockerfile** of [RSK Node](http://www.rsk.co/) for [Docker](https://www.docker.com/)'s automated build. Is not published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [dockerfile/Ubuntu:Latest](https://hub.docker.com/_/ubuntu/)


### Installation

1. Install [Docker](https://docs.docker.com/engine/installation/).

2. Build the image from the Dockerfile:
  * MainNet

  ```bash
 docker build -t mainnet -f Dockerfile.MainNet .
 ```
  * TestNet

  ```bash
  docker build -t testnet -f Dockerfile.TestNet .
  ```

  * RegTest

  ```bash
  docker build -t regtest -f Dockerfile.RegTest .
  ```

### Usage Examples
* MainNet

```bash
docker run -d --name mainnet-node-01  -p 4444:4444 -p 5050:5050 mainnet
```
* TestNet

```bash
docker run -d --name testnet-node-01  -p 4444:4444 -p 50505:50505 testnet
```
* RegTest

```bash
docker run -d --name regtest-node-01  -p 4444:4444 -p 30305:30305 regtest
```
