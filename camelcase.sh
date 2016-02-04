if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT 2_10,next_version,exclude_spell_checker,word,base_word,alternatief,aantekeningen FROM words_list WHERE next_version <> '-' AND word REGEXP '[a-z][A-Z]' ORDER BY lower(next_version),lower(2_10),word"|tail -n +5>camelcase.tsv
echo Aantal woorden die camelcase zijn: `cat camelcase.tsv|wc -l`
echo -e "2_10\tnext\texclude\tword\tbasiswoord\talternatief\taantekeningen">header
cat camelcase.tsv>>header
mv -f header camelcase.tsv
