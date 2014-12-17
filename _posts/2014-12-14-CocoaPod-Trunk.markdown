---
layout: post
title: Submit Cocoapod using Trunk

---

<em>所有文章均为作者原创，转载请注明出处</em>

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