// Playground - noun: a place where people can play

import UIKit

//Arrays

//Inferred
let birdGames = ["Angry Birds","Tiny Wings","Flappy Bird"]

//Explicit (long form)
let birdGamesLongExplicit :Array <String> = birdGames

//Explicit (short form)
let birdGamesShortExplicit :[String] = birdGames

//Empty
let birdEmptyGames :[String] = []


//Accessing Arrays
let index1 = birdGames[0]
let indexLast = birdGames[birdGames.count - 1]

//finding item index
let flappyIndex = find(birdGames, "Flappy Bird") //returns an optional value

if let actualIndex = flappyIndex
{
    println(actualIndex)
}

//Immutable vs. Mutable Arrays
let immutable = birdGames

var mutable = birdGames
mutable.append("Angry Me")

//append a list
mutable +=  ["1","2"]

//modifying Arrays
mutable.insert("Angry Birds Rio", atIndex: 1)
mutable.removeAtIndex(0)

//sort 
mutable.sort{a,b in a<b}

//replace
mutable[0...1] = ["Kobe","Jeremy","Nash"]

println(mutable)

//typealias
typealias StringList = [String]
var genericList = StringList()
genericList.append("haha")
print(genericList)


