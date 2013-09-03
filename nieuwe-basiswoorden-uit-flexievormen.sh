if [ ! -e alle-basiswoorden.txt ]
then
	./alle-basiswoorden.sh
fi
if [ ! -e alle-basiswoorden-uit-flexievormen.txt ]
then
	./alle-basiswoorden-uit-flexievormen.sh
fi
diff alle-basiswoorden.txt alle-basiswoorden-uit-flexievormen.txt |grep '^> '|sed -e 's/^> //'|grep -v '\?'>nieuwe-basiswoorden-uit-flexievormen.txt
echo Aantal nieuwe basiswoorden uit flexievormen: `cat nieuwe-basiswoorden-uit-flexievormen.txt|wc -l`
./verrijk-basiswoorden-uit-flexievormen.py>nieuwe-basiswoorden-uit-flexievormen.tsv
echo Gevonden in totaal aantal verwijzingen vanuit flexievormen: `cat nieuwe-basiswoorden-uit-flexievormen.tsv|wc -l`
