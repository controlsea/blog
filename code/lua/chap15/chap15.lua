--chap15:Modules and Packages

--一个Module就是一个Table:

--local m = require "Mod"
--m.foo()

--require的内部实现:

-- function require(name)
--
-- 	if not package.loaded[name] then -- module not loaded yet?
-- 		local loader = findloader(name)
-- 		if loader ==nil then
-- 			error("unable to load module")
-- 		end
--
-- 		package.loaded[name] = true
-- 		local res = loader(name)
-- 		if res ~= nil then
-- 			package.loaded[name] = res
-- 		end
-- 	end
-- 	return package.loaded[name]
-- end


--require 的参数是模式匹配的,用?来替换文件名:
--?;?.lua;/usr/local/?.lua
--如果输入 require "sql", 那么真正的路径是sql;sql.lua;/usr/local/sql.lua

--lua默认路径为package.path ： LUA_PATH

print(package.path)

--./?.lua;
--/usr/local/share/lua/5.1/?.lua;
--/usr/local/share/lua/5.1/?/init.lua;
--/usr/local/lib/lua/5.1/?.lua;
--/usr/local/lib/lua/5.1/?/init.lua

--lua的require方法会先找lua的module，找不到，再找C的lib
--C的module，需要提供一个luaopen_*的方法



local f = require "Foo"

for k,v in pairs(f) do
	print(k,v)
end

f.new(1,2)


local m = require "M"
m.printTest()
m.printModule()

--module name
print(m._NAME)

--package name
print(m._PACKAGE)



