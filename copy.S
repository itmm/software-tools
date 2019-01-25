
	
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
	
loop:
	
	
	mov r7, #read
	mov r0, #stdin
	ldr r1, =buffer
	ldr r2, =buffer_size
	swi 0

	cmp r0, #0
	ble finish

	
	mov r7, #write
	mov r2, r0
	mov r0, #stdout
	ldr r1, =buffer
	swi 0

	
	b loop


finish:

	
	mov r7, #exit
	mov r0, #exit_success
	swi 0


