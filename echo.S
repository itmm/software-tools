
	
	.equ exit, 1
	.equ exit_success, 0

	.equ write, 4
	.equ stdout, 1

	.equ read, 3
	.equ stdin, 0

	.data
	
	
	.equ buffer_size, 4096
buffer:
	.space buffer_size


	.text
	
	.global _start
_start:
	
	ldr r8, =buffer
	ldr r9, =buffer_size
	add r9, r8, r9
	mov r10, r8

	
	ldmfd sp!, {r11}
	add sp, sp, #4
	mov r12, #-1

loop:
	subs r11, r11, #1
	ble finish
	
	cmp r12, #0
	bne no_space
	
	cmp r10, r9
	blt space_for_space
	
	sub r0, r10, r8
	
	mov r7, #write
	mov r2, r0
	mov r0, #stdout
	ldr r1, =buffer
	swi 0

	mov r10, r8

space_for_space:
	mov r0, $' 
	strb r0, [r10], #1

no_space:
	mov r12, #0

	ldmfd sp!, {r12}
arg_loop:
	ldrb r14, [r12], #1
	cmp r14, #0
	beq finish_arg_loop
	cmp r10, r9
	blt space_for_arg
	
	sub r0, r10, r8
	
	mov r7, #write
	mov r2, r0
	mov r0, #stdout
	ldr r1, =buffer
	swi 0

	mov r10, r8

space_for_arg:
	strb r14, [r10], #1
	b arg_loop
finish_arg_loop:
	mov r12, #0

	b loop
finish:

	
	cmp r10, r9
	blt space_for_newline
	
	sub r0, r10, r8
	
	mov r7, #write
	mov r2, r0
	mov r0, #stdout
	ldr r1, =buffer
	swi 0

	mov r10, r8

space_for_newline:
	mov r0, $'\n 
	strb r0, [r10], #1

	
	sub r0, r10, r8
	
	mov r7, #write
	mov r2, r0
	mov r0, #stdout
	ldr r1, =buffer
	swi 0

	mov r10, r8

	
	mov r7, #exit
	mov r0, #exit_success
	swi 0


