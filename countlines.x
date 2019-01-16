# countlines - Zeilen der Eingabe zählen

```
D{file: countlines.s}
	e{data}
	e{code}
x{file: countlines.s}
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
x{setup}
```

```
d{loop}
loop:
	bl getchar
	cmp r0, #0
	blt done
	cmp r0, $'\n
	addeq r5, r5, #1
	b loop
done:
x{loop}
```

```
d{data entries}
	G{reply format}
x{data entries}
```
