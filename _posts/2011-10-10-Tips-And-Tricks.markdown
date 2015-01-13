---
layout: post

---

<em>所有文章均为作者原创，转载请注明出处</em>
  
<h3>使用Trunk提交cocoaPods</h3>

2014年5月20日之后，cocoaPods不再接受pull Request的提交方式，而转为用[trunk](http://blog.cocoapods.org/CocoaPods-Trunk/)。使用trunk需要cocoapods的版本大于0.33。

- 注册trunk:
  
  - 命令为: `pod trunk register orta@cocoapods.org 'Orta Therox' --description='macbook air'`

  - 例子: `pod trunk register jayson.xu@foxmail.com 'jayson' --verbose`

  - 注册成功后,会返回下面信息:

  ```
  [!] Please verify the session by clicking the link in the verification email that has been sent to jayson.xu@foxmail.com
  ``` 

- 在邮箱激活trunk

- 查看注册信息:

  - `pod trunk me`

- 提交pod:

  - 在podsepc的目录下: `pod trunk push`

  - 成功后回返回podspec的json格式的url

<h3>查看RSA的FingerPrint</h3>

```
ssh-keygen -l -f rsa_key.pub
```

<h3>Mac OS 卸载 MySQL</h3>

```
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/mysql*
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
vim /etc/hostconfig  (and removed the line MYSQLCOM=-YES-)
rm -rf ~/Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /var/db/receipts/com.mysql.*

```

<h3>Rake Commands</h3>

[Answer](http://jonathanhui.com/rake-command)

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

- 当系统内存紧张时，NSCache会自动释放一些资源
- 线程安全
- NSCache不会copy存入object的key

开源项目SDWebImage就是直接使用NSCache来缓存图片：

```objc
@interface SDImageCache ()

@property (strong, nonatomic) NSCache *memCache;
@property (strong, nonatomic) NSString *diskCachePath;
@property (SDDispatchQueueSetterSementics, nonatomic) dispatch_queue_t ioQueue;

@end
```

但实际项目中，为了查询方便，通常还会提供一个list来保存image的key:

```objc

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


UIKit和Foundation对象的copy都是shallow copy（浅拷贝）。比如UIImage：

```objc
UIImage* img = [UIImage imageNamed:@"pic.jpg"];
UIImage* img_copy = [img copy];
NSLog(@"%p,%p,%p,%p",img,img_copy,&img,&img_copy);
```

结果为：

```
0xc135b90,0xc135b90,0xbfffedc0,0xbfffedbc
```

他们指向的heap地址是相同的，他们各自在stack上的地址是不同的，相差4字节。

`mutableCopy`也是`shallow copy`。

对于自定义对象，比如`ETSomeItem:NSObject`，这种对象要实现`<NSCopy>`，对这种对象的`copy`操作为`deep copy`

###NSNull和Nil

```objc

NSString* null = [NSString stringWithFormat:@"%@",[NSNull null]];
NSString* nill = [NSString stringWithFormat:@"%@",nil];

```
输出为：

- `"<null>"`

- `"(null)"`

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

###改变Git Repo的作者和email

- `cd proj`

- `git config user.name "jack"`

- `git config user.email "jack@gmail.com"`

查看全局的git账户信息:

- `git config --global user.name`

- `git config --global user.email`





