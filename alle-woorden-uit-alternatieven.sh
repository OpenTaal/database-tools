if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT alternatief FROM words_list WHERE (next_version = 'f' OR next_version = 'F' OR next_version = 'k' OR next_version = 'K' OR next_version = 'b' OR next_version = 'B' OR next_version = 'x' OR next_version = 'X' OR next_version = 'h' OR next_version = 'H') AND alternatief <> '' AND alternatief <> '-' order by alternatief">alle-woorden-uit-alternatieven.txt.tmp
cat alle-woorden-uit-alternatieven.txt.tmp|tail -n +5|sed -e 's/;/\n/g'|sort|uniq>alle-woorden-uit-alternatieven.txt
echo Aantal woorden uit alternatieven: `cat alle-woorden-uit-alternatieven.txt|wc -l`
