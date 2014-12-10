## chap9 文件与数据库 ##

##输入与输出

#a = gets ##接收用户输入，这种情况极少出现
#puts a

##-----读文件---------


##如果用new打开文件，需要调用close
a = File.new("./input.json","r")
puts a.class ## File

##默认以换行符进行分割
a.each{|line| puts line}
a.close

puts "===================="

a = File.new("./input.json","r")
##如果用其他符号分割:
a.each(':'){|line| puts line}
a.close


puts "==================="

a = File.new("./input.json","r")
##逐个字节读取I/O流
a.each_byte{|byte| puts byte}
a.close

##也可以用read方法

puts "==================="
a = File.new("./input.json","r")
puts a.readlines.join("--")
a.close


puts "==================="

##更简单的读文件的方法,a为字符串
a = File.read("./input.json")
puts a.class ##string, not File
puts a

puts "==================="
##文件指针

f = File.open("./input.json")
f.pos = 8 ##从第8个字节后开始读取
puts f.gets
puts f.pos

##-----写文件---------

##创建文件，“w”为只写，创建新文件
File.open("text.txt","w") do |f|
  f.puts "This is a test\nthis is another test"
end

##创建文件，可以持续写入"a",用来输出日志
f = File.open("logFile.txt","a")
f.puts Time.now
f.close

puts "==================="
##创建文件，可读写"r+"
f = File.open("text.txt","r+")
f.write "12345"
f.close

f = File.open("text.txt","r")
puts f.gets ##输出一行
f.close

##-----改名，删除文件---------

#改名：
File.rename("text.txt","test.txt")
 

#删除
File.open("file1.txt","w+")
File.delete("file1.txt")

##-----检查两个文件是否相同---------

b = File.identical?("file1.txt","file2.txt")

##-----检查文件是否存在---------
b = File.exist?("file1.txt")

##-----检查文件是否到末尾---------

puts "==================="
f = File.open("test.txt","r")
f.each{ |line| puts line}
puts "end of file" if f.eof?
f.close

##-----文件夹操作---------

##查看当前路径？
puts Dir.pwd

##改变当前目录
Dir.chdir("/Users/moxinxt/codingForFun/ruby/")
Dir.chdir("/Users/moxinxt/codingForFun/ruby/chap9")

##列出当前路径下的文件
puts Dir.entries("/Users/moxinxt/codingForFun/ruby/chap9").join("\n")

#创建，删除文件夹
if Dir.exist?("mvc")
  Dir.delete("mvc")
end
Dir.mkdir("mvc")

##创建临时文件
require 'tmpdir'
tempfilename = File.join(Dir.tmpdir,"myapp.dat")
tempfile = File.open(tempfilename,"w")
tempfile.puts "This is only a test"
tempfile.close
File.delete(tempfilename)
