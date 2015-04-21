require 'spec_helper'

describe 'optoro_metrics::default' do
  describe package('sensu-community-plugins') do
    it { should be_installed }
  end

  describe file('/opt/logstash/agent/bin/sensu_metrics.sh') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end
end
