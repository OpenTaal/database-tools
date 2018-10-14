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
for line in open('dt-fout_2.csv', 'r'):
	word, corr = line[:-1].split('\t')
#	print(word, corr)
	query = ("INSERT INTO words_list (word, alternatief, next_version) VALUES ('{}', '{}', 'x')".format(word, corr))
	print(query)
	try:
		cursor.execute(query)
		pass
	except:
		query = ("UPDATE words_list SET alternatief='{}',next_version='x' WHERE word='{}'".format(corr, word))
		print(query)
		try:
			cursor.execute(query)
			pass
		except:
			print('ZZZ')
		
cnx.commit()
cursor.close()
cnx.close()
