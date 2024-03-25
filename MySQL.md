# MySQL

## MySQL之启动选项

![image-20240324135112445](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324135112445.png)

![image-20240324135125198](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324135125198.png)

![image-20240324134545952](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324134545952.png)

![image-20240324135234392](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324135234392.png)

![image-20240324135446300](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324135446300.png)

![image-20240324135502894](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324135502894.png)

![image-20240324135519074](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324135519074.png)

![image-20240324135605028](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324135605028.png)

![image-20240324135638676](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324135638676.png)

mysqld_safe程序启动服务端程序时，会调用mysqld，如果使用 mysqld_safe 命令时带的选项，mysqld_safe 处理不了，将交给 mysqld 处理，

例如 `msyqld_safe --skip-networking` ， --skip-networking 将交给 mysqld 处理。

![image-20240324135811209](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324135811209.png)

1. 在配置文件中的，选项明必须是长形式，不可以写成短形式
2. 配置文件中的启动选项不可以加--前缀，并且每行只能有一个选项
3. =等号周围可以有空白字符，命令行中是不可以有的
4. 配置文件中，可以使用#号作为注释

不同的选项做提供给不同的程序使用，如果选项组的名称与程序相同，那么组中的选项将专门用于该程序。

1. [mysqld]和[mysql]组专门应用于mysqld服务器程序和mysql客户端程序
2. [server]组与[client]组较为特别，前者的启动项用于所有的服务端程序，后者的启动项用于所有的客户端程序

![image-20240324140011242](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324140011242.png)

![image-20240324140042527](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324140042527.png)

## 存储引擎

### **MySQL体系结构**

