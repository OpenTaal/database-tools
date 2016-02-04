if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,next_version FROM words_list WHERE no_ij_ligature = 1 ORDER BY word"|tail -n +5|sort>alles-geen-ij.tsv
echo Aantal goede woorden: `cat alles-geen-ij.tsv|wc -l`
