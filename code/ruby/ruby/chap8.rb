##--异常--##


##begin-rescue

begin 
  puts 10/0
rescue
  puts "crash"
end

##catch-thow
catch(:finish) do
  1000.times do
    x = rand(1000)
    throw  :finish if x == 123
  end
  
  puts "the random number is 123"
end

##debug
# ruby -r debug chap8.rb
i = 1
j = 0
until i > 1000000
  i *= 2
  j += 1
end

puts "i = #{i}, j= #{j}"
  
  
##单元测试

require 'test/unit'

class TestClz < Test::Unit::TestCase
  
  #test method

end