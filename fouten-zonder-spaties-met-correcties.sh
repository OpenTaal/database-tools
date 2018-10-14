if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT id,next_version,word,alternatief FROM words_list WHERE (next_version = 'x' OR next_version = 'X') AND alternatief <> '' AND alternatief <> '-' AND word NOT LIKE '% %' order by word"|tail -n +5>fouten-zonder-spaties-met-correcties.tsv
echo Aantal fouten zonder spaties met correcties: `cat fouten-zonder-spaties-met-correcties.tsv|wc -l`
