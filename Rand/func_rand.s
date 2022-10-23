	.file	"func_rand.c"
	.intel_syntax noprefix
	.text
	.globl	func
	.type	func, @function
func:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	DWORD PTR -36[rbp], edx
	mov	DWORD PTR -40[rbp], ecx
	mov	DWORD PTR -4[rbp], 0
	mov	DWORD PTR -36[rbp], 0
	jmp	.L2
.L6:
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jne	.L3
	cmp	DWORD PTR -4[rbp], 0
	jne	.L3
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	DWORD PTR [rax], 1
	jmp	.L4
.L3:
	cmp	DWORD PTR -4[rbp], 0
	jne	.L5
	mov	DWORD PTR -4[rbp], 1
.L5:
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -36[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	mov	rdx, QWORD PTR -32[rbp]
	add	rdx, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
.L4:
	add	DWORD PTR -36[rbp], 1
.L2:
	mov	eax, DWORD PTR -36[rbp]
	cmp	eax, DWORD PTR -40[rbp]
	jl	.L6
	nop
	pop	rbp
	ret
	.size	func, .-func
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
