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

//initialization

//one single rule : Every value must be initialized before it is used

var message: String
var tmp: Bool = true;
if(tmp)
{
    message = "welcome to swift"
}
    
    //println(message) //error
else
{
    message = "else called"
}
println(message)


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


