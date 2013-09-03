if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
# aantekeningen tot nu toe voor deze resultaten altijd NULL geweest, daarom niet nodig te vermelden
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version,word,base_word,alternatief,aantekeningen FROM words_list WHERE (next_version = 'b' OR next_version = 'B' OR next_version = 'k' OR next_version = 'K' OR next_version ='v' OR next_version = 'V' OR next_version ='w' OR next_version = 'W') AND base_word <> '' ORDER BY word">basiswoord-met-basiswoord.tsv
echo Aantal basiswoorden die helaas een basiswoord hebben: `cat basiswoord-met-basiswoord.tsv|tail -n +5|wc -l`
