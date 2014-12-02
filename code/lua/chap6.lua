--learning lua--
--chap6--
--More About Functions--


--lua是函数型语言的一种，因此，它也支持将函数当做变量--
--函数名称只是变量的名称--

a = {p=print}

func = a["p"];
func("hello world")-->hello world
--等同于--
a.p("hello world")
--等同于--
a["p"]("hello world")
--等同于--
a["p"]"hello world" -->

--传统定义函数的方式--

function foo(x)

return 2*x
	
end

--这种方式其实是一种syntactic sugar，实际上可以将foo当做变量，这么写--

foo = function(x) return 2*x end

print(foo(2)) -->4

--所以函数定义其实是一种对变量的赋值--
--这种函数也叫匿名函数，绝大多数情况，我们定义的函数都是全局的，类似第一种方式，
--但是某些场合，使用匿名函数更方便，比如可以将匿名函数作为参数传给另一个函数：--

network = {
	{name="jason",ip = "192.168.1.11"},
	{name="kate",ip = "192.168.1.12"},
	{name="candy",ip = "192.168.1.13"},
	{name="carl",ip = "192.168.1.14"},
}
table.sort(network,function(a,b) return(a.name > b.name) end)
print(network[1].name,network[1].ip) -->kate,192.168.1.12

--Higher Order Function:高阶函数,是函数型语言中常见的表达，意思是，函数同变量一样可以作为入参或者返回值--

--Closure--
--lexical scoping : 当函数以变量形式匿名使用时，函数的body内可以访问该函数所在stack中的任何变量。
--first-class function : 函数同变量一样可以作为入参或者返回值
--具备这两点的编程语言并不多，这两点的特性组成Closure

--重新定义函数--

do

local oldOpen = io.open
local accessOkFunc = function(fileName,mode) 
if type(fileName) ~= string then return false 
elseif  fileName ~= "lua.config" then return false
else  return true 
end -- end of if

end --end of function

--重新定义file.open方法
io.open = function(fileName,mode)

if accessOKFunc(fileName,mode) then oldOpen(fileName,mode)
else return nil,"access denied" 

end -- end of if

end -- end of funciton
	
end -- end of do

-- Non-Global Functions --

local t = {foo = function(x,y) return x+y end , goo = function(x,y) return x -y end };
print(t.foo(10,20));

--t.foo，t.goo都属于Non-Global Function，当t销毁掉，foo，goo也就不存在了--

-- 如果显式定义非global的function,通常用local关键字--

local f = function()
--这里不能有递归运算
end

--因此，好的做法是--
local f 
f = function()
end

--tail call--
--tail call指的是函数A的body中只有一行命令：return了另一个函数B--
--taill call实际上是一条goto语句，而goto语句在汇编上就是bl跳转
function f()
return h() --tail call
end

--taill call的好处是不需要在stack上分配额外的空间--
--原因很好理解，当执行return h()时，相同于goto到h()的stack中，f()没有任何stack上的开销

--tail call用来实现state machine是最合适的，由于不产生额外的stack开销，一个函数调用N多次也不会overflow stack