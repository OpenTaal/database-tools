if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE (next_version = 'k' or next_version = 'K') AND 2_10 <> 'K' ORDER BY word"|tail -n +5>alle-nieuw-te-keuren-basiswoorden.txt
echo Aantal basiswoorden die nieuw te keuren zijn: `cat alle-nieuw-te-keuren-basiswoorden.txt|wc -l`
