describe 'optoro_metrics::nginx' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_metrics'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        it 'Installs cronjob for nginx/nginx-metrics.rb' do
          expect(chef_run).to create_cron('poll_nginx-metrics.rb').with(user: 'root', minute: '*', hour: '*', day: '*')
        end

      end
    end
  end
end
