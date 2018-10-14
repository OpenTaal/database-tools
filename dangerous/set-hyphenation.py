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
 
for line in open('processed.txt', 'r'):
	if line == '' or line == '\n':
		continue
	hyph = line.strip().split(' ')[0]
	word = hyph.replace('~', '').replace('=', '')
	print('{} // {}'.format(word, hyph))
	query = ("SELECT hyphenation FROM words_list WHERE word = '{}'".format(word))
	cursor.execute(query)
	for (hyphenation, ) in cursor:
		hyphenation = str(hyphenation, 'utf-8')
		if hyphenation == '':
			query2 = ("UPDATE words_list SET hyphenation='{}' WHERE word = '{}'".format(hyph, word))
			cursor2.execute(query2)
			cnx.commit()
		else:
			if hyphenation == hyph:
				print('WARNING: Word {} already has hyphenation {} while trying to set it again to {}'.format(word, hyphenation, hyph))
			else:
				print('ERROR: Word {} already has hyphenation {} while trying to set it to different value of {}'.format(word, hyphenation, hyph))
		break

cursor.close()
cursor2.close()

cnx.close()
