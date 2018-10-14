if [ ! -e ../.database-username -a ! -e ../.database-password ]
then
	echo ERROR: Missing ../.database-username and/or ../.database-password files
	exit 1
fi
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT alternatief FROM words_list WHERE (next_version = 'f' OR next_version = 'F' OR next_version = 'k' OR next_version = 'K' OR next_version = 'b' OR next_version = 'B' OR next_version = 'x' OR next_version = 'X' OR next_version = 'h' OR next_version = 'H') AND alternatief <> '' AND alternatief <> '-' ORDER BY alternatief">alle-woorden-uit-alternatieven.txt.tmp
cat alle-woorden-uit-alternatieven.txt.tmp|tail -n +5|sed -e 's/;/\n/g'|sort|uniq>alle-woorden-uit-alternatieven.txt
rm -f alle-woorden-uit-alternatieven.txt.tmp
echo Aantal woorden uit alternatieven: `cat alle-woorden-uit-alternatieven.txt|wc -l`
#mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,word,alternatief FROM words_list WHERE (next_version = 'f' OR next_version = 'F' OR next_version = 'k' OR next_version = 'K') AND alternatief = '' ORDER BY word"|tail -n +5|sort>alle-woorden-zonden-alt.txt
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT word,word,alternatief FROM words_list WHERE (next_version = 'f' OR next_version = 'F' OR next_version = 'k' OR next_version = 'K') AND alternatief <> '' AND alternatief <> '-' ORDER BY word"|tail -n +5|sort>alle-woorden-uit-paren.txt
mysql --silent opentaal -u `cat ../.database-username` -p`cat ../.database-password` -D opentaal -v -e "SELECT alternatief,word,alternatief FROM words_list WHERE (next_version = 'f' OR next_version = 'F' OR next_version = 'k' OR next_version = 'K') AND alternatief <> '' AND alternatief <> '-' ORDER BY alternatief"|tail -n +5|sed -e 's/;/\n/g'|sort>alle-alternatiever-uit-paren.txt
diff alle-woorden-uit-paren.txt alle-alternatiever-uit-paren.txt>unbalanced-pairs.txt
#cat ongebalanceerde-woord-alternatief-paren.tsv|awk '{print $1}'>fix-unbalanced.txt.tmp
#cat ongebalanceerde-woord-alternatief-paren.tsv|awk '{print $2}'>>fix-unbalanced.txt.tmp
#sort fix-unbalanced.txt.tmp|uniq>fix-unbalanced.txt
#rm -f fix-unbalanced.txt.tmp
