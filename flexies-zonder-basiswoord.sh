if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
# aantekeningen tot nu toe voor deze resultaten altijd NULL geweest, daarom niet nodig te vermelden
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version,word,alternatief,aantekeningen FROM words_list WHERE (next_version = 'f' OR next_version = 'F' OR next_version ='u' OR next_version = 'U') AND base_word = '' ORDER BY word"|tail -n +5>flexies-zonder-basiswoord.tsv
echo Aantal flexievormen die helaas geen basiswoord hebben: `cat flexies-zonder-basiswoord.tsv|wc -l`
echo -e "next\tword\talternatief\taantekeningen">header
cat flexies-zonder-basiswoord.tsv>>header
mv -f header flexies-zonder-basiswoord.tsv
