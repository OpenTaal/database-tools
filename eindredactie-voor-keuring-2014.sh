if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version,2_10,exclude_spell_checker,temporal_qualifier,word,base_word,alternatief,woordtype,aantekeningen FROM words_list WHERE next_version REGEXP '[kKdDtTfFbBXxHh]' ORDER BY LOWER(next_version),LOWER(2_10),word">eindredactie-voor-keuring-2014.tsv
echo Aantal woorden in zoekresultaat: `cat eindredactie-voor-keuring-2014.tsv|tail -n +5|wc -l`
