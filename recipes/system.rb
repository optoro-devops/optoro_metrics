#<
# Installs cron jobs to collect system metrics
#>

include_recipe 'optoro_metrics::default'

%w(cpu-metrics.rb disk-capacity-metrics.rb disk-metrics.rb disk-usage-metrics.rb interface-metrics.rb iostat-extended-metrics.rb load-metrics.rb memory-metrics-percent.rb memory-metrics.rb ntpdate-metrics.rb ntpstats-metrics.rb vmstat-metrics.rb).each do |script|
  cron "poll_#{script}" do
    action :create
    command "/opt/logstash/agent/bin/sensu_metrics.sh system/#{script}"
    user 'root'
    minute '*'
  end
end

cron 'poll_netif-metrics.rb' do
  action :create
  command '/opt/logstash/agent/bin/sensu_metrics.sh network/netif-metrics.rb'
  user 'root'
  minute '*'
end
