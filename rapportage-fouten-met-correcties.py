#!/usr/bin/env python3

import codecs
from difflib import SequenceMatcher

def row(report_file, next, word, correction, link=False, first=True, rows=1):
    word_layout = []
    word_index = -1
    correction_layout = []
    correction_index = -1
    s = SequenceMatcher(None, word, correction)
    for tag, i1, i2, j1, j2 in s.get_opcodes():
#        print("%7s word[%d:%d] (%s) correction[%d:%d] (%s)" %(tag, i1, i2, word[i1:i2], j1, j2, correction[j1:j2]))
        if tag == 'delete':
            if word_index == -1:
                word_layout.append(word[:i1])
            word_layout.append('<span style="background-color:#ff8888;">%s</span>' %word[i1:i2])
            word_index = i2
        elif tag == 'replace':
            word_layout.append('<span style="background-color:#ffcc88;">%s</span>' %word[i1:i2])
            word_index = i2
            correction_layout.append('<span style="background-color:#88ffcc;">%s</span>' %correction[j1:j2])
            correction_index = j2
        elif tag == 'equal':
            word_layout.append(word[i1:i2])
            word_index = i2
            correction_layout.append(correction[j1:j2])
            correction_index = j2
        elif tag == 'insert':
            correction_layout.append('<span style="background-color:#88ff88;">%s</span>' %correction[j1:j2])
            correction_index = j2
    if word_index == -1:
        word_layout = word
    else:
        word_layout = ''.join(word_layout)
    if correction_index == -1:
        correction_layout = correction
    else:
        correction_layout = ''.join(correction_layout)
    if next == 'X':
        next = '<strong>X</strong>'
    if link:
        if row == 1:
            if first:
                report_file.write('<tr><td><a target="_blank" href="http://data.opentaal.org/opentaalbank/spellingcontrole/next_version/bewerkWoordenlijst.php?wordfilter=^%s%%24">%s</a>&nbsp;</td><td>%s</td><td><a target="_blank" href="http://data.opentaal.org/opentaalbank/woorddetails.php?word=%s">i</a>&nbsp;</td><td>%s</td><td><a target="_blank" href="http://data.opentaal.org/opentaalbank/woorddetails.php?word=%s">i</a>&nbsp;</td><td>&nbsp;%1.2f</td></tr>\n' %(word, next, word_layout, word, correction_layout, correction, s.ratio()))
            else:
                report_file.write(u'<tr><td>&nbsp;</td><td>%s</td><td>↲&nbsp;</td><td>%s</td><td><a target="_blank" href="http://data.opentaal.org/opentaalbank/woorddetails.php?word=%s">i</a>&nbsp;</td><td>&nbsp;%1.2f</td></tr>\n' %(word_layout, correction_layout, correction, s.ratio()))
        else:
            if first:
                report_file.write('<tr><td rowspan="%d"><a target="_blank" href="http://data.opentaal.org/opentaalbank/spellingcontrole/next_version/bewerkWoordenlijst.php?wordfilter=^%s%%24">%s</a>&nbsp;</td><td>%s</td><td><a target="_blank" href="http://data.opentaal.org/opentaalbank/woorddetails.php?word=%s">i</a>&nbsp;</td><td>%s</td><td><a target="_blank" href="http://data.opentaal.org/opentaalbank/woorddetails.php?word=%s">i</a>&nbsp;</td><td>&nbsp;%1.2f</td></tr>\n' %(rows, word, next, word_layout, word, correction_layout, correction, s.ratio()))
            else:
                report_file.write(u'<tr><td>%s</td><td>↲&nbsp;</td><td>%s</td><td><a target="_blank" href="http://data.opentaal.org/opentaalbank/woorddetails.php?word=%s">i</a>&nbsp;</td><td>&nbsp;%1.2f</td></tr>\n' %(word_layout, correction_layout, correction, s.ratio()))
    else:
        if row == 1:
            if first:
                report_file.write('<tr><td><a target="_blank" href="http://data.opentaal.org/opentaalbank/woorddetails.php?word=%s">%s</a>&nbsp;</td><td>%s</td><td>%s</td></tr>\n' %(word, next, word_layout, correction_layout))
            else:
                report_file.write('<tr><td>&nbsp;</td><td>%s</td><td>%s</td></tr>\n' %(word_layout, correction_layout))
        else:
            if first:
                report_file.write('<tr><td rowspan="%d"><a target="_blank" href="http://data.opentaal.org/opentaalbank/woorddetails.php?word=%s">%s</a>&nbsp;</td><td>%s</td><td>%s</td></tr>\n' %(rows, word, next, word_layout, correction_layout))
            else:
                report_file.write('<tr><td>%s</td><td>%s</td></tr>\n' %(word_layout, correction_layout))

