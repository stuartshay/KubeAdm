

```
docker run -p 10000:10000 -p 10001:10001 mcr.microsoft.com/azure-storage/azurite


docker stack deploy --compose-file /docker/azurite/docker-compose.yaml azurite
```