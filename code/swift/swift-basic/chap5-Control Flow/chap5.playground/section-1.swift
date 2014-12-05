// Playground - noun: a place where people can play

import UIKit

//Control Flow

let birdGames = ["Angry Birds","Tiny Wings","Flappy Bird"]
let gameTypes = ["COD":"Shooting","COL":"RPG"]

//for in
for i in 1..<10
{
    println("Exclusive: \(i)")
}

//include 10
for i in 1...10
{
    println("Exclusive: \(i)")
}

for i in 0..<birdGames.count
{
    let birdGame = birdGames[i]
    println(birdGame)
}

for var i=0 ;i<birdGames.count; i++
{
    let birdGame = birdGames[i]
    println(birdGame)
}

//itorate arrays
for birdGame in birdGames
{
    println(birdGame)
}

//itorate using tuple
for (index,birdGame) in enumerate(birdGames)
{
    println("index:\(index) => value:\(birdGame)")
}

//itorate dictionary
for(k,v) in gameTypes
{
    println("\(v) is  \(k) type.")
}

//print only keys
for(k,_) in gameTypes
{
    println("key:\(k)")
}

//while loop

var multiplesof3 = 3
while multiplesof3 < 100
{
    println("\(multiplesof3)")
    multiplesof3 += 3
}

//do-while loop

import Foundation

let lastRandom = 5
var random:Int = 4

do{
    
    random = Int(arc4random() % 10)

}while(random == lastRandom)


//if 

let name = "Ray"

if countElements(name) <= 3
{
    println("You Hava a short name")
}
else if countElements(name) <= 6
{
    println("You Hava a average name")
}
else
{
    println("You Hava a long name")
}

//switch
let teamMember = "BC"

switch (teamMember)
{
    case "BC","Chris B":
        println("Editor")
    
    case "Chris LP","Alexis":
        println("Tech Editor")
    
    case "Greg","Brain":
        println("Razeware")
    
    default:
        println("Tutorial Team")
}

//switch and ranges
switch countElements(name)
{
    case 0...3:
        println("You Have a Short Name")
    case 4...6:
        println("You Have a average name")
    default:
        println("You Hava a long name")
}

//pattern matching and binding 
let point = (10,10)

switch point
{
case(0,_):
    println("\(point)")
case(0,let y):
    println("\(y)")
case let (x,y) where x==y:
    println("(\(x),\(y))")
default:
    println("default")
}

//switch and conditional cases
for birdGame in birdGames
{
    switch birdGame
    {
        case let x where (x as NSString).containsString("Bird"):
            println("found a Bird game")
        default:
            println("found no Bird game")
    }
}


