cookbook_file 'openvpn_metrics.rb' do
  action :create
  path '/opt/logstash/agent/bin/openvpn_metrics.rb'
  owner 'root'
  group 'root'
  mode '0755'
end

cron 'poll_openvpn' do
  action :create
  command '/opt/logstash/agent/bin/openvpn_metrics.rb | /bin/nc -q0 -t 127.0.0.1 6008'
  user 'root'
  minute '*'
end
