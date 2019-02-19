# Software Tools in GNU ARM Assembler
* Implementierung der Software Tools von Kernighan und Plauger in
  GNU ARM Assembler
* Start-Projekt, um strukturierte Maschinensprache zu entwickeln
* Laufen auf Raspberry Pi 3

```
@inc(hello.x)
```
* Das erste Programm `hello` gibt nur einen festen Text aus
* Der Link `hello.x` im `@include`-Tag führt zur Beschreibung vom
  Programm `hello`

```
@inc(copy.x)
```
* Das Programm `copy` kopiert die Eingabe in die Ausgabe
* Der Link `copy.x` im `@include`-Tag führt zur Beschreibung vom
  Programm `copy`

```
@inc(echo.x)
```
* Das Programm `echo` gibt alle Argumente aus
* Der Link `echo.x` im `@include`-Tag führt zur Beschreibung vom
  Programm `echo`

```
@inc(count-chars.x)
```
* Zählt alle Zeichen der Eingabe und gibt die Anzahl aus
* Durch Anwahl von `count-chars.x` im `@include`-Tag kann in die
  Beschreibung von `count-chars` gewechselt werden

```
@inc(count-lines.x)
```
* Zählt alle Zeilen der Eingabe und gibt die Anzahl aus
* Durch Anwahl von `count-lines.x` im `@include`-Tag kann in die
  Beschreibung von `count-lines` gewechselt werden

```
@inc(count-words.x)
```
* Zählt alle Wörter der Eingabe und gibt die Anzahl aus
* Durch Anwahl von `count-words.x` im `@include`-Tag kann in die
  Beschreibung von `count-words` gewechselt werden

```
@inc(un-tab.x)
```
* Wandelt Tabulatoren in Freizeichen um
* Durch Anwahl von `un-tab.x` im `@include`-Tag kann in die Beschreibung
  von `un-tab` gewechselt werden

```
@inc(re-tab.x)
```
* Wandelt Freizeichen in Tabulatoren um
* Durch Anwahl von `re-tab.x` im `@include`-Tag kann in die Beschreibung
  von `re-tab` gewechselt werden

```
@inc(crypt.x)
```

