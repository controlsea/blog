
module("M",package.seeall)

function printTest()
	print("test is called in Modual M")

end

function printModule()
	
	for k,v in pairs(_M) do
	
		print(k,v)
	end

end

--module name
function printModuleName()
	print(_M._NAME)
end

--package name
function printPackageName()
	print(_M._PACKAGE)
end