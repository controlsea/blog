#reserved words
#循环:
# do, until , while, yield, next, for, in

#control flow:
#if-else-elsif, unless, case, when, then

#blocks & exception handling:
#return, begin, rescue, redo ,break, ensure, retry

#class & modules:
#module, class, def, undef, defined? alias, super

#conditional:
#and,or,not

#truthy:
#true, false, nil

#scope:
#self

#files:
#BEGIN,  END,  __LINE__


##LESSON 1
a = 1
puts a 

b = "Hello world"
puts b

##变量类型：一共有四种
#local obj, instance obj, global obj, constants

#global:$开头
$g_v = false

#constants:大写开头
CONST_V = "abc"

#local :作用域限制
def func
  number = 1
end

#instance:类中以@开头
class Clz
  attr_accessor :instance_v
  
  def initialize
    @instance_v = "hehe"
  end
end



##控制流：
#if - elsif - else

if a == 1
  puts "a = 1"
elsif a == 2
  puts "a = 2"
else
  puts "a = unknown"    
end

#case-when
a = 2
case a
when 1
  puts "a = 1"
when 2
  puts "a = 2"
else
  puts "a = unknown"    
end


##objec & classes:

c = Clz.new
puts c.instance_v


##strings:
a = "Hello"
puts "jayson says #{a}" #
puts 'jayson says #{b}'#jayson says #{b}

##使用%{}
name = %{Jason} ##会被#{}解析
name = %q{Json} ##不会被#{}解析

##使用%|| 
name = %|Json|

##特殊符号：\n, \t：tab , \b : 删除 , \v 换行+tab

##字符串中的引号
puts "Hello \" world \" " ##双引号可被#{}解析
puts 'Hello "world"'

##字符串中的\
puts "Hello \\ world"

##链接字符串:

#使用+号
a = "first"+ " "+"last"
puts a

#使用*号
b = a*3 
puts b 

#使用<<
c = "a"<<" "<<"b"
puts c

##inspect
string = "  Hello world"
d = string.inspect
puts d

#chop
e = string.chop
puts e

#include
b = string.include?("Hello")
puts b

#replace:将字符串替换为
c = string.replace("jason")
puts c

#index
string.index("a") ##1

#reverse
string = string.reverse()
puts string

#uper case
string = string.upcase()
puts string

#lower case
string = string.downcase()
puts string

#swap
string = string.swapcase()
puts string

#length
l = string.length
puts l

#size == length
s = string.size
puts s

#split
string = "hello world"
list = string.split(" ")
puts list.inspect

#concat
string.concat("another string")
puts string

##numbers : 

#create number
num = 100
puts num.class

num = 100.5
puts num.class

str = "100"
num = str.to_i ##100
puts num

num = str.to_f ##100.0
puts num

num = 5e10
puts num

#size : number of bytes in computer，浮点数不能用size
num = 100
puts num.size #8字节

#operators:addition, substraction, multiply, divide
num = num + 10 ; puts num
num = num - 10 ; puts num
num = num * 10 ; puts num
num = num / 10 ; puts num
num = num ** 10 ; puts num
num = num += 100; puts num
num = num -= 100; puts num
num = num % 10 ; puts num

#compare
a,b = 10,20
c = 0
if a==b
  c = 1

elsif a != b
  c = -1 
end

#<=>符号：a<b 为 1， a>b 为 -1， a=b 为 0
c = a<=> b
puts c

#eql? 检测类型和值
c = 10
r = a.eql?(c)
puts r #true
d = 10.0
r = a.eql?(d)
puts r #false

#math : 两个常量E,PI，math库是自动加载的
puts Math::E
puts Math::PI
puts Math::log(10)
puts Math::log(10,2) 

#随机数:
r = rand
puts r

r = rand(100) #0-100内的随机数
puts r  

#format:格式化字符串
str = sprintf("%.1f",r)
puts str.inspect

d = 7.3-7.2
puts d #0.09999999999999964

require "bigdecimal"

a = BigDecimal.new("7.3")
b = BigDecimal.new("7.2")
puts a-b #0.1E0

#currency
#gem install money
##require "money"

##Array:

#create:
list = Array.new()
puts list.inspect

#push
list.push(1)
list << 2
list <<"hello world"
puts list.inspect

#pop
list.pop
puts list.inspect

#lenght
l = list.length

#push array
list += [4,2]
puts list.inspect

#index
index = list.index(2)
puts index ##return index

#access
list1 = [1,2,3]

ele = list1.at(0) ; puts ele
ele = list1[-1];puts ele

first = list1.first
last = list1.last


list2 = [4,5,6]

#join
list3 = list1 & list2
list3 = list1 & [2,3,4] ; puts list3.inspect

