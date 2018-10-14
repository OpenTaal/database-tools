#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs
import MySQLdb

databaseUsername = ''
databasePassword = ''
for line in open('../.database-username', 'r'):
	databaseUsername = line.strip()
	break
for line in open('../.database-password', 'r'):
	databasePassword = line.strip()
	break

db=MySQLdb.connect(passwd=databasePassword, db='opentaal', )
db.autocommit(True)
c=db.cursor()

for line in codecs.open('countryNames.txt', 'r', 'utf-8'):
	line = line.strip().replace('\'', '\'\'')
	q = u'SELECT word FROM words_list WHERE word = \'%s\'' %line
	c.execute(q)
	row1 = c.fetchone()
	if row1 is None:
		pass
#		print line
##		q = u'INSERT INTO words_list (word, woordtype, next_version, ntg1996, shorttag, base_word, alternatief, sentences_wherein, woord_status, safehyphenation) VALUES (%s, \'countryName\', \'b\', \'\', \'\', \'\', \'\', 0, \'\', \'\')'
##		p = (line)
##		c.execute(q, p)
	else:
		q = u'SELECT word FROM words_list WHERE word = %s AND woordtype = \'\''
		p = (line)
		c.execute(q, p)
		row3 = c.fetchone()
		if row3 is not None:
			q = u'UPDATE words_list SET woordtype=\'countryName\' WHERE word = %s'
			p = (line)
			c.execute(q, p)
			print 'For %s, %d row(s) were updated' %(line, c.rowcount)
		else:
			q = u'SELECT word,woordtype FROM words_list WHERE word = %s AND woordtype NOT LIKE %s'
			p = (line, '%'+'countryName'+'%')
			c.execute(q, p)
			row4 = c.fetchone()
			if row4 is not None:
				q = u'UPDATE words_list SET woordtype=\'countryName\' WHERE word = %s'
#				q = u'UPDATE words_list SET woordtype=CONCAT(woordtype, \';countryName\') WHERE word = %s'
				p = (line)
#				print q, p
				c.execute(q, p)
				print 'For %s, %d row(s) were updated' %(line, c.rowcount)
