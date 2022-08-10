require 'socket'



def scanner(rhost, rport)
  begin
    socket = TCPSocket.new(rhost, rport)
    status = "open"
  rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
    status = "closed"
  end
  
  puts "#{rhost} -> #{rport} is #{status}"
end


if ARGV[0] != 0 and ARGV[1] != 0
  rhost = ARGV[0]
  rport = ARGV[1]
  scanner(rhost, rport)
else
  puts "Usage: ruby PortSpecific.rb <target> <port>"
end

