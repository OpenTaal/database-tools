cat upload.sh |awk '{print $4$3}'|sed -e 's/\/var\/www\/opentaal.nl\/www\/htdocs/http:\/\/data.opentaal.org/g'
