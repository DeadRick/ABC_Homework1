# ИДЗ1,  Демьяненко Виктор Николевич БПИ217 

## Задание:
Разработать программу, которая получает одномерный массив AN, после
чего формирует из элементов массива A новый массив B по правилам,
указанным в варианте, и выводит его. Память под массивы может
выделяться статически, на стеке, автоматичеси по выбору разработчика.
При решении задачи необходимо использовать подпрограммы для
реализации ввода, вывода и формирования нового массива.
## Вариант 19:
Сформировать массив B из элементов массива A заменой нулевых
элементов, предшествующих первому отрицательному, единицей.
## Отчет:
 - ### 4 балла:
 - Приведено решение задачи на C
 - Немодифицированная ассемблерная программа с комментариями
 -  Модифицированная ассемблерная программа с комментариями
 -  Тесты (всего 4 штуки)
 -  ### 5 балла:
 -  Также передаю парметры через int main(int argc) в main_rand.c
 -  Решение на C с передачей данных в функции через параметры и локальные переменные:
 -  - void func(int* a, int* b, int i, int n) (Функция с передачей параметров)
 -  - int flag = 0; (Локальные переменные)
 -  Ассемблерная программа с комментариями.
 -  ### 6 баллов:
 -  Решение на ассемблере с рефакторингом программы за счет максимального использования регистров процессор (См. Оптимизация)
 -  ### 7 баллов:
 -  Использование командной строки для ввода данных (реализовано в прошлых пунктах)
 -  Чтение из файла. Запись в файл.
 - ### 8 баллов:
 - Добавил генератор рандомных чисел, также передаю параметр в командной строке
 - Данные добавляются в массив рандомно
 - Зациклил выполнения основной функции (500 раз)
 - ### 9 баллов:
 - Протестировал оптимизации с разными флагами (O0, O1, 03)

