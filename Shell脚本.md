# Shell脚本

## Linux Shell 获取参数的方法

### **传参用法**

Linux Shell 如何获取参数的方法：

- $#   传给脚本的参数个数
- $0   脚本本身的名字
- $1   传递给该shell脚本的第一个参数
- $2   传递给该shell脚本的第二个参数
- $@  传递给脚本的所有参数的列表
- $*    以一个单字符串显示所有向脚本传递的参数，与位置变量不同，参数可超过9个
- $$    脚本运行的当前进程ID号
- $?    显示最后命令的退出状态，0表示没有错误，其他表示有错误

与Makefile文件，不同：

- $@   表示目标文件
- $<     表示第一个依赖文件
- $^     表示所有的依赖文件
- $?    表示比目标还要新的依赖文件列表

![image-20240324220236419](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324220236419.png)

![image-20240324220253571](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324220253571.png)

![image-20240324220426826](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324220426826.png)

![image-20240324205608580](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324205608580.png)

### $\$@\ 和\ \$*$

#### 相同点

都是引用参数

#### 不同点

\$@ 和 \$* 都表示传递给函数或脚本的所有参数，不被双引号(" ")包含时，都以"\$1"、"\$2"、"\$3"......."\$n" 的形式输出所有参数。

当它们被双引号(" ")包含时，"\$*" 会将所有的参数作为一个整体，以"\$1 \$2 …\$n"的形式输出所有参数；

