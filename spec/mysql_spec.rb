describe 'optoro_metrics::mysql' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_metrics'

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        it 'Installs cronjob for mysql/mysql-graphite.rb' do
          expect(chef_run).to delete_cron('poll_mysql-graphite.rb').with(user: 'root', minute: '*', hour: '*', day: '*')
        end
      end
    end
  end
end
