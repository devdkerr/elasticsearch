Dockerized ElasticSearch
========================================

A dockerized ElasticSearch service, with Monit monitoring.

Docker Run
----------------------------------------

```bash
docker run -d -p 2812 -p 9200:9200 -v data/elasticsearch/data:/elasticsearch/data devdkerr/elasticsearch
```

Docker-Compose Run
----------------------------------------

```yaml
elasticsearch:
    image: devdkerr/elasticsearch
    ports:
     - "2812"
     - "9200:9200"
    volumes:
     - data/elasticsearch/data:/elasticsearch/data
     - data/elasticsearch/logs:/elasticsearch/logs
     - data/elasticsearch/work:/elasticsearch/work
```
     