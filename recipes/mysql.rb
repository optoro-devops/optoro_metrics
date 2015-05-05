#<
# Installs cron job and mysql account to poll mysql
#>

sensu = Chef::EncryptedDataBagItem.load('passwords', 'mysql')['sensu']

template '/root/.mysql.sensu.ini' do
  action :create
  source 'mysql_ini.erb'
  owner 'root'
  group 'root'
  mode '0600'
  variables(sensu.to_hash)
  sensitive true
  only_if { sensu }
end

cron 'poll_mysql-graphite.rb' do
  action :create
  command '/opt/logstash/agent/bin/sensu_metrics.sh mysql/mysql-graphite.rb -h 127.0.0.1 -i /root/.mysql.sensu.ini'
  user 'root'
  minute '*'
end
