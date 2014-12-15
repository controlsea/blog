---
layout: post
title: Deploy Rails

---

>更新于 2014/05/02

##Install RVM

- 安装rvm: 
	- `curl -L https://get.rvm.io | bash -s stable`
	
- 载入rvm环境:
	- `source ~/.rvm/scripts/rvm`
	
- 验证rvm是否安装成功:
	- `rvm -v`
	
##Install Ruby

- 安装ruby:
	
	- `rvm install 2.1.1`
	
- 指定默认ruby版本:

	- `rvm 2.1.1 --default`
	
- 验证ruby是否安装成功

	- `ruby -v`
	- `gem -v`
	
- 查看rvm默认的gemset:

	- `rvm gemset list`
		 	


##Install Rails

- 安装rails:
	
	- `gem install rails` 

	- rails会默认安装到global的gemset中
	
- 安装sqlite3:

	- `sudo apt-get install sqlite3`
	
	- `sudo apt-get install libsqlite3-dev `

	

##Install Passenger

- 安装passenger：

	- `gem install passenger `
	
- 安装nginx

	- `rvmsudo passenger-install-nginx-module`
	
##Config nginx
	
- 找到nginx的配置文件:
	
	- `vim /opt/nginx/conf`

- 配置rails:
	
```
http {
   passenger_root /Users/moxinxt/.rvm/gems/ruby-2.1.1@global/gems/passenger-4.0.55;
   passenger_ruby /Users/moxinxt/.rvm/gems/ruby-2.1.1/wrappers/ruby;

   include       mime.types;
   default_type  application/octet-stream;

   sendfile        on;
   keepalive_timeout  65;

   server {
       listen       2000;
       server_name  localhost;

       root /home/admin/vizline/vizline/public;
       passenger_enabled on;
       rails_env development;
   }
    
``` 


	
##Run nginx

- 启动nginx:
 
	- `sudo nginx` 

- 停止nginx:
	
	- `sudo nginx -s stop`
	
- 修改配置后重新reload：

	- `sudo nginx -s reload`
	
- 访问:

	- `http://localhost:2000`






