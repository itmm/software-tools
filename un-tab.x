# un-tab - Tabulatoren expandieren

```
@Def(file: un-tab.s)
	.text
	.global main
@f(main):
	mov r4, lr

	@put(setup)
	@put(loop)

	mov r0, #0
	mov pc, r4
@end(file: un-tab.s)
```
* Der ausführbare Bereich besteht nur aus der `main`-Funktion
* Vor der Schleife werden die Variablen initialisiert

```
@def(setup)
	mov r5, #8
@end(setup)
```
* `r5` gibt an, wie viele Freizeichen in der aktuellen Spalte
  ausgegeben werden müssen, wenn ein Tab erweitert wird

```
@def(loop)
loop:
	bl @f(getchar)
	cmp r0, #0
	blt done
	@put(expand tab)
	@Mul(no tab)
	b loop
done:
@end(loop)
```
* Wenn die Eingabe zu Ende ist, wird die Schleife verlassen
* Zuerst wird auf einen Tabulator geprüft
* Ansonsten werden die restlichen Zeichen verarbeitet

```
@def(expand tab)
	cmp r0, @s($'\t)
	bne no_tab

tab_loop:
	mov r0, @s($' )
	bl @f(putchar)
	subs r5, r5, #1
	bne tab_loop
	mov r5, #8
	b loop

no_tab:
@end(expand tab)
```
* Wenn kein Tabulator gelesen wird, dann wird in den Else-Zweig
  gesprungen
* Es werden so viele Freizeichen ausgegeben, wie der Zähler enthält
* Danach wird der Zähler neu initialisiert
* Und das nächste Zeichen gelesen

```
@Def(no tab)
	bl @f(putchar)

	subs r5, r5, #1
	moveq r5, #8

	cmp r0, @s($'\n)
	moveq r5, #8
@end(no tab)
```
* Sonst wird das Zeichen ausgegeben
* Und der Zähler reduziert
* Wenn er auf `0` fällt wird er neu initialisiert
* Oder wenn ein Zeilenumbruch gelesen wurde

