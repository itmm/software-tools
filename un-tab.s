
	.text
	.global main
main:
	mov r4, lr

	
	mov r5, #8

	
loop:
	bl getchar
	cmp r0, #0
	blt done
	
	cmp r0, $'\t
	bne no_tab

tab_loop:
	mov r0, $' 
	bl putchar
	subs r5, r5, #1
	bne tab_loop
	mov r5, #8
	b loop

no_tab:

	
	bl putchar

	subs r5, r5, #1
	moveq r5, #8

	cmp r0, $'\n
	moveq r5, #8

	b loop
done:


	mov r0, #0
	mov pc, r4
