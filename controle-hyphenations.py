#!/usr/bin/env python3

from re import sub
from difflib import SequenceMatcher

output = open('controle-hyphenations.html', 'w')
output.write("""<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>Rapportage afbreekpatronen met fouten</title>
</head>
<body style="font-family:courier;">
<h1>Rapportage afbreekpatronen met fouten</h1>
<table border="1">
""")
for line in open('controle-hyphenations.tsv', 'r'):
	word, hyph = line[:-1].split('\t')
	stripped = hyph
	stripped = stripped.replace('{///}', '/')
	while '<' in stripped and '>' in stripped:
		stripped = sub(r'(.*)<(.*)>(.*)', r'\1\2\3', stripped)
	while '{' in stripped and '/' in stripped and '}' in stripped:
		stripped = sub(r'(.*){(.*)/(.*)}(.*)', r'\1\2\4', stripped)
	while '[' in stripped and '/' in stripped and ']' in stripped:
		stripped = sub(r'(.*)\[(.*)/(.*)\](.*)', r'\1\2\4', stripped)
	stripped = stripped.replace('~', '').replace('=', '').replace('|', '')
	if word != stripped:
		word_layout = []
		word_index = -1
		stripped_layout = []
		stripped_index = -1
		s = SequenceMatcher(None, word, stripped)
		for tag, i1, i2, j1, j2 in s.get_opcodes():
			if tag == 'delete':
				if word_index == -1:
					word_layout.append(word[:i1])
				word_layout.append('<span style="background-color:#ff8888;">%s</span>' %word[i1:i2])
				word_index = i2
			elif tag == 'replace':
				word_layout.append('<span style="background-color:#ffcc88;">%s</span>' %word[i1:i2])
				word_index = i2
				stripped_layout.append('<span style="background-color:#88ffcc;">%s</span>' %stripped[j1:j2])
				stripped_index = j2
			elif tag == 'equal':
				word_layout.append(word[i1:i2])
				word_index = i2
				stripped_layout.append(stripped[j1:j2])
				stripped_index = j2
			elif tag == 'insert':
				stripped_layout.append('<span style="background-color:#88ff88;">%s</span>' %stripped[j1:j2])
				stripped_index = j2
		if word_index == -1:
			word_layout = word
		else:
			word_layout = ''.join(word_layout)
		if stripped_index == -1:
			stripped_layout = stripped
		else:
			stripped_layout = ''.join(stripped_layout)


		output.write('<tr><td>{}</td><td>{}</td></tr>\n'.format(word_layout, stripped_layout))

output.write("""</table>
</body>
</html>
""")