## Флаги GCC
```
gcc -masm=intel \
    -fno-asynchronous-unwind-tables \
    -fno-jump-tables \
    -fno-stack-protector \
    -fno-exceptions \
    ./code.c \
    -S -o ./code.s
```
### Тесты:
- n = 5
- 1A: 0 0 0 -1 5
- 1B: 1 1 1 -1 5
---
- n = 5
- 2A: 0 0 -1 0 0
- 2B 1 1 -1 0 0
---
- n = 1
- 3A: 0
- 3B: 1
---
- n = 5
- 4A: 1 2 3 4 5
- 4B: 1 2 3 4 5
## Код программы на C
``` C
#include <stdio.h>

void func(int* a, int* b, int i, int n)
{
    int flag = 0;
    for(i=0;i<n;i++) 
    {
        if (a[i] == 0 && flag == 0) {
            b[i] = 1;
        } else {
            if (flag == 0) {
                flag = 1;
            }
            b[i] = a[i];
        }
    }
}

int main(int argc, char* argv[]) 
{
    int i, n;
    int A[100];
    int B[100];
    scanf("%d", &n);
    for(i=0;i<n;i++) 
    {
        scanf("%i",&A[i]);
    }
    func(A, B, i, n);
    for(i=0;i<n;i++) 
    {
        printf("%d ",B[i]);
    }
    return 0;
}
```
## Код на Assembler (пока что без комментариев)
``` asm
.file    "code.c"
    .intel_syntax noprefix
    .text
    .globl    func
    .type    func, @function
func:
    push    rbp
    mov    rbp, rsp
    mov    QWORD PTR -24[rbp], rdi
    mov    QWORD PTR -32[rbp], rsi
    mov    DWORD PTR -36[rbp], edx
    mov    DWORD PTR -40[rbp], ecx
    mov    DWORD PTR -4[rbp], 0
    mov    DWORD PTR -36[rbp], 0
    jmp    .L2
.L6:
    mov    eax, DWORD PTR -36[rbp]
    cdqe
    lea    rdx, 0[0+rax*4]
    mov    rax, QWORD PTR -24[rbp]
    add    rax, rdx
    mov    eax, DWORD PTR [rax]
    test    eax, eax
    jne    .L3
    cmp    DWORD PTR -4[rbp], 0
    jne    .L3
    mov    eax, DWORD PTR -36[rbp]
    cdqe
    lea    rdx, 0[0+rax*4]
    mov    rax, QWORD PTR -32[rbp]
    add    rax, rdx
    mov    DWORD PTR [rax], 1
    jmp    .L4
.L3:
    cmp    DWORD PTR -4[rbp], 0
    jne    .L5
    mov    DWORD PTR -4[rbp], 1
.L5:
    mov    eax, DWORD PTR -36[rbp]
    cdqe
    lea    rdx, 0[0+rax*4]
    mov    rax, QWORD PTR -24[rbp]
    add    rax, rdx
    mov    edx, DWORD PTR -36[rbp]
    movsx    rdx, edx
    lea    rcx, 0[0+rdx*4]
    mov    rdx, QWORD PTR -32[rbp]
    add    rdx, rcx
    mov    eax, DWORD PTR [rax]
    mov    DWORD PTR [rdx], eax
.L4:
    add    DWORD PTR -36[rbp], 1
.L2:
    mov    eax, DWORD PTR -36[rbp]
    cmp    eax, DWORD PTR -40[rbp]
    jl    .L6
    nop
    pop    rbp
    ret
    .size    func, .-func
    .section    .rodata
.LC0:
    .string    "%d"
.LC1:
    .string    "%i"
.LC2:
    .string    "%d "
    .text
    .globl    main
    .type    main, @function
main:
    push    rbp
    mov    rbp, rsp
    sub    rsp, 832
    mov    DWORD PTR -820[rbp], edi
    mov    QWORD PTR -832[rbp], rsi
    lea    rax, -8[rbp]
    mov    rsi, rax
    lea    rdi, .LC0[rip]
    mov    eax, 0
    call    __isoc99_scanf@PLT
    mov    DWORD PTR -4[rbp], 0
    jmp    .L8
.L9:
    lea    rax, -416[rbp]
    mov    edx, DWORD PTR -4[rbp]
    movsx    rdx, edx
    sal    rdx, 2
    add    rax, rdx
    mov    rsi, rax
    lea    rdi, .LC1[rip]
    mov    eax, 0
    call    __isoc99_scanf@PLT
    add    DWORD PTR -4[rbp], 1
.L8:
    mov    eax, DWORD PTR -8[rbp]
    cmp    DWORD PTR -4[rbp], eax
    jl    .L9
    mov    ecx, DWORD PTR -8[rbp]
    mov    edx, DWORD PTR -4[rbp]
    lea    rsi, -816[rbp]
    lea    rax, -416[rbp]
    mov    rdi, rax
    call    func
    mov    DWORD PTR -4[rbp], 0
    jmp    .L10
.L11:
    mov    eax, DWORD PTR -4[rbp]
    cdqe
    mov    eax, DWORD PTR -816[rbp+rax*4]
    mov    esi, eax
    lea    rdi, .LC2[rip]
    mov    eax, 0
    call    printf@PLT
    add    DWORD PTR -4[rbp], 1
.L10:
    mov    eax, DWORD PTR -8[rbp]
    cmp    DWORD PTR -4[rbp], eax
    jl    .L11
    mov    eax, 0
    leave
    ret
    .size    main, .-main
    .ident    "GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
    .section    .note.GNU-stack,"",@progbits
```

Код успешно компилируется, теперь уберем всю ненужную информацию, которую оставил компилятор:
- .size    main, .-main
    .ident    "GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
    .section    .note.GNU-stack,"",@progbits
- .file    "code.c"

