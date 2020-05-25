# RSK docker-compose

This `docker-compose.yml` uses the [official docker hub images of rsksmart](https://hub.docker.com/u/rsksmart) and the configurations for the [dockerfiles](https://github.com/rsksmart/artifacts/tree/master/Dockerfiles/RSK-Node) on this docs for setting up rsk mainnet/testnet nodes 

## Example Usage

For running
> docker-compose up

For debugging/check current sync logs
> docker ps (Verify the container id you want to check)
>  docker exec -it <container-id> tail -f /var/log/rsk/rsk.log 
