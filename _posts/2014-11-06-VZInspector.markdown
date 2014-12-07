--- 
title: VZInspector
layout: post

---

<em>所有文章均为作者原创，转载请注明出处</em>

##VZInspector

[VZInspector](https://github.com/akaDealloc/VZInspector) 是一个可以在App内部运行的debugger，功能类似Instrument，可以监测App在运行时的状态信息。最开始在项目中运用，得到了测试和服务端开发人员的一致好评，因此我决定将它从业务中剥离出来，希望可以复用到每个独立的工程中。

<ul style="list-style:none;">
	<li><img src="/blog/images/2014/12/vzi_1.png" alt="vzi_1.png" style="float: left; display:inline-block; width:45%;margin: 5px 5% 10px 0;"></li>
	<li> <img src="/blog/images/2014/12/vzi_2.png" alt="vzi_2.png" style="float: left; display:inline-block; width:45%;margin: 5px 0 10px 0;"></li>
	<li> <img src="/blog/images/2014/12/vzi_3.png" alt="vzi_3.png" style="float: left; display:inline-block; width:45%; margin: 5px 5% 10px 0;"></li>
	<li> <img src="/blog/images/2014/12/vzi_4.png" alt="vzi_4.png" style="float: left; display:inline-block; width:45%; margin: 5px 0 10px 0;"></li>
</ul>



<p style="clear: both; margin-bottom:20px;"></p>
##Features：

### 全局状态

- 内存状态：

![Alt text](/blog/images/2014/12/vzi_memory.png)

如图所示，我们可以通过内存的起伏来判断页面消耗内存的情况，以及判断是否存在内存泄露。

具体做法可以参考之前的[这篇文章](http://akadealloc.github.io/blog/2012/07/11/Debuging-Memory-Issues-2.html)。

- 网络请求状态

![Alt text](/blog/images/2014/12/vzi_network.png)

如图所示，如果界面有网络请求，便会出现一个峰值。

通过这个功能，测试人员可以脱离代码，快速了解到每个页面的网络请求状况。

右上角会累计所有的HTTP请求的response字节数。便于评估一段时间的操作大概会产生多少流量。

- 全局变量状态值

![Alt text](/blog/images/2014/12/vzi_overview.png)

如图所示，App可以通过VZInspector提供的接口来实时监控一些重要的全局数据状态。比如，地理位置，用户名，版本号等一些业务相关的信息。

这个功能通常用在App出了问题，电脑又不在旁边时，可以先查看一下全局变量的状态值来初步定位问题。

一个案例是，一次在饭店吃饭的过程中，打开APP发现数据有问题，通过查看全局的地理位置状态发现了是手机定位的问题。

### Log

- Request Log:

![Alt text](/blog/images/2014/12/vzi_request_log.png)

如图所示，我们可以在App内部实时抓取HTTP请求中的参数。

这个功能的用处很多，实际项目中主要有两方面：

(1) 在App出了问题，电脑又不在旁边时，我们可以先查看网络请求的参数是否正确

(2) 服务端的开发人员可以通过这个功能来Debug自己的接口，来查看UI展示是否正确


- Response Log:

![Alt text](/blog/images/2014/12/vzi_response_log.png)

如图所示，我们可以在App内部实时抓取HTTP请求的返回值。

这个功能和上面的功能通常一起使用，便于在无法调试时定位是数据接口问题还是App的问题。


### 命令行

命令行这个功能非常强大，我们可以通过输入一些命令来获取我们想要的结果。


- 查询Crash日志：

命令为: `show_crashes`

通常情况下，我们在脱离调试环境时发生crash都无法及时查找原因。VZInspector会拦截crash产生的exception并将内容按照时间戳保存到本地的沙盒中，便于及时查看，如图：

![Alt text](/blog/images/2014/12/vzi_crashes.png)


- 查询Heap中仍然存活的object:

命令为: `show_heap`

这个功能类似于Instrument中的allocation，可以通过过滤类名前缀查看当前heap上活跃的object，从而可以判断出哪些对象没有被释放。如图：

![Alt text](/blog/images/2014/12/vzi_heap.png)

- 查询沙盒文件:

命令为: `show_sandbox`

这个功能可以实时查询沙盒内的文件:

![Alt text](/blog/images/2014/12/vzi_sandbox.png)

除了这几个功能外，VZInspector的命令行还具备如下功能:

- `mw on/off` : 这个功能可以在App内部每隔1s触发一次低内存警告。

- `show_grid` : 当前界面栅格化，方便设计师查看元素对其情况

- `show_border`: 会拦截点击时间，并将其应用在响应的View上，会实时标红响应View的边框。


### 环境切换

通常一个项目中会有多套开发环境，比如开发环境，预发布环境和正式环境。VZInspector会提供接口，注入业务代码的规则，实现在App内部即时切换环境。省去重复编译代码的时间。如图:

![Alt text](/blog/images/2014/12/vzi_setting.png)


##用法

在AppDelegate或者其它全局初始化方法中加入:

```objc

 #if DEBUG
    //业务类的前缀
    [VZInspector setClassPrefixName:@"VZ"];
    //是否要记录crash日志到本地
    [VZInspector setShouldHandleCrash:true];
    //全局变量信息回调
    [VZInspector setObserveCallback:^NSString *{
       
        NSString* v = [NSString stringWithFormat:@"System Ver:%@\n",[UIDevice currentDevice].systemVersion];
        NSString* n = [NSString stringWithFormat:@"System Name:%@\n",[UIDevice currentDevice].systemName];
        
        NSString* ret = [v stringByAppendingString:n];
       
        return ret;
    }];
    //在状态栏显示VZInspector入口
    [VZInspector showOnStatusBar];
 #endif

```

###注意：

VZInpsector的大部分功能是独立的，但是有一些功能是依赖Vizzle的，关于Vizzle请参考[这篇文章](http://akadealloc.github.io/blog/2014/09/15/Vizzle.html)


##小结

随着业务不断复杂，项目的不断迭代，代码不断增长，血多代码执行细节变的难以把控。我们需要一些手段来对App做这样的监控，和调试。同样随着挑战的不断增加，VZInspector会持续集成一些实用的功能进来，越来越强大。

That‘s all