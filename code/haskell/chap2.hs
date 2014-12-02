--chap2--
--Types and TypeClasses

------------------------------------
--变量类型
------------------------------------

--命令：:t用来查看变量的type

--ghci> :t 'a'   
--'a' :: Char   

--ghci> :t True   
--True :: Bool   

--ghci> :t "HELLO!"   
--"HELLO!" :: [Char]   

--ghci> :t (True, 'a')   
--(True, 'a') :: (Bool, Char)   

--ghci> :t 4 == 5   
--4 == 5 :: Bool

------------------------------------
--函数类型
------------------------------------

--函数类型声明

--入参->出参
removeNonUppercase :: [Char] -> [Char]   
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

--入参->入参->入参->出参
addThree :: Int -> Int -> Int -> Int   
addThree x y z = x + y + z


--Types : Integer, Float, Double, Bool, Char
--类型首字母必须大写

------------------------------------

--Type variables

--主要讨论函数的出参，和入参类型

------------------------------------

--ghci> :t head   
--head :: [a] -> a

--意思是head这个function，入参是泛型的[a]，出参是泛型的a，这种都是泛型的出入参函数叫做“多态函数”

------------------------------------
--Typeclasses

--还是讨论函数的参数问题

------------------------------------

-- 有些函数的入参，出参类型是被约束的，它要服从其“父类”的类型约束条件
--例如：

--ghci> :t (==)   
--(==) :: (Eq a) => a -> a -> Bool

--有意思。在这里我们见到个新东西：=> 符号。
--它左边的部分叫做类型约束
--我们可以这样阅读这段类型声明："相等函数取两个相同类型的值作为参数并回传一个布林值，而这两个参数的类型同在 Eq 类之中(即类型约束)"

--怎么理解呢？
-- “==”这个函数的入参和出参类型，取决于Eq，因为“==”的父类就是Eq，
-- Eq的子类还有“/=”

--相似的例子还有Ord：

--ghci> :t (>)   
--(>) :: (Ord a) => a -> a -> Bool
-- “>”的参数类型取决于父类Ord
--同理，ord包含了<, >, <=, >= 这几个接口


show1 = show 3 -- "3"

-- Main> :t (show)
--(show) :: Show a => a -> String

-- show的参数类型取决于show自己，而show这个typeclass包含的参数类型为所有
--3 是Integer，在包含的范围之内，因此可以转换为string

--read将字符串转为某成员类型,类型根据第二个参数确定
read1 = read "True" || False -- True
read2 = read "8.2" + 3.8 -- 12.0

--read若只有一个参数，则需要提供一个参数类型，帮助其转换
read3 = read "3" :: Int
read4 = (read "4.0"::Float)*4
read5 = read "[1,2,3,4]" :: [Int]   
--[1,2,3,4]   
read6 = read "(3, 'a')" :: (Int, Char)  

--Enum包含：
--succ，pred，[1..3](range)
--参数类型包括：

-- Main> :t ([1..3])
-- ([1..3]) :: (Enum t, Num t) => [t]
