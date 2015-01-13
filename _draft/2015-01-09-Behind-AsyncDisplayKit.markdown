---
layout: post
title:  AsyncDisplayKit

---

<em>所有文章均为作者原创，转载请注明出处</em> 


##AsyncDisplayKit简介

[AsyncDisplayKit](https://github.com/facebook/AsyncDisplayKit)(后面简称AS)，是Facebook开源的一套异步绘制UI的framework，用来提高GUI的绘制效率。它最初和[POP](https://github.com/facebook/pop)一起被用在Facebook的Paper上，Paper在当时引起了强烈的反响，因为其引入了很多物理效果和流畅的动画表现。然后Facebook开源了它们的物理效果引擎[POP](https://github.com/facebook/pop)，同时也宣布会开源一套全新的UI绘制引擎，大概7个月前，Facebook宣布开源AsyncDisplayKit。


##一段以前的故事

大概在2年多以前，我经历的一个项目是做一个SNS的APP，当时市面上的主流机型是iPhone4/4s，那时候我们面临的一个很大的技术问题是Timeline列表的UI性能问题，由于用户输入的内容都比较复杂，有文字，图片，表情，关键字，短连接等，因此在UI的呈现上也比较复杂。

我们当时使用的文字排版引擎是CoreText，CoreText虽然能解决各种元素混排的问题，但是其性能却非常一般，实时绘制的成本很高，直观感受就是列表滚动起来很卡。随后我们进行了一系列的优化，最后的结果是将整个绘制过程都分离到了另一个线程中，具体来说就是我们在一个后台线程开辟了一块内存，创建了一个`CGContextRef`，用这个context完成对attributedString的绘制(CoreText API是线程安全的)，生成一张bitmap，然后在主线程中将这个bitmap作为layer的backing store，直接显示出来。

这种方式最终极大的提升了UI性能，因为主线程不再做任何CPU相关的计算了，GPU面对的也是"a single texture"，节省了compositing的过程。

当我们将这种技术实践了一段时间后，我们开始想能否将它抽象一下，用到其它View的渲染上，原因是当时iPhone5已经出了，iPhone4开始变少，这意味着多核的时代来临了，我们可以充分利用CPU的性能完成更多并发的绘制。当我把这个想法说出来的时候，立刻得到了另一个同事的响应，于是我们找了个周末，在西溪的一个茶馆里，开始研究异步绘制，思路和我们上面提到的类似，只不过针对View，我们使用了`layer.renderInContext(ctx)`的方式，将所有的SubView绘制成一张bitmap。然后我们将绘制好的bitmap放到memory cache里。

这个方法居然work了，demo中我们极大的提高了UITableView的性能。当时我们均感到十分兴奋，因为我们相当于重新定义了一套UIKit的渲染方式。

但是我们很快就遇到了一些难解的问题，比如View上元素的事件无法响应了（因为全变成layer了）；对于单核CPU的设备，这种大量的，高并发的，后台CPU运算，速度实在太慢，跟不上主线程的显式；`renderInContext`有时候线程不安全；生成过多的bitmap，消耗过多的内存等等。就在我们准备仔细思考这些问题时，团队突然解散了，项目失败了，各种变动导致我们最终放弃了对异步绘制的研究。后面，我抽了点时间将上面提到的内容汇总了一篇文章在[这里](http://akadealloc.github.io/blog/2013/07/12/custom-drawing.html)。

直到前几个月，看到了[AsyncDisplayKit](https://github.com/facebook/AsyncDisplayKit)，一看名字就猜到它是干嘛的了, 然后反反复复看了几遍[NSLondon](http://vimeo.com/103589245)以及[Paper](https://www.youtube.com/watch?v=OiY1cheLpmI&list=PLb0IAmt7-GS2sh8saWW4z8x2vo7puwgnR)上的Tech Talk，发现他们的思路和我上面提到的是一样的，也是在另一个线程中绘制bitmap，只是他们没有使用`renderInContext`。但是Facebook就是Facebook，他们花了1年的时间解决了我们当时遇到的所有的问题。

## NSLondon & Paper Tech Talk

相比POP, AS并没有引起人们很大的关注，原因一方面是现在的硬件设备强大了，无论是CPU的计算速度还是GPU的渲染能力都变强了，对于一些对帧率不敏感的App，不做优化也还算流畅。第二个原因是很多人根本不明白它究竟在解决什么问题，是干什么的，只有在这方面吃过苦，有过优化经验的人才明白它的价值。

对于AsyncDisplayKit的资料，公布出来的还并不是很多，主要是官网+两次Tech talk（一次是NSLondon，一次是Paper的发布会）。这一章主要是对两次Tech talk内容的部分摘录。

###Creative Labs

- Paper来自Facebook中一个叫做Creative Labs的团队
- 它是一个垂直的创新型团队
- Paper是第一个App


###ORIGAMI

- [ORIGAMI](https://facebook.github.io/origami/)使用了Quartz Composer，设计师可以在PC上做出一些很炫的效果。但是如何将这些效果在iOS上实现却成了难题。

- 单纯使用CoreAnimation是无法支撑Paper所需要的效果的，Paper花了1年的时间重新设计一个新的物理和GUI引擎，又花了1年在开发App上。


###CoreAnimation

- iOS7之前，像Paper这种，全是基于手势的App很少，多数都是以静态动画为主的App:

	- Static animations and basic tap handling have been easy and well-optimized.
	
	- Gestures usually discrete (buttons = taps).
	
	- Animations usually fire-and-forget, not interactive or interruptible
	
	- Think UINavigationController

- 对于Paper这种App，需要实时处理每一帧，对主线程的阻塞非常敏感。而CoreAnimation使用的Render Server是跨进程的，它对于处理静态的动画有着非常好的优化。 但是对于基于手势的连续的，实时的动画，使用跨进程的方式去渲染就会有性能问题。 为什么？

	- Discrete Gestures & Static Animations tolerate main thread stalls
	
	- Continuous Gestures & Dynamic Animations cannot
	
	- The CA Render Server is only effective with static animations
	
	- These new interactions must be implemented in-process
	
	- The OS scheduler is no longer able to keep animtions fluid
	
	- UIScrollView是个例子
	
- CoreAnimation的局限：

	- UIKit和CoreAnimation线程不安全
	
	- 被用来在主线程中使用，在其它线程创建`UIView`或`CALayer`都会引起crash
	
- 影响Main Thread的几个方面

	- Stalling the main thread for more than ~5ms will often cause a frame drop(when processing gestures or physical animations)

	- Work that frequently takes ~5ms or more
	
		- `-layoutSubviews/-layoutSublayers` when sizing text.
		
		- `-drawRect`: rendering all types of context(text,image,graphics).
		
		- UIView: `init/addSubview:/removeFromSuperView/dealloc`
	
	- System Objects: Create, Destroy, UIView musted be created on main thread
	
	
###AsyncDisplayKit
	
- 设计模型：

	- New object("node") wraps system classes
	
	- Nodes are thread safe
	
	- Marshal System objects for max performance
	
- 异步过程

	- 创建并layout node:
	
		```
		
		dispatch_async(queue,^{ node = [[FBNode alloc] initWithItem:item];
							    [node layoutRecuriey];});
		```
		
	- 绘制node:
	
		```
		
		- (void)display
		{
			dispatch_async(queue, ^{
			
				CGContextRef ctx = newContextOfSize(self.bounds.size);
				
				[self.node drawInContext:ctx];
			
				dispatch_async(main,^{self.contents = ctx})
			
			});
		
		}
		
		```
		
- 更多的优化

	- Layer-backing: 对于不需要响应Event的View，直接使用Layer
	
	- Subtree-preCompositing: 将View上面所有的subview都绘制成一个texture
	
- 并发的优势：

	- Asynchronous is necessary for smoothness
	
	- 80% of iOS device are dual-core
	
	- important concurrent operations:
	
		- Recursive UI layout(text sizing)
		
		- Rendering(text,images, graphics)


	
	

	

##AsyncDisplayKit入门

Raywenerlich上有一篇关于[使用AS的文章](http://www.raywenderlich.com/86365/asyncdisplaykit-tutorial-achieving-60-fps-scrolling)，是一篇不错的入门文章，包含了AS的一些常见用法




##深入理解AsyncDisplayKit

这部分是我对AS源码的分析






##Further Reading:

- [Paper Tech Talk](https://www.youtube.com/watch?v=OiY1cheLpmI&list=PLb0IAmt7-GS2sh8saWW4z8x2vo7puwgnR)
- [Paper]()
- [NSLondon]() 