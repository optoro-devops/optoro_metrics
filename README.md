# Description

Installs sensu metrics package and sets up metric cron jobs

# Requirements

## Platform:

* Ubuntu (= 14.04)

## Cookbooks:

*No dependencies defined*

# Attributes

*No attributes defined*

# Recipes

* [optoro_metrics::default](#optoro_metricsdefault) - Installs metric scripts
* [optoro_metrics::system](#optoro_metricssystem) - Setups system metric collection

## optoro_metrics::default

Installs Sensu Community Plugin package

## optoro_metrics::system

Installs cron jobs to collect system metrics

# License and Maintainer

Maintainer:: Optoro (<devops@optoro.com>)

License:: MIT
