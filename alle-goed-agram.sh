if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version REGEXP '[kKfF]' and word REGEXP '^[a-záàäâåçéèëêíìïîñóòöôøúùüû]+$' ORDER BY word"|tail -n +5|sort>alle-goed-agram.txt
echo Aantal goede woorden voor agram: `cat alle-goed-agram.txt|wc -l`
