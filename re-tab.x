# un-tab - Tabulatoren expandieren

```
D{file: re-tab.s}
	.text
	.global main
f{main}:
	mov r4, lr

	e{setup}
	e{loop}

	mov r0, #0
	mov pc, r4
x{file: re-tab.s}
```
* Der ausführbare Bereich besteht nur aus der `main`-Funktion
* Vor der Schleife werden die Variablen initialisiert

```
d{setup}
	mov r5, #8
x{setup}
```
* `r5` gibt an, wie viele Freizeichen in der aktuellen Spalte
  ausgegeben werden müssen, wenn ein Tab erweitert wird

```
d{loop}
loop:
	bl f{getchar}
	cmp r0, #0
	blt done
	e{spaces}
	G{no tab}
	b loop
done:
x{loop}
```
* Wenn die Eingabe zu Ende ist, wird die Schleife verlassen
* Zuerst wird auf Leerzeichen geprüft
* Ansonsten werden die restlichen Zeichen verarbeitet
* Dieser Teil wird aus dem Programm `un-tab` kopiert

```
d{spaces}
	cmp r0, s{$' }
	bne no_space

	mov r6, #1
space_loop:
	e{space loop}
	e{write spaces}

no_space:
x{spaces}
```
* Wenn kein Leerzeichen gelesen wurde
* Dann geht in den Default-Teil
* Ansonsten zählt `r6` wie viele Leerzeichen gelesen und noch nicht
  ausgegeben wurden
* Und in der Schleife werden Leerzeichen gelesen und durch Tabulatoren
  ersetzt
* Überschüssige Leerzeichen müssen danach noch ausgegeben werden

```
d{space loop}
	subs r5, r5, #1
	bne no_tab_yet

	e{write tab}

no_tab_yet:
	e{next char}
x{space loop}
```
* Wenn der Spaltenzähler `0` wird, kann ein Tabulator ausgegeben werden
* Andernfalls wird das nächste Zeichen gelesen
* Und die Space-Schleife weiter durchlaufen so lange es sich um ein
  Leerzeichen handelt

```
d{write tab}
	mov r0, s{$'\t}
	bl f{putchar}
	mov r6, #0
	mov r5, #8
x{write tab}
```
* Ein Tabulator-Zeichen wird ausgegeben
* Der Spaltenzähler wird aktualisiert
* Und der Zähler der Leerzeichen zurückgesetzt

```
d{next char}
	bl f{getchar}
	cmp r0, s{$' }
	bne no_more_space
	add r6, r6, #1
	b space_loop

no_more_space:
x{next char}
```
* Wenn das nächste Zeichen kein Leerzeichen ist, wird die Schleife
  verlassen
* Sonst wird der Zähler erhöht und die Schleife erneut durchlaufen

```
d{write spaces}
	mov r7, r0

write_spaces_loop:
	subs r6, r6, #1
	blt end_of_write_spaces
	mov r0, s{$' }
	bl f{putchar}
	b write_spaces_loop

end_of_write_spaces:
	mov r0, r7
x{write spaces}
```
* In `r0` steht das nächste Zeichen
* Es wird in `r7` gesichert, da `putchar` das Register verändert
* Es werden `r6` viele Leerzeichen ausgegeben

