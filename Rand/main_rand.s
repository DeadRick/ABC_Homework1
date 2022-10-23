	.file	"main_rand.c"
	.intel_syntax noprefix			# Используем синтаксис Интела
	.text					# Начало секции
	.globl	timespecDiff			# Объявление функции 
	.type	timespecDiff, @function		# Отмечаем, что это функция
timespecDiff:
	push	rbp				# Пролог функции
	mov	rbp, rsp
	mov	rax, rdi			# Конец пролога
	mov	r8, rsi				# r8 := rsi
	mov	rsi, rax			# rsi := raxы
	mov	rdi, rdx			# rdi := rdx
	mov	rdi, r8				# rdi := r8
	mov	r13, rsi			# Заданные переменные в функции	
	mov	r14, rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	r15, rax			# nsecA
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000		# nsecA *= 1000000000;
	mov	QWORD PTR -8[rbp], rax		# rax := nsecA;
	mov	rax, r14
	add	QWORD PTR -8[rbp], rax		# nsecA += timeA.tv_nsec;
	mov	rax, QWORD PTR -48[rbp]
	mov	r15, rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000		# nsecB *= 1000000000;
	mov	r15, rax			# rax := nsecB;
	mov	rax, QWORD PTR -40[rbp]
	add	r15, rax			# nsecA += timeA.tv_nsec;
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]		# return nsecA - nsecB;
	pop	rbp
	ret					# Эпилог функции.
	.size	timespecDiff, .-timespecDiff
	.section	.rodata
.LC0:						# Метки с текстом и объявление main
	.string	"Elapsed: %ld ns"
	.text
	.globl	main				# Объявляем main
	.type	main, @function			# Отмечаем, что это функция
main:
	push	rbp				# Стандартный эпилог мейна
	mov	rbp, rsp
	sub	rsp, 880
	mov	DWORD PTR -868[rbp], edi	# int argc
	mov	QWORD PTR -880[rbp], rsi	# char **argv
	cmp	DWORD PTR -868[rbp], 2		# argc == 2
	jne	.L4				# then go to return 1;
	mov	rax, QWORD PTR -880[rbp]	# rax := rbp - 880
	mov	rax, QWORD PTR 8[rax]		# rax := rax - 8
	mov	rdi, rax		
	call	atoi@PLT			# seed = atoi(arg);
	mov	edi, eax			# edi := eax
	call	srand@PLT			# srand();
	lea	rax, -48[rbp]			# 
	mov	rsi, rax			# rsi := rax
	mov	edi, 1				# edi := 1
	call	clock_gettime@PLT		# clock_gettime();
	mov	r14, 5				# n = 5;
	mov	r12, 0				# i = 0;
	jmp	.L7				# then goto after for { }
.L4:	
	mov	eax, 1				# return 1;
	jmp	.L11
.L8:
	call	rand@PLT			# rand();
	mov	edx, r12		
	cdqe					# sign
	mov	DWORD PTR -464[rbp+rax*4], edx	# A[i] = rand();
	add	r12, 1				# i++;
.L7:
	mov	eax, r12			# eax := rbp
	cmp	eax, r14			# i < n
	jl	.L8				# then goto for { }
	mov	r12, 0				# i = 0
	jmp	.L9				# goto after for { }
.L10:
	mov	ecx, r14 			# func(A, B, i, n)
	mov	edx, r12			# i
	lea	rsi, -864[rbp]			# &A
	lea	rax, -464[rbp]			# &B
	mov	rdi, rax			# rdi := rax;
	call	func@PLT			# call func
	add	r12, 1				# i++;
.L9:
	cmp	r12, 499			# i < 500;
	jle	.L10				# goto in for { }
	lea	rax, -64[rbp]			# rax := rbp - 64
	mov	rsi, rax			# rsi := rax 	
	mov	edi, 1				# edi := 1
	call	clock_gettime@PLT		# call clock_gettime();
	mov	rax, QWORD PTR -48[rbp]		# Передача параметров в timespecDiff
	mov	rdx, QWORD PTR -40[rbp]		# end and start
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rax			
	call	timespecDiff			# call timespecDiff();
	mov	r13, rax			# printf
	mov	rsi, r13
	lea	rdi, .LC0[rip]		
	mov	eax, 0				# Зануляем мусор
	call	printf@PLT			# call printf()
	mov	eax, 0				# return 0;
.L11:
	leave					# Конец
	ret
