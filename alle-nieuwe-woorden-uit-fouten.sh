./alle-goed.sh
./alle-woorden-uit-fouten.sh
diff alle-goed.txt alle-woorden-uit-fouten.txt |grep '^> '|sed -e 's/^> //'|grep -v '\?'>alle-nieuwe-woorden-uit-fouten.txt
echo Aantal nieuwe woorden uit fouten: `cat alle-nieuwe-woorden-uit-fouten.txt|wc -l`
#./verrijk-basiswoorden-uit-flexievormen.py>alle-nieuwe-basiswoorden-uit-flexievormen.tsv
#echo Gevonden in totaal aantal verwijzingen vanuit flexievormen: `cat alle-nieuwe-basiswoorden-uit-flexievormen.tsv|wc -l`