"\$@" 会将各个参数分开，以"\$1" "\$2" … "\$n" 的形式输出所有参数。[Linux就该这么学](https://www.linuxprobe.com/)
新建file.sh，写入以下内容：

![image-20240324213521129](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324213521129.png)

![image-20240324214112543](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324214112543.png)

![image-20240324214308889](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324214308889.png)

![image-20240324214319487](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324214319487.png)







## Bash 双引号和单引号的区别

Bash 没有数据类型的概念，所有变量值都是字符串。

### 1.字符串三种表示方式

Bash 使用过程中，经常会用双引号或单引号将字符串括起来，也可以不使用引号来定义字符串变量。

`s=testString     #无引号   `

`s='testString'   #单引号     `

`s="testString"   #双引号`

因此字符串变量的定义有三种方式，分别是双引号、单引号和无引号。这三种方式有什么区别呢？单引号和双引号又有什么区别呢？

### 2.单引号

单引号是全引用，被单引号括起的内容不管是常量还是变量都不会发生替换。

也就是说**单引号定义字符串所见即所得**，将单引号内的内容输出，看到的是什么就会输出什么。

`var=dablelv `

`echo '$var'`

![image-20240324211142399](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324211142399.png)

![image-20240324211321939](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324211321939.png)

### 3.双引号

**双引号引用的内容，所见非所得**。如果内容中有命令、变量等，会先把变量、命令解析出结果，然后在输出最终内容。双引号是部分引用，被双引号括起的内容常量还是常量，变量则会发生替换，替换成变量内容。

![image-20240324211215933](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324211215933.png)

![image-20240324211349737](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324211349737.png)

### 4.无引号

不使用引号定义字符串时，字符串不能包含空白字符（如 Space 或 Tab），需要加引号。一般连续的字符串、数字、路径等可以不加引号。如果内容有命令、变量等，会先把变量、命令解析出结果，然后再输出最终内容。

![image-20240324211428131](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324211428131.png)

![image-20240324212352230](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324212352230.png)

### 5.反斜杠

反斜杠就像在单个字符周围加上单引号。反斜杠“转义”它之前放置的字符。

这意味着反斜杠后面的字符将失去其特殊含义（如果有）。

```text
abhishek@its-foss:~$ var=variable
abhishek@its-foss:~$ echo \var
var
abhishek@its-foss:~$ echo $var
variable
abhishek@its-foss:~$ echo \$var
$var
```

因为v没有特殊含义，echo \var只是打印var。另一方面，当它与 一起使用时，反斜杠转义了的特殊含义，因此它被打印为$var而不是 的值var。

#### **用反斜杠继续该行**

您会注意到反斜杠字符的另一种实际用途是在多行上继续执行单个命令。

当命令太长或命令组合时，您会看到一些网站使用反斜杠在多行中显示单个命令。这使命令/代码更具可读性。

以这个长命令为例。

```text
docker run --name server --network net -v html:/usr/share/nginx/html -v $PWD/custom-config.conf:/etc/nginx/nginx.conf -p 80:80 --restart on-failure -d nginx:latest
```

由于反斜杠，同一命令可以分解为多行。

```text
docker run --name server --network net \
-v html:/usr/share/nginx/html \
-v $PWD/custom-config.conf:/etc/nginx/nginx.conf \
-p 80:80 --restart on-failure -d nginx:latest
```

这是相同的命令，只是更容易理解一些。

#### **双引号内的反斜杠**

反斜杠是与美元符号和反引号一起保持其特殊含义的三个特殊字符之一。

这样，您可以使用反斜杠来转义美元符号、双引号和双引号中的反引号的特殊含义。

以下面的示例为例，其中$5被视为未声明的变量，因此它没有值。这就是为什么从echo 命令的输出中忽略它的原因。

```text
abhishek@its-foss:~$ echo "Meal costs $5.25"
Meal costs .25
```

要使用此 $ 而不被解释为变量的值，您必须使用 / 对其进行转义。

```text
abhishek@its-foss:~$ echo "Meal costs \$5.25"
Meal costs $5.25
```

在这里，反斜杠（\）被解释为它的超能力，这是为了逃避后续字符的特殊含义。

### 6.反引号

此列表中的最后一个是反引号，它具有特殊含义。它用于命令替换。

shell 具有此命令替换功能，其中指定的命令被替换为命令的输出。

在下面的示例中，`date` 被替换为 date 命令的输出，显示 Linux 系统的当前日期和时间。

```text
abhishek@its-foss:~$ echo The current date and time is `date`
The current date and time is Monday 23 August 2021 04:55:18 PM IST
```

要记住的一件事是，只有在反引号之间有命令时才会进行替换，否则，将按原样显示。

```text
abhishek@its-foss:~$ echo 'The current date and time is `late`'
The current date and time is `late`
```

同样，双引号解释反引号，但单引号忽略其特殊含义。

#### **不再推荐反引号**

多年来，反引号用于 Shell 脚本中的命令替换，但是现在，现代 UNIX 和 Linux 系统更喜欢这种$(command)结构。

```text
abhishek@its-foss:~$ echo The current date and time is $(date)
The current date and time is Monday 23 August 2021 05:55:47 PM IST
```

与时俱进，现在停止使用反引号。

### 7.建议

字符串常量使用单引号括起来，如果字符串含有变量、命令等使用双引号括起来，不建议不加引号。

## Shell 自定义函数

### 基本语法

![image-20240324215511942](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324215511942.png)

### 1.函数定义

![image-20240324220922494](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324220922494.png)

![image-20240324220943602](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324220943602.png)

### 2.函数变量

![image-20240324221006754](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221006754.png)

![image-20240324221037448](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221037448.png)

![image-20240324221054929](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221054929.png)

### 3.函数调用

![image-20240324221128231](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221128231.png)

![image-20240324221211794](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221211794.png)

### 4.函数传参

![image-20240324221252910](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221252910.png)

![image-20240324221316566](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221316566.png)

![image-20240324221339794](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221339794.png)

### 5.函数返回值

![image-20240324221402613](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221402613.png)

![image-20240324221418326](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221418326.png)

![image-20240324221433539](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221433539.png)

![image-20240324221458003](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324221458003.png)

![image-20240324222123680](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222123680.png)

### 6.函数返回值

Shell函数返回值，常用的两种方式：return、echo。

![image-20240324222234361](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222234361.png)

![image-20240324222327262](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222327262.png)

![image-20240324222345210](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222345210.png)

![image-20240324222405416](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222405416.png)

![image-20240324222422718](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222422718.png)

![image-20240324222445062](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222445062.png)

![image-20240324222539571](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222539571.png)

### 7.获取函数返回值

![image-20240324222618009](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222618009.png)

![image-20240324222644980](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324222644980.png)

## Linux Shell 编程之 for循环语句 if条件语句

![image-20240324223412460](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324223412460.png)

### **shell条件判断语句：if**

![image-20240324223947825](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324223947825.png)

![image-20240324224012095](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224012095.png)

![image-20240324224036560](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224036560.png)

![image-20240324224053120](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224053120.png)

![image-20240324224107657](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224107657.png)

![image-20240324224132944](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224132944.png)

![image-20240324224145764](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224145764.png)

### **shell循环结构语句**

![image-20240324224207199](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224207199.png)

![image-20240324224243690](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224243690.png)

![image-20240324224509506](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224509506.png)

![image-20240324224535403](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224535403.png)

![image-20240324224604707](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224604707.png)

![image-20240324224622291](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224622291.png)

## Linux Shell中的case语句

![image-20240324224849363](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224849363.png)

- 如果 expression 和某个模式（比如 pattern2）匹配成功，就会执行这模式（比如 pattern2）后面对应的所有语句（该语句可以有一条，也可以有多条），直到遇见双分号;;才停止；然后整个 case 语句就执行完了，程序会跳出整个 case 语句，执行 esac 后面的其它语句。
- 如果 expression 没有匹配到任何一个模式，那么就执行*)后面的语句（*表示其它所有值），直到遇见双分号;;或者esac才结束。*)相当于多个 if 分支语句中最后的 else 部分

