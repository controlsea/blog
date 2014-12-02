--chap3--
--函数语法--

----------参数匹配（代数）--------------------

lucky2 :: (Integral a) => a -> String
lucky2 x = (if x==7 then "LuckNumber" else "wrongNumber")

--等价于这个
lucky :: (Integral a) => a -> String
lucky 7 = "Luck Number!"
lucky x = "wrong number!"

--在调用 lucky 时，模式会从上至下进行检查，一旦有匹配，那对应的函数体就被应用了。
--这个模式中的唯一匹配是参数为 7，如果不是 7，就转到下一个模式，它匹配一切数值并将其绑定为 x 。

sayMe :: (Integral a) => a -> String   
sayMe 1 = "One!"   
sayMe 2 = "Two!"   
sayMe 3 = "Three!"   
sayMe 4 = "Four!"   
sayMe 5 = "Five!"   
sayMe x = "Not between 1 and 5"  

--同样会对参数a从上向下匹配
--如果把x放到最前面，那么后面的条件都不会执行
--其实这就是haskell的switch-case

--求阶乘
factorial :: (Integral a) => a -> a   
factorial 0 = 1   
factorial n = n * factorial (n - 1)  

--两个向量相加:
--限制a类型为num
addVectors :: (Num a) => (a,a) -> (a,a) ->(a,a)
addVectors a b = (fst a+fst b, snd a+snd b)

--使用模式匹配
addVectors2 :: (Num a) => (a, a) -> (a, a) -> (a, a)   
addVectors2 (x1, y1) (x2, y2) = (x1 + x2, y1 + y2) 



--对 List 本身也可以使用模式匹配。
--你可以用 [] 或 : 来匹配它。
--因为 [1,2,3] 本质就是 1:2:3:[] 的语法糖。
--你也可以使用前一种形式
--像 x:xs 这样的模式可以将 List 的头部绑定为 x，尾部绑定为 xs。
--如果这 List 只有一个元素，那么 xs 就是一个空 List,只有一个头部元素x。

--自己实现list的head方法
headVal :: [a] -> a   
headVal [] = error "Can't call head on an empty list, dummy!"   
headVal (x:_) = x  

--怎么理解这个呢？
--首先匹配list，需要用()
--其次，"-"代表匹配任意list
--例如用户输入：[1,2,3]实际上匹配的是1:[2,3]自然结果是1

--弄个简单函数，让它用非标准的英语给我们展示 List 的前几项。
tell :: (Show a) => [a] -> String   
tell [] = "The list is empty"   
tell (x:[]) = "The list has one element: " ++ show x   
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y   
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y  

--同上，如果输入为：[]匹配的是第一条
--输入为：[1]匹配的是第二条：1:[]
--输入为：[1,2]匹配的是第三条：1:2:[]
--输入为:[1,2,3]匹配的是第三条：1:2:[3]

--list长度
--用递归求数组长度 

length'::(Num b) => [a] -> b
length' [] = 0
lenght' (_:xs) = length'(xs)+1
--例如，输入为:[1,2,3]，匹配的是1:[2,3]依此递归下去

--list求和，同样道理
sum' :: (Num a) => [a] -> a   
sum' [] = 0   
sum' (x:xs) = x + sum' xs  

---------------------------------------
--Guards
---------------------------------------

--模式用来检查一个值是否合适并从中取值，而 guard 则用来检查一个值的某项属性是否为真。
--咋一听有点像是 if 语句，实际上也正是如此。
--不过处理多个条件分支时 guard 的可读性要高些，并且与模式匹配契合的很好。

--就可以把guard简单理解为if

bmiTell :: (RealFloat a) => a -> String   
bmiTell x   
    | x <= 18.5 = "You're underweight, you emo, you!"   
    | x <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"   
    | x <= 30.0 = "You're fat! Lose some weight, fatty!"   
    | otherwise   = "You're a whale, congratulations!"  
	
-- guard 由跟在函数名及参数后面的竖线标志，通常他们都是靠右一个缩进排成一列。
-- 一个 guard 就是一个布尔表达式，如果为真，就使用其对应的函数体。如果为假，就送去见下一个 guard，如之继续
--注：bmiTell x和下一句间不能有空行

--重写max函数
max' :: (Ord a) => a -> a -> a   
max' a b    
    | a > b     = a   
    | otherwise = b  


---------------------------------------
--where
---------------------------------------

bmiTell2 :: (RealFloat a) => a -> a -> String   
bmiTell2 weight height   
    | bmi <= skinny = "You're underweight, you emo, you!"   
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"   
    | bmi <= fat    = "You're fat! Lose some weight, fatty!"   
    | otherwise     = "You're a whale, congratulations!"   
    where bmi = weight / height ^ 2   
          skinny = 18.5   
          normal = 25.0   
          fat = 30.0
	
--where必须定义在最后面，而且变量的名字必须排成竖行

---------------------------------------
--let-in
---------------------------------------

--let-in允许在函数中的任意位置定义局部变量

calcBmis :: (RealFloat a) => [(a, a)] -> [a]   
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]

---------------------------------------
--case
---------------------------------------	

--用它可以对变量的不同情况分别求值，还可以使用模式匹配。
--Hmm，取一个变量，对它模式匹配，执行对应的代码块。
--好像在哪儿听过？啊，就是函数定义时参数的模式匹配！
--{好吧，模式匹配本质上不过就是 case 语句的语法糖而已}--

--case表达式：
--case expression of pattern -> result   
--                   pattern -> result   
--                   pattern -> result   
--                   ...  



head2 :: [a] -> a   
head2 xs = case xs of [] -> error "No head for empty lists!"   
                      (x:_) -> x  
                   
	
describeList :: [a] -> String   
describeList xs = "The list is " ++ case xs of [] -> "empty."   
                                               [x] -> "a singleton list."    
                                               xs -> "a longer list." 
