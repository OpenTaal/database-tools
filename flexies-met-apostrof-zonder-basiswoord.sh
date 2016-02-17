if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE (next_version = 'f' OR next_version = 'F') AND base_word = '' AND word LIKE '%''s' ORDER by word"|tail -n +5>alle-flexies-met-apostrof-zonder-basis.txt
echo Aantal flexievormen met apostrofe s zonder basisvorm: `cat alle-flexies-met-apostrof-zonder-basis.txt|wc -l`