## Комментарии к коду
``` asm
	.intel_syntax noprefix			# Используем синтаксис Интела
	.text					        # Начало секции
	.globl	func				    # Объявление функции func
	.type	func, @function         # Отмечаем, что это функция
func:
	push	rbp				        # Стандартный пролог функции
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi     # Тут идут переменные, переданные с функции
	mov	QWORD PTR -32[rbp], rsi     # Массив А, массив В
	mov	DWORD PTR -36[rbp], edx		# Итератор i (на стеке видно, что он на 36 месте)
	mov	DWORD PTR -40[rbp], ecx		# Размер массива
	mov	DWORD PTR -4[rbp], 0        # int flag = 0
	mov	DWORD PTR -36[rbp], 0       # Зануляем переменную i в цикле for 
	jmp	.L2				            # Затем проверяем условие
.L6:                                # if (a[i] == 0 && flag == 0)
	mov	eax, DWORD PTR -36[rbp]		
	cdqe
	lea	rdx, 0[0+rax*4]			
	mov	rax, QWORD PTR -24[rbp] 	# a[i] == 0
	add	rax, rdx			
	mov	eax, DWORD PTR [rax]
	test	eax, eax			    # && 
	jne	.L3				            # Идём в else
	cmp	DWORD PTR -4[rbp], 0		# flag == 0
	jne	.L3				            # Если условие не выполнилось, идем в else
	mov	eax, DWORD PTR -36[rbp]     # b[i]
	cdqe
	lea	rdx, 0[0+rax*4]			
	mov	rax, QWORD PTR -32[rbp]		# rax := b[i]
	add	rax, rdx			        # rdx := rax
	mov	DWORD PTR [rax], 1		    # в b[i] записываем единицу
	jmp	.L4
.L3:						        # else {
	cmp	DWORD PTR -4[rbp], 0		# if (flag == 0)
	jne	.L5				            # Переход в b[i] = a[i]
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
.L2:						        # if (a[i] == 0 && flag == 0)
	mov	eax, DWORD PTR -36[rbp]     # Загружаем int i в стек
	cmp	eax, DWORD PTR -40[rbp]     # Сравниваем с n   
	jl	.L6				            # Идём к другому условию 
	nop					            # Nope!
	pop	rbp				            # Эпилог функции
	ret
	.size	func, .-func
	.section	.rodata
.LC0:						        # Всякие метки для строк
	.string	"%d"
.LC1:
	.string	"%i"
.LC2:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp				        # Пролог функции
	mov	rbp, rsp
	sub	rsp, 832
	mov	DWORD PTR -820[rbp], edi	# int argc
	mov	QWORD PTR -832[rbp], rsi	# char *argv[]
	lea	rax, -8[rbp]			    # scanf
	mov	rsi, rax
	lea	rdi, .LC0[rip]			
	mov	eax, 0
	call	__isoc99_scanf@PLT		
	mov	DWORD PTR -4[rbp], 0		# i := 0
	jmp	.L8			            	# Идем на метку L8 чтобы сравнить i < n
.L9:
	lea	rax, -416[rbp]		    	# Записываем в A[i] информацию
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
	call	func			    	# Сам вызов функции со всеми аргументами
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
	mov	eax, 0				        # return 0;
	leave				        	# }
	ret
```
# Оптимизация
Заменил: 
- DWORD PTR -4[rbp] -> r12d
- DWORD PTR -36[rbp] -> r13d
- DWORD PTR -40[rbp] -> r14d

Также удаляем лишнюю строчку с командой nop

# Разбиение на файлы и компановка
Весь этот ужас, который получился сверху я разделил на три файла: 
 - main.c
 - print.c
 - func.o
 

