if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
# bewust geen 'h' of 'H'
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT 2_10,next_version,woordtype,exclude_spell_checker,temporal_qualifier,word,base_word,alternatief,aantekeningen FROM words_list WHERE (next_version = 'k' OR next_version = 'K' OR next_Version = 'b' OR next_version = 'B' OR next_version = 'd' OR next_version = 'D') AND woordtype <> '' AND woordtype <> 'rangtelwoord' AND woordtype <> 'romeins getal' AND woordtype <> 'klemtoonschrijfwijze' ORDER BY word"|tail -n +5|sort>woorden-met-woordtype.tsv
echo Aantal wijzigingen: `cat woorden-met-woordtype.tsv|wc -l`
echo -e "2_10\tnext\twoordtype\texclude\ttemporal\tword\tbasiswoord\talternatief\taantekeningen">header
cat woorden-met-woordtype.tsv>>header
mv -f header woorden-met-woordtype.tsv
