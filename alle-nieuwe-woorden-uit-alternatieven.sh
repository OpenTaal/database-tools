./alle-goed.sh
./alle-woorden-uit-alternatieven.sh
diff alle-goed.txt alle-woorden-uit-alternatieven.txt |grep '^> '|sed -e 's/^> //'|grep -v '\?'>alle-nieuwe-woorden-uit-alternatieven.txt
echo Aantal nieuwe woorden uit alternatieven: `cat alle-nieuwe-woorden-uit-alternatieven.txt|wc -l`
