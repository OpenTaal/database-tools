if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version,word,base_word,alternatief,aantekeningen FROM words_list WHERE no_ij_ligature = 1 ORDER BY lower(next_version),word"|tail -n +5>ij-geen-lange-ij.tsv
echo Aantal woorden met ij die geen lange ij is: `cat ij-geen-lange-ij.tsv|wc -l`
echo -e "oordeel\twoord\tbasiswoord\talternatief\taantekeningen">header
cat ij-geen-lange-ij.tsv>>header
mv -f header ij-geen-lange-ij.tsv
