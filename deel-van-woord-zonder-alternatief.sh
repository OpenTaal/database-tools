if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
# aantekeningen tot nu toe voor deze resultaten altijd NULL geweest, daarom niet nodig te vermelden
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE (next_version = 'd' OR next_version = 'D') AND alternatief = '' ORDER BY word"|tail -n +5|sort>deel-van-woord-zonder-alternatief.txt
echo Aantal woorden die deel van woord zijn maar geen alternatief hebben: `cat deel-van-woord-zonder-alternatief.txt|wc -l`
