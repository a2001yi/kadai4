#!/bin/bash

#引数個数チェック
if [ ! $# -eq 2 ]; then
	echo "引数は2つ指定してください"
	exit 1
fi
#最大公約数の計算
a=$1
b=$2
if [ $a -le 0 -o $b -le 0 ]; then
	echo "error"
	exit 1
fi
r=`expr $a % $b`
if [ $r = 0 ]; then
	echo "最大公約数は $b"
	exit 0
else
	while [ ! $r = 0 ];
	do
		a=$b
		b=$r
		r=`expr $a % $b`
	done
	echo "最大公約数は $b"
	exit 0
fi



