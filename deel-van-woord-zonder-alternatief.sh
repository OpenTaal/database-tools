if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
# aantekeningen tot nu toe voor deze resultaten altijd NULL geweest, daarom niet nodig te vermelden
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version = 'd' AND alternatief = '' ORDER BY word">deel-van-woord-zonder-alternatief.tsv
echo Aantal woorden die deel van woord zijn maar geen alternatief hebben: `cat deel-van-woord-zonder-alternatief.tsv|tail -n +5|wc -l`
