if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version, word,base_word,alternatief,aantekeningen FROM words_list WHERE (word LIKE '%ò%' OR word LIKE '%Ò%' OR word LIKE '%ì%' OR word LIKE '%Ì%' OR word LIKE '%ù%' OR word LIKE '%Ù%' OR word LIKE '%ç%' OR word LIKE '%Ç%' OR word LIKE '%ñ%' OR word LIKE '%Ñ%' OR word LIKE '%+%') AND next_version <> '-' ORDER BY next_version,word"|tail -n +5>toegestane-speciale-karakters.tsv
echo Aantal woorden met toegestane speciale karakters: `cat toegestane-speciale-karakters.tsv|wc -l`
