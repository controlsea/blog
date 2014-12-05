// Playground - noun: a place where people can play

import UIKit

// enums

enum Suit
{
    case Clubs,Diamonds,Hearts,Spades
}

var cardSuit1 = Suit.Diamonds

let cardSuit2:Suit = .Clubs

switch cardSuit1
{
case .Clubs:
    println("Clubs")
case .Diamonds:
    println("Diamonds")
case .Hearts:
    println("Hearts")
case .Spades:
    println("Spades")
}

enum Rank:Int
{
    case Ace = 1
    case two,three,four
}

let rwVal = Rank.three.rawValue

let orank = Rank(rawValue: 3) //optional

if let rank = orank
{
    println(rank.rawValue)
}

//associated values
enum Rank2
{
    case Ace
    case Num(Int)
    case Jack,Queen,King
    func description() ->String
    {
        switch(self)
        {
        case .Ace:
            return "ACE"
        case .Jack:
            return "JACK"
        case .Queen:
            return "Queue"
        case .King :
            return "King"
        
        case .Num(let val):
            return String(val)
        }
        
    }
}
//
let rank4 = Rank2.Num(3)
rank4.description()


//default values
enum Rating : Int
{
    case Terrible = 1
    case Average
    case Epic
    
    init()
    {
        self = .Average
    }
}

let myRating = Rating()
myRating.rawValue











