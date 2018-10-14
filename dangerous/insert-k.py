#!/usr/bin/env python3

import mysql.connector

#exit(0)
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
 
#for line in open('correcties.tsv', 'r'):
for line in open('b', 'r'):
	word = line[:-1].replace("'", "\\'")
#	print(word, corr)
	query = ("INSERT INTO words_list (word, next_version) VALUES ('{}', 'k')".format(word))
#	print(query)
	try:
		cursor.execute(query)
		pass
	except:
		print(word)
		query = ("UPDATE words_list SET next_version='k' WHERE word='{}'".format(word))
		print(query)
		try:
			cursor.execute(query)
			pass
		except:
			print('ZZZ')
		
cnx.commit()
cursor.close()
cnx.close()
