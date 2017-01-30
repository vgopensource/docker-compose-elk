# docker-compose-elk setup 

Docker Compose Based ELK setup for Centralized logging of Applications

Running the latest version of the ELK (Elasticseach, Logstash, Kibana) stack with Docker and Docker-compose.

With this ELK setup we are trying to analyze the data set using the aggregation and search capabilities of ElasticSearch and for Visualization of Kibana.

Based on the official Docker images:

* [elasticsearch](https://registry.hub.docker.com/_/elasticsearch/)
* [logstash](https://registry.hub.docker.com/_/logstash/)
* [kibana](https://registry.hub.docker.com/_/kibana/)
* [wordpress](https://registry.hub.docker.com/_/Wordpress/) (LEMP based)
- [mysql](https://registry.hub.docker.com/_/mysql/)

# Setup Requirements

1. Install Docker.
2. Install Docker-compose latest version.

# Pre-requisites

Ansible control machine with python boto library installed for using the AWS environment.
Setup the ACCESS_KEY and SCERET_KEY for aws iam user as a "environment variable".

```bash
export AWS_ACCESS_KEY=' ' 
export AWS_SECRET_KEY_ID=' '
```

you need to start the ssh-agent to perform the remote operations on EC2 instances.

```bash
ssh-agent bash
```

# Usage 

1. Clone this repository
2. The shell script with the name elkstack should now be there in the present directory.
3. Just execute the script and it should start building up the stack over EC2 instance in the form of contanierized apps.
4. Once finished then access Kibana UI by hitting http://<ec2 instance IP>:5601 with a web browser.  
5. we have already Injected wordpress application syslog into the logstash which has been indexed and ready to be used by Kibana UI.
6. All you should have to do is to hit the create button , it should already be set up with @timestamp and default logstash-* index.

By default, the stack exposes the following ports:

* 5000: Logstash TCP input.
* 9200: Elasticsearch HTTP
* 9300: Elasticsearch TCP transport
* 5601: Kibana
* 8081: Wordpress Port
* 3306: MySQL Port

# Configuration

## Kibana

The Kibana default configuration is stored in `docker/elk-stack/kibana/config/kibana.yml`
Additional Plugins can be added based on the application logging features.

## LogStash

Logstash performs the Indexing of data and parse the logs based on the input,filter and output plugin.
Configuration file is at the location `docker/elk-stack/logstash/config`
New plugins can be added to the logstash configuration for the additional logs

* Just need to add the associated plugin code configuration to the `logstash/config/logstash.conf` file

## Elasticsearch

 ElasticSearch is a search engine which at the core runs on top of Apache Lucene and uses REST API to perform the index searches.
 In the event of this it also does the query to logstash for data using similar API.
 
 Note : For Elasticsearch to successfully start the docker host memory set to be minimum 21644 , by default it's too less.
       In the configuration this has been corrected already so no manual intervention should be required.

## Health status of the cluster
# Elasticsearch cluster health is indicated in three parameters:

• Red indicates that some or all primary shards are not ready to serve the requests.
• Yellow indicates that all primary shards are allocated but some or all of the replicas have not been allocated. Normally, single node   clusters will have their health status as yellow as no other node is available for replication.
• Green indicates that all shards and their replicas are well allocated and the cluster is fully operational.