#slice:取数组的某些值，组成一个新数组, 参数为index值，不修改原array
list1 = [1,2,3]
ele = list1.slice(1); puts ele.inspect #[2]
slice = list1.slice(1,2) ; puts slice.inspect #[2,3]

#slice!:取数组的某些值，组成一个新数组, 参数为index值，修改原array
slice = list1.slice!(1,2) ; puts list1.inspect #[1]

#unshift : put the item at the beginning of the array
list1 = list1.unshift(2)
puts list1.inspect


#rindex:return the position of item
list1 << "a"
index = list1.rindex("a")
puts index

#clear:清空array
list1.clear()
puts list1.inspect

#多为数组
array = [1,2,3]
array = array.push([2,3,4])
puts array.inspect #[1, 2, 3, [2, 3, 4]]

#展成1维数组
array = array.flatten
puts array.inspect()

#soring & comparing
array = [5,1,3,5,4,9]
array1 = array.sort ; puts array1.inspect()
array1 = array.sort{|a,b| a<=>b} ; puts array1.inspect()
array1 = array.sort{|b,a| a<=>b}.reverse ; puts array1.inspect()
array1 = array.sort{|b,a| a<=>b}.reverse.uniq ; puts array1.inspect() ##uniq去重

#itor
array1.each do |e| puts e.inspect end
array1.each{|e| puts e.inspect} 

#any? all?
ret = array.any?{|e| e>3} ; puts ret.inspect()
ret = array.all?{|e| e>3} ; puts ret.inspect()

#select:选出符合条件的元素
newArray = array.select{ |e| e>3}; puts newArray.inspect()

#reject:去除符合条件的元素
newArray = array.reject{ |e| e>3}; puts newArray.inspect()

#map：
newArray = array.map{|e| e*2 }; puts newArray.inspect()

###Hashes:

#create:
h = Hash.new() ; puts h.inspect()
h = {"hello" => "world"}
h = Hash.new{|hash,key| hash[key] = "Default value for #{key}"}
puts h['jayson'].inspect()
puts h[0].inspect()


#add another
h["name"] = "jayson" ; puts h.inspect()

#print keys
puts h.keys

#get key of value
puts h.key("jayson")

#check keys exist?
puts h.has_key?("candy")

#print values
puts h.values

#check value exist?
puts h.has_value?("jayson")

#values_at : returns a array corresponing to the values
puts h.values_at("jayson",0) 

#empty?
puts h.empty?

#delete
h.delete(0)
h.delete_if {|key,value| key =="some key"}

#clear
h.clear;puts h.empty?

#to array
h = {"501" => "cctv1", "502" => "cctv2", "503" => "cctv3"}
puts h.to_a.inspect

#itor
h.each do |k,v|
  puts k,v
end
h.each {|k,v| puts k,v}
h.each_pair {|k,v| puts "the key at #{k} is #{v}"}
h.each_key{|k| puts "the key is #{k}"}
h.each_value{|v| puts "the value is #{v}"}
h.select{|k,v| k == "501"};puts h.inspect
h.keep_if{|k,v| k == "502"}; puts h.inspect

#find
h = {"501" => "cctv1", "502" => "cctv2", "503" => "cctv3"}
puts h.find{|k,v| k == "503"}.inspect;  ##["503","cctv3"]返回数组
puts h.find_all{|k,v| v.match("cc")}.inspect 
puts h.all?{|k,v| v.match("cctv1")}
puts h.any?{|k,v| v.match("cctv1")}

#map
puts h.map{|k,v| v += "ss"}.inspect #将value的值映射为#["cctv1ss","cctv2ss","cctv3ss"]

#reject
h.reject{|k,v| k == "cctv1"}.inspect


puts "=======================METHOD========================"
##methods
def hello(name = "your name")
  puts "Hello #{name}"
end
hello

#class methods
class BankAccount

  attr_reader :first_name
  attr_reader :last_name
  attr_reader :balance
  ##下面代码段为类方法
  class << self
    
    def create_for(first_name, last_name)
      @accounts ||= [] ##如果@account为空，则创建
      @accounts << BankAccount.new(first_name, last_name)
    end
  
  end
  
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end
  
  

  def reset!
    @balance = 0
  end
  
private :reset!
    
end

puts "=======================LOOPS========================"
#loops
array = [1,2,3,4]
for i in array do
  puts "i is #{i}"
end

strlist1 = ["a","b","c"]
puts strlist1.inspect

strlist2 = %w{dog monkey pigg cock} ##将元素转换为字符串数组
puts strlist2.inspect

for animal in strlist2 do
  next if animal == "monkey" ##continue
  puts "#{animal}"
end

#retry && redo

puts "=======================BLOCKS========================"
##blocks
def say_hello(&block)
  puts "Hello world"
  if block_given?
    block.call
  else
    puts "no block given"
  end
end

say_hello {puts "call from block"}
say_hello do
  puts "call from block"
