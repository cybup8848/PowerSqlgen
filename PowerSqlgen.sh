#########################################################################
# File Name: PowerSqlgen.sh
# Author: cheng yingbin
# mail: 703477993@qq.com
# Created Time: Mon Mar 25 09:31:15 2024
#########################################################################
#!/bin/bash

_mysql="mysql --defaults-extra-file=./config.cnf"
function createDataBase(){
	echo "$(date +"%Y-%m-%d %H:%M:%S")" start
	dbName=$1
	sql="create database if not exists "$dbName""
	$_mysql -e "$sql"
	echo "$sql" done
	echo "$(date +"%Y-%m-%d %H:%M:%S")" end
}

function dropDataBase(){
	echo "$(date +"%Y-%m-%d %H:%M:%S")" start
	dbName=$1
	sql="drop database if exists $dbName"
	$_mysql -e "$sql"
	echo "$sql" done
	echo "$(date +"%Y-%m-%d %H:%M:%S")" end
}


function createTable(){
	echo "$(date +"%Y-%m-%d %H:%M:%S")" start
	echo $1 $2 $3 $4
	$_mysql -e "create database if not exists "$3""
	start=$1
	end=$2
	dbName=$3
	tableName=$4
	for((i=$start;i<=$end;i++))
	do
		sql="create table if not exists "$dbName"."$tableName"_"$i"(k1 BIGINT NOT NULL, \
			k2 VARCHAR(300), v1 BIGINT,v2 DATETIME NOT NULL DEFAULT \"$(date +"%Y-%m-%d %H:%M:%S")\")"
		$_mysql -e "$sql"
		echo "$sql" done
		if [ $? -ne 0 ];then
			echo $(date +"%Y-%m-%d %H:%M:%S") $i
		fi
	done
	echo "$(date +"%Y-%m-%d %H:%M:%S")" end
}


