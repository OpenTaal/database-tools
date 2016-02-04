if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word FROM words_list WHERE next_version REGEXP '[^Xx-]' AND no_ij_ligature <> 1 AND word LIKE '%ffij%' ORDER BY word"|tail -n +5>ffi-ligatuur-ongewenst.txt
echo Aantal woorden waar ffi-ligatuur ongewenst is: `cat ffi-ligatuur-ongewenst.txt|wc -l`
