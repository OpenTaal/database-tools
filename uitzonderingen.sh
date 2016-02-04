#TODO https://sf.own-it.nl/projects/opentaal/wiki/Leestekens
if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT exclude_spell_checker,temporal_qualifier,2_10,next_version,word,base_word,alternatief,aantekeningen FROM words_list WHERE exclude_spell_checker <> 0 OR temporal_qualifier <> 0 ORDER BY lower(next_version),lower(2_10),word"|tail -n +5>uitzonderingen.tsv
echo Aantal woorden met uitzonderingen: `cat uitzonderingen.tsv|wc -l`
echo -e "exclude\ttemporal\t2_10\tnext_version\tword\tbasiswoord\talternatief\taantekeningen">header
cat uitzonderingen.tsv>>header
mv -f header uitzonderingen.tsv
