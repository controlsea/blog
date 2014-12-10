
#------chap7-----------#


##包含其它文件用:require 'xxx文件名'

require "./chap7_a.rb"
require "./chap7_b.rb"


funcA(4)
funcB(5)

a = NameSpace_A::AClz.new
a.funcA(3)

b = NameSpace_B::BClz.new
b.funcB(4)

#NameSpace_A::func()

##自带HTTP库

require "net/http"

##获取网页的html代码
Net::HTTP.get_print("www.rubyinside.com","/")

##分析response
url = URI.parse("http://www.rubyinside.com/")

puts "=====response==="
puts url.inspect

##获取url下所有path的html代码
response = Net::HTTP.start(url.host,url.port) do |http|
  http.get(url.path)
end


content = response.body
puts content.inspect