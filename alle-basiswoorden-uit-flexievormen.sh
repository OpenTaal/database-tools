if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT base_word FROM words_list WHERE (next_version = 'f' OR next_version = 'F' OR next_version = 'u' OR next_version = 'U') AND base_word <> '' order by base_word">alle-basiswoorden-uit-flexievormen.txt.tmp
cat alle-basiswoorden-uit-flexievormen.txt.tmp|tail -n +5|sed -e 's/;/\n/g'|sort|uniq>alle-basiswoorden-uit-flexievormen.txt
echo Aantal basiswoorden uit flexievormen: `cat alle-basiswoorden-uit-flexievormen.txt|wc -l`
