/*
 * Author: Andrew Johnston
 * Date: 10/06/2020
 * Class: CMPE-120
 * Project: Term Project
 * Group: #6
 * 
 * Adds two arrays A and B together and stores the results in C:
 * for (int i = 0; i < 4; i++) C[i] = A[i] + B[i]
 *
 * For testing purposes as required in the spec, we only need to iteratate
 * from i = 0 to i = 3 and we need to have the arrays pre-defined in .data.
 *
 * To validate the results in array C: 
 * (1) run the program in debug mode by using the command: make debug
 * (2) Find the place to insert a breakpoint using the command multiple times: list
 * (3) Insert a breakpoint after the registers are loaded in the _check_values
 * label with: b [number], for example: b 54
 * (4) Use the command to run the program in debug mode: run
 * (5) Use the command to view the registers contents: info r
 */

.global _start

_start:
	MOV R0, #0			@ i = 0
	LDR R1, =A			@ Loading address of A[0]
	LDR R2, =B			@ Loading address of B[0]
	LDR R3, =C			@ Loading address of C[0]
	MOV R4, #0			@ Used to hold the sum as it's being calculated

_calc_array_loop:
	CMP R0, #4			@ if (i = 4) 
	BEQ _calc_done			@ then exit loop

	LDR R5, [R1], #4		@ Load values stored at A[i]
	LDR R6, [R2], #4		@ Load values stored at B[i]
	ADD R4, R5, R6			@ A[i] + B[i]
	STR R4, [R3], #4		@ Store R5 into C[i]

	ADD R0, R0, #1			@ i++
	B _calc_array_loop		@ Branch to the next iteration

_calc_done:
	MOV R0, #0			@ i = 0

_check_values:
	LDR R0, =C			@ Load address of C into R0
	LDR R1, [R0]			@ C[0] = 6
	LDR R2, [R0, #4]		@ C[1] = 8
	LDR R3, [R0, #8]		@ C[2] = 10
	LDR R4, [R0, #12]		@ C[3] = 12
	
					@ Insert breakpoint on this line # to inspect registers R1 - R4 before termination

_exit:
	MOV R7, #1			@ Syscall for exit
	SWI 0				@ Software interupt

.data
A:	.word	1, 2, 3, 4		@ Array A initialized with [1, 2, 3, 4]
B:	.word	5, 6, 7, 8		@ Array B initialized with [5, 6, 7, 8]
C:	.word	0, 0, 0, 0		@ Array C initialized with [0]
