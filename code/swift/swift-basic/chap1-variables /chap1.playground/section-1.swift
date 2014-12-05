// Playground - noun: a place where people can play

import UIKit

var myInt:Int = 1
var myDouble:Double = 1.4
var myBool:Bool = true
var myString:String = "Jayson"

var myView:UIView = UIView(frame: CGRectMake(0, 0, 320, 100))
myView.backgroundColor = UIColor(red: 0x11, green: 0x22, blue: 0x33,alpha: 1.0)

var urInt = 1
var urDouble = 1.4
var urBool = true
var urString = "Jayson"

var mutableDouble = 1.0
mutableDouble = 2.0

let constantDouble = 2.0
//constantDouble = 3.0 //error


//optional variables
var myStringNonOptional:String
// println(myStringNonOptional) //error
// myStringNonOptional = nil //error

var myStringOptional:String?
if(myStringOptional != nil)
{
    let myAnotherString = myStringOptional!
    println(myAnotherString)
}
else
{
    println("myAnotherString is nil")
}


if let myAnotherString = myStringOptional
{
    println(myAnotherString)
}
else
{
    println("myAnotherString is nil")
}




