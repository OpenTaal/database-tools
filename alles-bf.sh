if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version = 'b' OR next_version = 'B' OR next_version = 'f' OR next_version = 'F' ORDER BY word"|tail -n +5|sort>alles-bf.txt
echo Aantal woorden: `cat alles-bf.txt|wc -l`
