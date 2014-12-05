// Playground - noun: a place where people can play

import UIKit

//function
func greetingFunc()->() {println("greeting func is called!")}
greetingFunc()

//closure is just an unnamed function
let greetingBlock:()->()  = {println("greeting block is called!")}
greetingBlock()




//sort using block:

var clients = ["aa","sdf","v","asdfasdf"]
//sort takes a block:理解为block是一个lambda表达式
let sort_block:(a:String, b:String) -> Bool = {(a:String,b:String)->Bool in return a < b}
//
clients.sort(sort_block)

println(clients)

//infer type:
clients.sorted{ a,b in a<b}
println(clients)

//even cooler
clients.sorted({$0 < $1})


//map - filter -reduce
let result:NSString = clients.map { (a:String) -> String in return a.uppercaseString}
    .filter{(a:String) -> Bool in a.hasPrefix("A")}
    .reduce("reduce"){(a:String,b:String)->String in "\(a) \(b)"}
println(result)


//short version
let result2:NSString = clients.map{$0.uppercaseString}.filter{$0.hasPrefix("A")}.reduce("reduce"){"\($0) \($1)"}
println(result2)


//sum the values, haskell thing
let numbers = [1,2,3,4,5]
func sum(numbers :[Int]) -> Int
{
    var tmp = 0
    
    numbers.map{ tmp += $0}
    //numbers.map{ println($0)}
    
    return tmp
    
}

println( sum(numbers))

//capture retain cycles
class TempNotifier
{
    //self retains this block
    var onChange:(Int) -> Void = {(a:Int)->Void in  }
    var currentTemp = 72
    
    init()
    {
        //block retains self
        onChange = { tmp in self.currentTemp = tmp}
    }
    
    deinit
    {
        println("deinit called")
    }
    
}

func testTempNotifier() -> Void
{
    let a = TempNotifier()
}

println(testTempNotifier())

