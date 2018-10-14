if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version,word FROM words_list WHERE (next_version = 'x' OR next_version = 'X') AND alternatief = '' order by word"|tail -n +5>fouten-zonder-correcties.tsv
echo Aantal fouten zonder correcties: `cat fouten-zonder-correcties.tsv|wc -l`
