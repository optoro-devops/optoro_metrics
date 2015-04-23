#<
# Installs Sensu Community Plugin package
#>

package 'sensu-community-plugins' do
  action :install
end

cookbook_file 'sensu_metrics.sh' do
  action :create
  path '/opt/logstash/agent/bin/sensu_metrics.sh'
  owner 'root'
  group 'root'
  mode '0755'
end
