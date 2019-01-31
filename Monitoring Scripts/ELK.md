ELK Stack
=========

## Installation



--------------------------------------

## Docker Installation

```bash
sudo docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name elk sebp/elk
```

or

```bash
git clone https://github.com/deviantony/docker-elk.git
cd /docker-elk
docker-compose up -d
```