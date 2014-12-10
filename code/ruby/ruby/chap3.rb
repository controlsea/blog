#chap3 


# x <=> y 比较：x>y 则返回1 ， x<y则返回-1 ， x=y则返回0

#使用times:x.times ,x为执行次数

3.times do
  puts "test"
end

#将do 。。 end 替换为block

3.times {puts "test"}

#-----------------------------迭代器------------------------------------#

#上面可以看出times是一种循环的迭代，类似times这种迭代器，还有很多：

#例如upto：从1到5
1.upto(5) {puts "upto"}

#downto:从10递减到5
10.downto(5) {puts "downto"}

#从0开始，到50，每次步进5
0.step(50,5) do
  puts "step"
end

#如果要打印出循环的index，怎么办？

#使用block
1.upto(5) {|i| puts i}

#使用do 。。。 end
10.downto(5) do |i|
  puts i
end


#-----------------------------类型转换------------------------------------#

#整型 <=> float
a = 10;
print a.to_f #10.0

puts""

a = 3.3
print a.to_i

puts""

#-----------------------------常量------------------------------------#
#Pi属于常量，不要轻易修改

#-----------------------------字符串------------------------------------#
a = "hello"
puts(a.class)

x = "a"
y = "b"

if x+y == "ab"
  puts "success" ##success
end

##上面代码还可以这样:
puts "success" if x+y == "ab"

##换行输出:%q{"xxxxxx"}，其中{xxxxxx}还可以为<xxxxxx> !xxxxxx! (xxxxxx)
x = %q{ this is some
thing 
else,haha}

puts x

##使用标记来约定字符串的开始和结束：<<ID xxxxx ID
x = <<JAYSON_
this is some
thing
else,haha
JAYSON_

puts x

##字符串链接用+号

x = "b"+"a"
puts x

##字符串重复
x = "b"*5
puts x

##字符的ASCII码
puts ?A

#使用#{}
#如果字符串中有#{。。。}的内容，则这部分当做ruby代码执行后返回结果插入原位置。

x = "xxx #{puts x}"
puts x

x = 10
y = 20
puts "#{x} + #{y} = #{x+y}"

#替换:
x = "foobar"

#sub方法只将第一个bar变成boo
y = x.sub('bar','boo')
puts y


x = "foobarxoobar,ioo="

#gsub方法将所有bar都变成boo
y = x.gsub('bar','boo')
puts y  


#使用正则表达式进行替换:
#正则以/xxx/表示

#将前两个字符替换成Hello
y = x.sub(/^../,'Hello')
puts y

#将后两个字符替换为Hello
y = x.sub(/..$/,'Hello')
puts y

#遍历字符串的每个字符
x = "abc"
puts x[0]

#x.each{|i| puts i} #--wrong!
#需要使用scan
x.scan(/./){|i| puts i} #--Right!

#scan的参数为正则表达式
x = "this is something I will never do"
x.scan(/\w\w/){|i| puts i}

#\w的意思是匹配数字,字母下,划线，对每个字符进行匹配
# \w\w 是对两个字符进行匹配

x.scan(/\w+/){|i| puts i}

###.scan方法实际上返回的时数组
p = x.scan(/\w+/)
puts "-----"
puts p.class  #array
puts "-----"
puts p
puts "-----"
#\w+ ：+的意思是一直向后匹配，直到遇见非数字，字母，下划线

x = "I spent 100 dollars on this machine which is now 200 dollars"
x.scan(/\d+/){|i| puts i}
#匹配出数字

#匹配字符集[....]匹配[]中的字符集
x = "this is a test"
x.scan(/[aeiou]/) {|i| puts i}
x.scan(/[a-m]/){|i| puts i}



#字符串匹配：

#（1）根据正则匹配：
#检测字符串中是否包含某字符: 使用=~
#检测字符串中不包含某字符: 使用!~
puts "get string" if "jayson loves basketball" =~ /[basketball]/
puts "String contains no digits" unless "jayson loves basketball" =~ /[0-9]/


#（2）使用match方法
puts "String has matched" if "jayson loves basketball".match("loves")