Вот их содержимое:
# main.c
```C
#include <stdio.h>

extern void func(int* a, int* b, int i, int n);
extern void print(int *b, const int n, int i);

int main(int argc, char* argv[]) 
{
    int i, n;
    int A[100];
    int B[100];
    scanf("%d", &n);
    for(i=0;i<n;i++) 
    {
        scanf("%i",&A[i]);
    }

    func(A, B, i, n);
    print(B, n, i);
    return 0;
}
```
---
# func.c
``` C
void func(int* a, int* b, int i, int n)
{
    int flag = 0;
    for(i=0;i<n;i++) 
    {
        if (a[i] == 0 && flag == 0) {
            b[i] = 1;
        } else {
            if (flag == 0) {
                flag = 1;
            }
            b[i] = a[i];
        }
    }
}
```
---
# print.c
``` C
#include <stdio.h>

void print(int *b, const int n, int i)
{
    for(i=0;i<n;i++) 
    {
        printf("%d ",b[i]);
    }
}
```
---
## Компановка
Для того, чтобы слинковать эти файлы, я использовал следующие команды:
``` 
gcc ./print.c -c -o print.o
gcc ./main.c -c -o main.o
gcc ./func -c -o func.o
```
Итоговый файл:
``` 
gcc ./main.o ./func.o ./print.o -o ./foo.exe
```
Проверил на всех тестиках и убедился, что программа успешно выполняется.

# Запись в файл. Чтение из файла
Для этого я убрал функцию print() и оставил:
 - main_file.c
 - func_file.c
 - input.txt
 - output.txt

В main_file.c я использовал fopen для открытия файл. fscanf для чтения из фалйа, также после работы с файлы закрываю чтение функцией fclose. Также я не рассматриваю случаи, если файл пустой.
# main_file.c
``` C
#include <stdio.h>

extern void func(int* a, int* b, int i, int n);

int main(int argc, char* argv[]) 
{
    FILE *input, *output; # Файлики
    int i, n;
    int A[100];
    int B[100];
    input = fopen("input.txt", "r");
    for (i = 0; i < 1; ++i) 
    {
	fscanf(input, "%d", &n);
    }
    for (i = 0; i < n; ++i)
    {
        fscanf(input, "%d", &A[i]);
    }
    fclose(input);
    func(A, B, i, n);
    output = fopen("output.txt", "w");
    for (i = 0; i < n; ++i)
    {
        fprintf(output, "%d ", B[i]);
    }
    fclose(output);
    return 0;
}
```
--- 
# func_file.c
Тут я ничего не изменил, так что можно посмотреть код выше в func.c
--- 
# input.txt
```
5
0 0 -1 0 0
```
--- 
Файлы скомпановал, всё работает и на выходе получился файл:
# output.txt
```
1 1 -1 0 0
```
## Рандом
- main_rand.c
- func_rand.c

Использовал библиотеку stdlib.h и time.h
# main_rand.c
``` C
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void func(int* a, int* b, int i, int n);

int64_t timespecDiff(
    struct timespec timeA,
    struct timespec timeB
)
{
    int64_t nsecA, nsecB;

	nsecA = timeA.tv_sec;
    nsecA *= 1000000000;
	nsecA += timeA.tv_nsec;

	nsecB = timeB.tv_sec;
	nsecB *= 1000000000;
	nsecB += timeB.tv_nsec;
	
	return nsecA - nsecB;
}

int main(int argc, char** argv) 
{
    char* arg;
    int i, n, seed;
	struct timespec start;
	struct timespec end;
	int64_t elapsed_ns;
    if (argc == 2) 
    {
		arg = argv[1];
		seed = atoi(arg);
		srand(seed);
    } else {
		return 1;
    }
    int A[100];
    int B[100];
    clock_gettime(CLOCK_MONOTONIC, &start);
    n = 99;
    for(i=0;i<n;i++) 
    {
        A[i] = rand();
    }
    for(i=0;i<500;++i) 
    {
        func(A, B, i, n);   
    }
	clock_gettime(CLOCK_MONOTONIC, &end);
	elapsed_ns = timespecDiff(end, start);
	printf("Elapsed: %ld ns", elapsed_ns);
    return 0;
}
```

