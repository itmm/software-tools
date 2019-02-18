# count-chars - Zeichen zählen
* Dieses Programm zählt alle Zeichen in der Eingabe
* Auch hier werden wieder die C-Funktionen für die eingentliche Ein-
  und Ausgabe zu Hilfe genommen

```
D{file: count-chars.s}
	@expand(data)
	@expand(code)
@end(file: count-chars.s)
```
* Neben dem Code-Block, der die Maschinensprach-Befehle enthält, gibt
  es noch einen Datenblock
* Dieser enthält eine Zeichenkette zur Ausgabe von Zahlen

```
@def(data)
	.data
	@expand(data entries)
@end(data)
```
* Die einzelnen Daten liegen in der `.data`-Sektion

```
@def(code)
	.text
	@expand(main)
@end(code)
```
* Die ausführbaren Befehle liegen in der `.text`-Sektion
* Es gibt wieder nur eine einzige Funktion `main`

```
@def(main)
	.global main
main:
	mov r4, lr

	@expand(setup)
	@expand(loop)
	G{reply}

	mov r0, #0
	mov pc, r4
@end(main)
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
@def(setup)
	mov r5, #0
@end(setup)
```
* In einem weiteren Register zählt das Programm die Anzahl der gelesenen
  Zeichen

```
@def(loop)
loop:
	bl getchar
	cmp r0, #0
	blt done
	add r5, r5, #1
	b loop
done:
@end(loop)
```
* In der Schleife werden Zeichen gelesen, bis das Ende erreicht ist
* Bei jedem Zeichen wird das Register `r5` um `1` erhöht

```
@def(data entries)
	G{reply format}
@end(data entries)
```
* Es gibt nur ein Datenelement:
* Das Format der Antwort

```
D{reply format}
reply:
	.string "%d\n"
@end(reply format)
```
* Für die Antwort wird die `printf`-Funktion verwendet
* Diese erhält als ersten Parameter eine Zeichenkette
* Diese beschreibt, was wie ausgegeben werden soll
* `%d` steht für eine ganze Zahl und `\n` für einen Zeilenumbruch

```
D{reply}
	ldr r0, =reply
	mov r1, r5
	bl printf
@end(reply)
```
* Für `printf` wird das Format im Register `r0` erwartet
* Und die Zahl im Register `r1`

