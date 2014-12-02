--Learing lua --
--chap 5--
--Functions--
--如果只有一个参数，如果参数类型为string或者table，那么函数不用加()--
print("hello")
--等价于--
print"hello"
--最好还是都加括号，阅读方便——

x = {10,20,30,a="100", b=99}

--定义一个函数——

function add(a)

local sum = 0

for i,v in ipairs(a) do

print(i,v)
sum = sum + v;
	
end
	return sum;
end

r = add(x)

print(r)

function f(a,b)

return a and b 
	
end

r = f(10,20)

print(r)

--函数有多个返回值——

function foo() end
function foo1() return "a" end
function foo2() return "a","b" end

x,y = foo2() --> a, b
x = foo2()   --> a
x,y,z = 10,foo2() -->10,a,b

x,y = foo() -->nil.nil
x,y = foo1() -->a,nil

--系统函数--找到字符串的起始位置
s,e = string.find("hello lua users","lua")
print(s,e) -->7,9

t = {foo()}
print(t[1]) -- >nil

t = {foo2()}
print(t[1],t[2]) --> a,b

t = {foo(),foo2(),4} -->nil,a,4

--可变参数--
function add2(...)

local s = 0

for i,v in ipairs{...}do
s = s+v
end

return s 
	
end

--print(add2(3,1,10,"a",12)) --> crash!
print(add2(3,10,11,12))

local a,b = ...
print(a,b) -->nil,nil

function foo4(...)
return ...
end

print(foo4("a","b",10)) --> a, b, 10

--格式化字符串--
s = string.format("%d",10);
print(s)

function fooStr(fmt,...)

return string.format(fmt,...)
	
end

print(fooStr("%d,%s",10,'a'))

--用select('#',...)打印出可变参数的个数，包括nil--
print(select('#',"a",10,11,"ss",nil))

--用select(n,...)返回可变参数中的第n个参数--
function test1(...)
	
	for i=1,select('#', ...) do

		local var = select(i, ...)
		print(var)	
	end

end

test1("----test1:----",1,",","n","ll",111,"--------")

---lua 5.0之后，对可变参数提供了一个隐式参数：arg---

function test2(...)
local k = {...}
k.n = select("#",...)

n = k.n 

for i=1,n do
	local var = select(i, ...)
	print(var)	
end

end

test2("----test2----",1,",","n","ll",111,"--------")

--前面提到，如果函数只有一个参数，我们可以直接传一个table--
--这样做的好处是，参数可以顺序可以不同，接受参数的function，可以根据key-value
--找到值，如下：--

function someFunc(arg)
	
	print(arg.old,arg.new)
	
end

someFunc{new=101,old="100",mid=88,err= -1} -->100,101