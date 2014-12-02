--learning lua--
--chap 8 : compilation,execution and errors--

--8.1 compilation：汇编--
--脚本语言的一个特征不是没有编译过程，而是编译器是runtime的一部分--

--一个很好的例子是dofile函数--
--dofile("./chap7.lua")

--dofile函数会打开一个.lua脚本，并执行，它内部是通过loadfile函数执行的：

function fake_dofile(filename)
	local f = assert(loadfile(filename))
	return f()
end

--loadfile的作用是将lua脚本进行编译，但并不执行脚本

--loadstring函数铜loadfile类似，只不过它的参数一段lua string：
--f = loadstring("i=i+1")
--不推荐使用loadstring
--loadstring返回的是一个function对象：loadstring("a=1")
--等价于 function(...) a=1 end

--处理异常：error，assert方法

--local t = "abc"
--assert(tonumber(t),"assert error:wrong type" )
--if not tonumber(t) then error("wrong type") end

--处理异常：lua中的try-catch：pcall方法

--foo is wrong
local foo
foo = function() local t="abc" print(s[1]) end

if pcall(foo) then
	print("foo is no error")
else
	print("foo is error",debug.traceback())
end

local err = pcall(foo)
print(err)

function foo(str)
	if type(str) ~= "string" then
		error("string expected",2)
	else
		print(str)
	end
end


	