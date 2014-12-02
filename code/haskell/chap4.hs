--chap4--
--递归--

--haskell用递归代替for/while循环


--递归求最大值
maximumVal :: (Ord a)=>[a]->a
maximumVal [] = error "error"
maximumVal [x] = x
maximumVal (x:xs) 
	| x > maxTail = x 
	| otherwise = maxTail
	where maxTail = maximumVal xs
	
-- 我们取个 List [2,5,1] 做例子来看看它的工作原理。
-- 当调用 maximum' 处理它时，前两个模式不会被匹配，而第三个模式匹配了它并将其分为 2 与 [5,1]。
-- where 子句再取 [5,1] 的最大值。
-- 于是再次与第三个模式匹配，并将 [5,1] 分割为 5 和 [1]。
-- 继续，where 子句取 [1] 的最大值，这时终于到了边缘条件！回传 1。
-- 进一步，将 5 与 [1] 中的最大值做比较，易得 5，现在我们就得到了 [5,1] 的最大值。
-- 再进一步，将 2 与 [5,1] 中的最大值相比较，可得 5 更大，最终得 5。

-- 改用 max 函数会使代码更加清晰。
-- 如果你还记得，max 函数取两个值做参数并回传其中较大的值。
-- 如下便是用 max 函数重写的 maximun'

maximum' :: (Ord a) => [a] -> a   
maximum' [] = error "maximum of empty list"   
maximum' [x] = x   
maximum' (x:xs) = max x (maximum' xs)


--实现take
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
	 | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x : take' (n-1) xs


--实现reverse
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

--实现zip
zip' :: [a] -> [b] -> [(a,b)]   
zip' _ [] = []   
zip' [] _ = []   
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

--快速排序
quicksort :: (Ord a) => [a] -> [a]   
quicksort [] = []   
quicksort (x:xs) =   
  let smallerSorted = quicksort [a | a <- xs, a <= x]  
      biggerSorted = quicksort [a | a <- xs, a > x]   
  in smallerSorted ++ [x] ++ biggerSorted

