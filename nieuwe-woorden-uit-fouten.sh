if [ ! -e alles-behalve-fout.txt ]
then
	./alles-behalve-fout.sh
fi
if [ ! -e alle-woorden-uit-fouten.txt ]
then
	./alle-woorden-uit-fouten.sh
fi
diff alles-behalve-fout.txt alle-woorden-uit-fouten.txt |grep '^> '|sed -e 's/^> //'|grep -v '\?'>nieuwe-woorden-uit-fouten.txt
echo Aantal nieuwe woorden uit fouten: `cat nieuwe-woorden-uit-fouten.txt|wc -l`
#./verrijk-basiswoorden-uit-flexievormen.py>nieuwe-basiswoorden-uit-flexievormen.tsv
#echo Gevonden in totaal aantal verwijzingen vanuit flexievormen: `cat nieuwe-basiswoorden-uit-flexievormen.tsv|wc -l`
