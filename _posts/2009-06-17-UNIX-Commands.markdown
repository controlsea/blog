---
layout: post

---

<em>所有文章均为作者原创，转载请注明出处</em>

##使用GCC##

.c编译完成后会生成.o文件，多个.o文件和一些lib，一起link得到可执行文件，下面是GCC的一些编译选项：

- gcc：直接执行% gcc  main.c 会得到 一个 a.out的可执行二进制文件。运行时需要带路径：% ./a.out

-  -c : 生成目标文件.o。例如得到main.o：

```
% gcc -c main.c
```

使用<code>nm main.o</code>

可以看到文件内容

- -o : 生成可执行文件。例如得到可执行文件p：

<code> % gcc -o p main.o module1.o module2.o </code>

<code> % gcc -o p main.o module1.c module2.c </code>

- -g : 编译器在输出文件中包含debug信息。例如:<code> % gcc -g main.c</code>

- -Wall:编译器编译时打出warning信息,强烈推荐使用这个选项。例如:<code> % gcc -Wall main.c</code>

- -I<em>dir</em>: 除了在main.c当前目录和系统默认目录中寻找.h外，还在dir目录寻找，注意，dir是一个绝对路径。

例如：<code> % gcc main.o ./dir/module.o -o p </code>



下面我们看一个完整的例子：

----./test/main.c , main.h  ,  module_1.h  ,  module_1.c  

----./test/ext/module_2.h  ,  module_2.c

main.h : 

```c 
 #include <stdio.h>;

int main(void);

```

main.c:

```c

 #include "main.h" 
 #include "module_1.h"
 #include "module_2.h"

int  main(void)
{
	printf("hello world");
	
	int ret1 = module_1_Func(100,20); 
	printf("\n%d\n",ret1);
	
        int ret2 = module_2_Func(200,100);
	printf("\n%d\n",ret2);
	

	return 0;
}
```

下面我们要编译出main.c的可执行文件p：

- 使用-o选项，一行搞定：

<code> % gcc -o p main.c module_1.c ./ext/module_2.c -I./ext </code>

- 先单独编译成.o，在link

	- <code> % gcc -c module_1.c </code>生成module_1.o

	- <code> % cd ./ext	% gcc -c module_2.c </code>生成module_2.o

	- <code> % gcc -c main.c -I./ext </code>生成main.o

	- <code> % gcc -o p main.o module_1.o ./ext/module_2.o </code>生成p


##使用Makefile##

当一个工程很大，有很多文件时，使用gcc去编译就局限了。这个时候通常使用makefile，makefile中，需要把这些文件组织到一起。
makefile是一个纯文本文件，实际上它就是一个shell脚本，并且对大小写敏感，里面定义一些变量。重要的变量有三个：

- CC ： 编译器名称

- CFLAGS ： 编译参数，也就是上面提到的gcc的编译选项。这个变量通常用来指定头文件的位置，常用的是-I, -g。

- LDFLAGS ：链接参数，告诉链接器lib的位置，常用的有-I,-L，

引用变量的形式是 : $(CC),$(CFLAGS),$(LDFLAGS)

例如：

<code> % gcc  main.c </code> 这样一条command在makefile中表达如下：

<code> $(CC) main.c </code>

例如：

<code> %gcc -g -I./ext -c main.c </code> 这样一条command在makefile中表达如下：

<code> CFLAGS = -g -I./ext </code>

<code> %(CC) $(CFLAGS) -c main.c </code>

一个简单的makefile：

```
CC = gcc
main:main.c main.h
        $(CC) main.c
```

必须要包含这三部分

main.o: main.c main.h

这句话的意思是main.o必须由main.c，main.h来生成

`$(CC)main.c`

是shell命令，前面必须加tab

针对上面的例子，我们可以写一个makefile 文件


```
C = gcc
CFLAGS = -g -I./ext/

PROG = p
HDRS = main.h module_1.h ./ext/module_2.h
SRCS = main.c module_1.c ./ext/module_2.c

$(PROG) : main.h main.c module_1.h ./ext/module_2.h
	$(CC) -o $(PROG) $(SRCS) $(CFLAGS)

```


<h3>Further Reading:</h3>

- <a href="http://cslibrary.stanford.edu/107/UnixProgrammingTools.pdf">UNIX Programming Tools</a>

- <a href="https://www.google.com.hk/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&ved=0CC4QFjAB&url=%68%74%74%70%3a%2f%2f%66%6c%79%66%65%65%6c%2e%67%6f%6f%67%6c%65%63%6f%64%65%2e%63%6f%6d%2f%66%69%6c%65%73%2f%48%6f%77%25%32%30%74%6f%25%32%30%57%72%69%74%65%25%32%30%6d%61%6b%65%66%69%6c%65%2e%70%64%66&ei=DycDU9blG-TUigeM04GwAg&usg=AFQjCNGR312P8_ZhYaJaGVLK_7R6pgkSRA">陈皓：跟我一起学makefile</a>