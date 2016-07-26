describe 'optoro_metrics::kafka' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_metrics'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        it 'Includes optoro_metrics::kafka' do
          expect(chef_run).to include_recipe('optoro_metrics::kafka')
        end

        it 'Installs jmxtrans package' do
          expect(chef_run).to install_package('jmxtrans')
        end

        it 'Writes out a jmx config file' do
          expect(chef_run).to render_file('/var/lib/jmxtrans/kafka-metrics.json')
        end
      end
    end
  end
end
