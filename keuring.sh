if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi

DT=`date +%Y%m%d`

#kK txt
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version REGEXP '[kKdD]' ORDER BY word"|tail -n +5>A_keuring_basiswoord_$DT.txt
echo Aantal basiswoorden letters: `cat A_keuring_basiswoord_$DT.txt|wc -l`

#kK csv
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,2_10,base_word,alternatief,woordtype,aantekeningen FROM words_list WHERE next_version REGEXP '[kKdD]' ORDER BY word"|tail -n +5|sed 's/NULL//'>A_keuring_basiswoord_$DT.csv
echo Aantal basiswoorden met details: `cat A_keuring_basiswoord_$DT.csv|wc -l`
echo -e "woord\t2_10\tbasiswoord\talternatief\taantekeningen">header
cat A_keuring_basiswoord_$DT.csv>>header
mv -f header A_keuring_basiswoord_$DT.csv

#bB txt
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version REGEXP '[bB]' ORDER BY word"|tail -n +5>B_keuring_namen_ed_$DT.txt
echo Aantal namen: `cat B_keuring_namen_ed_$DT.txt|wc -l`

#bB csv
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,2_10,base_word,alternatief,woordtype,aantekeningen FROM words_list WHERE next_version REGEXP '[bB]' ORDER BY word"|tail -n +5|sed 's/NULL//'>B_keuring_namen_ed_$DT.csv
echo Aantal namen met details: `cat B_keuring_namen_ed_$DT.csv|wc -l`
echo -e "woord\t2_10\tbasiswoord\talternatief\taantekeningen">header
cat B_keuring_namen_ed_$DT.csv>>header
mv -f header B_keuring_namen_ed_$DT.csv

# package

rm -rf keuring_$DT-deel1
mkdir keuring_$DT-deel1
cp readme_en_licentie.txt keuring_$DT-deel1
mv ?_keuring_*txt ?_keuring_*csv keuring_$DT-deel1
zip -r keuring_$DT-deel1.zip keuring_$DT-deel1
ls -lh keuring_$DT-deel1.zip
cp -f keuring_$DT-deel1.zip /var/www/opentaal.nl/www/htdocs/downloads/
echo http://data.opentaal.org/downloads/keuring_$DT-deel1.zip
