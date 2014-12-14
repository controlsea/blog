---
layout: post

---

<h3>HomeBrew和Gem</h3>

- HomeBrew

HomeBrew会将`/usr/local`初始化为git环境:

```
-bin          用于存放所安装程序的启动链接（相当于快捷方式）
-Cellar       所以brew安装的程序，都将以[程序名/版本号]存放于本目录下
-etc          brew安装程序的配置文件默认存放路径
-Library      Homebrew 系统自身文件夹
```

- Gem包路径：

使用`%gem environment`查看gem环境:

```
RubyGems Environment:
  - RUBYGEMS VERSION: 2.2.2
  - RUBY VERSION: 2.1.1 (2014-02-24 patchlevel 76) [x86_64-darwin13.0]
  - INSTALLATION DIRECTORY: /Users/xt/.rvm/gems/ruby-2.1.1
  - RUBY EXECUTABLE: /Users/xt/.rvm/rubies/ruby-2.1.1/bin/ruby
  - EXECUTABLE DIRECTORY: /Users/xt/.rvm/gems/ruby-2.1.1/bin
  - SPEC CACHE DIRECTORY: /Users/xt/.gem/specs
  - RUBYGEMS PLATFORMS:
    - ruby
    - x86_64-darwin-13
  - GEM PATHS:
     - /Users/xt/.rvm/gems/ruby-2.1.1
     - /Users/xt/.rvm/gems/ruby-2.1.1@global
  - GEM CONFIGURATION:
     - :update_sources => true
     - :verbose => true
     - :backtrace => false
     - :bulk_threshold => 1000
     - :sources => ["https://rubygems.org/"]
  - REMOTE SOURCES:
     - https://rubygems.org/
  - SHELL PATH:
     - /Users/xt/.rvm/gems/ruby-2.1.1/bin
     - /Users/xt/.rvm/gems/ruby-2.1.1@global/bin
     - /Users/xt/.rvm/rubies/ruby-2.1.1/bin
     - /Users/xt/.rvm/bin
     - /usr/local/heroku/bin
     - /usr/bin
     - /bin
     - /usr/sbin
     - /sbin
     - /usr/local/bin
     - /opt/X11/bin
```
如果不指定某个gemset，则gem默认将包装到这个gemset：

```
/Users/xt/.rvm/gems/ruby-2.1.1@global
```


<h3>RVM Command</h3>

rvm是ruby的版本管理工具，项目中可以通过rvm来创建多套gem环境。

- rvm路径：`~/.rvm`

- 管理ruby：

```
//rvm 管理的ruby斑斑
% rvm list

//使用系统ruby版本
% rvm use system

//使用rvm管理的default版本
% rvm use default
```

- 管理gemset

```
//创建gemset
% rvm gemset create xxx

//使用某个gemset
% rvm gemset use xxx

//查看所有的gemset
% rvm gemset list

```

[RVM官网](https://rvm.io/rvm/basics)

[Ruby China 关于RVM命令的介绍](https://ruby-china.org/wiki/rvm-guide)

<h3>解决10.9下cocoapods的bug</h3>

<a href="http://blog.cocoapods.org/Repairing-Our-Broken-Specs-Repository/">Answer</a>

<h3>使用appleDoc生成文档</h3>

<em>update @2013/11/16</em> 

- 首先代码注释要规范，通常以/**开头，以*/结尾。推荐xcode自动注释插件：<a href="https://github.com/onevcat/VVDocumenter-Xcode ">VVDocumenter</a>

- 从github上clone appleDoc工程：

```
git clone git://github.com/tomaz/appledoc.git
cd appledoc
sudo sh install-appledoc.sh
```

- 创建appleDoc的html文件，注意工程的绝对路径要带出来

```
appledoc --no-create-docset --output ./docNew --project-name xxx --project-company "xxx" --company-id "com.xxx.xxx" ~/Desktop/tbcity-mvc/xxx/Universal/Libraries/xxx/Core/
```


<h3>解决xcode找不到libtool问题</h3>

<em>update @2013/10/1 </em>

高版本的OSX，如果在app store上更新了Xcode，系统会把它当做普通的app，这个修改会导致和原来xcode的安装路径不一致。因此xcode会找到不到libtool。

解决办法：

将usr/bin/libtool考到xcode要求那个目录



<h3>NSString的hash问题</h3>

<em>update @2013/05/10 </em> 

我们知道如果两个object是equal的，那么他们的hash value一定相同。
但是hash value相同的两个object却不一定是equal的。

NSString就是个例子：

当string长度长度大于96个字符时，NSString会为其生成相同的hash value

http://www.abakia.de/blog/2012/12/05/nsstring-hash-is-bad/

这种情况可以用sha1算法代替


<h3>使用NSCache</h3>

<em>update @2012/12/5 </em> 

（1）当系统内存紧张时，NSCache会自动释放一些资源
（2）线程安全
（3）NSCache不会copy存入object的key

开源项目SDWebImage就是直接使用NSCache来缓存图片：

```objc
@interface SDImageCache ()

@property (strong, nonatomic) NSCache *memCache;
@property (strong, nonatomic) NSString *diskCachePath;
@property (SDDispatchQueueSetterSementics, nonatomic) dispatch_queue_t ioQueue;

@end
```

但实际项目中，为了查询方便，通常还会提供一个list来保存image的key，比如我个人的SDK中，image cache中还会增加一个keySet：

```c 
@interface ETImageCache()<NSCacheDelegate>
{
    //mutable keyset
    NSMutableSet* _keySet;
    
    //internal memory cache
    NSCache* _memCache;
    
    // an async write-only-lock
    dispatch_queue_t _lockQueue;
}
```

基本上使用NSCache可以解决大部分的问题：你可以尽情的向cache中塞图片，当内存不足时，你可以选择手动释放掉NSCache中所有图片，也可以默认NSCache自己的策略：根据LRU规则释放掉最不活跃的图片。当app退到后台时，NSCache会自动释放掉图片，腾出空间给其它app。



<h3>Objective-C中的copy</h3>


多数情况下，UIKit和Foundation对象的copy都是shallow copy（浅拷贝）。比如UIImage：

```objc
UIImage* img = [UIImage imageNamed:@"pic.jpg"];
UIImage* img_copy = [img copy];
NSLog(@"%p,%p,%p,%p",img,img_copy,&img,&img_copy);
```

结果为：
0xc135b90,0xc135b90,0xbfffedc0,0xbfffedbc

他们指向的heap地址是相同的，他们各自在stack上的地址是不同的，相差4字节。

mutableCopy也是shallow copy。



<h3>NSLog:C语言中的可变参数</h3>

<em>update @2012/07/05/</em>

NSLog的实现用到了C语言中的可变参数：

void NSLog(NSString *format, ...) 

我们可以自己实现一个NSLog：

 
```c
void mySBLog(NSString* format,...)
{
    va_list ap;
    va_start(ap, format);
    NSString* string = [[NSString alloc]initWithFormat:format arguments:ap];
    va_end(ap);
    printf("!![SBLog]-->!!%s \n",[string UTF8String]);
}
```

###Linux/Mac OS下文件夹的含义

[Answer](http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)

