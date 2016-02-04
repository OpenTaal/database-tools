if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT 2_10,next_version,exclude_spell_checker,temporal_qualifier,word,base_word,alternatief,aantekeningen FROM words_list WHERE 2_10 <> next_version AND next_version != 'f' AND next_version != 'F' AND 2_10 = 'F' ORDER BY next_version,word"|tail -n +5>alle-voorheen-flexie.tsv
echo Aantal voorheen flexie: `cat alle-voorheen-flexie.tsv|wc -l`
echo -e "2_10\tnext\texclude\ttemporal\tword\tbasiswoord\talternatief\taantekeningen">header
cat alle-voorheen-flexie.tsv>>header
mv -f header alle-voorheen-flexie.tsv
