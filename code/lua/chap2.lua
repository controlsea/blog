-- learn lua--
-- chap 2 -- 


-------------------- string --------------------

a = "one string"
b = string.gsub(a,"one","another")
print(b)

a = "a line"
b = 'another line'
print(a,b)

a = "a line\b anotherline"
print(a)	--a lin anotherline--

a = "Tom says \"this cake tastes like shit\""
print(a)	--Tom says "this cake tastes like shit"--

a = "\\"
print(a)	--\--

print("10"+1) --11--

print("10+1") --10+1--

--字符串连接符--
print(10 .. 20) -- 1020--

print("100" .. "hello") -- 100hello --

--string to number --
a = "10";
print(tonumber(a))

--number to string--
a = 10
print(tostring(a))
print(tostring(10) == "10") -- true--

--隐式转换--
print(10 .. "" == 10) --false
print(10 .. "" == "10")--true--

--字符串长度---

a = "some"
b = #a
print(b) -- 4

a = "some\nsom"
print(#a) -- 8

-------------------- table --------------------

--create a table--

a = {}
k = "x"
a[k] = 100
print(a[k]) 	-- 100
print(a["x"])	-- 100
print(a.x) 		-- 100 : a.x = a["x"]

a.l = 102
print(a["l"])	-- 102
print(a[l])		-- nil : this one is important

--create a reference,not copy--
b = a
print(b.x) -- 100
b.x = 101
print(a.x)--101

--index---
x =  10
a[x] = 199
print(a[x])
for i=1,10 do
a[i]=i 
end
print(a[0]) --nil -- lua 下标从1开始--
print(a[10]) --10

for i=1, #a do	--#a 返回数组a的最后一个元素下标，不是值
	print(a[i])
end

print(a[#a])--10
a[#a] = nil --去掉最后一个元素
a[#a+1] = 99 -- append value to the end of list
print(a[#a]) 

a={}
a[100] = 1
print(#a) --0

--通常情况array都是连续有值的，中间没有hole--
i = 10;j="10";k="+10"
a={}
a[i] = "one value"
a[j] = "another value"
a[k] = "yet another value"
print(a[j])
print(a[k])
print(a[tonumber(j)])
print(a[tonumber(k)])




