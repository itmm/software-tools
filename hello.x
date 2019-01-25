# Ein erstes Assembler-Programm
* Dieses Kapitel beschreibt ein minimales Assembler-Programm für den
  Raspberry Pi
* Dieses Programm gibt einen fester Text aus
* Dabei wird nicht die C-Bibliothek verwendet
* Sondern nur direkte Aufrufe von Kernel-Funktionen

```
D{file: hello.S}
	e{parts}
x{file: hello.S}
```
* Das Programm besteht aus mehreren Teilen

```
d{parts}
	e{symbols}
x{parts}
```
* Am Anfang des Programms stehen Symbol-Definitionen
* Anstatt von nackten Zahlen verwendet das Programm beschreibende Namen
* und ist so verständlicher

```
a{parts}
	.data
	e{data}
x{parts}
```
* In der Daten-Sektion stehen Daten, die das Programm verwendet
* Dies können Zahlen oder Texte sein
* Oder nur ein Speicherbereich, den das Programm während der Laufzeit
  braucht

```
a{parts}
	.text
	e{code}
x{parts}
```
* Zum Schluss steht das eigentliche Programm
* in der Text-Sektion

```
d{code}
	.global _start
_start:
	e{write}
	e{exit}
x{code}
```
* Das Programm gibt nur die Nachricht aus
* und beendet sich danach selber

## Programm beenden
* Das Programm muss sich mit dem Aufruf des `exit`-Traps beenden
* Ansonsten stürzt das Programm ab

```
d{symbols}
	.equ exit, 1
	.equ exit_success, 0
x{symbols}
```
* Der Exit-Trap hat die Nummer `1`
* und erwartet den Return-Code im Register `r0`
* Mit dem Return-Code `0` signalisiert das Programm einen fehlerlosen
  Ablauf

```
d{exit}
	mov r7, #exit
	mov r0, #exit_success
	swi 0
x{exit}
```
* Die Trap-Nummer steht in Register `r7`
* Die Argumente des Traps stehen in den Registern `r0` bis `r6`
* `exit` hat nur ein Argument
* Aus diesem Trap erfolgt kein Rücksprung

## Nachricht ausgeben
* Gibt eine feste Nachricht aus
* Die Nachricht liegt in der Daten-Sektion

```
d{data}
message:
	.ascii "Hallo Welt\n"
	.equ message_size, . - message
x{data}
```
* In der Daten-Sektion liegt die Nachricht, die das Programm ausgibt
* Der Assembler berechnet die Länge der Nachricht
* und hält sie in einem Symbol fest
* Die Nachricht enthält kein abschließendes Null-Byte

```
a{symbols}
	.equ write, 4
	.equ stdout, 1
x{symbols}
```
* Die Trap-Nummer für `write` ist `4`
* Und der offene Datei-Handle für die Standard-Ausgabe ist `1`

```
d{write}
	mov r7, #write
	mov r0, #stdout
	ldr r1, =message
	ldr r2, =message_size
	swi 0
x{write}
```
* Der `write`-Trap hat die Ausgabe-Datei als erstes Argument
* Das zweite Argument ist der Start der Bytes, die ausgegeben werden
* Das dritte Argument ist die Anzahl der Bytes

