if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT 2_10,next_version,exclude_spell_checker,word,base_word FROM words_list WHERE (next_version <> 'f' AND next_version <> 'F') AND base_word <> '' ORDER BY lower(next_version),lower(2_10),word"|tail -n +5|sort>impliciete-flexies.tsv
echo 'Aantal impliciete flexies (non-F/f met basiswoord)': `cat impliciete-flexies.tsv|wc -l`
echo -e "2_10\tnext\texclude\tword\tbasiswoord\talternatief\taantekeningen">header
cat impliciete-flexies.tsv>>header
mv -f header impliciete-flexies.tsv
