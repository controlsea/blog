// Playground - noun: a place where people can play

import UIKit

//dicionarys


//Inferred
let gameTypes = ["COD":"Shooting","COL":"RPG"]

//explicity (long)
let gameTypesExplicit1:Dictionary<String,String> = ["COD":"Shooting","COL":"RPG"]

//explicity (short)
let gameTypesExplicit2:[String:String] = ["COD":"Shooting","COL":"RPG"]

//empty
let gameTypesExplicity3 = Dictionary<String,String>()

//Accessing
let optionalGameType = gameTypes["COD"]

if let definiteGameType = optionalGameType
{
    println(definiteGameType)
}


//Immutable vs. mutable

let immutable = gameTypes
var mutable   = gameTypes
//insert
mutable["KOF"] = "Combat"
//remove
mutable["KOF"] = nil