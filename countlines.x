# countlines - Zeilen der Eingabe zählen
* Zählt alle Zeilen der Eingabe

```
D{file: countlines.s}
	e{data}
	e{code}
x{file: countlines.s}
```
* Auch hier besteht das Programm aus einem Datenblock
* Und einem Code-Block

```
d{data}
	.data
	e{data entries}
x{data}
```
* Der Datenblock enthält Einträge

```
d{code}
	.text
	e{main}
x{code}
```
* Der Code-Block nur die `main` Funktion

```
d{main}
	.global main
main:
	mov r4, lr

	e{setup}
	e{loop}
	G{reply}

	mov r0, #0
	mov pc, r4
x{main}
```
* Wie vorher wird die Rücksprung-Adresse gesichert
* Danach der Status initialisiert
* Die Zeichen in einer Schleife eingelesen
* Und zum Schluss die Summe ausgegeben

```
d{setup}
	mov r5, #0
x{setup}
```
* Das Zähl-Register wird mit `0` initialisiert

```
d{loop}
loop:
	bl getchar
	cmp r0, #0
	blt done
	cmp r0, $'\n
	addeq r5, r5, #1
	b loop
done:
x{loop}
```
* In der Schleife prüft das Programm zuerst, ob das Ende erreicht ist
* Wenn nicht wird getestet, ob das Zeichen ein Zeilenumbruch ist
* Nur in diesem Fall wird der Zähler erhöht

```
d{data entries}
	G{reply format}
x{data entries}
```
* Die Ausgabe ist aus dem Programm `countchars` entnommen
* Dessen Format für die `printf`-Funktion muss hier ebenfalls integriert
  werden

