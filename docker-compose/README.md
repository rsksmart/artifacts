# RSK docker-compose

This `docker-compose.yml` Uses the dockerfiles images and configurations [here](https://github.com/rsksmart/artifacts/tree/master/Dockerfiles/RSK-Node) on this docs for setting up rsk mainnet/testnet nodes 

## Example Usage

For running
> docker-compose up

For debugging/check current sync logs
> docker ps (Verify the container id you want to check)
>  docker exec -it <container-id> tail -f /var/log/rsk/rsk.log 
