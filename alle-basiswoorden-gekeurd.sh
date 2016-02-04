if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE (next_version = 'k' OR next_version = 'K') ORDER BY word"|tail -n +5|sort>alle-basiswoorden-gekeurd.txt
echo Aantal gekeurde basiswoorden: `cat alle-basiswoorden-gekeurd.txt|wc -l`
