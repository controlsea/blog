// Playground - noun: a place where people can play

import UIKit

//Memory Management

//ARC
//retain cycle:
class A
{
    // unowned var delegate1 :B? //unretain-unsafe
    weak var    delegate2 :B? //weak
    var         delegate3 :B? //strong
}

class B
{
    weak var a :A?
    
    func foo() -> Void
    {
        
    }
    
    init()
    {
        a = A()
        // a?.delegate1 = self
        a?.delegate2 = self;
        a?.delegate3 = self;
        
        //execute a method
        foo()
        
    }
}



