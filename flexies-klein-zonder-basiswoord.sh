if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,base_word FROM words_list WHERE next_version REGEXP '[fF]' AND word REGEXP '^[a-z]' AND base_word = '' ORDER BY word"|tail -n +5>flexies-klein-zonder-basiswoord.tsv
echo Aantal flexievormen met kleine letters die geen basiswoord hebben: `cat flexies-klein-zonder-basiswoord.tsv|wc -l`
echo -e "FLEXIE\tBASISWOORD">header
cat flexies-klein-zonder-basiswoord.tsv>>header
mv -f header flexies-klein-zonder-basiswoord.tsv
