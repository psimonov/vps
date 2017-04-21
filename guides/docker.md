# Настройка Docker

## Удаление контейнеров и образов:

```
#!/bin/bash
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)
```
