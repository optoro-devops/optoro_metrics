require 'spec_helper'

describe 'optoro_metrics::kafka' do

  describe file('/var/lib/jmxtrans/kafka-metrics.json') do
    it { should be_file }
  end

  describe package('jmxtrans') do
    it { should be_installed }
  end

  describe service('jmxtrans') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

end
