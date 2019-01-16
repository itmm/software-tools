
	.text
	.global main
main:
	mov r4, lr

	
	mov r5, #8

	
loop:
	bl getchar
	cmp r0, #0
	blt done
	
	cmp r0, $' 
	bne no_space

	mov r6, #1
space_loop:
	
	subs r5, r5, #1
	bne no_tab_yet

	
	mov r0, $'\t
	bl putchar
	mov r6, #0
	mov r5, #8


no_tab_yet:
	
	bl getchar
	cmp r0, $' 
	bne no_more_space
	add r6, r6, #1
	b space_loop

no_more_space:


	
	mov r7, r0

write_spaces_loop:
	subs r6, r6, #1
	blt end_of_write_spaces
	mov r0, $' 
	bl putchar
	b write_spaces_loop

end_of_write_spaces:
	mov r0, r7


no_space:

	
	bl putchar

	subs r5, r5, #1
	moveq r5, #8

	cmp r0, $'\n
	moveq r5, #8

	b loop
done:


	mov r0, #0
	mov pc, r4
