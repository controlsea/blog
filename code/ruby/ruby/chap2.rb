##chap2

##kernel:ruby的kernel是一个公共库，里面定义了一些全局API

##puts
puts "hello world"

##等同于
Kernel.puts "Hello world"


##Object：所有全局函数都是Object对象的成员函数


##全局函数：
def func(a)
  puts a
end

##调用全局函数
func(10)


##等同于
Object.func(10)




