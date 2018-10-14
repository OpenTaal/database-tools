if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,hyphenation FROM words_list WHERE (next_version = 'b' OR next_version = 'B' OR next_version = 'k' OR next_version = 'K' OR next_version = 'f' OR next_version = 'F' OR next_version = 'd' OR next_version = 'D') AND hyphenation <> '' AND word <> hyphenation ORDER BY word"|tail -n +5>controle-hyphenations.tsv
echo Aantal woorden met hyphenation: `cat controle-hyphenations.tsv|wc -l`
