if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE (next_version = 'f' OR next_version = 'F') AND 2_10 = 'F' ORDER BY word"|tail -n +5>alle-blijvende-flexies.txt
echo Aantal blijvende flexies is: `cat alle-blijvende-flexies.txt|wc -l`
