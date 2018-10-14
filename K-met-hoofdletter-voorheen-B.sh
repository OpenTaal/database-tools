if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,base_word,alternatief,aantekeningen FROM words_list WHERE word REGEXP '.*[A-Z].*' AND next_version = 'K' AND 2_10 = 'B' ORDER BY word"|tail -n +5>K-met-hoofdletter-voorheen-B.tsv
echo Aantal woorden: `cat K-met-hoofdletter-voorheen-B.tsv|wc -l`
echo -e "woord\tbasiswoord\talternatief\taantekeningen">header
cat K-met-hoofdletter-voorheen-B.tsv>>header
mv -f header K-met-hoofdletter-voorheen-B.tsv
