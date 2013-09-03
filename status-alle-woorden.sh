if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT 2_10,COUNT(*) FROM words_list GROUP BY 2_10"
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version,COUNT(*) FROM words_list GROUP BY next_version"
