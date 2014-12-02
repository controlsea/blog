--learning lua--
--chap4--
--Statements--

a,b = "10",2
print(a,b)
a,b = b,a
print(a,b)

a,b,c = 0,1
print(a,b,c)

--local variable--
j = 10 -->global var
local i = 1 -->local var
--local 变量的作用域局限在block内，block是什么呢？
--do..end构成block，函数体构成block

--主动创建一个block--
local x,y = 1,2
do 
local m    = 10
local n    = 20;
local x    = x;
x1  = m*n  
x2 = m^n  
x = x1+x2
end

print(m ,n ) -->nil nil
print(x,y) --> 1 2

local t = false
local s = true

--controll structure--
--lua中所有过程结构都以end结尾--

--if--
a = -100;
if a>0
 then print(a ) 
else print(-a) 
end

--if elseif --
a = 0;
if a>0 then print(a )
elseif a==0 then print(a)
else print(-a) 
end

--lua中没有switch--

--while--
a = {1,2,3,4,56}
local i=1
while a[i] do
print(a[i])
i = i+1
end

--repeat until--]]
--[[
repeat
line = io.read()
until line == " "
print(line)--]]

local sqr = x/2
repeat sqr = (sqr+x/sqr)/2
local err = math.abs(sqr^2 -x) 
until err < x/1000 -->error still visible here

--numeric for--

for i=1,3,1 do
	print(i)
end

--上面代码的意思是：--
--for(int i=1; i<=3 i+=1)

for i=10,1,-1 do
--print(i)
end

--generic for --
--print下标为i的a的vlaue--
--iPairs打印出数组的index和value
a = {9,8,7,6,5,4,x=1}
for i,v in ipairs(a) do
print("--")
print(v) -->9,8,7,6,5,4 -->value
print("*")
print(i) -->1,2,3,4,5,6 -->key
end

--pairs打印出map的所有k，v
--print a所有的key
for k,v in pairs(a) do
print("##")
print(k,v) -->1,2,3,4,5,6,x
end

--break and return--
--return和block必须出现在block的末尾--
local i= 1
while a[i] do
if a[i] == 4 then break end
i=i+1
end

function foo()
--return : wrong!--
do 
--check some status--
return
end
--some statement--
end

