--learning lua--
--chap9 : Coroutines--
--coroutine和线程不同，某个时刻只有一个coroutine能被执行
--要停止coroutine必须显示调用suspend

--创建一个coroutine任务

co = coroutine.create(function() print("hi") end)
print(co,type(co)) -->thread: 0x1001082a0	thread

--coroutine有四种状态：
--suspend，dead，running，normal

--suspend：当coroutine被创建时，是suspend状态
print(coroutine.status(co)) -->suspend
--resume方法会执行coroutine任务，状态会变为running
coroutine.resume(co) -->hi
--coroutine执行完成后，状态变为dead
print(coroutine.status(co)) -->dead
--dead之后不能resume了
print(coroutine.resume(co)) -->false	cannot resume dead coroutine

--coroutine的用法要搭配yield函数使用
co = coroutine.create(function()
	for i=1,10 do 
		print("co",i)
		print("yield",coroutine.yield())
	end
end)

coroutine.resume(co) -->co 1
--这说明yield可以控制coroutine的执行
--@important：
--从coroutine的角度出发，当co suspend时，co在试行yield的操作，当yield执行完后，再会在执行co的操作
--这意味着，当co被suspend时，stack上的参数传递给yield继续执行，yield执行完后，再将参数交给co的stack


--传参:任何传递给yield/resume的参数，都会作为返回值返回给main function
--考虑两种情况：
--一种是coroutine function没有配对的yield，function自然dead
--一种是有配对的yield

--第一种情况--：
--使用wrap
co = coroutine.wrap(function(a) return 2*a end)
b = co(20)
print(b) -- 40

--使用create
co = coroutine.create(function(a) return 2*a end)
b,v1 = coroutine.resume(co,20)
print(b,v1) --true 40

--第二种情况，resume有对应的yield
co = coroutine.wrap(function(a) local c = coroutine.yield(a+1) print("main func a: ",a) return 2*a end)
b = co(20)
print(b) -- 21
--从yield后面执行
d = co(b+1)
print(d) -- 40


--使用create
co = coroutine.create(function(a) return 2*a end)
b,v = coroutine.resume(co,20)
print(b,v) -- true

--使用create
co = coroutine.create(function(a) local c = coroutine.yield(a+1) print("main func c: ",c) return 2*a end)
b,v = coroutine.resume(co,20)
print(b,v) -- true
b,v = coroutine.resume(co,20)
print(b,v)

--生产者，消费者模式--
--通过yield，resume配对实现，类似java的wait和notify

function send(x)
	coroutine.yield(x)
end

producer = coroutine.create(function() while true do 
	local x = io.read()
	print("producer get: ",x)
	send(x)
	end
end)

function receive()
	local status,value = coroutine.resume(producer)
	--print(status,value)
	return value
end

function consumer ()
	while(true) do
		local x = receive()
		
		if x == "ok" then
		print("consumer quit: ",x)
		break
	else
		print("consumer get: ",x)
		end
	end
end

--consumer()

--过程变为：
--1，由消费者驱动数据：消费者首先需要一个x,调用receive，此时main coroutine停止running，进入normal状态，
--2，此时创建一个coroutine：producer，它有自己的stack，自己的状态，resume后，执行send，发送一个x,此时yield，producer暂停
--3, 消费者收到x，继续请求令一个x


