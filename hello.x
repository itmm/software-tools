# Ein erstes Assembler-Programm
* Dieses Kapitel beschreibt ein minimales Assembler-Programm für den
  Raspberry Pi
* Dieses Programm gibt einen fester Text aus
* Dabei wird nicht die C-Bibliothek verwendet
* Sondern nur direkte Aufrufe von Kernel-Funktionen

```
@Def(file: hello.S)
	@put(parts)
@end(file: hello.S)
```
* Das Programm besteht aus mehreren Teilen

```
@def(parts)
	G{symbols}
@end(parts)
```
* Am Anfang des Programms stehen Symbol-Definitionen
* Anstatt von nackten Zahlen verwendet das Programm beschreibende Namen
* und ist so verständlicher

```
@add(parts)
	.global _start
_start:
	@put(write)
	G{exit}
	@put(data)
@end(parts)
```
* Das Programm gibt nur die Nachricht aus
* und beendet sich danach selber
* Der Text liegt am Ende des Programms

## Programm beenden
* Das Programm muss sich mit dem Aufruf des `exit`-Traps beenden
* Ansonsten stürzt das Programm ab

```
@Def(symbols)
	.equ exit, 1
	.equ exit_success, 0
@end(symbols)
```
* Der Exit-Trap hat die Nummer `1`
* und erwartet den Return-Code im Register `r0`
* Mit dem Return-Code `0` signalisiert das Programm einen fehlerlosen
  Ablauf

```
@Def(exit)
	mov r7, #exit
	mov r0, #exit_success
	swi 0
@end(exit)
```
* Die Trap-Nummer steht in Register `r7`
* Die Argumente des Traps stehen in den Registern `r0` bis `r6`
* `exit` hat nur ein Argument
* Aus diesem Trap erfolgt kein Rücksprung

## Nachricht ausgeben
* Gibt eine feste Nachricht aus
* Die Nachricht liegt in der Daten-Sektion

```
@def(data)
msg:
	.ascii "Hallo Welt\n"
	.equ msg_len, . - msg
@end(data)
```
* In der Daten-Sektion liegt die Nachricht, die das Programm ausgibt
* Der Assembler berechnet die Länge der Nachricht
* und hält sie in einem Symbol fest
* Die Nachricht enthält kein abschließendes Null-Byte

```
@Add(symbols)
	.equ write, 4
	.equ stdout, 1
@end(symbols)
```
* Die Trap-Nummer für `write` ist `4`
* Und der offene Datei-Handle für die Standard-Ausgabe ist `1`

```
@def(write)
	mov r7, #write
	mov r0, #stdout
	add r1, pc, #(msg - . - 8)
	mov r2, #msg_len
	swi 0
@end(write)
```
* Der `write`-Trap hat die Ausgabe-Datei als erstes Argument
* Das zweite Argument ist der Start der Bytes, die ausgegeben werden
* Dies wird relativ zum Programm-Counter berechnet
* Das dritte Argument ist die Anzahl der Bytes

