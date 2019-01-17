# crypt
* Verschlüsselt die Eingabe
* Dies Schlüssel werden als Argumente übergeben
* Die Eingabe wird mit Zeichen aus jedem Schlüssel exklusiv
  oder-verknüpft

```
D{file: crypt.s}
	.text
	.global main
f{main}:
	stmfd sp!, {lr}
	e{crypt}
	mov r0, #0
	ldmfd sp!, {lr}
	mov pc, lr
x{file: crypt.s}
```
* Der ausführbare Bereich besteht nur aus der `main`-Funktion
* Diesmal wird die Rücksprung-Adresse auf dem Stack gesichert
* Und von dort wieder hergestellt

```
d{crypt}
	mov r4, sp
	e{copy args on stack}
	e{loop}
	mov sp, r4
x{crypt}
```
* Der Stack wird nach `r4` gesichert und Zeiger auf die Argumente auf
  den Stack gelegt
* Diese können mit jedem Zeichen der Eingabe weiter geschoben werden
* Nach der Schleife wird es wieder zurückgesetzt

```
d{loop}
loop:
	bl getchar
	cmp r0, #0
	blt done
	e{encrypt char}
	bl putchar
	b loop
done:
x{loop}
```
* In der Schleife werden die Zeichen gelesen
* Jedes Zeichen wird für sich separat verschlüsselt

```
d{copy args on stack}
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
x{copy args on stack}
```
* Das erste Argument ist der Name des Programms
* Ein Zeiger auf das erste wirkliche Argument wird gesichert
* Dann werden die Zeiger auf die Argumente auf den Stapel geschoben

```
d{encrypt char}
	mov r1, sp
crypt_loop:
	cmp r1, r4
	beq end_of_crypt_loop
	ldr r2, [r1]
	e{encrypt with key}
	str r2, [r1]
	add r1, r1, #4
	b crypt_loop
end_of_crypt_loop:
x{encrypt char}
```
* Alle Argumente vom Stapel werden durchgegangen
* Der Zeiger auf das Argument wird in `r2` abgelegt
* Und wird nach der Verschlüsselung zurückgespeichert
* In der Verschlüsselung muss der Zeiger weiter geschoben werden

```
d{encrypt with key}
	ldrb r3, [r2]
	cmp r3, #0
	addne r2, #1
	bne valid_ch

	e{reset key}

valid_ch:
	eor r0, r0, r3
x{encrypt with key}
```
* Wenn das aktuelle Zeichen ein Null-Byte ist, wird versucht den
  Schlüssel zurückzusetzen
* Und das erste Zeichen zu verwenden
* Ansonsten wird das aktuelle Zeichen benutzt und der Zeiger weiter
  geschoben

```
d{reset key}
	sub r6, r4, r1
	add r6, r6, r5
	ldr r2, [r6]
	ldrb r3, [r2]
	cmp r3, #0
	addne r2, #1
x{reset key}
```
* Zuerst wird in `r6` abgelegt, wie groß der Abstand zum gespeicherten
  Stapel-Anfang ist
* Das ist `4` für das erste Argument, `8` für das zweite und so weiter
* Dieser Werte kann zum Start der Argument-Liste addiert werden, um das
  ursprüngliche Argument zu erhalten
* Denn an `0`-ter Stelle steht dort der Programm-Name
* Das erste Zeichen wird verwendet
* Und der Zähler erhöht, wenn es nicht schon das letzte Zeichen ist

