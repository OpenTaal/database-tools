if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT 2_10,next_version,word,base_word,alternatief,aantekeningen FROM words_list WHERE alternatief LIKE '%;%;%' ORDER BY lower(next_version),lower(2_10),word"|tail -n +5|sort>meer-dan-een-alternatief.tsv
echo Aantal woorden met meer dan een alternatief: `cat meer-dan-een-alternatief.tsv|wc -l`
echo -e "2_10\tnext\tword\tbasiswoord\talternatief\taantekeningen">header
cat meer-dan-een-alternatief.tsv>>header
mv -f header meer-dan-een-alternatief.tsv
