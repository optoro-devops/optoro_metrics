#<
# Installs memcached cron jobs to pull metrics and place into logstash
#>

%w(memcached_socket_graphite.rb memcached-key-stats-graphite.rb).each do |check|
  cron "poll_#{check}" do
    action :delete
    command "/opt/logstash/agent/bin/sensu_metrics.sh memcached/#{check}"
    user 'root'
    minute '*'
  end
end