![image-20240324224924966](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224924966.png)

![image-20240324224941293](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324224941293.png)

上面的代码是 case in 最常见的用法，即 expression 部分是一个变量，pattern 部分是一个数字或者表达式

![image-20240324225016824](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324225016824.png)

![image-20240324225030266](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324225030266.png)

![image-20240324225048319](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324225048319.png)

## shell 中各种括号的作用()、(())、[]、[[]]、{}









## Bash技巧：详解用$获取变量值是否要加双引号或大括号

### 用 $ 获取变量值是否要加双引号

在 bash shell 脚本中，用 `$` 来获取变量值时，有一些不加双引号，例如 `$arg`。有一些会加双引号，例如 `"$arg"`。
下面具体说明这两种形式之间的区别，什么情况下要加双引号，什么情况可以不加双引号。

在 bash 中，各个参数之间默认用隔开。
当参数值本身就带有空格时，如果不加双引号把参数值括起来，那么这个参数值可能会被扩展为多个参数值，而丢失原本的完整值。
具体举例说明如下：

```bash
$ function test_args() { echo \$\#: $#; echo first: $1; echo second: $2; }
$ args="This is a Test"
$ test_args $args
$#: 4
first: This
second: is
$ test_args "$args"
$#: 1
first: This is a Test
second:
```

这里定义了一个 *test_args* 函数，打印传入的 `$1`、`$2` 参数值。
所给的 *args* 变量指定的字符串含有空格。

可以看到，当执行 `test_args $args` 时，args 变量的值被空格隔开成四个参数。
而执行 `test_args "$args"` 时，args 变量的值保持不变，被当成一个参数。
使用双引号把字符串括起来，可以避免空格导致单词拆分。

**即，当我们需要保持变量本身值的完整，不想被空格扩展为多个参数，那么就需要用双引号括起来**。

在给脚本或函数传递参数时，我们可能不确定获取到的参数值是否带有空格。
为了避免带有空格导致不预期的单词拆分，造成参数个数发生变化，建议传参时每个参数都使用双引号括起来。

### 用 $ 获取变量值是否要加大括号

