#!/usr/bin/env python3

import mysql.connector

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
for line in open('spelling_database_2016_01_18-gb-unique-lemmas.txt', 'r'):
	word = line[:-1]
#	print(word)
	query = ("INSERT INTO woordbeoordelingen (word, beoordelaar, notities, woordsoort, verwerkt) VALUES ('{}', 'wosp', 'Basiswoord woordenlijst 20160118 Spellingwet', 'Nn', 'N')".format(word))
#	print(query)
	try:
		cursor.execute(query)
		pass
	except:
		pass
#		query = ("UPDATE words_list SET alternatief='{}',next_version='x' WHERE word='{}'".format(corr, word))
#		print(query)
#		try:
#			cursor.execute(query)
#			pass
#		except:
#			print('ZZZ')
		
cnx.commit()
cursor.close()
cnx.close()
