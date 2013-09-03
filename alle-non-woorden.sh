if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version = 'x' OR next_version = 'X' OR next_version = '-' OR next_version = '?' OR next_version = 'y' OR next_version = 'z' OR next_version = 'd' OR next_version = 'D' order by word"|sort>alle-non-woorden.txt
echo Aantal non-woorden: `cat alle-non-woorden.txt|tail -n +5|wc -l`
