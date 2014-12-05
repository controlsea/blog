// Playground - noun: a place where people can play

import UIKit

//add string values
var str = "Hello, playground" + ","
str += "!"

//string interpolation
var myInt = 10
str += "\(myInt)"
str += "\(5*6)"

//compare characters
let str1 = "Jayson"
let str2 = "Jayson"
let str3 = "jayson"

println(str1 == str2)
println(str1.lowercaseString == str3)
println(str2.isEmpty)

//conversion

//integer/double -> string
let str4 = String(1)
//let str5 = String(1.1)
let str6 = NSString(format: "%.1f", 3.14)

//string -> integer/double
//func toInt() -> Int?
let maybeInt = str4.toInt() //returns an optional value

if( maybeInt != nil )
{
    let definitInt = maybeInt!
    println(definitInt)
}

//String is Swift class, NSString is OC class
//needs bridging : "as"

//The entire NSString API is available to call on any String value you create

var myDouble = Double(("3.14" as NSString).doubleValue) //use "as" to convert String to NSString, then use NSString's API

//contains string
var flappy = "Flappy Jay"
(flappy as NSString).containsString("Jay")

//substring
var jay = (flappy as NSString).substringWithRange(NSMakeRange(6, 4))

//Strings are an ordered collection of Characters
let chara:Character = "a"
let charb:Character = "b"
let holidays:String = chara+charb

//all swift code is unicode

//number of unicode characters:
countElements(holidays) //2

//not necessarily the same as NSString's length(number of UTF-16 units)
holidays.utf16Count //2
(holidays as NSString).length //2

holidays.utf8















