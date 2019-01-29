
	
	
	.equ exit, 1
	.equ exit_success, 0

	.equ write, 4
	.equ stdout, 1

	.equ read, 3
	.equ stdin, 0


	.global _start
_start:
	
	mov r7, #write
	mov r0, #stdout
	add r1, pc, #(msg - . - 8)
	mov r2, #msg_len
	swi 0

	
	mov r7, #exit
	mov r0, #exit_success
	swi 0

	
msg:
	.ascii "Hallo Welt\n"
	.equ msg_len, . - msg


