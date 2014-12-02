--chap13: metatables and metamethods

--每个table都有个metatable，metatable可以为table 增加方法

t = {}
metaT = {hi="123"}
setmetatable(t,metaT)

print(getmetatable(t)) --table: 0x7f8dc3c09a60


----使用metatable为table增加运算功能


Set = {}
local mt = {}

--create a new set with the values of the given list

function union(a,b)
	
	if getmetatable(a) ~= mt or
	getmetatable(b) ~= mt then
		error("attempt tp add set with a non-set value",2)
	end
	
	local ret = {}
	
	for k,v in pairs(a) do ret[k]=true end
	for k,v in pairs(b) do ret[k]=true end

	return ret
	
end

function intersection(a,b)

	local set = {}
	
	for k,v in pairs(a) do
		
		set[k]=b[k]
	end

	return ret

end

function Set.print(s)
	
	local l = {}
	
	for e in pairs(s) do
		l[#l+1]=e
	end
	
	str = "{" .. table.concat(l,", ") .. "}" 
	
	print(str)

end

function Set.new(l)
	
	local set={}
	
	for k,v in ipairs(l) do
		set[v] = true
	end
	
	return set

end


mt.__add = union

s1 = Set.new({10,20,30})
s2 = Set.new{30,1}

setmetatable(s1,mt)
setmetatable(s2,mt)

print(getmetatable(s1))
print(getmetatable(s2))

--mt.__add = Set.union

s3 = s1+s2
Set.print(s3)



--index
Window = {}

Window.protype = {x=0,y=0,width=100,height=100}
Window.mt = {}
Window.new = function(o) setmetatable(o,Window.mt) return o end
Window.mt.__index = function(table,key) return Window.protype[key] end

w = Window.new{x=10,y=20}
print(w.width) --100



--table with default values

function setDefault(t,d)
	local mt = { __index = function() return d end}
	setmetatable(t,mt)
end


tab = {x=10,y=20}
print(tab.x,tab.y)
setDefault(tab,100)
print(tab.x,tab.z) --10,100


local mt = {__index = function(t) return t.___ end}
function setDefault(t,d)
	t.___ = d
	setmetatable(t,mt)
end

setDefault(tab,200)
print(tab.x,tab.u)

local key = {}
local mt = {__index = function(t) return t[key] end}
function setDefault(t,d)
	t[key] = d
	setmetatable(t,mt)
end

--newIndex

t = {}
local proxy = t
t = {}
local mt = {

	__index = function(t,k) 
		print("access to element"..tostring(k)) 
		return proxy[k] 
	end,
		
	__newindex = function(t,k,v) 
		print("update of element"..tostring(k).."to"..tostring(v)) 
		proxy[k]=v 
	end
}

setmetatable(t,mt)

t[2] = "hello"
print(t[2])

print("---")

a = function(x) x = 2*x print(x) end
a(2)


a = {x=10, y = function(x) print(x) end}
a.y(2)