function dropTable(){
	echo "$(date +"%Y-%m-%d %H:%M:%S")" start
	if [ $# -eq 1 ];then
		sql="drop table "$1""
		echo "$sql" done
		$_mysql -e "$sql"
	else
		start=$1
		end=$2
		dbName=$3
		tableName=$4
		for key in $(seq $start $end)
		do
			sql="drop table if exists "$dbName"."$tableName"_"$key""
			$_mysql -e "$sql"
			echo "$sql" done
			if [ $? -ne 0 ];then
				echo "$(date +"%Y-%m-%d %H:%M:%S")" end
			fi
		done
	fi
	echo "$(date +"%Y-%m-%d %H:%M:%S")" end
}

function insertData(){
	echo "$(date +"%Y-%m-%d %H:%M:%S")" start
	start=$1
	step=$2
	end=$3
	dbName=$4
	tableName=$5
	tableIdStart=$6
	tableIdEnd=$7
	for((i=start;i<=end;i+=step))
	do
		for id in $(seq $tableIdStart $tableIdEnd)
		do
			randTime=""$((RANDOM%9000+1000))"-"$((RANDOM%12+1))"-"$((RANDOM%31+1))" "$(expr $RANDOM % 24)":"$((RANDOM%60))":"$((RANDOM%60))""
			randStr="${RANDOM}${RANDOM}${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
			sql="insert into "$dbName"."$tableName"_"$id" (k1,k2,v1,v2) values ('$i','$randStr','$RANDOM','$randTime')"
			$_mysql -e "$sql"
			echo "$sql" done
			if [ $? -ne 0 ];then
				echo "$(date +"%Y-%m-%d %H:%M:%S")" $i
			fi
		done
	done
	echo "$(date +"%Y-%m-%d %H:%M:%S")" end
}

function updateData(){
	echo "$(date +"%Y-%m-%d %H:%M:%S")" start
	start=$1
	step=$2
	end=$3
	dbName=$4
	tableName=$5
	tableIdStart=$6
	tableIdEnd=$7
	for i in $(seq $start $step $end)
	do
		for id in $(seq $tableIdStart $tableIdEnd)
		do
			randStr=""$RANDOM""$RANDOM""$RANDOM""$RANDOM""$RANDOM""$RANDOM""
			sql="update "$dbName"."$tableName"_"$i" set k1='$i',k2='"$randStr"',v1='$RANDOM' where k1="$i""
			$_mysql -e "$sql"
			echo "$sql" done
		done
		if (( $?!=0 )) ;then
			echo "$(date +"%Y-%m-%d %H:%M:%S")" $i
		fi
	done
	echo "$(date +"%Y-%m-%d %H:%M:%S")" end
}

function deleteData(){
	echo "$(date +"%Y-%m-%d %H:%M:%S")" start
	start=$1
	step=$2
	end=$3
	dbName=$4
	tableName=$5
	tableIdStart=$6
	tableIdEnd=$7
	for((i=start;i<=end;i+=step))
	do
		for tid in $(seq $tableIdStart $tableIdEnd)
		do
			sql="delete from "$dbName"."$tableName"_"$tid" where k1="$i""
			$_mysql -e "$sql"
			echo "$sql" done
		done
		if [ $? -ne 0 ];then
			echo "$(date +"%Y-%m-%d %H:%M:%S")" $i
		fi
	done
	echo "$(date +"%Y-%m-%d %H:%M:%S")" end
}

function selectCount(){
	echo "$(date +"%Y-%m-%d %H:%M:%S")" start
	dbName=$1
	tableName=$2
	tableIdStart=$3
	tableIdEnd=$4
	for tid in $(seq $tableIdStart $tableIdEnd)
	do
		tbName="$dbName"."$tableName"_"$tid"
		sql="begin;select count(*) from "$tbName";commit;"
		echo "the number of " "$tbName is:"
		$_mysql -e "$sql"
		echo "$sql" done
	done
	echo "$(date +"%Y-%m-%d %H:%M:%S")" end
}


function usage() {
    echo " _____                       _____       _                  "
    echo "|  __ \                     / ____|     | |                 "
    echo "| |__) |____      _____ _ _| (___   __ _| | __ _  ___ _ __  "
    echo "|  ___/ _ \ \ /\ / / _ \ '__\___ \ / _  | |/ _  |/ _ \ '_ \ "
    echo "| |  | (_) \ V  V /  __/ |  ____) | (_| | | (_| |  __/ | | |"
    echo "|_|   \___/ \_/\_/ \___|_| |_____/ \__, |_|\__, |\___|_| |_|"
    echo "                                      | |   __/ |           "
    echo "                                      |_|  |___/            "
    echo "------------------------------------------------------------"
    echo "usage:" 
    echo "sh  PowerSqlgen.sh create_db "'${db_name}'
	echo "sh PowerSqlgen.sh drop_tb "'${db_name}'
    echo "sh PowerSqlgen.sh create_table "'${table_id_start}' '${table_id_end}' '${db_name}' '${table_name}' 
    echo "sh PowerSqlgen.sh insert "'${key_id_start}' '${key_id_end}' '${db_name}' '${table_name}' '${table_id_start}' '${table_id_end}' 
    echo "sh PowerSqlgen.sh get_table_count "'${db_name}' '${table_name}' '${table_id_start}' '${table_id_end}'
    echo "sh PowerSqlgen.sh update "'${key_id_start}' '${key_id_end}' '${db_name}' '${table_name}' '${table_id_start}' '${table_id_end}'
    echo "sh PowerSqlgen.sh drop_table_1 "'${table_name}'
	echo "sh PowerSqlgen.sh drop_table_n "'${table_id_start}' '${table_id_end}' '${db_name}' '${table_name}'
    echo "------------------------------------------------------------"
    echo "example: "
    echo "sh PowerSqlgen.sh create_db PowerSqlgen_test"
    echo "sh PowerSqlgen.sh create_table 1 300 PowerSqlgen_test meta_tablet_1"
    echo "sh PowerSqlgen.sh insert 1 10000 PowerSqlgen_test meta_tablet_1 1 10" 
    echo "sh PowerSqlgen.sh get_table_count PowerSqlgen_test meta_tablet_1 60 70"
    echo "sh PowerSqlgen.sh update 60 70 PowerSqlgen_test meta_tablet_1 1 10"
	echo "sh PowerSqlgen.sh drop_table_1 PowerSqlgen_test.meat_tablet_1_2"
    echo "sh PowerSqlgen.sh drop_table_n 1 100 PowerSqlgen_test meta_tablet_1 "
    exit -1;
}

case $1 in
	create_db)
		createDataBase $2
		;;
	drop_db)
		dropDataBase $2
		;;
	create_table)
		createTable $2 $3 $4 $5
		;;
	drop_table_1)
		dropTable $2
		;;
	drop_table_n)
		dropTable $2 $3 $4 $5
		;;
	insert_data)
		insertData $2 $3 $4 $5 $6 $7 $8
		;;
	update_data)
		updateData $2 $3 $4 $5 $6 $7 $8
		;;
	delete_data)
		deleteData $2 $3 $4 $5 $6 $7 $8
		;;
	get_table_count)
		selectCount $2 $3 $4 $5
		;;
	*)
		usage
		;;
esac		













