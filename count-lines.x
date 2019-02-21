# count-lines - Zeilen der Eingabe zählen
* Zählt alle Zeilen der Eingabe

```
@Def(file: count-lines.s)
	@put(data)
	@put(code)
@end(file: count-lines.s)
```
* Auch hier besteht das Programm aus einem Datenblock
* Und einem Code-Block

```
@def(data)
	.data
	@put(data entries)
@end(data)
```
* Der Datenblock enthält Einträge

```
@def(code)
	.text
	@put(main)
@end(code)
```
* Der Code-Block nur die `main` Funktion

```
@def(main)
	.global main
main:
	mov r4, lr

	@put(setup)
	@put(loop)
	@Mul(reply)

	mov r0, #0
	mov pc, r4
@end(main)
```
* Wie vorher wird die Rücksprung-Adresse gesichert
* Danach der Status initialisiert
* Die Zeichen in einer Schleife eingelesen
* Und zum Schluss die Summe ausgegeben

```
@def(setup)
	mov r5, #0
@end(setup)
```
* Das Zähl-Register wird mit `0` initialisiert

```
@def(loop)
loop:
	bl getchar
	cmp r0, #0
	blt done
	cmp r0, s{$'\n}
	addeq r5, r5, #1
	b loop
done:
@end(loop)
```
* In der Schleife prüft das Programm zuerst, ob das Ende erreicht ist
* Wenn nicht wird getestet, ob das Zeichen ein Zeilenumbruch ist
* Nur in diesem Fall wird der Zähler erhöht

```
@def(data entries)
	@Mul(reply format)
@end(data entries)
```
* Die Ausgabe ist aus dem Programm `count-chars` entnommen
* Dessen Format für die `printf`-Funktion muss hier ebenfalls integriert
  werden

