if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,base_word FROM words_list WHERE (next_version = 'f' OR next_version = 'F') AND base_word <> '' ORDER BY word"|tail -n +5|sort>flexies-met-basiswoord.tsv
echo Aantal flexies met basiswoord: `cat flexies-met-basiswoord.tsv|wc -l`
echo -e "word\tbasiswoord">header
cat flexies-met-basiswoord.tsv>>header
mv -f header flexies-met-basiswoord.tsv
