---
layout: post
title: Behind Swift Object

---
<em>所有文章均为作者原创，转载请注明出处</em>

>本文的内容一部分来自[Mike Ash](https://www.mikeash.com/)的研究成果，一部分来自作者的一些实验性探索。感谢Mike长期以来对iOS/MacOS社区做出的贡献，他的研究成果让我获益匪浅。


##Memory Layout

```
class MySwiftClass
{
    let a : UInt64 = 10
    func method(){ }
}
```

我们首先定义一个类`MySwiftClass`，不指定其父类。接着我们想来观察这类的memory layout(x86_64)。

>所谓Memory Layout是指一个对象在内存中的存储形式。如果熟悉C++，那么对这个概念不会陌生，即使不熟悉C++，Objective-C对象在内存中也有固定的[存储形式]()。


```
//creat an instance of MySwiftClass
let obj = MySwiftClass()

//get it's pointer in memory
var obj_ptr:UnsafePointer<Void> = unsafeAddressOf(obj)

//size of obj
let l:UInt = malloc_size(obj_ptr)

//memory layout of obj
let d = NSData(bytes: obj_ptr, length: (Int)(l));

println("%@",d)

```

- `obj`的大小为32byte

- `obj`在内存中的存放格式为`<100d8719 01000000 0c000000 01000000 0a000000 00000000 00000000 00000000>`


在x86_64上，数据按照little-endian存储，低位在前，高位在后，数据按照64bit对齐内存。前16字节为[isa pointer]():`100d8719 01000000 0c000000 01000000`。后16字节为成员变量`a`。

从这个结果来看Swift对象的内存格式和Objective-C对象是相同的。


##Swift Object

###objc_class在哪?

在Objective-C中，`isa`实际上是`objc_class`类型的结构体。因此，最先首先想到的办法当然是在Swift的各种framework中看看能否找到`objc_class`的定义。翻了半天，只找到了这样一句:

`/* Use 'Class' instead of 'struct objc_class *' */`

这是不是说明Swift的`objc_class`不存在呢？通过上一节的分析，应该可以确定`isa`是存在的，只是不允许被直接访问了。

网上有一篇很神奇的文章[Inside Swift](http://www.eswick.com/2014/06/inside-swift/)。他是通过逆向Mach-O文件，在`__objc_classlist`段，找到了`objc_class`

```
struct objc_class {
    uint64_t isa;
    uint64_t superclass;
    uint64_t cache;
    uint64_t vtable;
    uint64_t data;
};
```
其中`vtable`能给我们带来一些启示，写过C++的人都知道，这个`vtable`叫做[虚表](http://en.wikipedia.org/wiki/Virtual_method_table)，用来在运行时决虚函数地址。

- 接下来是我的一些推测：

为了[提升性能](https://www.mikeash.com/pyblog/friday-qa-2014-07-04-secrets-of-swifts-speed.html)，Swift对象间的通信（method调用），是不需要runtime的（在下一节会印证这个观点），也没有了所谓的"消息"。取而代之的是，采用了类似C++的机制，将method提前编译好，对于那些需要在运行时执行的虚函数，则为其提供了`vtable`这样一个虚表。

但有一个问题，如果这个Swift对象需要和Objective-C对象通信怎么办？例如，有这样一段OC代码，它向`s`发消息:

```
MySwiftClass* s = [MySwiftClass new];

if([s responseToSelector(@selector(method))])
{
	[s method];
}
	

```
因此Swift对象:`s`仍然需要具有在运行时introspect的能力，那这一点是怎么做到的呢？


###神奇的SwiftObject

接着上面的问题，既然我们已经知道Swift对象必须具有introspect的能力，那么我们如何来验证呢？首先想到的就是在运行时反射出Swift对象的一些信息，由于上文已经创建好了`obj`：

```
let obj = MySwiftClass()

```
我们接下来的任务就是反射出`obj`更多的信息，关于在Swift中如何拿到这些信息，Mike写了一个[非常牛逼的工具](https://github.com/mikeash/memorydumper/blob/master/memory.swift)，这个工具的思路是根据对象address和size，通过`dladdr`将里面的内容符号化。这份代码对于理解Swift和C有着很好的帮助。但是...仅从实现这个功能来说，不需要那么复杂，我上传了一份比较精简的[代码]。总之，不论用哪种方法，都能得到下面的结果:


```
class:Optional("TestSwiftRuntime.MySwiftClass")
superclass:Optional("SwiftObject")
ivar:Optional("magic")  type:Optional("{SwiftObject_s=\"isa\"^v\"refCount\"q}")
ivar:Optional("a") type:Optional("")
property:Optional("hash") type:Optional("TQ,R")
property:Optional("superclass") type:Optional("T#,R")
property:Optional("description") type:Optional("T@\"NSString\",R,C")
property:Optional("debugDescription") type:Optional("T@\"NSString\",R,C")
method:Optional("zone") type:Optional("^{_NSZone=}16@0:8") 
method:Optional("doesNotRecognizeSelector:") type:Optional("v24@0:8:16") 
method:Optional("description") type:Optional("@16@0:8") 
method:Optional(".cxx_construct") type:Optional("@16@0:8") 
method:Optional("retain") type:Optional("@16@0:8") 
method:Optional("release") type:Optional("v16@0:8") 
method:Optional("autorelease") type:Optional("@16@0:8") 
method:Optional("retainCount") type:Optional("Q16@0:8") 
method:Optional("dealloc") type:Optional("v16@0:8") 
method:Optional("isKindOfClass:") type:Optional("B24@0:8#16") 
method:Optional("hash") type:Optional("Q16@0:8") 
method:Optional("isEqual:") type:Optional("B24@0:8@16") 
method:Optional("_cfTypeID") type:Optional("Q16@0:8") 
method:Optional("respondsToSelector:") type:Optional("B24@0:8:16") 
method:Optional("self") type:Optional("@16@0:8") 
method:Optional("performSelector:") type:Optional("@24@0:8:16") 
method:Optional("performSelector:withObject:") type:Optional("@32@0:8:16@24") 
method:Optional("conformsToProtocol:") type:Optional("B24@0:8@16") 
method:Optional("performSelector:withObject:withObject:") type:Optional("@40@0:8:16@24@32") 
method:Optional("isProxy") type:Optional("B16@0:8") 
method:Optional("isMemberOfClass:") type:Optional("B24@0:8#16") 
method:Optional("superclass") type:Optional("#16@0:8") 
method:Optional("class") type:Optional("#16@0:8") 
method:Optional("debugDescription") type:Optional("@16@0:8") 

```

由于上面所有的信息都是通过`<objc/runtime.h>`的API得到的，能输出这样的结果意味着，这些信息可以被Objective-C在运行时发现，那么我们的Swift对象:`obj`要么自己就是一个Objective-C对象，要么它的父类是。

- 类名：运行时`obj`的类名变成了`TestSwiftRuntime.MySwiftClass`。格式为: `Target名称.类名`。也许有人会注意到，上面的结果和[这篇文章](https://www.mikeash.com/pyblog/friday-qa-2014-07-18-exploring-swift-memory-layout.html)得到的结果不一样，它得到类名是混淆过的结果：`_TtC16TestSwiftRuntime12MySwiftClass`。产生这个问题的原因是使用API的差别:`String(UTF8String:ptr)`和`String.fromCString(ptr)`，但这并不是根本原因，根本原因是[Name Mangling](http://en.wikipedia.org/wiki/Name_manglin)。

- 父类：`SwiftObject`一个新OC基类出现了，实现了`<NSObject>`，因此具备了和其它OC对象通信的能力，这个也间接回答了上一小节留下的问题。但是，和`NSObject`不同的是，它还有一个成员变量叫`magic`，从TypeEncoding的结果来看，它是一个结构体，有两个成员:`isa`，`refCount`。功能上貌似是用来做引用计数。更多关于`magic`的内容还有待证研究。
	
- 关于成员变量`a`：我们为`MySwiftClass`定义了一个`UInt32`类型的成员`a`，但是我们却无法获取它的TypeEncoding，为什么呢？这说明Objective-C的runtime是无法获取到Swift变量的类型的。

- 关于成员函数`method()`：我们发现`method()`根本没有被反射出来，原因在上一节末尾也提到了，Swift对象的method被放到了`vtable`里，而Objective-C的运行时是无法发现`vtable`的。

###寻找vtable

接下来是比较艰难的问题，我们如果要知道`mthod()`在哪里，需要先找到`vtable`。而我们已经没有系统的API可以使用了，这时候，只能依靠Mike的牛逼的工具了：

```
Symbol _TFC16TestSwiftRuntime12MySwiftClassg1aVSs6UInt32
Symbol _TFC16TestSwiftRuntime12MySwiftClasss1aVSs6UInt32
Symbol _TFC16TestSwiftRuntime12MySwiftClassm1aVSs6UInt32
Symbol _TFC16TestSwiftRuntime12MySwiftClass6methodfS0_FT_T
Symbol _TFC16TestSwiftRuntime12MySwiftClasscfMS0_FT_S0

```


###Name Mangling的规则

Swift黑语法:

```
//name mangling:
println("%s",_stdlib_getTypeName(obj))
(%s, _TtC16TestSwiftRuntime12MySwiftClass)

//demangling:
println("%s",_stdlib_demangleName(_stdlib_getTypeName(obj)))
(%s, TestSwiftRuntime.MySwiftClass)

```


##更多

我们上面研究了Swift中对象的内存模型和类结构，而Swift中还有很多非对象类型，比如Struct，Optional对象，继承了NSObject的Swift对象，等等...它们也有自己的内存模型。篇幅的原因，本文无法列举出所有的情况，这方面Mike做了非常详细的分析和研究，感兴趣的可以直接去阅读他的文章。


##总结

最后我们再来梳理一遍上面的内容：

- 首先我们有一个Swift对象：`obj`，他没有任何父类

- 然后我们通过OC的运行时发现它有一个父类`SwiftObject`，它实现了<NSObject>的接口，使`obj`有了和OC对象通信的能力

- 然后我们发现`obj`的`method`方法被定义在了`vtable`里面

- 最后我们解释了Name Mangling


##Further Reading

- [Inside Swift](http://www.eswick.com/2014/06/inside-swift/)
- [Mike's Blog](https://www.mikeash.com/pyblog/)