def report(link=False):
    name = 'rapportage-fouten-met-correcties'
    if link:
        name += '-en-links'
    report_file = codecs.open('%s.html' %name, 'w', 'utf-8')
    report_file.write(u"""<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>Rapportage fouten met correcties</title>
</head>
<body style="font-family:courier;">
<h1>Rapportage fouten met correcties</h1>
<p>OpenTaal heeft bijna 20.000 foute woorden in haar collectie. Van meer dan 2500 woorden zijn ook correcties opgenomen. Deze worden hier getoond om herzien te kunnen worden. Deze correcties zijn noodzakelijk om de suggesties van de automatische spellingcontrole te kunnen valideren. Inmiddels hebben we 700 uitzonderingen voor de spellingcontrole die bijvoorbeeld de volgorde van de suggesties verbetert of suggesties toevoegt die niet werden aangeboden. Onderstaande fouten en correcties zijn dus belangrijk voor een betere spellingcontrole met een groter gebruikersgemak.</p>
<h2>Legenda</h2>
<table border="1">
<tr><th></th><th>betekenis</th><tr>
<tr><td><strong>X</strong></td><td>woord is gemarkeerd als fout</td><tr>
<tr><td>x</td><td>woord is gepland om als fout te markeren</td><tr>
<tr><td><span style="background-color:#ff8888;">&nbsp;&nbsp;</span></td><td>letters die verwijderd moeten worden</td><tr>
<tr><td><span style="background-color:#ffcc88;">&nbsp;&nbsp;</span></td><td>letters die vervangen moeten worden</td><tr>
<tr><td><span style="background-color:#88ff88;">&nbsp;&nbsp;</span></td><td>letters die toegevoegd worden</td><tr>
<tr><td><span style="background-color:#88ffcc;">&nbsp;&nbsp;</span></td><td>letters die voor vervanging zorgen</td><tr>
</table>
<p>Soms heeft een fout woord meerdere correcties die aflopen in relevantie. Het liefst is er maar een correctie per fout woord opgegeven. Dat is niet altijd mogelijk maar er wordt gestreefd naar een correctie per fout woord. Op de x in de eerste kolom zit een link om meer informatie en voorbeeldzinnen van een woord op te vragen.</p>
<h2>Correcties</h2>
<p>Lees onderstaande lijst door en laat ons weten wat verbeterd kan worden via <a href="mailto:info@opentaal.org?subject=Correctie fout woord">info@opentaal.org</a>.</p>
<p>U kunt zich ook bij ons aanmelden om een lijstje van foute woorden die nog geen correcties hebben te voorzien van correcties.</p>
""")

    report_file.write('<table border="1">\n')
    if link:
        report_file.write('<tr><th colspan="2">woord</th><th colspan="2">verbetering</th><th>ratio</th></tr>\n')
    else:
        report_file.write('<tr><th colspan="2">woord</th><th>verbetering</th></tr>\n')
    all_words = []
    all_corrections = []
    for line in codecs.open('fouten-met-correcties.tsv', 'r', 'utf-8'):
        line = line.strip()
        if line.count('\t') != 4:
            print('ERROR:', line)
            exit(1)
        (id, next, word, count, correction) = line.split('\t')
        if word not in all_words:
            all_words.append(word)
        if ';' in correction:
            corrections = correction.split(';')
            first = True
            rows = len(corrections)
            for corr in corrections:
                if link and corr not in all_corrections:
                    all_corrections.append(corr)
                row(report_file, next, word, corr, link, first, rows)
                first = False
        else:
            if link and correction not in all_corrections:
                all_corrections.append(correction)
            row(report_file, next, word, correction, link)
    if link:
        report_file.write('<tr><th colspan="2">woord</th><th colspan="2">verbetering</th><th>ratio</th></tr>\n')
    else:
        report_file.write('<tr><th colspan="2">woord</th><th>verbetering</th></tr>\n')
    report_file.write('</table>\n')
    
    if link:
        for word in all_words:
            if word in all_corrections:
                print('ERROR: gebruikt als fout woord en als correctie: %s' %word)
    
report()
report(True)
