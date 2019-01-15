# copy
* Kopiert Eingabe in Ausgabe

```
D{file: copy.s}
	.text
	.global main
main:
	mov r4, lr
	e{loop}
done:
	mov r0, #0
	mov pc, r4
x{file: copy.s}
```

```
d{loop}
loop:
	bl getchar
	cmp r0, #0
	blt done
	bl putchar
	b loop
x{loop}
```

