; 编译链接方法
; (ld 的‘-s’选项意为“strip all”)
;
; $ nasm -f elf foo.asm -o foo.o
; $ gcc -c bar.c -o bar.o
; $ ld -s hello.o bar.o -o foobar
; $ ./foobar
; the 2nd one
; $

extern _choose	; int choose(int a, int b);

[section .data]	; 数据在此

num1st		dd	3
num2nd		dd	4

[section .text]	; 代码在此

global _main	; 我们必须导出 _start 这个入口，以便让链接器识别。
global myprint	; 导出这个函数为了让 bar.c 使用

_main:
	push	dword [num2nd]	; `.
	push	dword [num1st]	;  |
	call	_choose		;  | choose(num1st, num2nd);
	add	esp, 8		; /
	ret
	
; void myprint(char* msg, int len)
myprint:
	mov	edx, [esp + 8]	; len
	mov	ecx, [esp + 4]	; msg
	mov	ebx, 1
	mov	eax, 4		; sys_write
	int	0x80		; 系统调用
	ret
	
