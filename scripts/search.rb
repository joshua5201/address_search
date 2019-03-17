require "address_search"

filename = ARGV[0]
format = ARGV[1]
keywords = ARGV[2..ARGV.length]

s = AddressSearch.new(filename, format.to_sym)
keywords.each do |keyword|
  results = s.perform(keyword).first(5)
  if results.empty?
    puts "no results for #{keyword}"
    next
  end
  puts "first #{results.size} results for #{keyword}"
  s.perform(keyword).first(5).each do |row|
    puts row.to_s
  end
end
