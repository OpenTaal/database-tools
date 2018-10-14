if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE word = base_word ORDER BY word"|tail -n +5|sort>identical-word-basiswoord.txt
echo Aantal woorden identiek aan basiswoord: `cat identical-word-basiswoord.txt|wc -l`
