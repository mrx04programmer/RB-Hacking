## Working in linux : !/usr/bin/env ruby

require 'socket'

def connect(host, port)
    c = TCPSocket.new(host, port)
    rhost = c.peeraddr.last
    c.gets.chomp
    c.puts "[+] Connect to #{host}" # <- message to send to host
end

parameter = ARGV[0]
host = ARGV[1]
port = ARGV[2].to_i

#puts "parameter:#{parameter}\nhost:#{host}\nport:#{port}"

if parameter == '-s'
  puts "[*] Server initializing in #{host} in the port #{port}"
  server = TCPServer.new(host, port)
  pt = server.accept
  device = pt.peeraddr.last
  # Content of the server:
  pt.puts "Hi Client #{device}"
  pt.gets.chomp
  #server.add[1]
  #pt.close
  #server.close
end

if parameter == '-c'
  if host != 0 and port != 0
    connect(host, port)
  else  
    puts "Usage as Client: rubbet -c <target> <port>"
    puts "Usage as Server: rubbet -s <localhost> <port>"
  end
end

if parameter == '-h' or parameter == 0
  puts "Usage as Client: rubbet -c <target> <port>"
  puts "Usage as Server: rubbet -s <localhost> <port>"
end
