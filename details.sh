if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -B -e "SELECT word,next_version,2_10,2_00,1_10,1_00,ntg1996,egb,base_word,alternatief,woordtype,exclude_spell_checker,temporal_qualifier FROM words_list ORDER BY word"|tail -n +2>details.tsv
echo 'Aantal woorden voor details: '`cat details.tsv|wc -l`
bzip2 -f details.tsv
