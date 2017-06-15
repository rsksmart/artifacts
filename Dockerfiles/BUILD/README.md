# BuildMachine Docker File 

This ***Dockerfile*** is for [reproducible build](https://github.com/rsksmart/rskj/wiki/Reproducible-Build) of [RSK Node](http://www.rsk.co/). Is not published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

To use this container, follow the [reproducible build](https://github.com/rsksmart/rskj/wiki/Reproducible-Build) procedure.

### Base Docker Image

* [dockerfile/Ubuntu:16.04](https://hub.docker.com/_/ubuntu/)

### Usage

Build Container
```bash
docker build -t buildmachine .
```

Build
```bash
docker run -v $(pwd):/rskj -w /rskj buildmachine:latest sh -c 'gpg --keyserver https://secchannel.rsk.co/release.asc --recv-keys 5DECF4415E3B8FA4 && gpg --finger 5DECF4415E3B8FA4 && gpg --verify SHA256SUMS.asc && sha256sum --check SHA256SUMS.asc && ./configure.sh && ./gradlew shadow reproducible'
```

First of all, we have changed our working directory to the repository root, because we actually need Gradle and the root project in the Docker container as well
  * -v $(pwd/rskj) basically means that we mount the current working directory to the Docker container as /rskj
  * -w /rskj sets the our working directory to the mounted directory, so effectively we are in the same directory in the container as we are locally
  * buildmachine:latest just means that we use the latest image with the tag buildmachine that we created earlier.


Based in [Reproducible-builds](http://blog.greenhouseci.com/greenhouse/update/reproducible-builds/)
