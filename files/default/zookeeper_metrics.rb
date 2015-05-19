#!/usr/bin/ruby
require 'socket'

s = TCPSocket.open('127.0.0.1', 2181)

s.puts('mntr')
while line = s.gets # rubocop:disable Lint/AssignmentInCondition
  unless line =~ /^zk_version/
    metrics = line.split(' ')
    puts "#{Socket.gethostname}.zookeeper.#{metrics[0]} #{metrics[1]} #{Time.new.to_i}"
  end
end
s.close
