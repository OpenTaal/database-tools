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
 
basis = set()
for line in open('alle-basiswoorden-ongekeurd.txt', 'r'):
	basis.add(line[:-1])

output = open('flexies-met-ongekeurd-basiswoord.txt', 'w')
query = ("SELECT word, base_word FROM words_list WHERE next_version = 'f' OR next_version = 'F'")
cursor.execute(query)
count = 0
for (word, base_word) in cursor:
	word = str(word, 'utf-8')
	base_word = str(base_word, 'utf-8')
	if base_word in basis:
		count += 1
		output.write('{}\n'.format(word))
print('Aantal flexies met ongekeurd basiswoord is {}'.format(count))
	
cnx.commit()
cursor.close()
cnx.close()
