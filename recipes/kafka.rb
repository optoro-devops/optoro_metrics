#<
# Installs jmxtrans and configures it to emit metrics to graphite
#>

chef_gem 'json'
require 'json'

output_skel = { 'servers' => [{ 'alias' => node['fqdn'],
                                'host' => 'localhost',
                                'port' => '9999',
                                'queries' => []
                               }]
              }

output_writer = { '@class' => 'com.googlecode.jmxtrans.model.output.GraphiteWriter',
                  'settings' => {
                    'port' => 6008,
                    'host' => '127.0.0.1',
                    'rootPrefix' => node['fqdn']
                  }
               }

query_skel = { 'resultAlias' => '',
               'obj' =>  '',
               'attr' => [],
               'outputWriters' => [output_writer]
             }

mbeans = { 'kafka.server' => {},
           'kafka.network' => {},
           'kafka.controller' => {}
         }

obj_exceptions = { 'kafka.server:type=ReplicationFetcherManager,name=*' => 'kafka.server:type=ReplicaFetcherManager,name=*,clientId=Replica',
                   'kafka.network:type=RequestChannel,name=*' => 'kafka.network:type=RequestChannel,name=*,processor=*'
                 }

five_ten_fifteen = %w(Count FifteenMinuteRate FiveMinuteRate MeanRate OneMinuteRate)
percentile = %w(50thPercentile 75thPercentile 95thPercentile 98thPercentile 99thPercentile 999thPercentile)
max_min_stddev = %w(Max Mean Min StdDev)

# kafka.server types
%w(BrokerTopicMetrics DelayedFetchRequestMetrics DelayedProducerRequestMetrics KafkaRequestHandlerPool ReplicaManager).each do |key|
  mbeans['kafka.server'][key] = five_ten_fifteen
end

%w(FetchRequestPurgatory KafkaServer OffsetManager ProducerRequestPurgatory ReplicaFetcherManager).each do |key|
  mbeans['kafka.server'][key] = ['Value']
end

# kafka.network types
mbeans['kafka.network']['RequestChannel'] = ['Value']
mbeans['kafka.network']['SocketServer'] = five_ten_fifteen

# kafka.controller types
mbeans['kafka.controller']['ControllerStats'] = five_ten_fifteen + percentile + max_min_stddev
mbeans['kafka.controller']['KafkaController'] = ['Value']

mbeans.each do |mbean, types|
  types.each do |type, attr|
    query = query_skel.clone
    obj_to_query = "#{mbean}:type=#{type},name=*"
    if obj_exceptions.key?(obj_to_query)
      query['obj'] = obj_exceptions[obj_to_query]
      query['resultAlias'] = "#{mbean}.#{type}"
    else
      query['obj'] = obj_to_query
      query['resultAlias'] = "#{mbean}.#{type}"
    end
    query['attr'] = attr
    output_skel['servers'][0]['queries'].push(query)
  end
end

package 'jmxtrans'

service 'jmxtrans' do
  action [:enable, :start]
end

template '/var/lib/jmxtrans/kafka-metrics.json' do
  source 'kafka-metrics.json.erb'
  variables(:output => output_skel)
  notifies :restart, 'service[jmxtrans]', :immediately
end
