FROM ubuntu:trusty
MAINTAINER Daniel R. Kerr <daniel.r.kerr@gmail.com>

COPY elasticsearch.gpg /root/elasticsearch.gpg
RUN apt-key add /root/elasticsearch.gpg \
 && echo "deb http://packages.elastic.co/elasticsearch/1.5/debian stable main" > /etc/apt/sources.list.d/elasticsearch.list

RUN apt-get update -y \
 && apt-get install -qq -y elasticsearch monit openjdk-7-jre-headless supervisor \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head

COPY elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre

COPY monitrc /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc \
 && chown root:root /etc/monit/monitrc

VOLUME ["/elasticsearch/data", "/elasticsearch/logs", "/elasticsearch/work"]

EXPOSE 2812 9200 9300

COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]