В среднем программа выдает от 600ns при размере в 99 элемент.
 - Elapsed: 6530 ns
 - Elapsed: 6667 ns
 - Elapsed: 6165 ns
 - Elapsed: 6509 ns
 - Elapsed: 6698 ns
 
# Также прокомментируем код:
```
	.file	"main_rand.c"
	.intel_syntax noprefix			# Используем синтаксис Интела
	.text					        # Начало секции
	.globl	timespecDiff			# Объявление функции 
	.type	timespecDiff, @function	# Отмечаем, что это функция
timespecDiff:
	push	rbp			        	# Пролог функции
	mov	rbp, rsp
	mov	rax, rdi			        # Конец пролога
	mov	r8, rsi				        # r8 := rsi
	mov	rsi, rax			        # rsi := rax
	mov	rdi, rdx			        # rdi := rdx
	mov	rdi, r8				        # rdi := r8
	mov	QWORD PTR -32[rbp], rsi		# Заданные переменные в функции	
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -8[rbp], rax		# nsecA
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000	# nsecA *= 1000000000;
	mov	QWORD PTR -8[rbp], rax		# rax := nsecA;
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -8[rbp], rax		# nsecA += timeA.tv_nsec;
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000	# nsecB *= 1000000000;
	mov	QWORD PTR -16[rbp], rax		# rax := nsecB;
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -16[rbp], rax		# nsecA += timeA.tv_nsec;
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]		# return nsecA - nsecB;
	pop	rbp
	ret					            # Эпилог функции.
	.size	timespecDiff, .-timespecDiff
	.section	.rodata
.LC0:					        	# Метки с текстом и объявление main
	.string	"Elapsed: %ld ns"
	.text
	.globl	main			       	# Объявляем main
	.type	main, @function			# Отмечаем, что это функция
main:
	push	rbp				        # Стандартный эпилог мейна
	mov	rbp, rsp
	sub	rsp, 880
	mov	DWORD PTR -868[rbp], edi	# int argc
	mov	QWORD PTR -880[rbp], rsi	# char **argv
	cmp	DWORD PTR -868[rbp], 2		# argc == 2
	jne	.L4				            # then go to return 1;
	mov	rax, QWORD PTR -880[rbp]	# rax := rbp - 880
	mov	rax, QWORD PTR 8[rax]		# rax := rax - 8
	mov	QWORD PTR -16[rbp], rax		# arg = argv[1]
	mov	rax, QWORD PTR -16[rbp]		# rax := rbp - 16  		USELESS!
	mov	rdi, rax		        	# rdi := rax
	call	atoi@PLT			    # seed = atoi(arg);
	mov	DWORD PTR -20[rbp], eax		# Delete it!
	mov	eax, DWORD PTR -20[rbp]		# DELETE!
	mov	edi, eax		        	# edi := eax
	call	srand@PLT		    	# srand();
	lea	rax, -48[rbp]		    	# 
	mov	rsi, rax			        # rsi := rax
	mov	edi, 1				        # edi := 1
	call	clock_gettime@PLT		# clock_gettime();
	mov	DWORD PTR -24[rbp], 5		# n = 5;
	mov	DWORD PTR -4[rbp], 0		# i = 0;
	jmp	.L7				            # then goto after for { }
.L4:	
	mov	eax, 1				        # return 1;
	jmp	.L11
.L8:
	call	rand@PLT		    	# rand();
	mov	edx, eax		        	# edx := eax
	mov	eax, DWORD PTR -4[rbp]		# eax := DWORD.. 		USELESS!
	cdqe					        # sign
	mov	DWORD PTR -464[rbp+rax*4], edx	    # A[i] = rand();
	add	DWORD PTR -4[rbp], 1		# i++;
.L7:
	mov	eax, DWORD PTR -4[rbp]		# eax := rbp
	cmp	eax, DWORD PTR -24[rbp]		# i < n
	jl	.L8			            	# then goto for { }
	mov	DWORD PTR -4[rbp], 0		# i = 0
	jmp	.L9				            # goto after for { }
.L10:
	mov	ecx, DWORD PTR -24[rbp] 	# func(A, B, i, n)
	mov	edx, DWORD PTR -4[rbp]		# i
	lea	rsi, -864[rbp]			    # &A
	lea	rax, -464[rbp]			    # &B
	mov	rdi, rax			        # rdi := rax;
	call	func@PLT			    # call func
	add	DWORD PTR -4[rbp], 1		# i++;
.L9:
	cmp	DWORD PTR -4[rbp], 499		# i < 500;
	jle	.L10			        	# goto in for { }
	lea	rax, -64[rbp]		    	# rax := rbp - 64
	mov	rsi, rax			        # rsi := rax 			USELESS!
	mov	edi, 1				        # edi := 1
	call	clock_gettime@PLT		# call clock_gettime();
	mov	rax, QWORD PTR -48[rbp]		# Передача параметров в timespecDiff
	mov	rdx, QWORD PTR -40[rbp]		# end and start
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rdx			        # rcx := rdx
	mov	rdx, rax			        # rdx := rax			USELESS!
	call	timespecDiff			# call timespecDiff();
	mov	QWORD PTR -32[rbp], rax		# printf
	mov	rax, QWORD PTR -32[rbp]		# rax := rbx - 32
	mov	rsi, rax			        # rsi := rax;			USELESS!
	lea	rdi, .LC0[rip]		
	mov	eax, 0				        # Зануляем мусор
	call	printf@PLT			    # call printf()
	mov	eax, 0				        # return 0;
.L11:
	leave					        # Конец
	ret
```

