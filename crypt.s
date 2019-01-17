
	.text
	.global main
main:
	stmfd sp!, {lr}
	
	mov r4, sp
	
	mov r5, r1
	add r1, r1, #4
args_loop:
	subs r0, r0, #1
	ble end_of_args_loop
	ldr r2, [r1]
	stmfd sp!, {r2}
	add r1, r1, #4
	b args_loop
end_of_args_loop:

	
loop:
	bl getchar
	cmp r0, #0
	blt done
	
	mov r1, sp
crypt_loop:
	cmp r1, r4
	beq end_of_crypt_loop
	ldr r2, [r1]
	
	ldrb r3, [r2]
	cmp r3, #0
	addne r2, #1
	bne valid_ch

	
	sub r6, r4, r1
	add r6, r6, r5
	ldr r2, [r6]
	ldrb r3, [r2]
	cmp r3, #0
	addne r2, #1


valid_ch:
	eor r0, r0, r3

	str r2, [r1]
	add r1, r1, #4
	b crypt_loop
end_of_crypt_loop:

	bl putchar
	b loop
done:

	mov sp, r4

	mov r0, #0
	ldmfd sp!, {lr}
	mov pc, lr
