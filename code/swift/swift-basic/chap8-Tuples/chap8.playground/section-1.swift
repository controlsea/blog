// Playground - noun: a place where people can play

import UIKit

//tuples


//unnamed tuples
let tipAndTotal = (4.00,25)
let tipAndTotalExplicit:(Double,Double) = (3.00,200)

//access
tipAndTotal.0
tipAndTotal.1


//binding 
let(a,b) = tipAndTotal
println(a)
println(b)

//named tuples
let tipAndTotalExplicit2:(tipAmt:Double,total:Double) = (3.00,200)

//tuple as return values
let total = 21.19
let taxPct = 0.06
let subtotal = total / (taxPct + 1)

func calcTipWithTipPct(tip: Double) -> (tipAmt:Double,total:Double)
{
    let tipAmt = subtotal * tip
    let finalTotal = total + tipAmt
    
    return(tipAmt,finalTotal)
}

//tuple vs. class
func return3values() -> (a:String,b:String,c:String)
{
    return ("a","b","c")

}

let error = (404,"Not Found")

switch error
{
case(200,_):
    println("success")
case(_,"Not Found"):
    println("err")
case(300...399,_):
    println("Redirect")
case(500,let description):
    println("\(description),please")
case let (code,description):
    println("unexpected error code")
}

var name1 = "Ray"
var name2 = "Wenderlich"

(name1,name2) = ("Brain","Moakley")
(name1,name2) = (name2,name1)



