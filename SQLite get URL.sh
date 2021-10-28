#!/bin/bash
sqlite3 test.db 'SELECT * FROM test;' | grep "|5" | awk '{ gsub("\|"," "); print $2 }'| sed "s/[/]//g" > url.txt
com=0 && de=0 && ru=0 && eng=0 && indefined=0
a=`wc -l < url.txt`
for ((i=1; i<$a+1; i++))
do
b=`sed -n $i"p" url.txt | sed 's/example.//g'`
  if [[ $b = "com" ]]; then 
    com=$((com+1))
  elif [[ $b = "de" ]]; then
    de=$((de+1))
  elif [[ $b = "ru" ]]; then
    ru=$((ru+1))
  elif [[ $b = "eng" ]]; then
    eng=$((eng+1))
  else
    indefined=$((indefined+1))
  fi
done
echo "Результат: "
if [[ $com > 0 ]]; then echo "Домен com: "$com; fi
if [[ $de > 0 ]]; then echo "Домен de: "$de; fi
if [[ $ru > 0 ]]; then echo "Домен ru: "$ru; fi
if [[ $eng > 0 ]]; then echo "Домен eng: "$eng; fi
if [[ $indefined > 0 ]]; then echo "Домен не определён: "$indefined; fi
