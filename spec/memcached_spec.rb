describe 'optoro_metrics::memcached' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_metrics'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        %w(memcached_socket_graphite.rb memcached-key-stats-graphite.rb).each do |script|
          it "Installs cronjob for memcached/#{script}" do
            expect(chef_run).to create_cron("poll_#{script}").with(user: 'root', minute: '*', hour: '*', day: '*')
          end
        end
      end
    end
  end
end
