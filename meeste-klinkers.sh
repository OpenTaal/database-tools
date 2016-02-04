if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT next_version,word,base_word,alternatief FROM words_list WHERE next_version <> 'x' AND next_version <> 'X' AND next_version <> 'h' <> next_version <> 'H' AND word REGEXP '.*[aeiou]{5,}.*' ORDER BY lower(next_version),word"|tail -n +5>meeste-klinkers.tsv
echo Aantal woorden met meer dan 5 aaneensluitende klinkers is: `cat meeste-klinkers.tsv|wc -l`
echo -e "oordeel\twoord\tbasiswoord\talternatief">header
cat meeste-klinkers.tsv>>header
mv -f header meeste-klinkers.tsv
