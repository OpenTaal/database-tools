if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT alternatief FROM words_list WHERE (next_version = 'x' OR next_version = 'X') AND alternatief <> '' AND alternatief <> '-' ORDER BY alternatief">alle-woorden-uit-fouten.txt.tmp
cat alle-woorden-uit-fouten.txt.tmp|tail -n +5|sed -e 's/;/\n/g'|sort|uniq>alle-woorden-uit-fouten.txt
rm -f alle-woorden-uit-fouten.txt.tmp
echo Aantal woorden uit fouten: `cat alle-woorden-uit-fouten.txt|wc -l`
