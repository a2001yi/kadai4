#!/bin/bash

ans="/tmp/$$-ans"
result="/tmp/$$-result"
err="/tmp/$$-error"

#テスト内容（2つの引数はそれぞれa,bと表記）
#正常動作
#a>bの時
./saidai.sh 18 27 > ${result}
echo "最大公約数は 9" > ${ans}
diff ${result} ${ans} || echo "1-1 a>b 失敗" >> ${err}

#a<bの時
./saidai.sh 15 10 > ${result}
echo "最大公約数は 5" > ${ans}  
diff ${result} ${ans} || echo "1-2 a<b 失敗" >> ${err} 

#素数同士の時
./saidai.sh 3 5 > ${result}
echo "最大公約数は 1" > ${ans}  
diff ${result} ${ans} || echo "1-3 素数 失敗" >> ${err}

#異常動作
#0が含まれる
./saidai.sh 0 20 > ${result}
echo "error" > ${ans}
diff ${result} ${ans} || echo "2-1 a=0 失敗" >> ${err} 

./saidai.sh 114 0 > ${result} 
echo "error" > ${ans} 
diff ${result} ${ans} || echo "2-2 b=0 失敗" >> ${err}
     
./saidai.sh 0 0 > ${result}
echo "error" > ${ans}
diff ${result} ${ans} || echo "2-3 a=b=0 失敗" >> ${err}

#負の数が含まれる
./saidai.sh -1 5 > ${result}
echo "error" > ${ans}     
diff ${result} ${ans} || echo "2-4 a<0 失敗" >> ${err} 

./saidai.sh -1 -98 > ${result} 
echo "error" > ${ans} 
diff ${result} ${ans} || echo "2-5 a<0 b<0 失敗" >> ${err} 

./saidai.sh -999 -0 > ${result} 
echo "error" > ${ans} 
diff ${result} ${ans} || echo "2-6 a<0 b=0 失敗" >> ${err} 

#引数が足りない
./saidai.sh 46 > ${result} 
echo "引数は2つ指定してください" > ${ans}
diff ${result} ${ans} || echo "2-7 引数1つの場合 失敗" >> ${err} 

./saidai.sh  > ${result} 
echo "引数は2つ指定してください" > ${ans}
diff ${result} ${ans} || echo "2-8 引数0の場合 失敗" >> ${err}

if [ -f ${err} ]; then
	cat ${err}
	rm /tmp/$$-*
	exit 1
fi


