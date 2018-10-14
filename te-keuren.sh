if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
# aantekeningen tot nu toe voor deze resultaten altijd NULL geweest, daarom niet nodig te vermelden
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT 2_10,next_version,exclude_spell_checker,temporal_qualifier,word,base_word,alternatief,woordtype,aantekeningen FROM words_list WHERE next_version REGEXP '[kKdDfFbBhH]' ORDER BY lower(next_version),lower(2_10),word"|tail -n +5|sort>te-keuren.tsv
echo Aantal woorden in zoekresultaat: `cat te-keuren.tsv|wc -l`
echo -e "2_10\tnext\texclude\ttemp\twoord\tbasiswoord\talternatief\taantekeningen">header
cat te-keuren.tsv>>header
mv -f header te-keuren.tsv
#mv -f te-keuren.tsv te-keuren-`date +%Y%m%d`.tsv
