name 'optoro_metrics'
maintainer 'Optoro'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'Installs sensu metrics package and sets up metric cron jobs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

supports 'ubuntu', '= 14.04'

depends 'optoro_logstash'

provides 'optoro_metrics::default'
provides 'optoro_metrics::system'

recipe 'optoro_metrics::default', 'Installs metric scripts'
recipe 'optoro_metrics::system', 'Setups system metric collection'
