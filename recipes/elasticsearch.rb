#<
# Installs elasticsearch cron jobs to pull metrics and place into logstash
#>

%w(es-node-graphite.rb).each do |check|
  cron "poll_#{check}" do
    action :create
    command "/opt/logstash/agent/bin/sensu_metrics.sh elasticsearch/#{check}"
    user 'root'
    minute '*'
  end
end
