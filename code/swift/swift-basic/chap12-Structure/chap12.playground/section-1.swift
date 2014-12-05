// Playground - noun: a place where people can play

import UIKit


//structure
struct Point{
    
    var x,y :Double
    
}

struct Size
{
    var width,height :Int
}

//same with "class"
var pt = Point(x:64.0,y:32.0)
println("x:\(pt.x),y:\(pt.y)")

struct Rect
{
    var origin:Point
    var sz : Size
    var taggedPoints:[Point]
    
    var area:Double
    {
        return (Double)(sz.height * sz.height)
    }
    func isBiggerThanRect(other:Rect) -> Bool
    {
        return self.area > other.area
    }
    
    //mutating:
    //Struct are designed to be immutable by default, meaning you can not mutate struct member variables in
    //an instance method.You can add "mutating" keyword to let the compiler allow this happen
    mutating func addTaggedPoint(point:Point)
    {
        self.taggedPoints.append(point)
    }
}

//difference between class and structure

//1, structure can not inherite from another stuctures
//2,how values pass around:

//structure -> value : pass by copy
//class -> object : pass by reference

class Window
{
    init()
    {
        self.frame = Rect(origin: Point(x:10,y:10), sz: Size(width: 100, height: 100), taggedPoints: [Point]())
        self.title = "111"
        
    }
    var frame :Rect
    var title :String
}

//w1 is a reference to Window class
var w1 = Window()

let w2 = Window()
w2.title = "123"

//wrong: w2 = w1  -> w2 = Window* const  w1

var newFrame = w1.frame

//newFrame is a value
newFrame.origin.x = 20.0
