## Working in linux : !/usr/bin/env ruby

def validate_ssl(target)

    require 'socket'
    require 'openssl'
    ssl_context = OpenSSL::SSL::SSLContext.new
    ssl_context.verify_mode = OpenSSL::SSL::VERIFY_PEER
    store  = OpenSSL::X509::Store.new
    store.set_default_paths
    ssl_context.cert_store = store
    socket = TCPSocket.new(target, 443)
    ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)

    begin
      ssl_socket.connect
      puts "[+] #{target} -> Valid SSL "
    rescue OpenSSL::SSL::SSLError
      puts "[+] #{target} -> Invalid SSL "
    end

end

target = ARGV[0]

if target == 0
  puts 'Usage: ruby ssl_validator.rb <target>'
else
  validate_ssl(target)
end
