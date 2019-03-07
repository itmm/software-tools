# echo
* Gibt alle Argumente aus

```
@Def(| ./asm.sh echo)
	@Mul(symbols)
	.data
	@put(data)
	.text
	@put(code)
@end(| ./asm.sh echo)
```
* Das Programm besteht wieder aus einem Daten-Segment und einem 
  Code-Segment
* Die golbale Symbol-Liste wird wiederverwendet

```
@def(data)
	@Mul(buffer)
@end(data)
```

```
@def(code)
	.global _start
_start:
	@Put(init buffer)
	@put(write arguments)
	@put(add newline)
	@Mul(flush buffer)
	@Mul(exit)
@end(code)
```

```
@Def(init buffer)
	ldr r8, =buffer
	ldr r9, =buffer_size
	add r9, r8, r9
	mov r10, r8
@end(init buffer)
```

```
@Def(flush buffer)
	sub r0, r10, r8
	@Mul(write buffer)
	mov r10, r8
@end(flush buffer)
```

```
@def(add newline)
	cmp r10, r9
	blt space_for_newline
	@Mul(flush buffer)
space_for_newline:
	mov r0, $'\n 
	strb r0, [r10], #1
@end(add newline)
```

```
@def(write arguments)
	ldmfd sp!, {r11}
	add sp, sp, #4
	mov r12, #-1
@end(write arguments)
```

```
@add(write arguments)
loop:
	subs r11, r11, #1
	ble finish
	@put(write argument)
	b loop
finish:
@end(write arguments)
```

```
@def(write argument)
	cmp r12, #0
	bne no_space
	@put(add space)
no_space:
	mov r12, #0
@end(write argument)
```

```
@def(add space)
	cmp r10, r9
	blt space_for_space
	@Mul(flush buffer)
space_for_space:
	mov r0, $' 
	strb r0, [r10], #1
@end(add space)
```

```
@add(write argument)
	ldmfd sp!, {r12}
arg_loop:
	ldrb r14, [r12], #1
	cmp r14, #0
	beq finish_arg_loop
	cmp r10, r9
	blt space_for_arg
	@Mul(flush buffer)
space_for_arg:
	strb r14, [r10], #1
	b arg_loop
finish_arg_loop:
	mov r12, #0
@end(write argument)
```
