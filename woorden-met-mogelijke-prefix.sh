if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE (word LIKE 'aarts%' OR word LIKE 'be%' OR word LIKE '%ge' OR word LIKE 'her%' OR word LIKE 'on%' OR word LIKE 'ont%' OR word LIKE 'ver%' OR word LIKE 'wan%') AND (next_version = 'b' OR next_version = 'B' OR next_version = 'k' OR next_version = 'K' OR next_version = 'f' OR next_version = 'F') order by word"|tail -n +5>woorden-met-mogelijke-prefix.tsv
echo Aantal woorden met mogelijke prefix: `cat woorden-met-mogelijke-prefix.tsv|wc -l`
