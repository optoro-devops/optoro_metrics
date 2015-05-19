#!/usr/bin/ruby
require 'socket'

parse = false
connections = 0

File.open('/etc/openvpn/openvpn-status.log').each do |line|
  parse = false if line =~ /^ROUTING\ TABLE/

  if parse
    metrics = line.split(',')
    schema = "#{Socket.gethostname}.openvpn.#{metrics[0]}"
    puts "#{schema}.bytes_recv #{metrics[2]} #{Time.new.to_i}\n#{schema}.bytes_sent #{metrics[3]} #{Time.new.to_i}"
    connections += 1
  end

  parse = true if line =~ /^Common\ Name/
end
puts "#{Socket.gethostname}.openvpn.connections #{connections} #{Time.new.to_i}"
