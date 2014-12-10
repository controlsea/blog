#---------chap6------------#


#---------成员变量------------#
class Square
  
  ##默认构造
  def initialize(side_length)
    
    ##定义成员变量用@
    @side_length = side_length
  
  end
  
  def area
    priFunc() ##调用private方法
    self.pubFunc() ##调用public方法
    @side_length * @side_length
  end
  
private
  def priFunc()
    puts "private func called"
  end

public
  def pubFunc()
    puts "public func called"
  end

end

a = Square.new(10)
puts a.area

#---------全局变量------------#

#定义全局变量：在变量前加上$符号
def basic_method
  puts $x
end

$x = 10
basic_method()


#---------类变量&&类方法------------#

#定义类变量用@@

class Test < Object ##继承：默认都是从object继承

  ##定义类成员的getter方法
  def self.clz_counter
    @@clz_counter ##计数器
  end
  
  def initialize
    
    ##类成员
    if defined? (@@clz_counter)
      @@clz_counter += 1
    else
      @@clz_counter = 1
    end
  end
  
  ##类方法
  def self.test_method1
    puts "test self_method1"
  end
  
  def Test.test_method2
    puts "test self_method2"
  end

end

a = Test.new()
puts Test.clz_counter

b = Test.new()
puts Test.clz_counter


Test.test_method1
Test.test_method2


#---------override------------#

#Ruby的override很特殊：

class ParentClz
  
  #父类的pFunc方法返回a
  def pFunc (a)
     a
  end
  
end

class ChildClz <ParentClz
  
  ##重写p方法，返回ax
  def pFunc (a)
     a.to_s + "x"
  end
  
end


##给原来的类增加方法，或者修改原来的方法
class ChildClz
  
  def pFunc(a)
    a.to_s+"x"+"x"
  end
  
  def qFunc
    puts "this method is added"
  end
  
end

a = ChildClz.new
puts a.pFunc(10)
puts a.qFunc

##打印ChildClz所有的方法
puts a.methods.join(' ')


#---------attr------------#

class AttrClz
  
  ##自动支持.预发的getter和setter
  attr_accessor :name, :age
  
  ##私有方法
  private
  def private_method
  end
  
  ##共有方法
  public
  def public_method
  end
  
  def age
    @age
  end
  
  ##protect方法
  protected :age
  
end


a = AttrClz.new
a.name = "kate"
a.age = 16

##打印成员变量
puts a.instance_variables.inspect


#---------内部类------------#


class InsideClz
  
  def InsideClz.giveMeDrawingClz
    Drawing.new
  end
  
  ##内部类
  class Drawing
    def print
      puts "this is a print method inside Drawing"
    end
  end
  
end

a = InsideClz.new
InsideClz.giveMeDrawingClz.print

##返回Drawing 对象
a = InsideClz::Drawing.new
a.print


#---------命名空间------------#


##控制方法

module NameSpace1

  def NameSpace1.random
    rand(100)
  end

end

module NameSpace2
  
  def NameSpace2.random
    rand (10)
  end
end

puts NameSpace1.random
puts NameSpace2.random


##控制类

module ToolBox
  
  class Ruler
    attr_accessor :length
  end
end

module Country
    
  class Ruler
    attr_accessor :name
  end
end

a = ToolBox::Ruler.new
a.length = 50

b = Country::Ruler.new
b.name = "kate"

puts a,b

#----------include------------#

#在某个作用域中引入其它namespace中的方法或者类

module UsefulFeatures
  
  def class_name
    
    self.class.to_s
    
  end
  
end


class SomeClass
  
  ##包含了其它类
  include UsefulFeatures
  
end

x = SomeClass.new
puts x.class_name


##系统对array默认include的两个类：
##Enumerable

##each方法
[1,2,3].each{|i| puts i}

##除了each方法外，还提供了20多个有用的放法:
##collect,detect,find,find_all,include?,max,min,select,sort,to_a
list = %w{this is the longest word check}
puts list.inspect

##collect
[1,2,3].collect{|i| puts i.to_s+"x"}

##detect
a = [1,2,3].detect{|i| i.between?(2,3)}
puts a #2

##select
a = [1,2,3,4,5].select{|i| i.between?(2,3)}
puts a

##sort
[4,3,2,1].sort #[1,2,3,4]

#min/max
[1,2,3].max 
[1,2,3].min





