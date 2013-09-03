if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version <> 'x' AND next_version <> 'X' AND next_version <> '-' AND next_version <> '!' AND next_version <> '?' AND next_version <> 'y' AND next_version <> 'z' AND next_version <> 'd' AND next_version <> 'D' order by word">alle-woorden.txt
echo Aantal woorden: `cat alle-woorden.txt|tail -n +5|wc -l`
