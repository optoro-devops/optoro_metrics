#<
# Installs redis cron jobs to pull metrics and place into logstash
#>

%w(redis-graphite.rb).each do |check|
  cron "poll_#{check}" do
    action :create
    command "/opt/logstash/agent/bin/sensu_metrics.sh redis/#{check}"
    user 'root'
    minute '*'
  end
end
