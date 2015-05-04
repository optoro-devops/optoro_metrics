require 'spec_helper'

describe 'optoro_metrics::mysql' do
  describe file('/root/.mysql.sensu.ini') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 600 }
  end
end
