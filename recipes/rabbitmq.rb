#<
# Installs rabbitmq cron jobs to pull metrics and place into logstash
#>

%w(rabbitmq-overview-metrics.rb rabbitmq-queue-metrics.rb).each do |check|
  cron "poll_#{check}" do
    action :create
    command "/opt/logstash/agent/bin/sensu_metrics.sh rabbitmq/#{check}"
    user 'root'
    minute '*'
  end
end
