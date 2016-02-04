if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version <> 'x' AND next_version <> 'X' AND next_version <> '-' ORDER BY word"|tail -n +5|sort>alle-woorden-behalve-fout.txt
echo Aantal woorden: `cat alle-woorden-behalve-fout.txt|wc -l`
