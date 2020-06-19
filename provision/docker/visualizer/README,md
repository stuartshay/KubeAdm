

```
docker service create --name=visualizer --publish=8080:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock dockersamples/visualizer 


docker stack deploy --compose-file /docker/visualizer/docker-compose.yaml visualizer
```