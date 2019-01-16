# ccount - Zeichen zählen
* Dieses Programm zählt alle Zeichen in der Eingabe
* Auch hier werden wieder die C-Funktionen für die eingentliche Ein-
  und Ausgabe zu Hilfe genommen

```
D{file: countchars.s}
	e{data}
	e{code}
x{file: countchars.s}
```
* Neben dem Code-Block, der die Maschinensprach-Befehle enthält, gibt
  es noch einen Datenblock
* Dieser enthält eine Zeichenkette zur Ausgabe von Zahlen

```
d{data}
	.data
	e{data entries}
x{data}
```
* Die einzelnen Daten liegen in der `.data`-Sektion

```
d{code}
	.text
	e{main}
x{code}
```
* Die ausführbaren Befehle liegen in der `.text`-Sektion
* Es gibt wieder nur eine einzige Funktion `main`

```
d{main}
	.global main
main:
	mov r4, lr

	e{setup}
	e{loop}
	e{reply}

	mov r0, #0
	mov pc, r4
x{main}
```
* `main` ist global sichtbar und kann so vom Startup-Code aufgerufen
  werden
* Die Rücksprung-Adresse wird wieder in `r4` gesichert
* Da das `lr`-Register bei Funktionsaufrufen überschrieben wird
* Zum Schluss wird der Return-Code auf `0` gesetzt
* Und an die ursprüngliche Adresse zurück gesprungen
* Dazwischen wird der Zustand initialisiert, die Zeichen abgearbeitet
  und das Ergebnis ausgegeben

```
d{setup}
	mov r5, #0
x{setup}
```
* In einem weiteren Register zählt das Programm die Anzahl der gelesenen
  Zeichen

```
d{loop}
loop:
	bl getchar
	cmp r0, #0
	blt done
	add r5, r5, #1
	b loop
done:
x{loop}
```
* In der Schleife werden Zeichen gelesen, bis das Ende erreicht ist
* Bei jedem Zeichen wird das Register `r5` um `1` erhöht

```
d{data entries}
reply:
	.string "%d\n"
x{data entries}
```
* Für die Antwort wird die `printf`-Funktion verwendet
* Diese erhält als ersten Parameter eine Zeichenkette
* Diese beschreibt, was wie ausgegeben werden soll
* `%d` steht für eine ganze Zahl und `\n` für einen Zeilenumbruch

```
d{reply}
	ldr r0, =reply
	mov r1, r5
	bl printf
x{reply}
```
* Für `printf` wird das Format im Register `r0` erwartet
* Und die Zahl im Register `r1`

