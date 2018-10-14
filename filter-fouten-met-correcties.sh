cat header > autotext.xml
cat fouten-met-correcties.tsv |awk -F '\t' '{print "    <word src=\""$3"\">"$5}'|sed -e 's/;.*//g'|sed -e 's/$/<\/word>/g' >> autotext.xml
echo '<\words>' >> autotext.xml
