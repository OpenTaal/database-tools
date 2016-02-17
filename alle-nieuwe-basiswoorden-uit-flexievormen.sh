./alle-basiswoorden.sh
./alle-basiswoorden-uit-flexievormen.sh
diff alle-basiswoorden.txt alle-basiswoorden-uit-flexievormen.txt |grep '^> '|sed -e 's/^> //'|grep -v '\?'>alle-nieuwe-basiswoorden-uit-flexievormen.txt
echo Aantal nieuwe basiswoorden uit flexievormen: `cat alle-nieuwe-basiswoorden-uit-flexievormen.txt|wc -l`
