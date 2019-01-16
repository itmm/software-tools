# crypt
* Verschlüsselt die Eingabe

```
D{file: crypt.s}
	.text
	.global main
f{main}:
	mov r4, lr
	e{setup}
	e{loop}
done:
	mov r0, #0
	mov pc, r4
x{file: crypt.s}
```
* Der ausführbare Bereich besteht nur aus der `main`-Funktion

```
d{setup}
	cmp r0, #2
	bne copy_loop
	ldr r5, [r1, #4]
	ldrb r2, [r5]
	cmp r2, #0
	beq copy_loop
	mov r6, r5
x{setup}
```

```
d{loop}
loop:
	bl getchar
	cmp r0, #0
	blt done
	ldrb r1, [r6], #1
	cmp r1, #0
	bne no_reset
	mov r6, r5
	ldrb r1, [r6], #1
no_reset:
	eor r0, r0, r1
	bl putchar
	b loop
x{loop}
```

```
a{loop}
copy_loop:
	bl getchar
	cmp r0, #0
	blt done
	bl putchar
	b copy_loop
x{loop}
```

