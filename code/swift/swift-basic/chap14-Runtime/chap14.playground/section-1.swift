// Playground - noun: a place where people can play

import Darwin
import ObjectiveC
import Foundation

var str = "Hello, playground"


class MyClass
{
    let a : UInt32 = 10
    func test(){ }
}

var obj = MyClass()
var ptr:UnsafePointer<Void> = unsafeAddressOf(obj)
let mutable_ptr = UnsafeMutablePointer<Void>(ptr)
let l:UInt = malloc_size(mutable_ptr)
let d = NSData(bytes: UnsafePointer<Void>(mutable_ptr), length: (Int)(l));
println("%@",d)


println("%@",class_getSuperclass(MyClass))
println("%@",objc_getClass(UnsafePointer<Int8>(mutable_ptr).memory))

free(mutable_ptr)


