#!/usr/bin/env python3

import mysql.connector

exit(0)
databaseUsername = ''
databasePassword = ''
for line in open('../.database-username', 'r'):
	databaseUsername = line.strip()
	break
for line in open('../.database-password', 'r'):
	databasePassword = line.strip()
	break

cnx = mysql.connector.connect(user=databaseUsername, password=databasePassword, host='127.0.0.1', database='opentaal')
cursor = cnx.cursor()
cursor2 = cnx.cursor()
 
for line in open('a', 'r'):
	if line == '' or line == '\n':
		continue
	word = line[:-1].replace("'", "\\'")
	query = ("SELECT next_version FROM words_list WHERE word = '{}'".format(word))
	cursor.execute(query)
	for (next_version, ) in cursor:
		next_version = str(next_version, 'utf-8')
		if next_version == '-':
			query2 = ("UPDATE words_list SET next_version='b' WHERE word = '{}'".format(word))
			cursor2.execute(query2)
			cnx.commit()
		else:
			print(word)
		break

cursor.close()
cursor2.close()

cnx.close()
