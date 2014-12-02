--learning lua--
--chap7:Iterators and Generic for--

--7.1迭代器和Closure--
--如果想实现通过迭代器查找list元素，可以使用Closure:--
--由于Closure可以copy unused variable，因此可以创建一个--
--局部变量作为index--
--这种方法的本质是通过一个迭代函数完成循环的计算--

print("--chap7--")

function values(t)
	local i = 0
	return function() i = i+1;return t[i] end
end

t = {10,20,30,40,50,60,70,80,90,100}
iter = values(t);
while true do
	local element = iter() --call the iterator
	if element == nil
	then break
	end
	print(element)
end


-------------------------------
--7.2使用for循环--
--根据上面例子抽象出了for循环；
for element in values(t)
do print(element)
end

--将上面for循环做进一步抽象，可得到通用的公式--
for k,v in ipairs(t)
do print(k,v)
end
--如果仅需要value，可以：
for i=1,#t do
	print(t[i])
end

--ipairs函数会返回三个变量，分别是：
--iter：迭代函数
--a：源数据
--i:index
--lua拿到这三个参数后，调用iter(t,i):
local function iter(t,i)
	
	i = i+1
	local val = t[i]
	
	if val then 
		return i,val --return key,value
	else
		return i,nil
	end
end

local function fake_ipairs(t)
	return iter,i,t
end

-- for k,v in iter,t do
-- 	print(k,v)
-- end


--除了使用ipairs，还有一个函数叫pairs
--pairs和ipairs有什么区别呢？
--pairs的原理是拿到table的key然后找value，是一种无序的遍历，没有index的概念
--pairs的迭代器选择的是next，不是iter
--pairs的实现如下：

local function fake_pairs(t)
	return next,t,nil
end


--next方法是lua原生的方法，pairs是对next的一个封装
--next方法的意思是遍历table的key，找到对应的value:

print(next(t,nil)) --1,10
--next返回的是下一个key，nil的下一个是1
print(next(t,1))   --2, 10

--因此使用pairs也可以达到同样的效果
for k,v in pairs(t) do
print(k,v)
end

--也可以直接使用next
for k,v in next,t do
	print(k,v)
end




