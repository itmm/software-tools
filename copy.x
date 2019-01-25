# copy
* Kopiert Eingabe in Ausgabe
* Um das Programm einfach zu halten, werden Ein- und Ausgaben über
  C-Funktionen ausgeführt
* Es wird so lange einzelne Zeichen gelesen und ausgegeben, bis das
  Ende der Eingabe erreicht ist

```
D{file: copy.S}
	G{symbols}
	.data
	e{data}
	.text
	e{code}
x{file: copy.S}
```
* Das Programm verwendet und erweitert die Symbol-Tabelle aus dem
  Programm `hello`
* Auch dieses Programm besteht aus einem Code- und einem Daten-Segment

```
d{code}
	.global _start
f{_start}:
	e{copy}
	G{exit}
x{code}
```
* Das Programm kopiert die gesamte Standard-Eingabe in die
  Standard-Ausgabe
* Danach beendet sich das Programm

# Kopierschleife
* In der Kopierschleife wird ein Block an Daten geladen und danach
  geschrieben
* Das Programm kopiert die gesamte Eingabe blockweise

```
d{copy}
loop:
	e{loop}
finish:
x{copy}
```
* Das `loop`-Fragment implementiert die eigentliche Schleife
* Nachdem das Programm eine Iteration verarbeitet hat, springt es
  wieder zu `loop`
* Wenn das Programm nichts mehr lesen kann, wird zum Ende gesprungen

```
d{data}
	G{buffer}
x{data}
```
* Im Daten-Segment hat das Programm einen Buffer definiert
* In diesem legt das Programm gelesene Zeichen ab

```
D{buffer}
	.equ buffer_size, 4096
buffer:
	.space buffer_size
x{buffer}
```
* Der Buffer hat eine Größe von 4 Kilobyte
* Der Assembler legt die Größe im Symbol `buffer_size` ab
* Das restliche Programm muss so die aktuelle Größe nicht kennen
* sondern arbeitet nur mit dem Symbol `buffer_size`

```
A{symbols}
	.equ read, 3
	.equ stdin, 0
x{symbols}
```
* Der `read`-Trap hat die Nummer `3`
* Der File-Descriptor für die Standard-Eingabe ist `0`

```
d{loop}
	g{read buffer}
	G{write buffer}
	e{next}
x{loop}
```
* Das Programm befüllt den Buffer
* und schreibt ihn dann aus
* Wenn das Programm beim Lesen das Ende erkennt, springt es nach
  `finish`
* Danach durchläuft das Programm die Schleife erneut

```
D{read buffer}
	mov r7, #read
	mov r0, #stdin
	ldr r1, =buffer
	ldr r2, =buffer_size
	swi 0
x{read buffer}
```
* Das Programm liest Bytes in den Buffer

```
A{read buffer}
	cmp r0, #0
	ble finish
x{read buffer}
```
* Wenn das Ergebnis kleiner oder gleich `0` ist, dann ist das Ende
  erreicht

```
d{next}
	b loop
x{next}
```
* Nachdem nun die Abbruchbedingung der Schleife im Code steht, kann
  das Programm am Ende der Schleife zur nächsten Iteration zurück
  springen

```
D{write buffer}
	mov r7, #write
	mov r2, r0
	mov r0, #stdout
	ldr r1, =buffer
	swi 0
x{write buffer}
```
* Das Programm schreibt die befüllten Bytes des Buffers
* Die Anzahl der Bytes sichert es als neue Länge bevor das Register
  mit dem File-Descriptor überschrieben wird

