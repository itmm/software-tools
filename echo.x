# echo
* Gibt alle Argumente aus

```
D{file: echo.s}
	.text
	.global main
f{main}:
	mov r4, lr
	e{loop}
	mov r0, #0
	mov pc, r4
x{file: echo.s}
```
* Der ausführbare Bereich besteht nur aus der `main`-Funktion

```
d{loop}
	mov r5, r0
	mov r6, r1
x{loop}
```
* Die Anzahl der Argumente plus eins `r0` wird in `r5` gesichert
* Der Zeiger auf die Liste der Argument `r1` wird in `r6` gesichert
* Die Register `r0` und `r1` können von Funktionsaufrufen verändert
  werden

```
d{next arg}
	add r6, r6, #4
	subs r5, r5, #1
	beq done
x{next arg}
```
* Die Zähler werden in diesem Fragment weiter gezählt
* Wenn das Ende erreicht ist, wird zum Ende der Schleife gesprungen
* Dieser Teil ist als Fragment ausgelagert, da er zweimal verwendet
  wird

```
a{loop}
	E{next arg}
loop:
	e{write arg}
	E{next arg}
	e{write space}
	b loop
done:
	e{write newline}
x{loop}
```
* Da bei allen außer dem ersten Argument ein Leerzeichen vor dem
  Argument ausgegeben werden soll muss zweimal die Zähler angepaßt
  werden
* Alternativ könnte in einem weiteren Register ein Flag abgelegt werden
* Das Fragment wurde vorher definiert, um Endlosschleifen an dieser
  Stelle zu vermeiden

```
d{write arg}
	ldr r7, [r6]
write_arg_loop:
	ldrb r0, [r7], #1
	cmp r0, #0
	beq write_arg_end
	bl f{putchar}
	b write_arg_loop
write_arg_end:
x{write arg}
```
* Die Ausgabe erfolgt Zeichen für Zeichen bis das abschließende
  Null-Byte erreicht ist
* Alternativ könnten die C-Funktionen `puts` oder `printf` verwendet
  werden
* Aber es wird versucht, die Abhängigkeit zur C-Bibliothek zu reduzieren

```
d{write space}
	mov r0, s{$' }
	bl f{putchar}
x{write space}
```
* Gibt ein Leerzeichen aus

```
d{write newline}
	mov r0, s{$'\n}
	bl f{putchar}
x{write newline}
```
* Gibt einen Zeilenumbruch aus

