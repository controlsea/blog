--趣学haskell--

--everything in haskell is function--

--f (x) = x+x
doubleMe::(Num a)=>a->a
doubleMe x = x+x;

--f(x) = x+1
doubleSmallNumber x = (if x > 100 then x else x*2)+1

--f(x,y) = 2*x + 2*y
doubleXY x y = 2*x + 2*y

--字符常量
conanO'Brien = "It's a-me, Conan O'Brien!"  

--数组
numbers = [1,2,2,3,4,5,6]
strings = ["ask","hell"]

--数组拼接
addNumbers = [1,2,3] ++ [3,2,1]
addStrings = ["haskell","java"] ++ ["lua","python"]

--塞入
anotherStrings = "shit":["ask","hell"]

--索引函数，x为索引值
index x = [1,2,3,4,5,5] !! x 

--list比较，如果位数相同，则从第一个值开始向后比较
compareResult1 = [3,2,1] > [1,2,3] --true
compareResult2 = [3,4,2] > [99,88] --false
 
------------------------------------------------------------------------
--list方法
------------------------------------------------------------------------

--head ： 5
listHead = head[5,3,2,1]

--tail ： 2，3，1
listTail = tail[4,2,3,1]

--last : 1
listLast = last [3,2,1]

--init: 1,2,3
listInit = init [1,2,3,4]

--length : 4
listLength = length [123,2,3,4]

--take返回前几个:1,2,3
listTake = take 3 [1,2,3,4,5,5]

--null检测数组是否为空
listNull = null[12,3] -- false
listNull2 = null[]--true

--maximum/minimum数组最大值
listMax = maximum [1,2,3]
listMin = minimum [3,2,1]

--sum数组求和
listSum = sum [1,2,3]

--elem数组是否包含某个元素
listEle = 4 `elem` [3,3,4,5,5] -- true

--range
listRangeInteger = [1..20] --1,2,3,4,5,6...,20
listRangeString = ['a'..'z'] --a,b,c,d..,z
listRangeEventInteger = [2,4..20] -- 2,4,6,8...,20

--产生无限长的list，取前10个
listCycle10Integer = take 10 (cycle[1,2,3]) --1,2,3,1,2,3,1,2,3,1
listCycle10String = take 10 (cycle"LOL ") --LOL LOL LO

--产生重复的list,取前10个
listRepeat10Integer = take 10 (repeat(4)) --4444444444 

------------------------------------------------------------------------
--集合
------------------------------------------------------------------------

--例如：S = {2*x | x -> N, x <=10},用Haskell表示为：

-- 1<=x<=10，2x的集合
collectioA = [x*2 | x <- [1..10]]

--1<=x<=10，2x>12，2x的集合
collectionB = [x*2 | x <- [1..10],2*x >= 12]

-- 50<=x<=100 && x % 7 == 3的集合
collectionC = [x | x <- [50..100],x `mod` 7 == 3]

-- 从一个 List 中筛选出符合特定限制条件的操作也可以称为过滤 (flitering)。
-- 即取一组数并且按照一定的限制条件过滤它们。再举个例子吧
-- 假如我们想要一个 comprehension，它能够使 List 中所有大于 10 的奇数变为 "BANG"，小于 10 的奇数变为 "BOOM"

boomBangs list = [if x<10 then "BOOM" else "BANG" | x<-list,odd x]

--从多个 List 中取元素也是可以的。
--这样的话 comprehension 会把所有的元素组合交付给我们的输出函数。
--在不过滤的前提 下，取自两个长度为 4 的集合的 comprehension 会产生一个长度为 16 的 List。
--假设有两个 List，[2,5,10] 和 [8,10,11]， 要取它们所有组合的积，可以这样：
multiplyList = [x*y | x<-[2,5,10],y<-[3,6,9]]

--让我们编写自己的 length 函数吧！就叫做 length'!
length' list = sum[1 | _<-list]
--_ 表示我们并不关心从 List 中取什么值，与其弄个永远不用的变量，不如直接一个 _。
--这个函数将一个 List 中所有元素置换为 1，并且使其相加求和

--去除字符串中的小写字母
removeNonUppercase list = [c | c<-list, c `elem` ['A'..'Z']]

------------------------------------------------------------------------

--Tuple 元组

--从某种意义上讲，Tuple (元组)很像 List --都是将多个值存入一个个体的容器。
--但它们却有着本质的不同，一组数字的 List 就是一组数字，它们的类型相 同，且不关心其中包含元素的数量。
--而 Tuple 则要求你对需要组合的数据的数目非常的明确，它的类型取决于其中项的数目与其各自的类型。
--Tuple 中的项 由括号括起，并由逗号隔开。

--Tuple类似hash map，但是有多个value

------------------------------------------------------------------------

tupleA = ("jayson","code",28)

--tuple的长度是固定的，不能动态增减
--fst 返回tuple的首项。
tupleHead = fst(8,11)

--snd返回尾项
tupleTail = snd("jsyon",False)

--zip方法将k-v关联起来
zipValue1 = zip[1..3]["a","b","c"]

--zip不固定长度
zipValue2 = zip[1,2,4,5]["a","b"] --(1,"a")(2,"b")

--zip不固定长度
zipValue3 = zip[1..]["a","n","c"] --(1,"a")(2,"n")(3,"c")

--list 和 tuple
tupleList = [(a,b,c) | a<-[1..10],b<-[2..9],c<-[3..8],a^2+b^2==c^2]


--
-- 这便是函数式编程语言的一般思路：
-- 先取一个初始的集合（入参）并将其变形（map），执行过滤条件（filter），最终取得正确的结果。
--




