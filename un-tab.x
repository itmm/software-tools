# un-tab - Tabulatoren expandieren

```
D{file: un-tab.s}
	.text
	.global main
f{main}:
	mov r4, lr

	e{setup}
	e{loop}

	mov r0, #0
	mov pc, r4
x{file: un-tab.s}
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
	e{expand tab}
	e{no tab}
	b loop
done:
x{loop}
```
* Wenn die Eingabe zu Ende ist, wird die Schleife verlassen
* Zuerst wird auf einen Tabulator geprüft
* Ansonsten werden die restlichen Zeichen verarbeitet

```
d{expand tab}
	cmp r0, s{$'\t}
	bne no_tab

tab_loop:
	mov r0, s{$' }
	bl f{putchar}
	subs r5, r5, #1
	bne tab_loop
	mov r5, #8
	b loop

no_tab:
x{expand tab}
```
* Wenn kein Tabulator gelesen wird, dann wird in den Else-Zweig
  gesprungen
* Es werden so viele Freizeichen ausgegeben, wie der Zähler enthält
* Danach wird der Zähler neu initialisiert
* Und das nächste Zeichen gelesen

```
d{no tab}
	bl f{putchar}

	subs r5, r5, #1
	moveq r5, #8

	cmp r0, s{$'\n}
	moveq r5, #8
x{no tab}
```
* Sonst wird das Zeichen ausgegeben
* Und der Zähler reduziert
* Wenn er auf `0` fällt wird er neu initialisiert
* Oder wenn ein Zeilenumbruch gelesen wurde

