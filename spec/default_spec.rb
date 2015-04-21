describe 'optoro_metrics::default' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_metrics'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        it 'Installs sensu-community-plugins package' do
          expect(chef_run).to install_package('sensu-community-plugins')
        end

        it 'Installs sensu-metrics.sh into logstash' do
          expect(chef_run).to create_cookbook_file('/opt/logstash/agent/bin/sensu_metrics.sh').with(user: 'root', mode: '0755')
        end
      end
    end
  end
end
