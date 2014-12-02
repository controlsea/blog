--chap14 enviroment


for n in pairs(_G) do
	print(n)
end


xxxxxxxxxx = {x=10,y=10}

value = _G["xxxxxxxxxx"]
print(value.x, value.y)

function setfield(f,v)

	local t = _G

	for w,d in string.gmatch(f,"([%w_]+)(.?)") do 
		print(w,d)
	
		if d == "." then
			t[w] = t[w] or {}
			t = t[w]
		else
			t[w] = v
		end
	end		
end

function getfield(f)
	
	local v= _G
	
	for w in string.gmatch(f,"[%w_]+") do
		v = v[w]
	end
	
	return v

end

--t ={}
setfield("yyy.x.y",10)

for n in pairs(_G) do
	print(n)
end


print(getfield("yyy.x.y"))

if rawget(_G, "yyy") == nil then
	print "test is not defined"
end


a = 1
--setfenv(1,{g=_G})
--g.print(a) -- nil
--g.print(g.a) -- 1


a = 10
--local newgt = {}
--setmetatable(newgt,{__index = _G})
--setfenv(1,newgt)
--print(a)
--a = 100
--print(a) --call local a
--print(_G.a) --call global a
--_G.a = 1000
--print(_G.a)


function factory()

	return function() return a end
	
end

a = 3

f1 = factory()
f2 = factory()

print(f1()) --3
print(f2()) --3

setfenv(f1,{a=10})
print(f1()) --10
print(f2()) --3
