Graylog
=======

## Installation

### Prereqs

    Java (>= 8)
    MongoDB (>= 2.4)
    Elasticsearch (>= 2.x)

#### Helpful prereqs
```bash
sudo apt update
sudo apt install -y pwgen

# CREATE ROOT PW FOR GRAYLOG
echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1
```

#### Java
```bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install oracle-java8-installer
```

#### MongoDB
```bash
sudo apt update
sudo apt install -y mongodb
sudo systemctl status mongodb
```

#### Elasticsearch
```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt update
sudo apt install elasticsearch
sudo nano /etc/elasticsearch/elasticsearch.yml
#. . .
#network.host: localhost
#. . .
#CTRL+X, Y, <Enter>
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch
curl -X GET "localhost:9200" # test
```

### DEB/APT
```bash
sudo apt-get install apt-transport-https
wget https://packages.graylog2.org/repo/packages/graylog-2.5-repository_latest.deb
sudo dpkg -i graylog-2.5-repository_latest.deb
sudo apt-get update
sudo apt-get install graylog-server

# then start
sudo systemctl start graylog-server

# and/or enable on boot
sudo systemctl enable graylog-server
```

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