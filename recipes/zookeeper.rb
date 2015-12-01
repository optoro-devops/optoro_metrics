cookbook_file 'zookeeper_metrics.rb' do
  action :delete
  path '/opt/logstash/agent/bin/zookeeper_metrics.rb'
  owner 'root'
  group 'root'
  mode '0755'
end

cron 'poll_zookeeper' do
  action :delete
  command '/opt/logstash/agent/bin/zookeeper_metrics.rb | /bin/nc -q0 -t 127.0.0.1 6008'
  user 'root'
  minute '*'
end
