	.data
reply:
	.string "%d\n"

	.text
	.global main

main:
	mov r6, lr
	mov r5, #0
	mov r4, #0

loop:
	bl getchar
	cmp r0, #0
	blt done
	cmp r0, $' 
	movle r5, #0
	ble loop
	cmp r5, #0
	addeq r4, r4, #1
	mov r5, #1
	b loop

done:
	ldr r0, =reply
	mov r1, r4
	bl printf

	mov r0, #0
	mov pc, r6
