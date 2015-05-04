#<
# Installs cron job and mysql account to poll mysql
#>

template '/root/.mysql.sensu.ini' do
  action :create
  source 'mysql_ini.erb'
  owner 'root'
  group 'root'
  mode '0600'
  variables(
    'user' => 'sensu',
    'password' => Chef::EncryptedDataBagItem.load('passwords', 'mysql')['sensu']['password']
  )
  sensitive true
end

cron 'poll_mysql-graphite.rb' do
  action :create
  command '/opt/logstash/agent/bin/sensu_metrics.sh mysql/mysql-graphite -h 127.0.0.1 -i /root/.mysql.sensu.ini'
  user 'root'
  minute '*'
end
