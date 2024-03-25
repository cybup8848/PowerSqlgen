#########################################################################
# File Name: insert_data.sh
# Author: cheng yingbin
# mail: 703477993@qq.com
# Created Time: Mon Mar 25 16:54:42 2024
#########################################################################
#!/bin/bash

table_num=1

echo "$(date +"%Y-%m-%d %H:%M:%S")" start >>'meta_table_'${table_num}'_insert'.log

nohup bash PowerSqlgen.sh insert_data 1 2 100000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 


nohup bash PowerSqlgen.sh insert_data 100001 3 200000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 


nohup bash PowerSqlgen.sh insert_data 200001 4 300000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 


nohup bash PowerSqlgen.sh insert_data 300001 5 400000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 


nohup bash PowerSqlgen.sh insert_data 400001 6 500000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 


nohup bash PowerSqlgen.sh insert_data 500001 7 600000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 


nohup bash PowerSqlgen.sh insert_data 600001 8 700000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 


nohup bash PowerSqlgen.sh insert_data 700001 9 800000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 


nohup bash PowerSqlgen.sh insert_data 800001 10 900000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 


nohup bash PowerSqlgen.sh insert_data 900001 11 100000 PowerSqlgen_test meta_table_${table_num} 1 100 1>>'meta_table_'${table_num}'_insert'.log 2>>'meta_table_'${table_num}'_insert'.err & 

echo "$(date +"%Y-%m-%d %H:%M:%S")" end >>'meta_table_'${table_num}'_insert'.log
