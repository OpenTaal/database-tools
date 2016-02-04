if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version, word,base_word,alternatief,aantekeningen FROM words_list WHERE word LIKE '%²%' OR word LIKE '%³%' OR word LIKE '%₂%' OR word LIKE '%₃%' OR word LIKE '%å%' OR word LIKE '%Å%' OR word LIKE '%Ø%' OR word LIKE '%ø%' OR alternatief LIKE '%ȷ%' order by next_version,word"|tail -n +5>toegestane-zeer-speciale-karakters.tsv
echo Aantal woorden met toegestane zeer speciale karakters: `cat toegestane-zeer-speciale-karakters.tsv|wc -l`
