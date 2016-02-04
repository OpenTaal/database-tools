if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version,word FROM words_list WHERE word LIKE '%-%' AND (next_version = 'b' OR next_version = 'B' OR next_version = 'k' OR next_version = 'K' OR next_version = 'f' OR next_version = 'F') order by next_version,word"|tail -n +5>woorden-met-streepje.tsv
echo Aantal woorden met streepje: `cat woorden-met-streepje.tsv|wc -l`
