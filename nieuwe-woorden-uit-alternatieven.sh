./alle-goede-woorden.sh
./alle-woorden-uit-alternatieven.sh
diff alle-goede-woorden.txt alle-woorden-uit-alternatieven.txt |grep '^> '|sed -e 's/^> //'|grep -v '\?'>nieuwe-woorden-uit-alternatieven.txt
echo Aantal nieuwe woorden uit alternatieven: `cat nieuwe-woorden-uit-alternatieven.txt|wc -l`
./verrijk-woorden-uit-alternatieven.py>nieuwe-woorden-uit-alternatieven.tsv
echo Gevonden in totaal aantal verwijzingen vanuit alternatieven: `cat nieuwe-woorden-uit-alternatieven.tsv|wc -l`
