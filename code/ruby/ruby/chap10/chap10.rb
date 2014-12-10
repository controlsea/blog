##chap 10

puts RUBY_PLATFORM ##universal.x86_64-darwin13

ENV.each{ |e| puts e.join(': ')}

puts "-================="
puts ARGV.join('-')