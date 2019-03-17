require "address_search"
require "json"

def print_usage
  "dump [input file] [output file]"
end

if ARGV[0].nil?
  puts "please specify input file"
  print_usage
  exit(1)
end

if ARGV[1].nil?
  puts "please specify output file"
  print_usage
  exit(1)
end
s = AddressSearch.new(ARGV[0])
File.open(ARGV[1], "w") do |f|
  f.write(JSON.generate(s.to_a))
end

