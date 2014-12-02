
--create module:

--module "Foo" 

local modname = "Foo"
local M = {}
_G[modname] = M
package.loaded[modname] = M

--原先使用的是_G，现在将作用域限制在M这个table中，只能访问M内的方法,因此需要要：
setmetatable(M,{__index = _G})

setfenv(1,M)

M.i = {r=0,i=1}
M.new = function (r,i) print("M.new called") return {r=r,i=i} end 
M.add = function (c1,c2) print("M.add called") return M.new(c1.r+c2.r,c1.i+c2.i) end

--return M
