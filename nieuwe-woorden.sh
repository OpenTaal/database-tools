if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,alternatief,aantekeningen FROM words_list WHERE next_version = 'k' AND 2_10 <> 'K'"          >nieuwe-woorden-basiswoord-te-keuren.tsv
echo Aantal nieuwe woorden basiswoord te keuren: `cat nieuwe-woorden-basiswoord-te-keuren.tsv|tail -n +5|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,alternatief,aantekeningen FROM words_list WHERE next_version = 'b' AND 2_10 <> 'B'"          >nieuwe-woorden-basiswoord-ongekeurd.tsv
echo Aantal nieuwe woorden basiswoord ongekeurd: `cat nieuwe-woorden-basiswoord-ongekeurd.tsv|tail -n +5|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,alternatief,aantekeningen FROM words_list WHERE next_version = 'd' AND 2_10 <> 'D'"          >nieuwe-woorden-deel-van.tsv
echo Aantal nieuwe woorden deel van: `cat nieuwe-woorden-deel-van.tsv|tail -n +5|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,base_word,alternatief,aantekeningen FROM words_list WHERE next_version = 'f' AND 2_10 <> 'F'">nieuwe-woorden-flexievorm.tsv
echo Aantal nieuwe woorden flexievorm: `cat nieuwe-woorden-flexievorm.tsv|tail -n +5|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,word,alternatief,aantekeningen FROM words_list WHERE next_version = 'x' AND 2_10 <> 'X'"     >nieuwe-woorden-fout.tsv
echo Aantal nieuwe woorden fout: `cat nieuwe-woorden-fout.tsv|tail -n +5|wc -l`
