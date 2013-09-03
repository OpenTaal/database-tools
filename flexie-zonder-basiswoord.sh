if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
# aantekeningen tot nu toe voor deze resultaten altijd NULL geweest, daarom niet nodig te vermelden
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version,word,alternatief,aantekeningen FROM words_list WHERE (next_version = 'f' OR next_version = 'F') AND base_word = '' ORDER BY word">flexie-zonder-basiswoord.tsv
echo Aantal flexievormen die helaas geen basiswoord hebben: `cat flexie-zonder-basiswoord.tsv|tail -n +5|wc -l`
