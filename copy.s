
	.text
	.global main
main:
	mov r4, lr
	
loop:
	bl getchar
	cmp r0, #0
	blt done
	bl putchar
	b loop

done:
	mov r0, #0
	mov pc, r4