在 bash shell 脚本中，用 `$` 来获取变量值时，有一些不加大括号，例如 `$var`。有一些会加大括号，例如 `${var}`。
下面具体说明这两种形式之间的区别，什么情况下要加大括号，什么情况可以不加大括号。

查看 man bash 里面对 `${parameter}` 表达式的含义说明如下：

> **${parameter}**
> The value of parameter is substituted.
> The braces are required when parameter is a positional parameter with more than one digit, or when parameter is followed by a character which is not to be interpreted as part of its name.
> The parameter is a shell parameter or an array reference (Arrays).

即，大括号 `{}` 的作用是限定大括号里面的字符串是一个整体，不会跟相邻的字符组合成其他含义。

例如，有一个 var 变量值是 "Say"，现在想打印这个变量值，并跟着打印 "Hello" 字符串，也就是打印出来 "SayHello" 字符串。
那么获取 var 变量值的语句和 "Hello" 字符串中间就不能有空格，否则 *echo* 命令会把这个空格一起打印出来。
但是写为 `$varHello` 达不到想要的效果。
具体举例如下：

```bash
$ var="Say"
$ echo $var Hello
Say Hello
$ echo $varHello

$ echo ${var}Hello
SayHello
$ echo "$var"Hello
SayHello
```

可以看到，`$var Hello` 这种写法打印出来的 "Say" 和 "Hello" 中间有空格，不是想要的结果。
而 `$varHello` 打印为空，这其实是获取 varHello 变量的值，这个变量没有定义过，默认值是空。
`${var}Hello` 打印出了想要的结果，用 `{}` 把 var 括起来，明确指定要获取的变量名是 var，避免混淆。
`"$var"Hello` 用双引号把 `$var` 括起来，也可以跟后面的 "Hello" 字符串区分开。

即，当用 `$` 获取变量值时，如果变量名后面跟着空白字符，隔开了其他内容，可以不用大括号来把变量名括起来。

**如果变量名后面直接跟着不属于变量名自身的其他字符，就需要用大括号把变量名括起来，以便明确该变量的名称**。

## Bash编程中，变量“用双引号”和“不用双引号”的区别

### 变量用双引号括起来的意义

如果变量不用双引号括起来，比如echo \$a，那么隐含的意义就是，把\$a变量的字符串，按照空格、制表符、换行符等符号来分割开。然后把这些分割后的每一项再按 glob 模式展开，最后把这些值，再用一个空格重新连接起来，并打印出来。
如果碰巧\$a变量的字符串中，有连续两个空格符号，或者有制表符，那么echo $a就与程序员的思路出现了不一致。比如下例：

```bash
qilei@AFAAW-704030720:~$ cat a.sh
#!/bin/bash

a="1 2  3 4"
echo $a
echo "$a"

qilei@AFAAW-704030720:~$ ./a.sh
1 2 3 4
1 2  3 4
qilei@AFAAW-704030720:~$
```

### 推荐今后编程中，变量必须用双引号括起来

bash编程里的变量，全部用双引号括起来。这样更符合程序员的思路。
比如echo "$a"
举一反三，脚本命令的参数变量，也是同理的。

### 附加echo的简单说明

如下例所示，
echo -n 字符串；其中选项n表示输出文字后不换行。
echo -e 字符串；才能使用转义符号\。

```bash
qilei@AFAAW-704030720:~$ echo "\n"
\n
qilei@AFAAW-704030720:~$ echo -e "\n"


qilei@AFAAW-704030720:~$ echo -ne "\n"

qilei@AFAAW-704030720:~$
```

## Shell的RANDOM变量

shell有一个环境变量RANDOM,范围是0--32767

如果我们想要产生0-25范围内的数：$(($RANDOM%26))

在$(()) 是可以省略取值的$符号的。

（All tokens in the expression undergo parameter expansion, string expansion, command substitu-tion, and quote removal.）

用这个环境变量对26取模即可。

如果想得到1--68范围内的数 ： $(($RANDOM%68+1 ))

如果想得到6--87范围内的数 ： $(($RANDOM%82+6 ))

