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

  * Configuration
    
    It is possible to include your own configuration files to the image.
    In order to achieve this add, the following lines to `Dockerfile` before the `CMD` command.

    ```
    COPY logback.xml /etc/rsk/logback.xml
    COPY testnet.conf /etc/rsk/testnet.conf
    ```    
   
    Copy `logback.xml` and `testnet.conf` from `rskj-ubuntu-installer/config` directory to the current one. Modify them if it is necessary: e.g. put a rundom number as a hex string to `peer.privateKey` and `/bin/false` to `solc.path`. Run one of the command listed above to build the image.

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

* Preserve the database

In order to preseve the database between the container restart, create the directory `~/rsk-testnet`, modify its permission to be writable by anyone and and add `-v ~/rsk-testnet/:/var/lib/rsk/database` to one of the commands above. For example,

```bash
mkdir ~/rsk-testnet

chmod a+rwx ~/rsk-testnet

docker run -d --name testnet-node-01  -p 4444:4444 -p 50505:50505 -v ~/rsk-testnet/:/var/lib/rsk/database testnet
```

* Get the latest logs

```bash
docker exec testnet-node-01 tail /var/log/rsk/rsk.log
```
