describe 'optoro_metrics::system' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_metrics'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        it 'Includes optoro_metrics::default' do
          expect(chef_run).to include_recipe('optoro_metrics::default')
        end

        %w(cpu-pcnt-usage-metrics.rb cpu-metrics.rb disk-capacity-metrics.rb disk-metrics.rb disk-usage-metrics.rb interface-metrics.rb iostat-extended-metrics.rb load-metrics.rb memory-metrics-percent.rb memory-metrics.rb ntpdate-metrics.rb ntpstats-metrics.rb vmstat-metrics.rb).each do |script|
          it "Installs cronjob for system/#{script}" do
            expect(chef_run).to create_cron("poll_#{script}").with(user: 'root', minute: '*', hour: '*', day: '*')
          end
        end

        it 'Installs cronjob for network/poll_netif-metrics.rb' do
          expect(chef_run).to create_cron('poll_netif-metrics.rb').with(user: 'root', minute: '*', hour: '*', day: '*')
        end
      end
    end
  end
end
