
	
	
	.equ exit, 1
	.equ exit_success, 0

	.equ write, 4
	.equ stdout, 1


	.data
	
message:
	.ascii "Hallo Welt\n"
	.equ message_size, . - message


	.text
	
	.global _start
_start:
	
	mov r7, #write
	mov r0, #stdout
	ldr r1, =message
	ldr r2, =message_size
	swi 0

	
	mov r7, #exit
	mov r0, #exit_success
	swi 0



