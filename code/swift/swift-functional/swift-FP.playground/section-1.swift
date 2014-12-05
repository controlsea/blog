// Playground - noun: a place where people can play

import UIKit

//old for loop
var events = [Int]()

for i in 1...10
{
    if(i%2 == 0)
    {
       events.append(i)
    }
}
println(events);


//formal functional way:
events = Array(1...10).filter( {(a:Int) -> Bool in  return a%2 == 0 } )

//without ()
events = Array(1...10).filter {(a:Int) -> Bool in  return a%2 == 0 }

//binding
events = Array(1...10).filter {(a) in a%2 == 0}

//more consice way
events = Array(1...10).filter {$0 % 2 == 0}

println(events)


