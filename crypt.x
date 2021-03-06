# crypt
* Verschlüsselt die Eingabe
* Dies Schlüssel werden als Argumente übergeben
* Die Eingabe wird mit Zeichen aus jedem Schlüssel exklusiv
  oder-verknüpft

```
@Def(| ./c-asm.sh crypt)
	.text
	.global main
@f(main):
	stmfd sp!, {lr}
	@put(crypt)
	mov r0, #0
	ldmfd sp!, {lr}
	mov pc, lr
@end(| ./c-asm.sh crypt)
```
* Der ausführbare Bereich besteht nur aus der `main`-Funktion
* Diesmal wird die Rücksprung-Adresse auf dem Stack gesichert
* Und von dort wieder hergestellt

```
@def(crypt)
	mov r4, sp
	@put(copy args on stack)
	@put(loop)
	mov sp, r4
@end(crypt)
```
* Der Stack wird nach `r4` gesichert und Zeiger auf die Argumente auf
  den Stack gelegt
* Diese können mit jedem Zeichen der Eingabe weiter geschoben werden
* Nach der Schleife wird der Stack wieder zurückgesetzt

```
@def(loop)
loop:
	bl getchar
	cmp r0, #0
	blt done
	@put(encrypt char)
	bl putchar
	b loop
done:
@end(loop)
```
* In der Schleife werden die Zeichen gelesen
* Jedes Zeichen wird für sich separat verschlüsselt
* Das verschlüsselte Zeichen muss in `r0` abgelegt werden

```
@def(copy args on stack)
	mov r5, r1
	add r1, r1, #4

args_loop:
	subs r0, r0, #1
	ble end_of_args_loop

	ldr r2, [r1]
	stmfd sp!, {r2}
	add r1, r1, #4
	b args_loop

end_of_args_loop:
@end(copy args on stack)
```
* Ein Zeiger auf die Argument-Liste wird in `r5` gesichert
* Das erste Argument ist der Name des Programms
* Alle weiteren Argumente werden auf den Stapel geschoben

```
@def(encrypt char)
	mov r1, sp
crypt_loop:
	cmp r1, r4
	beq end_of_crypt_loop

	ldr r2, [r1]
	@put(encrypt with key)
	str r2, [r1]
	add r1, r1, #4
	b crypt_loop

end_of_crypt_loop:
@end(encrypt char)
```
* Alle Argumente vom Stapel werden durchgegangen
* Der Zeiger auf das Argument wird in `r2` abgelegt
* Und wird nach der Verschlüsselung zurückgespeichert
* In der Verschlüsselung muss der Zeiger weiter geschoben werden

```
@def(encrypt with key)
	ldrb r3, [r2]
	cmp r3, #0
	addne r2, #1
	bne valid_ch

	@put(reset key)

valid_ch:
	eor r0, r0, r3
@end(encrypt with key)
```
* Wenn das aktuelle Zeichen ein Null-Byte ist, wird versucht den
  Schlüssel zurückzusetzen
* Und das erste Zeichen zu verwenden
* Ansonsten wird das aktuelle Zeichen benutzt und der Zeiger weiter
  geschoben

```
@def(reset key)
	sub r6, r4, r1
	add r6, r6, r5
	ldr r2, [r6]
	ldrb r3, [r2]
	cmp r3, #0
	addne r2, #1
@end(reset key)
```
* Zuerst wird in `r6` abgelegt, wie groß der Abstand zum gespeicherten
  Stapel-Anfang ist
* Das ist `4` für das erste Argument, `8` für das zweite und so weiter
* Dieser Werte kann zum Start der Argument-Liste addiert werden, um das
  ursprüngliche Argument zu erhalten
* Denn an `0`-ter Stelle steht dort der Programm-Name
* Das erste Zeichen wird verwendet
* Und der Zähler erhöht, wenn es nicht schon das letzte Zeichen ist