Awk传递变量：awk 'BEGIN{srand();print rand()}'

## Linux Shell 命令中nohup、&、重定向的使用

### 一、nohup 和 & 使用方法

#### 1.1 nohup（不挂断）

`nohup` 是 no hung up 的缩写，意思是不挂断 。

使用 [Xshell](https://so.csdn.net/so/search?q=Xshell&spm=1001.2101.3001.7020) 等Linux 客户端工具，远程执行 Linux 脚本时，有时候会由于网络问题，导致客户端失去连接，终端断开，脚本运行一半就意外结束了。这种时候，就可以用`nohup` 指令来运行指令，即使客户端与服务端断开，服务端的脚本仍可继续运行。

nohup 语法格式：

```shell
nohup  command  [arg...]
```

**说明：**

- 除了无法进行输入操作（比如输入命令、换行、打空格等） 外 ，
- 标准输出 保存到 `nohup.out`文件中。
- 关闭客户端后，命令仍然会运行，**不会挂断**。

**例如：**

执行 `nohup sh test.sh` 脚本命令后，终端不能接收任何输入，标准输出 会输出到当前目录的`nohup.out` 文件。即使关闭xshell 退出后，当前session依然继续运行。

#### 1.2 &（可交互）

& 语法格式：

```shell
command   [arg...]   &
```

**说明：**

- 能进行输入操作（比如输入命令、换行、打空格等），即 **可进行交互** 输入和输出的操作。
- 标准输出 保存到 `nohup.out`文件中。
- 但是 关闭客户端后，**程序会就马上停止**。

**例如：**

执行 `sh test.sh &` 脚本命令后 ，关闭 xshell，脚本程序也立刻停止。

#### 1.3 nohup 和 & 一块使用（不挂断，可交互）

语法格式：

```
nohup   command  [arg...]  &
```

说明：

能进行输入操作（比如输入命令、换行、打空格等），即 可进行交互 输入和输出的操作，
标准输出 保存到 nohup.out 中，
关闭客户端后命令仍然会运行。
例子：
执行 nohup sh test.sh & 命令后，能进行输入操作，标准输出 的日志写入到 nohup.out 文件，即使关闭xshell，退出当前session后，脚本命令依然继续运行。

### 二、日志的重定向  >

上面提到的日志文件默认名称是 `nohup.out` ，如果修改日志文件的名称，则用到 **`重定向`** ，符号是 **`>`** ，语法格式是

```shell
 > logFile
```

说明：

- **`>`** 是重定向的符号。
- logFile 是日志文件名称，最好是英文、数字。

此时， `nohup`、 `&` 、 `>` 三者一块使用的 **语法格式** ：

```shell
nohup  command >logFile  &
```

示例：

```shell
nohup  start.sh >aa.log  &
```

### 三、错误信息的处理

```shell
nohup  command >logFile  &
```

虽然解决输入输出，后台也能运行问题，但是还有一项是 **错误信息** 无法输出到 日志文件中，要解决这个问题，需要增加命令 `2 > file` 。

标准输出 和 错误信息 同时使用，语法格式如下：

```shell
>logFile1   2 >logFile2
```

#### 3.1、Linux 标准输入、输出、错误信息的符号

Linux 标准输入、输出、错误信息的符号：

- 0：表示stdin（standard input）标准信息输入
- 1：表示stdout（standard output）标准信息输出
- 2：表示stderr（standard error）错误信息
- /dev/null：表示空设备文件。如果不想输出任何的日志时，使用此参数

再来回顾上面的示例：

```shell
>logFile1   2 >logFile2
```

- `> logFile1` ：即 `1 >logFile1`，1是`标准信息输出`，是默认的，可以省略，logFile1是 日志文件名字。
- `2 >logFile2` ：2 是`错误信息`，即将 `错误信息` 输出 到 logFile2 文件中 。

#### 3.2、错误信息 和 标准输出 输出在同一个文件中

如果想把 错误信息 和 标准输出 在同一个文件中 ，使用 `2>&1` 。 语法如下：

```shell
>logFile   2>&1
```

说明：

- `>logFile` 表示 标准信息 输出到 logFile 文件中；
- `2>&1` 表示 把 2（错误信息） 重定向， 输出到 1（标准输出） 中 。

两者的共同使用，表示 把 2（错误信息） 、1（标准输出） 都输出到同一个文件（logFile）中。

#### 3.3、思考：不想输出日志信息怎么办 ？

提示：`/dev/null `表示空设备文件。 如果不想输出任何的日志时，使用此参数 。

### 四、综合使用（推荐）

综上所述， 功能最全、推荐语法如下：

```shell
nohup  command  >logFile   2>&1  &
```

示例：

```shell
nohup  start.sh > mySysLog.log  2>&1   &
```

说明： 执行命令后，并且将 `标准输出(1)`、`错误信息(2) `写入到 mySysLog.log 文件中。

### 五、知识扩展

#### 5.1、不停止服务，直接清空nohup.out

如果脚本一直运行下去，nohup.out 日志会一直增长，但是硬盘容量有限，怎么把日志文件的大小减少 ？
注意，千万别直接删除日志文件，会造成服务无法输出日志，服务异常直接停止运行，这是最严重生产事故。

不停止服务，直接清空nohup.out文件有两种方法：

```shell
# 第1种：
cat /dev/null > nohup.out

# 第2种：
cp /dev/null nohup.out
```

#### 5.2、只记录警告级别比较高的日志

输出的日志太多，nohup.out 增长特别快，对于不重要的日记，可以不记录，选择只记录警告级别比较高的日志。

```shell
# 只输出错误信息到日志文件，其它日志不输出
nohup ./program > /dev/null   2>error.log  &
```

#### 5.3、不想输出日志

不想输出日志，什么日志都不要，只要服务能正常运行就行了。

```shell
# 什么日志也不输出
nohup ./program > /dev/null   2>&1   &
```

## Linux命令之重定向 >、 >>、 1>、 2>、 1>>、 2>>、 <

### 1.> 和 >>

这两个区别在于>是[重定向](https://so.csdn.net/so/search?q=重定向&spm=1001.2101.3001.7020)到一个文件，>>是追加内容到一个文件。如果文件不存在，那么这两个命令都会首先创建这个文件。

### 2.1> 和 2> 

他们两个用于将一个文件正确的输出，和错误的输出分开保存。

1> 将正确的输出重定向到某个文件

2> 将错误的输出重定向到某个文件

将错误输出和正确输出保存到同一个文件：

```shell
command 1> a.txt 2>&1
或者写作：command > a.txt 2>&1
```

### 3.1>> 和 2>>

同理1>> 2>>其实也就是追加数据到文件中，和前面介绍的>>没有什么不同，需要提到的一点是，如果我们想将错误的和正确的信息重定向追加到同一个文件应该怎么做呢？你可能会想到2>>&1。。。然而现实是，并没有这个语法。

然而我们却可以使用1 >> a.txt 2>&1的语法实现这个功能，比如：
```shell
command 1>> a.txt 2>&1
```

看似1> 1>> 2> 2>>是相一一对应的，但是其实不是，他们可以混用，比方说正确的结果想追加，错误的结果我想覆盖。

```shell
command 1>> right.txt 2> wrong.txt
```

如果我们想保存正确的结果，错误的结果直接丢向垃圾站，既不保存为文件，也不在标准输出打印又该怎么做呢？

```typescript
command 1>> right.txt 2> /dev/null
```

直接将错误输出重定向到/dev/null就好了，他好像就是一个无底洞，丢进去的东西就不见了。

### 4.<

< 可以将原本由标准输入改为由指定地方输入，比如下面

首先创建一个hh文件，里面写入hello world

然后执行 >> txt.py < hh

就可以把hh里面的内容写入到 txt.py







