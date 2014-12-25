// Playground - noun: a place where people can play

import UIKit

//initialization

//one single rule : Every value must be initialized before it is used
class B
{
    func foo() -> Void
    {
        
    }
}

//call super.init at the bottom of init method
class C : B
{
    lazy var color = UIColor.whiteColor()
    
    var hasTurbo :Bool
    
    override func foo() {
        
        hasTurbo = false
        println("turbo:\(hasTurbo)")
    }
    
    //designated initializer
    //can be inherited
    init(turbo:Bool) {
        
        hasTurbo = turbo
        
        super.init() //call super.init() after hasTurbo has been initialized
    }
    
    //convenient initializer
    //can not be inherited
    convenience init(color:UIColor) {
        
        self.init(turbo:true)
        self.color = color
    }
    
    
    //deinitializer
    deinit
    {
        println("C has been dealloced")
        
    }
    
}

func testDeinit()
{
    var obj:C = C(color: UIColor.blackColor())
    obj.foo()
    
}

testDeinit()
