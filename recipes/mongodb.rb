#<
# Installs mongo cron jobs to pull metrics and place into logstash
#>

%w(mongodb-metrics.rb).each do |check|
  cron "poll_#{check}" do
    action :delete
    command "/opt/logstash/agent/bin/sensu_metrics.sh mongodb/#{check}"
    user 'root'
    minute '*'
  end
end
