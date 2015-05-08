name 'optoro_metrics'
maintainer 'Optoro'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'Installs sensu metrics package and sets up metric cron jobs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.7'

supports 'ubuntu', '= 14.04'

depends 'optoro_logstash'
depends 'nginx'

provides 'optoro_metrics::default'
provides 'optoro_metrics::system'
provides 'optoro_metrics::nginx'
provides 'optoro_metrics::mysql'
provides 'optoro_metrics::kafka'

recipe 'optoro_metrics::default', 'Installs metric scripts'
recipe 'optoro_metrics::system', 'Setups system metric collection'
recipe 'optoro_metrics::nginx', 'Setups nginx to output metrics and collects them'
recipe 'optoro_metrics::mysql', 'Sets up mysql cron job to collect metrics'
recipe 'optoro_metrics::kafka', 'Setups kafka metric collection'
