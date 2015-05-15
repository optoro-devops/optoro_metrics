# Description

Installs sensu metrics package and sets up metric cron jobs

# Requirements

## Platform:

* Ubuntu (= 14.04)

## Cookbooks:

* optoro_logstash
* nginx

# Attributes

*No attributes defined*

# Recipes

* [optoro_metrics::default](#optoro_metricsdefault) - Installs metric scripts
* [optoro_metrics::system](#optoro_metricssystem) - Setups system metric collection
* [optoro_metrics::nginx](#optoro_metricsnginx) - Setups nginx to output metrics and collects them
* [optoro_metrics::mysql](#optoro_metricsmysql) - Sets up mysql cron job to collect metrics
* [optoro_metrics::kafka](#optoro_metricskafka) - Setups kafka metric collection
* [optoro_metrics::memcached](#optoro_metricsmemcached) - Setups memcached metric collection
* [optoro_metrics::elasticsearch](#optoro_metricselasticsearch) - Setups up elasticsearch metric collection
* [optoro_metrics::redis](#optoro_metricsredis) - Setups up redis metric collection
* [optoro_metrics::rabbitmq](#optoro_metricsrabbitmq) - Setups up rabbitmq metric collection
* [optoro_metrics::mongodb](#optoro_metricsmongodb) - Setups up mongodb metric collection

## optoro_metrics::default

Installs Sensu Community Plugin package

## optoro_metrics::system

Installs cron jobs to collect system metrics

## optoro_metrics::nginx

Installs cron job to poll nginx status page

## optoro_metrics::mysql

Installs cron job and mysql account to poll mysql

## optoro_metrics::kafka

Installs jmxtrans and configures it to emit metrics to graphite

## optoro_metrics::memcached

Installs memcached cron jobs to pull metrics and place into logstash

## optoro_metrics::elasticsearch

Installs elasticsearch cron jobs to pull metrics and place into logstash

## optoro_metrics::redis

Installs redis cron jobs to pull metrics and place into logstash

## optoro_metrics::rabbitmq

Installs rabbitmq cron jobs to pull metrics and place into logstash

## optoro_metrics::mongodb

Installs mongo cron jobs to pull metrics and place into logstash

# License and Maintainer

Maintainer:: Optoro (<devops@optoro.com>)

License:: MIT
