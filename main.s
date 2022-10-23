	.intel_syntax noprefix			# Используем синтаксис Интела
	.text					# Начало секции
	.globl	func				# Объявление функции func
	.type	func, @function                 # Отмечаем, что это функция
func:
	push	rbp				# Стандартный пролог функции
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi         # Тут идут переменные, переданные с функции
	mov	QWORD PTR -32[rbp], rsi         # Массив А, массив В
	mov	DWORD PTR -36[rbp], edx		# Итератор i (на стеке видно, что он на 36 месте)
	mov	DWORD PTR -40[rbp], ecx		# Размер массива
	mov	DWORD PTR -4[rbp], 0            # int flag = 0
	mov	DWORD PTR -36[rbp], 0           # Зануляем переменную i в цикле for 
	jmp	.L2				# Затем проверяем условие
.L6:                                            # if (a[i] == 0 && flag == 0)
	mov	eax, DWORD PTR -36[rbp]		
	cdqe
	lea	rdx, 0[0+rax*4]			
	mov	rax, QWORD PTR -24[rbp] 	# a[i] == 0
	add	rax, rdx			
	mov	eax, DWORD PTR [rax]
	test	eax, eax			# && 
	jne	.L3				# Идём в else
	cmp	DWORD PTR -4[rbp], 0		# flag == 0
	jne	.L3				# Если условие не выполнилось, идем в else
	mov	eax, DWORD PTR -36[rbp]         # b[i]
	cdqe
	lea	rdx, 0[0+rax*4]			
	mov	rax, QWORD PTR -32[rbp]		# rax := b[i]
	add	rax, rdx			# rdx := rax
	mov	DWORD PTR [rax], 1		# в b[i] записываем единицу
	jmp	.L4
.L3:						# else {
	cmp	DWORD PTR -4[rbp], 0		# if (flag == 0)
	jne	.L5				# Переход в b[i] = a[i]
	mov	DWORD PTR -4[rbp], 1		# flag = 1 }
.L5:
	mov	eax, DWORD PTR -36[rbp]		# b[i] = a[i]
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
	mov	DWORD PTR [rdx], eax		# Конец b[i] = a[i]
.L4:
	add	DWORD PTR -36[rbp], 1
.L2:						# if (a[i] == 0 && flag == 0)
	mov	eax, DWORD PTR -36[rbp]         # Загружаем int i в стек
	cmp	eax, DWORD PTR -40[rbp]         # Сравниваем с n   
	jl	.L6				# Идём к другому условию 
	nop					# Nope!
	pop	rbp				# Эпилог функции
	ret
	.size	func, .-func
	.section	.rodata
.LC0:						# Всякие метки для строк
	.string	"%d"
.LC1:
	.string	"%i"
.LC2:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 832
	mov	DWORD PTR -820[rbp], edi	# int argc
	mov	QWORD PTR -832[rbp], rsi	# char *argv[]
	lea	rax, -8[rbp]			# scanf
	mov	rsi, rax
	lea	rdi, .LC0[rip]			
	mov	eax, 0
	call	__isoc99_scanf@PLT		
	mov	DWORD PTR -4[rbp], 0		# i := 0
	jmp	.L8				# Идем на метку L8 чтобы сравнить i < n
.L9:
	lea	rax, -416[rbp]			# Записываем в A[i] информацию
	mov	edx, DWORD PTR -4[rbp]		# scanf
	movsx	rdx, edx
	sal	rdx, 2
	add	rax, rdx
	mov	rsi, rax
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	DWORD PTR -4[rbp], 1		# i++
.L8:
	mov	eax, DWORD PTR -8[rbp]		# i < n 
	cmp	DWORD PTR -4[rbp], eax
	jl	.L9				
	mov	ecx, DWORD PTR -8[rbp]		# func(A, B, i, n)	
	mov	edx, DWORD PTR -4[rbp]		# i
	lea	rsi, -816[rbp]
	lea	rax, -416[rbp]
	mov	rdi, rax
	call	func				# Сам вызов функции со всеми аргументами
	mov	DWORD PTR -4[rbp], 0		# i := 0
	jmp	.L10
.L11:
	mov	eax, DWORD PTR -4[rbp]		# printf
	cdqe
	mov	eax, DWORD PTR -816[rbp+rax*4]
	mov	esi, eax
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1		# i++
.L10:
	mov	eax, DWORD PTR -8[rbp]		
	cmp	DWORD PTR -4[rbp], eax		# i < n
	jl	.L11
	mov	eax, 0				# return 0;
	leave					# }
	ret
