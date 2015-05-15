describe 'optoro_metrics::mongodb' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_metrics'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        %w(mongodb-metrics.rb).each do |script|
          it "Installs cronjob for mongodb/#{script}" do
            expect(chef_run).to create_cron("poll_#{script}").with(user: 'root', minute: '*', hour: '*', day: '*')
          end
        end
      end
    end
  end
end
