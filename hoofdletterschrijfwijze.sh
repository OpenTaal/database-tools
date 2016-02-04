#TODO https://sf.own-it.nl/projects/opentaal/wiki/Leestekens
if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT 2_10,next_version,exclude_spell_checker,word,alternatief,aantekeningen FROM words_list WHERE (next_version = 'h' OR next_version = 'H') ORDER BY lower(next_version),lower(2_10),word"|tail -n +5>hoofdletterschrijfwijze.tsv
echo Aantal woorden die hoofdletterschrijfwijze zijn: `cat hoofdletterschrijfwijze.tsv|wc -l`
echo -e "2_10\tnext\texclude_spell_checker\tword\talternatief\taantekeningen">header
cat hoofdletterschrijfwijze.tsv>>header
mv -f header hoofdletterschrijfwijze.tsv
