##chap9 _ csv _part

##创建一个CSV文件

f = File.open("simpeCSV.txt","w")
f.puts "Fred Bloggs,Manager,Male,45\nLaral Smith,Cook,Female,23\nDebbie Watts,Professor,Female,38"
f.close

require 'csv'
c = CSV.open('simpeCSV.txt','r').each{ |p| puts p.inspect } ##打印每条信息
puts c.class ##nilClass

