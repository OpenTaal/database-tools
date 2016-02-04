if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE (next_version = 'd' OR next_version = 'D') ORDER BY word"|tail -n +5|sort>alle-deel-van-woorden.txt
echo Aantal deel van woorden: `cat alle-deel-van-woorden.txt|wc -l`
