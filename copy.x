# copy
* Kopiert Eingabe in Ausgabe
* Um das Programm einfach zu halten, werden Ein- und Ausgaben über
  C-Funktionen ausgeführt
* Es wird so lange einzelne Zeichen gelesen und ausgegeben, bis das
  Ende der Eingabe erreicht ist

```
D{file: copy.s}
	.text
	.global main
f{main}:
	mov r4, lr
	e{loop}
done:
	mov r0, #0
	mov pc, r4
x{file: copy.s}
```
* Der ausführbare Bereich besteht nur aus der `main`-Funktion
* Diese ist global sichtbar, damit sie vom C Startup-Code angesprungen
  werden kann
* Der Rücksprung-Wert wird in das Register `r4` gesichert
* Die Register `r0` bis `r3` können von Funktionen verändert werden
* Am Ende wird der Return-Wert auf `0` gesetzt
* Und die Funktion verlassen

```
d{loop}
loop:
	bl f{getchar}
	cmp r0, #0
	blt done
	bl f{putchar}
	b loop
x{loop}
```
* In der Hauptschleife werden einzelne Zeichen mit der C-Funktion
  `getchar` gelesen
* Wenn das Ende erreicht ist, dann ist der Rückgabewert der Funktion
  negativ
* Und das Ende ist erreicht
* Ansonsten wird das Zeichen mit der Funktion `putchar` ausgegeben
* Und das nächste Zeichen gelesen

