if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,hyphenation FROM words_list WHERE next_version <> '' AND next_version <> '-' AND next_version <> 'x' AND next_version <> 'X' AND next_version <> 'h' AND next_version <> 'H' AND hyphenation <> '' ORDER BY word"|tail -n +5|sort>alle-goed-nuttig-met-hyphenation.tsv
echo Aantal goede woorden: `cat alle-goed-nuttig-met-hyphenation.tsv|wc -l`
