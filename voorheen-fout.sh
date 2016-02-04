if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT 2_10,next_version,exclude_spell_checker,temporal_qualifier,word,base_word,alternatief,aantekeningen FROM words_list WHERE 2_10 <> next_version AND next_version <> '-' AND next_version <> 'x' AND next_version <> 'X' AND 2_10 = 'X' ORDER BY lower(next_version),lower(2_10),word"|tail -n +5>voorheen-fout.tsv
echo Aantal voorheen fout: `cat voorheen-fout.tsv|wc -l`
echo -e "2_10\tnext\texclude\ttemporal\tword\tbasiswoord\talternatief\taantekeningen">header
cat voorheen-fout.tsv>>header
mv -f header voorheen-fout.tsv