# Оптимизация
Пометка USELESS! или Delete - это всё, что зачем то сделал компилятор, но не имеет какого либо смысла

---
Было:
```
	mov	rax, QWORD PTR -16[rbp]		# rax := rbp - 16  		USELESS!
	mov	rdi, rax		        	# rdi := rax
```
Стало:
```
	mov	rdi, QWORD PTR -16[rbp]		        
```
---
Такое преобразование я сделал везде, где стояла пометка.
Также использовал регистры, чтобы не использовать память на стеки:
 - DWORD PTR -4[rbp] -> r12
 - QWORD PTR -32[rbp] -> r13
 - DWORD PTR -24[rbp] -> r14
 - DWORD PTR -16[rbp] -> r15
 

Получился вот такой код:
```
	.file	"main_rand.c"
	.intel_syntax noprefix			# Используем синтаксис Интела
	.text				        	# Начало секции
	.globl	timespecDiff			# Объявление функции 
	.type	timespecDiff, @function	# Отмечаем, что это функция
timespecDiff:
	push	rbp				        # Пролог функции
	mov	rbp, rsp
	mov	rax, rdi		        	# Конец пролога
	mov	r8, rsi			        	# r8 := rsi
	mov	rsi, rax		        	# rsi := raxы
	mov	rdi, rdx		        	# rdi := rdx
	mov	rdi, r8			        	# rdi := r8
	mov	r13, rsi		        	# Заданные переменные в функции	
	mov	r14, rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	r15, rax			        # nsecA
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000	# nsecA *= 1000000000;
	mov	QWORD PTR -8[rbp], rax		# rax := nsecA;
	mov	rax, r14
	add	QWORD PTR -8[rbp], rax		# nsecA += timeA.tv_nsec;
	mov	rax, QWORD PTR -48[rbp]
	mov	r15, rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000	# nsecB *= 1000000000;
	mov	r15, rax		           	# rax := nsecB;
	mov	rax, QWORD PTR -40[rbp]
	add	r15, rax		        	# nsecA += timeA.tv_nsec;
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]		# return nsecA - nsecB;
	pop	rbp
	ret					             # Эпилог функции.
	.size	timespecDiff, .-timespecDiff
	.section	.rodata
.LC0:						        # Метки с текстом и объявление main
	.string	"Elapsed: %ld ns"
	.text
	.globl	main				    # Объявляем main
	.type	main, @function			# Отмечаем, что это функция
main:
	push	rbp				        # Стандартный эпилог мейна
	mov	rbp, rsp
	sub	rsp, 880
	mov	DWORD PTR -868[rbp], edi	# int argc
	mov	QWORD PTR -880[rbp], rsi	# char **argv
	cmp	DWORD PTR -868[rbp], 2		# argc == 2
	jne	.L4				            # then go to return 1;
	mov	rax, QWORD PTR -880[rbp]	# rax := rbp - 880
	mov	rax, QWORD PTR 8[rax]		# rax := rax - 8
	mov	rdi, rax		
	call	atoi@PLT			    # seed = atoi(arg);
	mov	edi, eax		        	# edi := eax
	call	srand@PLT			    # srand();
	lea	rax, -48[rbp]			    # 
	mov	rsi, rax			        # rsi := rax
	mov	edi, 1			        	# edi := 1
	call	clock_gettime@PLT		# clock_gettime();
	mov	r14, 5				        # n = 5;
	mov	r12, 0				        # i = 0;
	jmp	.L7				            # then goto after for { }
.L4:	
	mov	eax, 1			        	# return 1;
	jmp	.L11
.L8:
	call	rand@PLT			    # rand();
	mov	edx, r12		
	cdqe				        	# sign
	mov	DWORD PTR -464[rbp+rax*4], edx	# A[i] = rand();
	add	r12, 1			            # i++;
.L7:
	mov	eax, r12		        	# eax := rbp
	cmp	eax, r14		           	# i < n
	jl	.L8			            	# then goto for { }
	mov	r12, 0			        	# i = 0
	jmp	.L9			            	# goto after for { }
.L10:
	mov	ecx, r14 			        # func(A, B, i, n)
	mov	edx, r12		        	# i
	lea	rsi, -864[rbp]			    # &A
	lea	rax, -464[rbp]		    	# &B
	mov	rdi, rax		        	# rdi := rax;
	call	func@PLT		    	# call func
	add	r12, 1			        	# i++;
.L9:
	cmp	r12, 499		        	# i < 500;
	jle	.L10				        # goto in for { }
	lea	rax, -64[rbp]		    	# rax := rbp - 64
	mov	rsi, rax			        # rsi := rax 	
	mov	edi, 1				        # edi := 1
	call	clock_gettime@PLT		# call clock_gettime();
	mov	rax, QWORD PTR -48[rbp]		# Передача параметров в timespecDiff
	mov	rdx, QWORD PTR -40[rbp]		# end and start
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rax			
	call	timespecDiff			# call timespecDiff();
	mov	r13, rax			        # printf
	mov	rsi, r13
	lea	rdi, .LC0[rip]		
	mov	eax, 0				        # Зануляем мусор
	call	printf@PLT			    # call printf()
	mov	eax, 0				        # return 0;
.L11:
	leave					        # Конец
	ret
```

## Тесты для разных оптимизаций и замерка времени:
```
gcc -O0 -Wall -masm=intel -S main_rand.c -o main_rand.o
```
 - Elapsed: 6510 ns
 - Elapsed: 6337 ns
 - Elapsed: 6654 ns
 - Elapsed: 5909 ns
 - Elapsed: 6238 ns
 
 ```
gcc -O1 -Wall -masm=intel -S main_rand.c -o main_rand.o
```
 - Elapsed: 5222 ns
 - Elapsed: 5139 ns
 - Elapsed: 5854 ns
 - Elapsed: 5872 ns
 - Elapsed: 5201 ns
 
 ```
gcc -O3 -Wall -masm=intel -S main_rand.c -o main_rand.o
```
 - Elapsed: 2157 ns
 - Elapsed: 2639 ns
 - Elapsed: 2754 ns
 - Elapsed: 2686 ns
 - Elapsed: 2075 ns