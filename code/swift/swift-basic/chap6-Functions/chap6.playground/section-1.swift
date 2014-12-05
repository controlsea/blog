// Playground - noun: a place where people can play

import UIKit

func addNums(x: Int,y: Int ) -> Int
{
    return x+y
}

addNums(10, 10)

func noParams1()->()
{}

func noParams2(){}

//external paramter name
import CoreGraphics

func lerp(from start:CGPoint, to end:CGPoint, delta t:CGFloat) -> CGPoint
{
    let range = CGPoint(x:end.x - start.x, y: end.y - start.y)
    return CGPoint(x:start.x + range.x * t, y:start.y + range.y*t)
}

//函数默认是没有external paramter name的
lerp(from: CGPoint(x:100,y:100), to: CGPoint(x:200,y:200), delta: 0.2)


//make external name equal to internal param's name :
//using hash tag
func SubtractNums(#x:Int , #y:Int) -> Int
{
    return x-y;
}

SubtractNums(x:10,y:5)

//default params
func calcTip(subtotal:Double, tipPct:Double = 0.18) -> Double
{
    return subtotal * tipPct
}

calcTip(10, tipPct: 0.2)
calcTip(10)

//variadic parameters
func maxof(numbers:Int ... ) ->Int
{
    if numbers.count == 0
    {
        return 0
    }
    
    var max = numbers[0]
    
    for number in numbers
    {
        if number > max
        {
            max = number
        }
    }
    return max
}


var string:String = "entryString"

//const,variable, inout params
func addEntry1(string:String)
{
    //by default string can not be modified
    //string += "!" //error
}


//const,variable, inout params
func addEntry2(var string:String)
{
    string += "!" //only modify the local value, caller's value is not modified
    
}

func addEntry3(inout string:String)
{
    string += "!"
}

addEntry1(string)
println(string)

addEntry2(string)
println(string)

addEntry3(&string)
println(string)

//default param value
func sayHello(name:String="Tom")
{
    println("Hello,\(name)")
}

//有默认参数的可以不传参，如果传参，需要加入param name
sayHello()
sayHello(name: "Bob")

//return multiple values:Tuple
func returnATupleFunc() -> (String,Int)
{
    return ("Success",200)
}

let tuple = returnATupleFunc()

println(tuple.0,tuple.1)

func repeat(count:Int, task:()->())
{
    for i in 0...count
    {
        task()
    }
}

func print()->(){ println("hello")}
let proc:()->() = { println("hello")}

//repeat function
repeat(2,proc)
repeat(2,print)
//if the block is the last param of the function:
repeat(2){println("hello")}





