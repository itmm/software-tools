
	
	.data
	
	
reply:
	.string "%d\n"



	
	.text
	
	.global main
main:
	mov r4, lr

	
	mov r5, #0
	mov r6, #0

	
loop:
	bl getchar
	cmp r0, #0
	blt done
	
	cmp r0, $'  
	movle r6, #0
	ble loop

	
	cmp r6, #0
	addeq r5, r5, #1
	mov r6, #-1

	b loop
done:

	
	ldr r0, =reply
	mov r1, r5
	bl printf


	mov r0, #0
	mov pc, r4


