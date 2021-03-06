# copy
* Kopiert Eingabe in Ausgabe
* Um das Programm einfach zu halten, werden Ein- und Ausgaben über
  C-Funktionen ausgeführt
* Es wird so lange einzelne Zeichen gelesen und ausgegeben, bis das
  Ende der Eingabe erreicht ist

```
@Def(| ./asm.sh copy)
	@Mul(symbols)
	.data
	@put(data)
	.text
	@put(code)
@end(| ./asm.sh copy)
```
* Das Programm verwendet und erweitert die Symbol-Tabelle aus dem
  Programm `hello`
* Auch dieses Programm besteht aus einem Code- und einem Daten-Segment

```
@def(code)
	.global _start
@f(_start):
	@put(copy)
	@Mul(exit)
@end(code)
```
* Das Programm kopiert die gesamte Standard-Eingabe in die
  Standard-Ausgabe
* Danach beendet sich das Programm

# Kopierschleife
* In der Kopierschleife wird ein Block an Daten geladen und danach
  geschrieben
* Das Programm kopiert die gesamte Eingabe blockweise

```
@def(copy)
loop:
	@put(loop)
finish:
@end(copy)
```
* Das `loop`-Fragment implementiert die eigentliche Schleife
* Nachdem das Programm eine Iteration verarbeitet hat, springt es
  wieder zu `loop`
* Wenn das Programm nichts mehr lesen kann, wird zum Ende gesprungen

```
@def(data)
	@Mul(buffer)
@end(data)
```
* Im Daten-Segment hat das Programm einen Buffer definiert
* In diesem legt das Programm gelesene Zeichen ab

```
@Def(buffer)
	.equ buffer_size, 4096
buffer:
	.space buffer_size
@end(buffer)
```
* Der Buffer hat eine Größe von 4 Kilobyte
* Der Assembler legt die Größe im Symbol `buffer_size` ab
* Das restliche Programm muss so die aktuelle Größe nicht kennen
* sondern arbeitet nur mit dem Symbol `buffer_size`

```
@Add(symbols)
	.equ read, 3
	.equ stdin, 0
@end(symbols)
```
* Der `read`-Trap hat die Nummer `3`
* Der File-Descriptor für die Standard-Eingabe ist `0`

```
@def(loop)
	@Put(read buffer)
	@Mul(write buffer)
	@put(next)
@end(loop)
```
* Das Programm befüllt den Buffer
* und schreibt ihn dann aus
* Wenn das Programm beim Lesen das Ende erkennt, springt es nach
  `finish`
* Danach durchläuft das Programm die Schleife erneut

```
@Def(read buffer)
	mov r7, #read
	mov r0, #stdin
	ldr r1, =buffer
	ldr r2, =buffer_size
	swi 0
@end(read buffer)
```
* Das Programm liest Bytes in den Buffer

```
@Add(read buffer)
	cmp r0, #0
	ble finish
@end(read buffer)
```
* Wenn das Ergebnis kleiner oder gleich `0` ist, dann ist das Ende
  erreicht

```
@def(next)
	b loop
@end(next)
```
* Nachdem nun die Abbruchbedingung der Schleife im Code steht, kann  das
  Programm am Ende der Schleife zur nächsten Iteration zurück
  springen

```
@Def(write buffer)
	mov r7, #write
	mov r2, r0
	mov r0, #stdout
	ldr r1, =buffer
	swi 0
@end(write buffer)
```
* Das Programm schreibt die befüllten Bytes des Buffers
* Die Anzahl der Bytes sichert es als neue Länge bevor das Register
  mit dem File-Descriptor überschrieben wird
