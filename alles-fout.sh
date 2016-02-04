if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE (next_version = 'x' OR next_version = 'X') AND alternatief != '-' ORDER BY word"|tail -n +5|sort>alles-fout.txt
echo Aantal foute woorden: `cat alles-fout.txt|wc -l`
