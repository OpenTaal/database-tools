if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version <> 'k' AND next_version <> 'K' AND next_version <> 'b' AND next_version <> 'B' AND next_version <> 'f' AND next_version <> 'F' ORDER BY word"|tail -n +5|sort>alles-kbf.txt
echo Aantal woorden: `cat alles-kbf.txt|wc -l`