![img](https://img2024.cnblogs.com/blog/1020574/202403/1020574-20240319215047945-1713294539.png)

- 连接层：最上层是一些客户端和链接服务，主要完成一些类似于连接处理、授权认证、及相关的安全方案。服务器也会为安全接入的每个客户端验证它所具有的操作权限。
- 服务层：第二层架构主要完成大多数的核心服务功能，如SQL接口，并完成缓存的查询，SQL的分析和优化，部分内置函数的执行。所有跨存储引擎的功能也在这一层实现，如 过程、函数等。
- 引擎层：存储引擎真正的负责了MvSOL中数据的存储和提取，服务器通过AP和存储引擎进行通信。不同的存储引擎具有不同的功能，这样我们可以根据自己的需要，来选取合适的存储引擎。
- 存储层：主要是将数据存储在文件系统之上，并完成与存储引擎的交互。

### **存储引擎简介**

存储引擎就是存储数据、建立索引、更新/查询数据等技术的实现方式。存储引擎是**基于表而不是基于库**的，所以存储引擎也可以被称为表类型。

**默认存储引擎是InnoDB。**

![image-20240324140525562](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324140525562.png)

### **存储引擎的特点**

![image-20240324140609160](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324140609160.png)

#### InnoDB

![image-20240324140647180](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324140647180.png)

![image-20240324140659460](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324140659460.png)

#### MyISAM

![image-20240324140723708](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324140723708.png)

#### Memory

![image-20240324140747832](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324140747832.png)

### **怎么选择存储引擎**

在选择存储引擎时，应该根据应用系统的特点选择合适的存储引擎。对于复杂的应用系统，还可以根据实际情况选择多种存储引擎进行组合。

- InnoDB: 如果应用对事物的完整性有比较高的要求，在并发条件下要求数据的一致性，数据操作除了插入和查询之外，还包含很多的更新、删除操作，则 InnoDB 是比较合适的选择
- MyISAM: 如果应用是以读操作和插入操作为主，只有很少的更新和删除操作，并且对事务的完整性、并发性要求不高，那这个存储引擎是非常合适的。
- Memory: 将所有数据保存在内存中，访问速度快，通常用于临时表及缓存。Memory 的缺陷是对表的大小有限制，太大的表无法缓存在内存中，而且无法保障数据的安全性

电商中的足迹和评论适合使用 MyISAM 引擎，缓存适合使用 Memory 引擎。

## Linux-Ubuntu安装和配置MySQL

MySQL 是最常见的开源关系数据库管理系统 (RDBMS) 之一，它基于结构化查询语言 (SQL)，这是一种用于管理数据库中保存的数据的编程语言。

### 要求

你将需要在系统上拥有提升的权限 (root)。你可以通过执行以下命令来执行此操作。

```
sudo su
```

### 程序

本文中选择的 Ubuntu 版本是 Ubuntu 20.04 LTS，使用 MySQL Linux 版本是 5.7 版做示例。要开始安装，请按照以下步骤操作：

### **步骤 1)**

确保系统中的所有软件包和存储库都是最新的。你可以通过运行以下命令来执行此操作：

```text
sudo apt update
```

![image-20240324161706590](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324161706590.png)

### **步骤 2)**

现在，我们将通过 apt 包管理器安装 MySQL。执行下面的命令。

```text
sudo apt install mysql-server
```

![image-20240324161749319](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324161749319.png)

### **步骤 3)**

安装成功后，mysql-service 应该会自动启动。你可以通过执行以下命令来确认：

```text
sudo systemctl mysql-server
```

你应该得到与下图类似的输出。

![image-20240324161855612](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324161855612.png)

在服务未运行的任何情况下，请执行以下命令：

```text
sudo /etc/init.d/mysql start
```

### 验证 MySQL 安装

你可以通过运行以下命令来验证安装结果，该命令将输出系统中所安装的 MySQL 版本和发行版。

```text
mysql --version
```

![image-20240324161939240](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324161939240.png)

### 保护MySQL数据库

既然 MySQL 数据库安装成功了，需要设置一些参数来保证以后配置的服务器和数据库的安全。

在其他情况下，MySQL 数据库包安装完成后，mysql-secure-installation 实用程序将自动启动。但是，如果你没有自动启动，可执行以下命令：

```text
sudo mysql_secure_installation
```

你将看到一个提示，询问你是否验证密码插件。它通过检查用户密码的强度来增强 MySQL 数据库的安全性，允许用户仅设置强密码。按 Y 接受 VALIDATION 或按 RETURN 键跳过。

![image-20240324161855612](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324161855612.png)

接下来，会看到设置 root 密码的提示。输入密码并按回车键。注意，出于安全原因，在控制台中键入的任何内容都不会显示。

接下来，会看到一个提示，询问你是否删除所有匿名用户，输入 Y 表示是。对于此处的任何其他提示，输入 Y 表示是。

### 以root身份登录并调整用户身份验证

MySQL 数据库带有一个客户端实用程序，允许你从 Linux 终端访问数据库并与之交互。

通常，在未执行任何配置的情况下在 Ubuntu 上全新安装 MySQL 后，访问服务器的用户将使用身份验证套接字 (auth_socket) 插件进行身份验证。

auth_socket 的使用会阻碍服务器使用密码对用户进行身份验证。它不仅会引发安全问题，而且还会使用户无法使用外部程序（如 phpMyAdmin）访问数据库。我们需要将身份验证方法从 auth_socket 更改为使用 mysql_native_password。

为此需要打开 MySQL 控制台，并在 Linux 终端上运行以下命令。

```text
sudo mysql
```

![image-20240324162117509](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324162117509.png)

现在，我们需要检查数据库对不同用户使用的身份验证方法。你可以通过运行以下命令来执行此操作。

```text
SELECT user,authentication_string,plugin,host FROM mysql.user;
```

![image-20240324162236803](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324162236803.png)

从上图中，我们可以确认 root 用户确实使用 auth_socket 插件进行了身份验证。我们需要使用下面的“ALTER USER”命令切换到“密码验证”的使用。确保使用安全密码（应超过 8 个字符，结合数字、字符串和特殊符号），因为它将替换你在执行上述命令“sudo mysql_secure_installation” 时设置的密码。运行以下命令。

```text
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';
```

![image-20240324162314750](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324162314750.png)

注意，上图中突出显示的文本是你输入安全密码的地方。将它包含在单个标签之间。现在，我们需要重新加载授权表并将更改更新到 MySQL 数据库。通过执行以下命令来执行此操作。刷新权限：

```text
FLUSH PRIVILEGES;
```

完成后，我们需要确认 root 用户不再使用 auth_socket 进行身份验证。通过再次运行以下命令来执行此操作。

```text
SELECT user,authentication_string,plugin,host FROM mysql.user;
```

![image-20240324162410111](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324162410111.png)

从上图中，我们看到 root 身份验证方法已从“auth_socket”更改为“pssword”。

由于我们更改了 root 的身份验证方法，因此我们无法使用之前使用的相同命令打开 MySQL 控制台。即“sudo mysql”。我们需要包括用户名和密码参数，如下所示。

```text
mysql -u root -p
```

“-u”表示用户，在我们的例子中是“root”，“-p”代表“password”，一旦你按下 Enter 键，服务器就会提示你输入。

![image-20240324162455300](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324162455300.png)

### 创建新用户

一切都设置好后，你可以创建一个新用户，你将授予该用户适当的权限。我们将创建一个用户 'PyDataStudio' 并分配对所有数据库表的权限以及更改、删除和添加用户权限的权限。逐行执行下面的命令。

```text
CREATE USER 'PyDataStudio'@'localhost' IDENTIFIED BY 'strong_password';

GRANT ALL PRIVILEGES ON *.* TO 'PyDataStudio'@'localhost' WITH GRANT OPTION;
```

第一个命令将创建新用户，第二个命令分配所需的权限。

![image-20240324164618358](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324164618358.png)

**一键建用户加赋权官方已经弃用了**

我们现在可以通过运行以下命令来测试我们的新用户。

```text
mysql -u PyDataStudio -p
```

![image-20240324164649975](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324164649975.png)

### 在 Ubuntu 上安装 MySQL-Server

在 Ubuntu 服务器上安装 MySQL-server 与上述步骤没有太大区别。但是，由于服务器是远程访问的，我们还需要为服务器启用远程访问。

要安装数据库并配置安全选项，只需在终端上逐行运行以下命令。

```text
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
```

![image-20240324165240744](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324165240744.png)

安装成功后，需要启用远程访问。从逻辑上讲，我们需要在 Ubuntu 服务器防火墙上打开一个端口，以便 MySQL 数据库进行通信。默认情况下，MySQL 服务在 3306 端口上运行。执行以下命令。启用远程访问：

```text
sudo ufw enable
sudo ufw allow mysql
```

![image-20240324165422409](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324165422409.png)

为了增强 MySQL 数据库的可靠性和可访问性，可以将 MySQL-server 服务配置为在启动时开始运行。执行以下命令。在启动时启用 MySQL Server：

```text
sudo systemctl enable mysql
```

![image-20240324170436255](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324170436255.png)

现在需要配置服务器的接口，从而服务器能够侦听远程可访问的接口。我们需要编辑“mysqld.cnf”文件。运行以下命令。

```text
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```

mysql配置文件已有：

![image-20240324171629146](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324171629146.png)

mysqld.cnf 配置文件内容：

![image-20240324171543462](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324171543462.png)

![image-20240324171812402](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324171812402.png)





![image-20240324165727144](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324165727144.png)

![image-20240324170151072](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324170151072.png)

![image-20240324170248673](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324170248673.png)

![image-20240324170314963](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324170314963.png)

## MySQL语法

### 创建、删除、查询数据库

#### 创建数据库

我们可以在登陆 MySQL 服务后，使用 **create** 命令创建数据库，语法如下:

```
CREATE DATABASE 数据库名;
```

以下命令简单的演示了创建数据库的过程，数据名为 RUNOOB:

```
[root@host]# mysql -u root -p   
Enter password:******  # 登录后进入终端

mysql> create DATABASE RUNOOB;
```

建数据库的基本语法如下：

```
CREATE DATABASE [IF NOT EXISTS] database_name
  [CHARACTER SET charset_name]
  [COLLATE collation_name];
```

如果你希望在创建数据库时指定一些选项，可以使用 CREATE DATABASE 语句的其他参数，例如，你可以指定字符集和排序规则：

实例

**CREATE** **DATABASE** mydatabase
 **CHARACTER** **SET** utf8mb4
 **COLLATE** utf8mb4_general_ci;

如果数据库已经存在，执行 CREATE DATABASE 将导致错误。

为了避免这种情况，你可以在 CREATE DATABASE 语句中添加 IF NOT EXISTS 子句：

实例

**CREATE** **DATABASE** **IF** **NOT** **EXISTS** mydatabase;

#### 查询数据库

要查看当前 MySQL 服务器上的数据库列表，使用以下命令：

```sql
show databases;
```

![image-20240325101043941](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240325101043941.png)

上述命令的执行结果如上图所示，在所示的数据库列表中，information_schema 和 mysql 为系统数据库，test 为测试数据库，bookstore 为刚刚创建的数据库。information_schema 是信息数据库，其中保存着 MySQL 服务器所维护的所有其他数据库的信息。mysql 数据库存储了 MySQL 的账户信息以及 MySQL 账户的访问权限，进而实现 MySQL 的账户的身份认证和权限验证，确保数据库安全。test 数据库则是安装时创建的一个测试数据库，是一个空数据库，其中没有任何表，可以删除

#### 显示数据库

数据库创建好之后，可以使用以下 MySQL 命令来查看数据库的相关信息，如默认字符集等：

```sql
show create database bookstore;
```

#### 选择当前数据库

在进行数据库操作前，必须指定操作的是哪个数据库，即需要指定哪一个数据库为当前数据库。在使用 CREATE DATABASE 命令创建新的数据库后，新数据库并不会自动的成为当前数据库。使用以下命令进行指定：

```sql
use bookstore;
```

#### 删除数据库

- 如果要删除某个指定的数据库，如 bookstore 数据库，则使用如下命令：

  ```sql
  drop database bookstore;
  ```

### 创建、删除、查询数据表

#### 创建数据表

创建 MySQL 数据表需要以下信息：

- 表名
- 表字段名
- 定义每个表字段的数据类型

语法

以下为创建 MySQL 数据表的 SQL 通用语法：

```
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    ...
);
```

**参数说明：**

- `table_name` 是你要创建的表的名称。
- `column1`, `column2`, ... 是表中的列名。
- `datatype` 是每个列的数据类型。

以下是一个具体的实例，创建一个用户表 **users**：

实例

**CREATE** **TABLE** users (
  id **INT** **AUTO_INCREMENT** **PRIMARY** **KEY**,
  username **VARCHAR**(50) **NOT** **NULL**,
  email **VARCHAR**(100) **NOT** **NULL**,
  birthdate **DATE**,
  is_active **BOOLEAN** **DEFAULT** **TRUE**
);

实例解析：

- `id`: 用户 id，整数类型，自增长，作为主键。
- `username`: 用户名，变长字符串，不允许为空。
- `email`: 用户邮箱，变长字符串，不允许为空。
- `birthdate`: 用户的生日，日期类型。
- `is_active`: 用户是否已经激活，布尔类型，默认值为 true。

以上只是一个简单的实例，用到了一些常见的数据类型包括 INT, VARCHAR, DATE, BOOLEAN，你可以根据实际需要选择不同的数据类型。AUTO_INCREMENT 关键字用于创建一个自增长的列，PRIMARY KEY 用于定义主键。

如果你希望在创建表时指定数据引擎，字符集和排序规则等，可以使用 **CHARACTER SET** 和 **COLLATE** 子句：

实例

**CREATE** **TABLE** mytable (
  id **INT** **PRIMARY** **KEY**,
  name **VARCHAR**(50)
) **CHARACTER** **SET** utf8mb4 **COLLATE** utf8mb4_general_ci;

以上代码创建一个使用 utf8mb4 字符集和 utf8mb4_general_ci 排序规则的表。

以下例子中我们将在 RUNOOB 数据库中创建数据表 runoob_tbl：

实例

**CREATE** **TABLE** **IF** **NOT** **EXISTS** `runoob_tbl`(
  `runoob_id` **INT** **UNSIGNED** **AUTO_INCREMENT**,
  `runoob_title` **VARCHAR**(100) **NOT** **NULL**,
  `runoob_author` **VARCHAR**(40) **NOT** **NULL**,
  `submission_date` **DATE**,
  **PRIMARY** **KEY** ( `runoob_id` )
)ENGINE=InnoDB **DEFAULT** CHARSET=utf8;

实例解析：

- 如果你不想字段为**空**可以设置字段的属性为 **NOT NULL**，如上实例中的 runoob_title 与 runoob_author 字段， 在操作数据库时如果输入该字段的数据为空，就会报错。
- **AUTO_INCREMENT** 定义列为自增的属性，一般用于主键，数值会自动加 1。
- **PRIMARY KEY** 关键字用于定义列为主键。 您可以使用多列来定义主键，列间以逗号 **,** 分隔。
- **ENGINE** 设置存储引擎，**CHARSET** 设置编码。

#### 删除数据表

MySQL中删除数据表是非常容易操作的，但是你在进行删除表操作时要非常小心，因为执行删除命令后所有数据都会消失。

语法

以下为删除 MySQL 数据表的通用语法：

```
DROP TABLE table_name ;    -- 直接删除表，不检查是否存在
或
DROP TABLE [IF EXISTS] table_name;
```

**参数说明：**

- `table_name` 是要删除的表的名称。
- `IF EXISTS` 是一个可选的子句，表示如果表存在才执行删除操作，避免因为表不存在而引发错误。

```
-- 删除表，如果存在的话
DROP TABLE IF EXISTS mytable;

-- 直接删除表，不检查是否存在
DROP TABLE mytable;
```

请替换 **mytable** 为你要删除的表的名称。

在命令行中，你也可以使用 **mysqladmin** 工具来删除表。

以下是使用 **mysqladmin** 删除表的命令：

```
mysqladmin -u your_username -p drop your_table
```

- **your_username** 是 MySQL 用户名。
- **your_table** 是要删除的表的名称。

执行此命令后，系统会提示输入密码，输入密码后按 Enter 键即可删除表。

**注意：** 在执行删除表操作时，请确保你确实想要删除表及其所有数据，因为该操作是不可逆的。为了避免误操作，通常建议在执行删除之前备份表。

实例

以下实例删除了数据表 runoob_tbl:

实例

```mysql
root@host# mysql -u root -p
Enter password:*******
mysql> **USE** RUNOOB;
**DATABASE** changed
mysql> **DROP** **TABLE** runoob_tbl;
Query OK, 0 **ROWS** affected (0.8 sec)
mysql>
```

#### 查看表

里的查看表指的是查看表的结构。

可以使用**DESCRIBE 表名**进行查看

我们还可以通过语句**SHOW CREATE TABLE 表名**的方法将展示表的详细信息

```shell
SHOW TABLES   #查看已创建的表格
SHOW DATABASES   #查看已创建的数据库
```

### 插入数据

MySQL 表中使用 **INSERT INTO** 语句来插入数据。

你可以通过 **mysql>** 命令提示窗口中向数据表中插入数据，或者通过PHP脚本来插入数据。

### 语法

以下为向MySQL数据表插入数据通用的 **INSERT INTO** SQL语法：

```mysql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
```

**参数说明：**

- `table_name` 是你要插入数据的表的名称
- `column1`, `column2`, `column3`, ... 是表中的列名
- `value1`, `value2`, `value3`, ... 是要插入的具体数值

如果数据是字符型，必须使用单引号 **'** 或者双引号 **"**，如： 'value1', "value1"。

一个简单的实例，插入了一行数据到名为 users 的表中：

```mysql
INSERT INTO users (username, email, birthdate, is_active)
VALUES ('test', 'test@runoob.com', '1990-01-01', true);
```

- `username`: 用户名，字符串类型
- `email`: 邮箱地址，字符串类型
- `birthdate`: 用户生日， 日期类型
- `is_active`: 是否已激活，布尔类型

如果你要插入所有列的数据，可以省略列名：

```mysql
INSERT INTO users
VALUES (NULL,'test', 'test@runoob.com', '1990-01-01', true);
```

这里，**NULL** 是用于自增长列的占位符，表示系统将为 **id** 列生成一个唯一的值。

如果你要插入多行数据，可以在 VALUES 子句中指定多组数值：

```mysql
INSERT INTO users (username, email, birthdate, is_active)
VALUES
    ('test1', 'test1@runoob.com', '1985-07-10', true),
    ('test2', 'test2@runoob.com', '1988-11-25', false),
    ('test3', 'test3@runoob.com', '1993-05-03', true);
```

### 查询数据

MySQL 数据库使用 **SELECT** 语句来查询数据。

你可以通过 **mysql>** 命令提示窗口中在数据库中查询数据，或者通过 PHP 脚本来查询数据。

### 语法

以下为在 MySQL 数据库中查询数据通用的 SELECT 语法：

```mysql
SELECT column1, column2, ...
FROM table_name
[WHERE condition]
[ORDER BY column_name [ASC | DESC]]
[LIMIT number];
```

**参数说明：**

- `column1`, `column2`, ... 是你想要选择的列的名称，如果使用 `*` 表示选择所有列。
- `table_name` 是你要从中查询数据的表的名称。
- `WHERE condition` 是一个可选的子句，用于指定过滤条件，只返回符合条件的行。
- `ORDER BY column_name [ASC | DESC]` 是一个可选的子句，用于指定结果集的排序顺序，默认是升序（ASC）。
- `LIMIT number` 是一个可选的子句，用于限制返回的行数。

MySQL SELECT 语句简单的应用实例：

实例

```mysql
-- 选择所有列的所有行
SELECT * FROM users;

-- 选择特定列的所有行
SELECT username, email FROM users;

-- 添加 WHERE 子句，选择满足条件的行
SELECT * FROM users WHERE is_active = TRUE;

-- 添加 ORDER BY 子句，按照某列的升序排序
SELECT * FROM users ORDER BY birthdate;

-- 添加 ORDER BY 子句，按照某列的降序排序
SELECT * FROM users ORDER BY birthdate DESC;

-- 添加 LIMIT 子句，限制返回的行数
SELECT * FROM users LIMIT 10;
```

SELECT 语句可以是灵活的，我们可以根据实际需求组合和使用这些子句，比如同时使用 WHERE 和 ORDER BY 子句，或者使用 LIMIT 控制返回的行数。

在 `WHERE` 子句中，你可以使用各种条件运算符（如 `=`, `<`, `>`, `<=`, `>=`, `!=`），逻辑运算符（如 `AND`, `OR`, `NOT`），以及通配符（如 `%`）等。

以下是一些进阶的 SELECT 语句实例：

实例

```mysql
-- 使用 AND 运算符和通配符
SELECT * FROM users WHERE username LIKE 'j%' AND is_active = TRUE;

-- 使用 OR 运算符
SELECT * FROM users WHERE is_active = TRUE OR birthdate < '1990-01-01';

-- 使用 IN 子句
SELECT * FROM users WHERE birthdate IN ('1990-01-01', '1992-03-15', '1993-05-03');
```

### 更新数据

如果我们需要修改或更新 MySQL 中的数据，我们可以使用 **UPDATE** 命令来操作。

以下是 UPDATE 命令修改 MySQL 数据表数据的通用 SQL 语法：

```mysql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

```

**参数说明：**

- `table_name` 是你要更新数据的表的名称
- `column1`, `column2`, ... 是你要更新的列的名称
- `value1`, `value2`, ... 是新的值，用于替换旧的值
- `WHERE condition` 是一个可选的子句，用于指定更新的行。如果省略 `WHERE` 子句，将更新表中的所有行

**更多说明：**

- 你可以同时更新一个或多个字段
- 你可以在 WHERE 子句中指定任何条件
- 你可以在一个单独表中同时更新数据

当你需要更新数据表中指定行的数据时 WHERE 子句是非常有用的

实例

以下实例演示了如何使用 UPDATE 语句。

1. 更新单个列的值

   ```mysql
   UPDATE employees SET salary = 60000 WHERE employee_id = 101;
   ```

2. 更新多个列的值

   ```mysql
   UPDATE orders
   SET status = 'Shipped', ship_date = '2023-03-01'
   WHERE order_id = 1001;
   ```

3. 使用表达式更新值

   ```mysql
   UPDATE products
   SET price = price * 1.1
   WHERE category = 'Electronics';
   ```

   以上 SQL 语句将每个属于 'Electronics' 类别的产品的价格都增加了 10%。

4.  更新符合条件的所有行

   ```mysql
   UPDATE students
   SET status = 'Graduated';
   ```

   以上 SQL 语句将所有学生的状态更新为 'Graduated'。

5. 更新使用子查询的值

   ```mysql
   UPDATE customers
   SET total_purchases = (
       SELECT SUM(amount)
       FROM orders
       WHERE orders.customer_id = customers.customer_id
   )
   WHERE customer_type = 'Premium';
   ```

   以上 SQL 语句通过子查询计算每个 'Premium' 类型客户的总购买金额，并将该值更新到 total_purchases 列中。

**注意：** 在使用 UPDATE 语句时，请确保你提供了足够的条件来确保只有你想要更新的行被修改。如果不提供 WHERE 子句，将更新表中的所有行，可能导致不可预测的结果。

### 删除数据







### 删除用户

![image-20240324163935540](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324163935540.png)

![image-20240324163952559](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324163952559.png)

![image-20240324164045948](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324164045948.png)

### 创建用户和赋权

![image-20240324163346669](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324163346669.png)

### 修改密码

![image-20240324163836249](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324163836249.png)

### **查看mysql已经创建的用户**

![image-20240324191516188](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324191516188.png)

![image-20240324192520740](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324192520740.png)

![image-20240324192657647](C:\Users\cyb\AppData\Roaming\Typora\typora-user-images\image-20240324192657647.png)











































