if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT id,next_version,word,alternatief FROM words_list WHERE (next_version = 'x' OR next_version = 'X') AND alternatief <> '' AND alternatief <> '-' order by word"|tail -n +5>fouten-met-correcties.tsv
echo Aantal fouten met correcties: `cat fouten-met-correcties.tsv|wc -l`
