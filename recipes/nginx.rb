include_recipe 'optoro_metrics::default'

cron 'poll_nginx-metrics.rb' do
  action :create
  command '/opt/logstash/agent/bin/sensu_metrics.sh nginx/nginx-metrics.rb -h 127.0.01 -q /nginx_status -P 8090'
  user 'root'
  minute '*'
end