#-----------------------------数组------------------------------------#

x = [1,"2",3.0]
puts x

#向末尾增加数据
x << "word"
puts x

#将最后一条数据弹出
puts x.pop

#如果一个数组全是字符串，可以使用.join方法，将数组中的元素连接起来
x = ["jj","ss","gg"]
puts x.join()
puts x.join(', ')

x = "asd asdf adff fdfdf"
p = x.scan(/\w+/)
puts p.join(', ')

#将字符串按照某种符号分割，例如按分号：
x = "short sentence; Another; no more"
q = x.split(';')
puts q.class ##array
puts q

##inspect使输出格式更易读，所有对象都有inspect方法
p = x.split(';').inspect 
puts p.class ##string
puts p  ##["short sentence", " Another", " no more"]

##遍历数组
q.each do |i|
  puts i.to_s
end

#使用block
q.each {|i| puts i.to_s + "x"}

#使用collect
[1,2,3,4].collect{|element| element*2}

#使用while
i = 0
while(i<q.length)
  puts i.to_s + "x"
  i += 1
end

#两个数组相加
p = [1,2,3]
q = ["1",2,"33"]  
z = p+q
print z

#两个数组相减
p = [1,2,3]
q = [4,5,6]
z = p-q
print z ##1,2,3

#数组个数
a = p.count
puts a


#是否包含某个元素
x = [1,2,3]
puts x.include?("x")
puts x.include?(3)

#第一个元素，和最后一个元素
puts x.first
puts x.last

#前n个元素
puts x.first(2)

#翻转
print x.reverse()


#-----------------------------map(dictionary)------------------------------------#

map = {'cat'=>"kitty", 'dog'=>"tom"}
puts map.inspect

#size
puts map.size

#get value
puts map['cat']

#set value
map['fish'] = "lisa"
puts map.inspect

#遍历，顺序随机
map.each{|k,v| puts "#{k} = #{v}"}

#得到所有的key
l = map.keys
puts l.class #array
puts l.inspect

#删除
map.delete("cat")
puts map.inspect

#根据条件删除
#map.delete_if{|k,v| v<25}
#puts map.inspect

#-----------------------------if------------------------------------#

a = 11

##正常顺序
if a>10
  puts "a>10"
#  exit ##退出ruby程序，后面不执行了
end

##单行判断
puts "a>10" if a>10

#if-elsif-else
if a<10
  puts "a<10"
elsif
  puts "a=10"
else
  puts "a>10"
end

#-----------------------------unless------------------------------------#

##unless : 与if相反

unless a>10 
  puts "a>10"
end


#-----------------------------?:------------------------------------#


##三元操作符，同c语言

type = a > 10 ? "1" : "2"
puts type


#-----------------------------case when------------------------------------#

##case-when


fruit = "orange"

case fruit
when "orange"
  color = "orange"
when "apple"
  color = "red"
when "banana"
  color = "yellow"
else
  color = "unknown"
end
puts color


#-----------------------------while------------------------------------#

x = 10

while(x>=1)
  x = x/2
  puts x
end

#单行
x=10
x = x/2 while x >= 1 
puts x

#-----------------------------until------------------------------------#

#与while相反

x = 10

until x <= 1
  x = x/2
  puts x
end

#单行
x = 10
x = x/2 until x<1 
puts x


#-----------------------------block------------------------------------#
x = [1,2,3]
x.each{|i| puts i}

##block是匿名函数，可以当参数传递,当参数时需要用&符号声明参数是block类型

def func1(&block)
  a = 10
  block.call(a)
end

func1 { |i| puts i}

##也可以使用lambda表达式
block_p = lambda {|x| puts x*2}
block_p.call(100)

#-----------------------------time------------------------------------#

#时间
puts Time.now
puts Time.now - 10 #减10秒
puts Time.now + 86400 #加一天


#-----------------------------symbol------------------------------------#

#symbol是无值常量，ruby特有


hello = :key
puts "equal" if hello == :key #equal
a = {:key => "hh"}
puts a[:key] ## hh



#('A'..'Z').each {|i| puts i}
