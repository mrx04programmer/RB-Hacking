#!/usr/bin/env ruby
require 'coffee-script'
if ARGF
  file = File.open("#{ARGV[0]}.js", 'a')
  file.write CoffeeScript.compile(ARGF.read)
  puts "[+] Take a coffee with #{ARGV[0]}.js :)"
end
