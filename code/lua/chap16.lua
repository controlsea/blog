--OO

Account = {balance = 100}
print(Account["balance"])

-- function Account.withdraw(self,v)
-- 	self.balance = self.balance - v
-- end
--这是self即为Account
--调用方式变成这样：
-- Account.withdraw(Account,30)
-- print(Account.balance)

--上述调用仍然过于累赘：每次需要传Account
--用：取代self参数
--:号只是语法糖
function Account:withdraw(v)
	self.balance = self.balance - v
end

Account:withdraw(50)
print(Account.balance)


--Account = {balance = 0, withdraw = function(self,v) self.balance = self.balance-v end}

function Account:deposit(v)
	self.balance = self.balance + v
end
 
 print(Account.balance)
--deposit方法通过:调用
Account:deposit(200) --:号会把self带过去
Account:withdraw(100)

--lua中没有类
--每个object(A)都被赋予一个prototype(B)，一个prototype也是一个object，当访问A不识别的方法时，他会查找B是否包含

--lua用prototype对象来表示类
a = {}
setmetatable(a,{__index = b}) --b为prototype

function Account:new(o)
	
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o
end

o = Account:new({balance = 0})
print(o)

for k,v in pairs(getmetatable(o).__index) do
	print(k,v)
end

o:deposit(100)
print(o.balance)