end

#block的返回值
def say_name(&block)
  name = block.call
  puts name
end

say_name{"Jayson"}

#ensure : 类似finally，保证会执行
#rescue : 

def header(&block)
  puts "this is our header"
  block.call
  puts "this is our footer"
  
rescue
  puts "this is where rescue an error"  
ensure
  puts "this one is ensure to be called"
end

header {puts "this block will crash"; raise "this is an error"}

puts "=======================BEGIN&END========================"
#BEGIN{} #END{}用来初始化和析构

BEGIN{puts "THIS IS THE BEGIN BLOCK"}
END{puts "THIS IS THE END BLOCK"}

#yield:
def test_yield(&block)
  for i in 1..5 do
    yield i ##will call block, pass i‘s copy to the block
  end
end

test_yield {|i| puts "#{i*2}"} #2,4,6,8,10

class SimpleBenchmarker
  
  def self.go(times, &block)
    
    puts "----------Benchmarking started------------"
    start_time = Time.now
    puts "start time : #{start_time}\n\n"
    times.times do |t|
      print "."
      block.call
    end
    print "\n\n"
    end_time = Time.now
    puts "End Time:\t #{end_time}\n"
    puts "----------Benchmarking finished-----------"
    puts "Result :\t\t #{end_time - start_time} seconds"
    
  end
end
# SimpleBenchmarker.go 5  do
#   time = rand(0.1..1.0)
#   sleep time
# end


puts "=======================PROC AND LAMBDA========================"
#proc : 用来创建匿名函数 - block

proc_b = Proc.new {puts "hello b"}
proc_a = proc {puts "hello a"}
proc_b.call
proc_a.call

#lambda : 一种proc
my_lambda_1 = lambda {}
my_lambda_2 = -> lambda {}

##proc和lambda的区别是，lambda必须要传入参数
my_proc = proc {|name| puts "hello #{name}"}
my_proc.call ("jayson")

my_lambda = lambda {|name| puts "hello #{name}"}
my_lambda.call ("candy")

def return_from_proc

  p = proc {return "return from proc"}
  p.call
  return "return from function"
  
end

def return_from_lambda

  l = lambda {return "return from lambda"}
  l.call
  return "return from function"
end

puts return_from_proc()
puts return_from_lambda()

puts "=======================SYMBOL========================"
#symbol:在内存中只创建一次
treehouse = {'name'=>'Treehouse','location' => 'Treehourse Island'}
#如果再创建一个treehouse，那么所有的key都要重新创建一遍

#如果使用symbol，key不会重新创建
treehouse = {:name => 'Treehouse', :location => 'Treehouse Island'}

puts "=======================DATE========================"
#date
require 'date'
require 'time'

#格式化时间：
date = Date.new(2014,4,1)
puts date.to_s
puts date.strftime("%m/%d/%Y")
puts date.strftime("%b/%d/%Y")
puts date.mday
puts date.day
puts date.year
#date 可以解析
date2 = Date.parse("2014/4/3")
puts date2-date #2/1
puts (date2-date).to_i

#time
time = Time.new
puts time
puts "=======================ENUMERABLE========================"
#enumerable
class BankAccount
  
  attr_reader :transactions
  
  include Enumerable ##this is important：包含这个module，会让这个类具有.each{}的能力，需要实现each方法
  include Comparable ##包含这个module，会让这个类有>,<,=的比较能力
  
  def <=> (other_account)
    self.balance <=> other_account.balance
  end
  
  def initialize(name)
    @name = name
    @balance = 0
    @transactions = []
  end
  
  def deposit(amount)
    @transactions << amount
  end
  
  def withdraw(amount)
    @transactions << -amount
  end
  
  def balance
    @transactions.inject(0) {|sum,itor| sum += itor}
  end
  
  ##must implement this method
  def each(&block)
    @transactions.each{ |transaction|  block.call(transaction)}
  end
  #等价于:
  def each
    @transactions.each {|transaction| yield transaction}
  end
  
  def to_s
    return "<class:#{self.class} name:#{@name}>"
  end

end

account1 = BankAccount.new("jayson")
puts account1
account1.deposit(100)
account1.withdraw(50)
account1.each {|transaction| puts transaction} ##这个会调用account1的each方法，each方法中将transaction通过yield方法传给block

account2 = BankAccount.new("candy")
account2.deposit(200)

accounts = []
accounts.push(account1)
accounts.push(account2)

puts accounts.sort

puts "=======================COMPARABLE========================"
#comparable
puts account1 > account2 #false

account3 = BankAccount.new("nick")
account3.deposit(100)

puts account3.between?(account1,account2) #true


Struct.new("TreeHouse", :name, :location)
treehouse = Struct::TreeHouse.new
treehouse.name = "treehouse"
treehouse.location = "newYork"
puts treehouse.inspect

