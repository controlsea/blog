--learning lua---
--chap3--
--Expressions--

x = math.pi
print(x)

x = math.abs(30)
print(x)

print(2<3)			--true
print("a"<"b")		--true

--"与"操作
print(nil and 4)	-- nil
print(nil and "4") 	-- nil
print(false and 4) 	-- false
print(true and 4)
print(4 and nil)   -- nil
print(4 and 5) -- 5

--"或"操作
print(nil or 4) --4
print(false or "4") --4
print(4 or 5) -- 4

--short cut evaluation--
--[[ and和or在判断时，如果第一个参数满足条件，则不进行第二个参数的判断--]]
--例如：
x= x or v
--如果x不是nil，则直接返回，如果x是ni，才进行x=v的操作。上面等价于：
if not x then x = v end

--例如：
x = a and b or c
--等价于:
--x = a ? b:c
--如果a=nil，那么a and b 返回nil，那么 nil or c 返回c
--如果a ！= nil，那么a and b 返回 b

--例如：比较两个数：
x = 10
y = 11
max = (x>y) and x or y
--当x>y时，返回true，true and x 返回x，x or y，返回x
--当x<y时，返回false，false and x 返回 false，false or y 返回 y

--not--操作符永远返回true或false

print(not nil) -- true
print(not false) -->true;
print(not 0)-->false
print(not not nil)-->flase

--..--连接符
print("hello" .. "jayson")

--table的构造--
--这种构造方式看似数组，但实际上是key-vale映射关系--
--key:下标，value：数据
days = {"sunday","monday","tuesday","wednesday","thursday","friday","saturday"}
print(days[1])

a = {x=10,y=20}
--这种构造就类似dictionary--
print(a["x"]) --> 10
print(a["y"]) --> 20

--上面的构造和下面等价--
a = {}
a.x = 10;
a.y = 20;

w = {x=0,y=0,label="console"}
print(w[1]) -->nil
--这么访问，意思是key为数字1，求value。因此得不到x=0--
--正确的方式：
w = {0,0,"console"}
print(w[1])-->0

w = {x=0,y=0,label="console"}
x = {math.sin(0),math.sin(1),math.sin(2)}
w[1] = "another field" --> add key 1 to table w
x.f = w;
print(x["f"]) -->0x100108460:w的指针
print(x.f[1]) -->another field
w.x = nil; -->remove x=0

--数组和dictionary混排--
polyline = {color="blue",thickness=2,points=4,{x=0,y=0}}
print(polyline[1].x)-->0


x = "-"
y="+"
wiredMap = {x="sub",y="add"}
print(wiredMap.x)

--上面的简略形式为：
wiredMap = {["-"] = "sub",["+"] = "add"}
print(wiredMap["-"])

--如果要让数组从0开始：
days = {[0]="1","2","3"}
print(days[1])-->2

--用分号分割不同的数据类型
list = {1,2,3;x="10",y=11}
print(list[1])
print(list.x)