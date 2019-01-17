
	.text
	.global main
main:
	mov r4, lr
	
	mov r5, r0
	mov r6, r1

	
	add r6, r6, #4
	subs r5, r5, #1
	beq done

loop:
	
	ldr r7, [r6]
write_arg_loop:
	ldrb r0, [r7], #1
	cmp r0, #0
	beq write_arg_end
	bl putchar
	b write_arg_loop
write_arg_end:

	
	add r6, r6, #4
	subs r5, r5, #1
	beq done

	
	mov r0, $' 
	bl putchar

	b loop
done:
	
	mov r0, $'\n
	bl putchar


	mov r0, #0
	mov pc, r4
