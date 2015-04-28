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

## optoro_metrics::default

Installs Sensu Community Plugin package

## optoro_metrics::system

Installs cron jobs to collect system metrics

## optoro_metrics::nginx

Installs cron job to poll nginx status page

# License and Maintainer

Maintainer:: Optoro (<devops@optoro.com>)

License:: MIT