Island = Struct.new(:name,:location)
island = Island.new("island","LA")
puts island.inspect

Lok = Struct.new(:name){
  
  ##define functions
   
  def to_s
    "<name:#{name}>"
  end
  
  def lock
    puts "#{name} is locked"
  end
}

lok = Lok.new("jayson")
lok.lock
puts lok.inspect

puts "=======================YAML========================"
#YAML : 
#YAML stands for "Yet Another Markup Language." 
#YAML is a plain text and human readable format that is frequently used for configuration files. 
#The YAML video teaches you how to use YAML in your Ruby programs.

require 'yaml'
array = %w(dog cat frog)
puts array.to_yaml
hash = {:name => "jayson", :location =>"TB"}
puts hash[:name]
puts hash.to_yaml

#yaml用于写配置文件
File.open('./config.yml','w+') {|f|
  
  f.puts hash.to_yaml
  
}

config = YAML.load(File.read('./config.yml'))
puts config.inspect

class Frog
  attr_accessor :name
end

frog = Frog.new
frog.name = "jayson"
yaml = frog.to_yaml
puts yaml.inspect

same_frog = YAML::load(yaml)
puts same_frog.inspect


puts "=======================ERB========================"
#ERB:
#easy to use but powerful templating system for ruby.
#Using ERB,actual ruby code can be added to any plain text document for the purpose of generating docment
#infomation details and/or flow control

require 'erb'

hash = {:name => "jayson", :location =>"TB"}

#以TEMPLATE开始到TEMPLATE结束之间的这段字符串会被复制到template这个变量中
#ruby代码需要包含在<%= ... %>中执行
template = <<-TEMPLATE

From the desk of <%= hash[:name] %>
-----------------------------------
Welcome to <%= treehouse[:location] %>.

we hope you enjoy stay.
-----------------------------------

<% hash.keys.each{|k| %>
  key:<%= k %>
<% } %>

TEMPLATE

erb = ERB.new(template)
puts erb.result


#FileUtils
puts "=======================FILEUTILS========================"
require 'fileutils'
here = File.dirname(__FILE__) #__FILE__:built-in ruby value : 表示当前文件所在目录
puts here
puts File.expand_path(here)

puts Dir.entries(here) #列出here目录下所有文件和文件夹

##fileutil创建目录
FileUtils.mkdir_p(here+'/stuff')
puts Dir.entries(here)

##创建文件
FileUtils.touch('file1')
puts Dir.entries(here)


##logger
puts "=======================LOGGER========================"
require 'logger'

class NewBankAccount
  attr_reader :file_logger, :stdout_logger
  
  def initialize(name)
    @name = name
    @transactions = []
    @stdout_logger = Logger.new(STDOUT)
    @file_logger = Logger.new("./bank_account.log")
  end
  
  def deposit(amount)
    log "deposit : #{amount}"
    @transactions << amount
  end
  
  def withdraw(amount)
    log "withdraw : #{amount}"
    @transactions << (-amount)
  end
  
  def log(message,level = Logger::INFO)
    file_logger.add level,message,"#{self.class}(#{@name})"
    stdout_logger.add level,message,"#{self.class}(#{@name})"
  end
  
end

account = NewBankAccount.new("jayson")
account.deposit(100)
account.withdraw(50)

#uri
puts "=======================URI========================"
require 'uri'
require 'open-uri'

url = URI.parse("http://objayc.com/blog")
puts url.hostname
puts url.path

puts URI.split('http://objayc.com/blog').inspect
google = open('http://www.objayc.com/blog').read
puts google

#bench mark
puts "=======================BENCHMARK========================"
require 'benchmark'

repetitions = 100000

Benchmark.bm(7){|x|
  
  x.report 'String' do
    repetitions.times{
      options = {'hello' => 'world'}
    }
  end
    
  x.report 'Symbol' do
    repetitions.times{
      options = {:hello => :world}
    }
  end
}


#option parser

#observable
puts "=======================OBSERVER========================"
require 'observer'

class BankAccount
  
  include Observable
  
  def initialize(name)
    @name = name
    @transactions = []

  end
  
  def deposit(amount)
    changed
    notify_observers(Time.now, 'deposit', amount)
    @transactions << amount
  end
  
  def withdraw(amount)
    
    changed
    notify_observers(Time.now, 'withdraw', amount)
    @transactions << (-amount)
  end
  
end

class BankAccountObserver
  
  def initialize(account)
    @account = account
    @account.add_observer(self)
  end
  
  def update(time,kind,amount)
    puts "[#{time} #{kind} ：#{amount}]"
  end
  
end

account = BankAccount.new("jason")
BankAccountObserver.new(account)

account.deposit(100)
account.withdraw(80)

puts "=======================MINI TESTING========================"
