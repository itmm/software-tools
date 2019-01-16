# countwords - Wörter in Eingabe zählen

```
D{file: countwords.s}
	e{data}
	e{code}
x{file: countwords.s}
```

```
d{data}
	.data
	e{data entries}
x{data}
```

```
d{code}
	.text
	e{main}
x{code}
```

```
d{main}
	.global main
main:
	mov r4, lr

	e{setup}
	e{loop}
	G{reply}

	mov r0, #0
	mov pc, r4
x{main}
```

```
d{setup}
	mov r5, #0
	mov r6, #0
x{setup}
```

```
d{loop}
loop:
	bl getchar
	cmp r0, #0
	blt done
	cmp r0, $' 
	movle r6, #0
	ble loop
	cmp r6, #0
	addeq r5, r5, #1
	mov r6, #-1
	b loop
done:
x{loop}
```

```
d{data entries}
	G{reply format}
x{data entries}
```

