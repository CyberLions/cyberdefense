Graylog
=======

## Installation



--------------------------------------

## Docker Installation

```bash
docker run --name mongo -d mongo:3
docker run --name elasticsearch \
    -e "http.host=0.0.0.0" -e "xpack.security.enabled=false" \
    -d docker.elastic.co/elasticsearch/elasticsearch-oss:6.5.4
docker run --link mongo --link elasticsearch \
    -p 9000:9000 -p 12201:12201 -p 514:514 \
    -e GRAYLOG_WEB_ENDPOINT_URI="http://<server ip>:9000/api" \
    -d graylog/graylog:2.5

# if elasticsearch fails to start, here are some options
# option 1: allocate more virtual memory
sudo sysctl -w vm.max_map_count=262144
#option 2: append this to the elasticsearch run
-e ES_CONNECT_RETRY=300
```