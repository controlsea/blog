// Playground - noun: a place where people can play

import Foundation

//generic:函数名称后面声明<T>
func SWAP<T>(inout x:T, inout y:T )
{
    let tmp = x
    x = y
    y = tmp
}

var a = 42
var b = 43
SWAP(&a, &b)

var c:String

//index of a target string in array
func indexOfString(target:String,array:[String]) -> Int?
{
    for (index,value) in enumerate(array)
    {
        if value == target
        {
            return index
        }
    }
    return nil
}

let strList:[String] = ["a","c","d"]

let index = indexOfString("a", strList)!

//index of any obj in array
func indexOf<T: Equatable>(target:T,array:[T]) ->Int?
{
    for(index,value) in enumerate(array)
    {
        if value == target
        {
            return index
        }
    }
    return nil
}

let indexStr = indexOf("c", strList)!
let indexInt = indexOf(3, [1,2,3])!


//a more complexed example
struct orderedDictionary<KeyType:Hashable,ValueType>
{
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType:ValueType]
    
    var array = ArrayType()
    var dicationary = DictionaryType()
    var count:Int
        {
        return self.array.count
    }
    
    //mutating:
    //Struct are designed to be immutable by default, meaning you can not mutate struct member variables in
    //an instance method.You can add "mutating" keyword to let the compiler allow this happen
    
    mutating func insert(value: ValueType,forkey key: KeyType,atIndex index:Int) -> ValueType?
    {
        var adjustedIndex = index
        
        let existingValue = self.dicationary[key];
        
        if existingValue != nil
        {
            let existingIndex = find(self.array, key)!
            
            if existingIndex < index
            {
                adjustedIndex--
            }
            self.array .removeAtIndex(existingIndex);
            
        }
        
        self.array.insert(key, atIndex: adjustedIndex)
        self.dicationary[key] = value
        
        return existingValue
    }
    
    mutating func removeAtIndex(index:Int) -> (KeyType,ValueType)
    {
        precondition(index < self.array.count, "Index out of bounds")
        
        let key = self.array.removeAtIndex(index)
        
        //确定value不为空，则直接使用!符号
        let value = self.dicationary.removeValueForKey(key)!
        return (key,value)
    }
    
    //实现dictionary的access
    //实现subscription接口 => dict[key]=value
    
    subscript(key: KeyType) -> ValueType?
        {
        get{
            
            println("ssss")
            return self.dicationary[key]
        }
        
        set{
            
            if let index = find(self.array, key)
            {
                
            }
            else
            {
                self.array.append(key)
            }
            
            //newValue是一个implicity参数
            self.dicationary[key] = newValue
        }
    }
    
    //value = dict[0]
    subscript(index:Int) -> (KeyType,ValueType)?
        {
        get
        {
            precondition(index < self.array.count, "Index out of bounds")
            
            let key = self.array[index]
            let value = self.dicationary[key]!
            return (key,value)
        }
        
        set
        {
            precondition(newValue != nil, "new value is nil!")
            
            let newTuple:(KeyType,ValueType) = newValue!
            
            if index < self.array.count
            {
                let key = self.array[index]
                
                self.array.removeAtIndex(index)
                self.dicationary.removeValueForKey(key)
                
                self.array.insert(newTuple.0, atIndex: index)
                
                self.dicationary[newTuple.0] = newTuple.1
                
            }
            else
            {
                
                self.array.append(newTuple.0)
                self.dicationary[newTuple.0] = newTuple.1
                
            }
            
        }
    }
}

var dict = orderedDictionary<Int, String>()

dict.insert("dog", forkey: 1, atIndex: 0)
dict.insert("cat", forkey: 2, atIndex: 1)
println(dict.array.description + ":" + dict.dicationary.description)

var byIndex:(Int,String) = dict[0]!
println(byIndex)

dict[3] = "pig"
println(dict.array.description + ":" + dict.dicationary.description)


if let v:String = dict[1]
{
    println(v)
}


dict[0] = (1,"phonex")
dict[4] = (55,"fish")
println(dict.array.description + ":" + dict.dicationary.description)


