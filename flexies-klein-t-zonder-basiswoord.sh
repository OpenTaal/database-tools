if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,base_word FROM words_list WHERE next_version REGEXP '[fF]' AND word REGEXP '^[a-z].*t$' AND base_word = '' ORDER BY word"|tail -n +5>flexies-klein-t-zonder-basiswoord.csv
echo Aantal flexievormen met kleine letters eindigend op t die geen basiswoord hebben: `cat flexies-klein-t-zonder-basiswoord.csv|wc -l`
