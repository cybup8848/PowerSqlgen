#########################################################################
# File Name: create_table.sh
# Author: cheng yingbin
# mail: 703477993@qq.com
# Created Time: Mon Mar 25 16:08:41 2024
#########################################################################
#!/bin/bash

table_num=1

mysql --defaults-extra-file=./config.cnf -e "create database if not exists PowerSqlgen_test" 

echo "$(date +"%Y-%m-%d %H:%M:%S")" start >>'meta_table_'${table_num}'_create'.log
nohup bash ./PowerSqlgen.sh create_table 1 25 PowerSqlgen_test meta_table_${table_num} 1>>'meta_table_'${table_num}'_create'.log 2>>'meta_table_'${table_num}'_create'.err &


nohup bash ./PowerSqlgen.sh create_table 26 50 PowerSqlgen_test meta_table_${table_num} 1>>'meta_table_'${table_num}'_create'.log 2>>'meta_table_'${table_num}'_create'.err &


nohup bash ./PowerSqlgen.sh create_table 51 75 PowerSqlgen_test meta_table_${table_num} 1>>'meta_table_'${table_num}'_create'.log 2>>'meta_table_'${table_num}'_create'.err &


nohup bash ./PowerSqlgen.sh create_table 76 100 PowerSqlgen_test meta_table_${table_num} 1>>'meta_table_'${table_num}'_create'.log 2>>'meta_table_'${table_num}'_create'.err &


echo "$(date +"%Y-%m-%d %H:%M:%S")" end >>'meta_table_'${table_num}'_create'.log
