// Playground - noun: a place where people can play

import Foundation

func iterate(pointer: UnsafeMutablePointer<COpaquePointer>, callForEach: (COpaquePointer) -> Void) {
    
    if pointer != nil
    {
        var i = 0
        while pointer[i] != nil
        {
            callForEach(pointer[i])
            i++
        }
        
        free(pointer)
    }
}

class MySwiftClass
{
    let a : UInt32 = 10
    func test(){ }
}

//creat an instance of MySwiftClass
let obj = MySwiftClass()

//get it's pointer in memory
let obj_ptr:UnsafePointer<Void> = unsafeAddressOf(obj)
let obj_ptr_shadow: UnsafePointer<Void> = unsafeBitCast(obj, UnsafePointer<Void>.self)

println("%@,%@",obj_ptr,obj_ptr_shadow)

//size of obj
let l:UInt = malloc_size(obj_ptr)

//memory layout of obj
let d = NSData(bytes: obj_ptr, length: (Int)(l));
println("obj's memory address:\(d)")

//get the class name of obj
let name_ptr:UnsafePointer<Int8> = object_getClassName(obj)
let obj_name = String(UTF8String: name_ptr)
println("class:\(obj_name)");

//get the super class type
let obj_class: AnyClass! = object_getClass(obj)
let obj_super_class:AnyClass = class_getSuperclass(obj_class)
println("superclass:\(String(UTF8String:object_getClassName(obj_super_class)))")

//get ivars from obj's super class
var count:UInt32 = 0;
let obj_super_class_ivars = class_copyIvarList(obj_super_class, &count);
iterate(obj_super_class_ivars) {
    
    let ivar_name = ivar_getName($0)
    let ivar_encode_type = ivar_getTypeEncoding($0)
    
    Swift.print("ivar:\(String(UTF8String: ivar_name))  type:\(String(UTF8String: ivar_encode_type))\n")
}

//get ivars from obj
let obj_class_ivars = class_copyIvarList(obj_class, &count)
iterate(obj_class_ivars) {
    
    let ivar_name = ivar_getName($0)
    let ivar_encode_type = ivar_getTypeEncoding($0)
    
    Swift.print("ivar:\(String(UTF8String: ivar_name)) type:\(String(UTF8String: ivar_encode_type))\n")
}

//get properties from obj's super class
let obj_super_class_properties = class_copyPropertyList(obj_super_class, &count)
iterate(obj_super_class_properties) {
    
    let proerty_name = property_getName($0)
    let propery_attr = property_getAttributes($0)
    
    Swift.print("property:\(String(UTF8String: proerty_name)) type:\(String(UTF8String: propery_attr))\n")
    
}

//get properties from obj's super class
let obj_class_properties = class_copyPropertyList(obj_class, &count)
iterate(obj_class_properties) {
    
    let proerty_name = property_getName($0)
    let propery_attr = property_getAttributes($0)
    
    Swift.print("property:\(String(UTF8String: proerty_name)) type:\(String(UTF8String: propery_attr))\n")
}


//get methods from obj's super class
let obj_super_class_methods = class_copyMethodList(obj_super_class, &count)
iterate(obj_super_class_methods) {
    
    let method_name = method_getName($0)
    let method_type = method_getTypeEncoding($0)
    
    Swift.print("method:\(String(UTF8String:sel_getName(method_name))) type:\(String(UTF8String: method_type)) \n")
    
}

let obj_class_methods = class_copyMethodList(obj_class, &count)
iterate(obj_class_methods) {
    
    let method_name = method_getName($0)
    let method_type = method_getTypeEncoding($0)
    
    Swift.print("method:\(String(UTF8String:sel_getName(method_name))) type:\(String(UTF8String: method_type))\n")
}




