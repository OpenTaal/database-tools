if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE word = alternatief ORDER BY word"|tail -n +5|sort>identical-word-alternatief.txt
echo Aantal woorden identiek aan alternatief: `cat identical-word-alternatief.txt|wc -l`
