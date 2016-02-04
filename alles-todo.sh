if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,2_10,next_version,base_word,alternatief,aantekeningen FROM words_list WHERE aantekeningen LIKE '%TODO%' ORDER BY word"|tail -n +5|sort>alles-todo.tsv
echo Aantal woorden met TODO in aantekeningen: `cat alles-todo.tsv|wc -l`
