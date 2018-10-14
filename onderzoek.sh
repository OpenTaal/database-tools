if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,safehyphenation,hyphenation FROM words_list WHERE next_version REGEXP '[KFBDAH]' AND word REGEXP '^.[aeiou][aeiou].$'"
