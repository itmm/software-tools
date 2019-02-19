# count-words - Wörter in Eingabe zählen
* Zählt alle Wörter der Eingabe
* Ein Wort ist eine Kette von Zeichen, die durch Freizeichen, Tabs oder
  Zeilenumbrüche separiert werden

```
@Def(file: count-words.s)
	@put(data)
	@put(code)
@end(file: count-words.s)
```
* Wieder eine Aufteilung in Daten und Code

```
@def(data)
	.data
	@put(data entries)
@end(data)
```
* Die Daten enthalten Einträge

```
@def(code)
	.text
	@put(main)
@end(code)
```
* Und der Code besteht nur aus der `main`-Funktion

```
@def(main)
	.global main
main:
	mov r4, lr

	@put(setup)
	@put(loop)
	G{reply}

	mov r0, #0
	mov pc, r4
@end(main)
```
* Das Rücksprung-Register wird gesichert
* Und die drei Schritte Setup, Zeichen lesen und Ausgabe werden
  abgearbeitet

```
@def(setup)
	mov r5, #0
	mov r6, #0
@end(setup)
```
* Diesmal werden zwei Register verwendet
* `r5` ist wieder der Zähler
* `r6` signalisiert mit einem Wert ungleich `0`, dass das letzte Zeichen
  Teil eines Wortes war

```
@def(loop)
loop:
	bl getchar
	cmp r0, #0
	blt done
	@put(space handling)
	@put(word handling)
	b loop
done:
@end(loop)
```
* Die Schleife wird wieder beendet, wenn das Ende erreicht ist
* Diesmal werden zuerst Freizeichen behandelt
* Danach werden Wort-Zeichen behandelt

```
@def(space handling)
	cmp r0, s{$' } 
	movle r6, #0
	ble loop
@end(space handling)
```
* Das aktuelle Zeichen wird mit dem Freizeichen verglichen
* Wenn es kleiner oder gleich ist, dann ist es nicht Teil eines Wortes
* Die Wort-Markierung wird gelöscht
* Und die Schleife neu durchlaufen
* Durch das `le` werden diese beiden Befehle nur für Zeichen ausgeführt,
  die nicht Teil eines Wortes sind

```
@def(word handling)
	cmp r6, #0
	addeq r5, r5, #1
	mov r6, #-1
@end(word handling)
```
* Wenn der Code an diese Stelle kommt, dann ist das aktuelle Zeichen
  Teil eines Worts
* Wenn das vorherige Zeichen nicht Teil eines Wortes war, dann ist ein
  neues Wort gefunden
* Und der Zähler wird erhöht
* Die Wort-Markierung kann in jedem Fall gesetzt werden

```
@def(data entries)
	G{reply format}
@end(data entries)
```
* Wieder wird die Ausgabe von `count-chars` übernommen
* Das verwendete Format muss eingebunden werden

