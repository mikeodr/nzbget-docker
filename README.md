# nzbget-docker

NZBGet Dockerfile Build

To Run:
```
docker run -d --name="nzbget" -v /path/to/dir/with/nzbget.conf:/config -v /path/to/downloads:/downloads -v /etc/localtime:/etc/localtime:ro -p 6789:6789 mikeodr/nzbget-docker
```
