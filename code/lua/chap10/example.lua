--[[
JSON4Lua example script.
Demonstrates the simple functionality of the json module.
]]--
json = require('json')


-- Object to JSON encode
test = {
  one='first',two='second',three={2,3,5}
}

jsonTest = json.encode(test)

print(type(jsonTest))


local path = "./chap10_input.json"
local f = assert(io.open(path, "r"))
local s = f:read "*a"
f:close()

--s = '{ "data" : {"title" : "visionary","org"   : "com.visionary.company","url" : "http://www.objayc.com/blog","contact" : "Jayson","entry" : [{"im" : "aaa"},{"im":"bbb"}],"description" : "As a way to kick off this new year."}}'
--print('JSON encoded test is: ' .. s)



-- Now JSON decode the json string
result = json.decode(s)

for k,v in pairs(result)
do
	print(k,v)
end

--print ("The decoded table result:")
--table.foreach(result,print)

--data = result.data
--table.foreach(data,print)





--print ("The decoded table result.three")
--table.foreach(result.three, print)
