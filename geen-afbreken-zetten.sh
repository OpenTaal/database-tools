if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "UPDATE words_list SET hyphenation = word WHERE (hyphenation = '' AND next_version REGEXP '[KFBDAH]' AND CHAR_LENGTH(word) < 4)"
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "UPDATE words_list SET hyphenation = word WHERE (hyphenation = '' AND next_version REGEXP '[KFBDAH]' AND word REGEXP '^.\\\\.$')"
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "UPDATE words_list SET hyphenation = word WHERE (hyphenation = '' AND next_version REGEXP '[KFBDAH]' AND word REGEXP '^.\\\\..\\\\.$')"
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "UPDATE words_list SET hyphenation = word WHERE (hyphenation = '' AND next_version REGEXP '[KFBDAH]' AND word REGEXP '^.\\\\..\\\\..\\\\.$')"
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "UPDATE words_list SET hyphenation = word WHERE (hyphenation = '' AND next_version REGEXP '[KFBDAH]' AND word REGEXP '^.\\\\..\\\\..\\\\..\\\\.$')"
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "UPDATE words_list SET hyphenation = word WHERE (hyphenation = '' AND next_version REGEXP '[KFBDAH]' AND word REGEXP '^.\\\\..\\\\..\\\\..\\\\..\\\\.$')" # alleen w.v.t.t.k.
# -in niet- dD
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,safehyphenation,hyphenation WHERE next_version REGEXP '[KFBDAH]' AND word REGEXP '^.[aeiou][aeiou].$')"
