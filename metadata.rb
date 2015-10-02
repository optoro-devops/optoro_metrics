name 'optoro_metrics'
maintainer 'Optoro'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'Installs sensu metrics package and sets up metric cron jobs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.14'

supports 'ubuntu', '= 14.04'

depends 'optoro_logstash'
depends 'nginx'

provides 'optoro_metrics::default'
provides 'optoro_metrics::system'
provides 'optoro_metrics::nginx'
provides 'optoro_metrics::mysql'
provides 'optoro_metrics::kafka'
provides 'optoro_metrics::memcached'
provides 'optoro_metrics::elasticsearch'
provides 'optoro_metrics::redis'
provides 'optoro_metrics::rabbitmq'
provides 'optoro_metrics::mongodb'
provides 'optoro_metrics::zookeeper'
provides 'optoro_metrics::openvpn'

recipe 'optoro_metrics::default', 'Installs metric scripts'
recipe 'optoro_metrics::system', 'Setups system metric collection'
recipe 'optoro_metrics::nginx', 'Setups nginx to output metrics and collects them'
recipe 'optoro_metrics::mysql', 'Sets up mysql cron job to collect metrics'
recipe 'optoro_metrics::kafka', 'Setups kafka metric collection'
recipe 'optoro_metrics::memcached', 'Setups memcached metric collection'
recipe 'optoro_metrics::elasticsearch', 'Setups elasticsearch metric collection'
recipe 'optoro_metrics::redis', 'Setups redis metric collection'
recipe 'optoro_metrics::rabbitmq', 'Setups rabbitmq metric collection'
recipe 'optoro_metrics::mongodb', 'Setups mongodb metric collection'
recipe 'optoro_metrics::zookeeper', 'Setups zookeeper metrics collection'
recipe 'optoro_metrics::openvpn', 'Setups openvpn metrics collection'
