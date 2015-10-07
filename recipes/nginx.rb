#<
# Installs cron job to poll nginx status page
#>
cron 'poll_nginx-metrics.rb' do
  action :delete
  command '/opt/logstash/agent/bin/sensu_metrics.sh nginx/nginx-metrics.rb -h 127.0.01 -q /nginx_status -P 8090'
  user 'root'
  minute '*'
end
