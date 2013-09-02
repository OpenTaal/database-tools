if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,alternatief,aantekeningen FROM words_list WHERE next_version = 'k' AND 2_10 != 'K'"          >nieuwe-woorden-basiswoord-te-keuren.tsv
echo Aantal nieuwe woorden basiswoord te keuren: `cat nieuwe-woorden-basiswoord-te-keuren.tsv|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,alternatief,aantekeningen FROM words_list WHERE next_version = 'b' AND 2_10 != 'B'"          >nieuwe-woorden-basiswoord-ongekeurd.tsv
echo Aantal nieuwe woorden basiswoord ongekeurd: `cat nieuwe-woorden-basiswoord-ongekeurd.tsv|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,alternatief,aantekeningen FROM words_list WHERE next_version = 'd' AND 2_10 != 'D'"          >nieuwe-woorden-deel-van.tsv
echo Aantal nieuwe woorden deel van: `cat nieuwe-woorden-deel-van.tsv|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,base_word,alternatief,aantekeningen FROM words_list WHERE next_version = 'f' AND 2_10 != 'F'">nieuwe-woorden-flexievorm.tsv
echo Aantal nieuwe woorden flexievorm: `cat nieuwe-woorden-flexievorm.tsv|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,word,alternatief,aantekeningen FROM words_list WHERE next_version = 'x' AND 2_10 != 'X'"     >nieuwe-woorden-fout.tsv
echo Aantal nieuwe woorden fout: `cat nieuwe-woorden-fout.tsv|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,alternatief,aantekeningen FROM words_list WHERE next_version = 'y'"                          >nieuwe-woorden-kandidaat-y.tsv
echo Aantal nieuwe woorden kandidaat y: `cat nieuwe-woorden-kandidaat-y.tsv|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,alternatief,aantekeningen FROM words_list WHERE next_version = 'z'"                          >nieuwe-woorden-kandidaat-z.tsv
echo Aantal nieuwe woorden kandidaat z: `cat nieuwe-woorden-kandidaat-z.tsv|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,aantekeningen FROM words_list WHERE next_version = 'w' AND 2_10 != 'V'"                      >nieuwe-woorden-verwarrend-te-keuren.tsv
echo Aantal nieuwe woorden verwarrend te keuren: `cat nieuwe-woorden-verwarrend-te-keuren.tsv|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,aantekeningen FROM words_list WHERE next_version = 'v' AND 2_10 != 'V'"                      >nieuwe-woorden-verwarrend-ongekeurd.tsv
echo Aantal nieuwe woorden verwarrend ongekeurd: `cat nieuwe-woorden-verwarrend-ongekeurd.tsv|wc -l`
mysql opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,aantekeningen FROM words_list WHERE next_version = 'u' AND 2_10 != 'V'"                      >nieuwe-woorden-verwarrend-flexievorm.tsv
echo Aantal nieuwe woorden verwarrend flexievorm: `cat nieuwe-woorden-verwarrend-flexievorm.tsv|wc -l`
