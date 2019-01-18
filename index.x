# Software Tools in GNU ARM Assembler
* Implementierung der Software Tools von Kernighan und Plauger in
  GNU ARM Assembler
* Start-Projekt, um strukturierte Maschinensprache zu entwickeln
* Laufen auf Raspberry Pi 3

```
i{copy.x}
```
* Erstes Programm kopiert die Eingabe in die Ausgabe
* Durch Anwahl von `copy.x` im `@include`-Tag kann in die Beschreibung
  von `copy` gewechselt werden

```
i{count-chars.x}
```
* Zählt alle Zeichen der Eingabe und gibt die Anzahl aus
* Durch Anwahl von `count-chars.x` im `@include`-Tag kann in die
  Beschreibung von `count-chars` gewechselt werden

```
i{count-lines.x}
```
* Zählt alle Zeilen der Eingabe und gibt die Anzahl aus
* Durch Anwahl von `count-lines.x` im `@include`-Tag kann in die
  Beschreibung von `count-lines` gewechselt werden

```
i{count-words.x}
```
* Zählt alle Wörter der Eingabe und gibt die Anzahl aus
* Durch Anwahl von `count-words.x` im `@include`-Tag kann in die
  Beschreibung von `count-words` gewechselt werden

```
i{un-tab.x}
```
* Wandelt Tabulatoren in Freizeichen um
* Durch Anwahl von `un-tab.x` im `@include`-Tag kann in die Beschreibung
  von `un-tab` gewechselt werden

```
i{re-tab.x}
```
* Wandelt Freizeichen in Tabulatoren um
* Durch Anwahl von `re-tab.x` im `@include`-Tag kann in die Beschreibung
  von `re-tab` gewechselt werden

```
i{echo.x}
```
* Gibt alle Argumente aus

```
i{crypt.x}
```

