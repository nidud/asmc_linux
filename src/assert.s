
.intel_syntax noprefix

.global AssertDirective

.extern EvaluateHllExpression
.extern ExpandCStrings
.extern GetLabelStr
.extern RunLineQueue
.extern AddLineQueueX
.extern AddLineQueue
.extern LstWrite
.extern GetCurrOffset
.extern MemDup
.extern LclAlloc
.extern MemFree
.extern CondPrepare
.extern CurrIfState
.extern tstricmp
.extern tstrcpy
.extern tstrchr
.extern asmerr
.extern ModuleInfo
.extern SymFind


.SECTION .text
	.ALIGN	16

AssertDirective:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 4168
	mov	dword ptr [rbp-0x1014], 0
	mov	rbx, rdx
	lea	rdi, [rbp-0x800]
	imul	eax, dword ptr [rbp+0x28], 24
	mov	eax, dword ptr [rbx+rax+0x4]
	mov	dword ptr [rbp-0x1018], eax
	inc	dword ptr [rbp+0x28]
	mov	rsi, qword ptr [ModuleInfo+0x100+rip]
	test	rsi, rsi
	jnz	$_001
	mov	ecx, 56
	call	LclAlloc@PLT
	mov	rsi, rax
$_001:	mov	rcx, qword ptr [rbp+0x30]
	call	ExpandCStrings@PLT
	xor	eax, eax
	mov	dword ptr [rsi+0x14], eax
	mov	dword ptr [rsi+0x2C], eax
	mov	eax, dword ptr [rbp-0x1018]
	jmp	$_032

$_002:	imul	edx, dword ptr [rbp+0x28], 24
	mov	al, byte ptr [rbx+rdx]
	cmp	al, 58
	jne	$_015
	add	dword ptr [rbp+0x28], 2
	mov	rdi, qword ptr [rbx+rdx+0x20]
	mov	al, byte ptr [rbx+rdx+0x18]
	cmp	al, 8
	jnz	$_003
	mov	rcx, rdi
	call	SymFind@PLT
	test	rax, rax
	jz	$_003
	mov	rcx, qword ptr [ModuleInfo+0x338+rip]
	call	MemFree@PLT
	mov	rcx, rdi
	call	MemDup@PLT
	mov	qword ptr [ModuleInfo+0x338+rip], rax
	jmp	$_033

$_003:	lea	rdx, [DS0000+rip]
	mov	rcx, rdi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_005
	test	byte ptr [ModuleInfo+0x334+rip], 0x40
	jnz	$_004
	mov	ecx, 471
	call	CondPrepare@PLT
	mov	dword ptr [CurrIfState+rip], 2
$_004:	jmp	$_033

$_005:	lea	rdx, [DS0001+rip]
	mov	rcx, rdi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_006
	jmp	$_033

$_006:	lea	rdx, [DS0002+rip]
	mov	rcx, rdi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_008
	mov	al, byte ptr [ModuleInfo+0x334+rip]
	mov	ecx, dword ptr [assert_stid+rip]
	cmp	ecx, 124
	jnc	$_007
	lea	rdx, [assert_stack+rip]
	mov	byte ptr [rdx+rcx], al
	inc	dword ptr [assert_stid+rip]
$_007:	jmp	$_033

$_008:	lea	rdx, [DS0003+rip]
	mov	rcx, rdi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_010
	mov	ecx, dword ptr [assert_stid+rip]
	lea	rdx, [assert_stack+rip]
	mov	al, byte ptr [rdx+rcx]
	mov	byte ptr [ModuleInfo+0x334+rip], al
	test	ecx, ecx
	jz	$_009
	dec	dword ptr [assert_stid+rip]
$_009:	jmp	$_033

$_010:	lea	rdx, [DS0004+rip]
	mov	rcx, rdi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_011
	or	byte ptr [ModuleInfo+0x334+rip], 0x40
	jmp	$_033

$_011:	lea	rdx, [DS0005+rip]
	mov	rcx, rdi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_012
	and	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFFBF
	jmp	$_033

$_012:	lea	rdx, [DS0006+rip]
	mov	rcx, rdi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_013
	or	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFF80
	jmp	$_033

$_013:	lea	rdx, [DS0007+rip]
	mov	rcx, rdi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_014
	and	byte ptr [ModuleInfo+0x334+rip], 0x7F
	jmp	$_033

$_014:	mov	rdx, rdi
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_033

	jmp	$_017

$_015:	test	al, al
	jz	$_016
	test	byte ptr [ModuleInfo+0x334+rip], 0x40
	jnz	$_017
$_016:	jmp	$_033

$_017:	imul	edx, dword ptr [rbp+0x28], 24
	mov	rdx, qword ptr [rbx+rdx+0x10]
	lea	rcx, [rbp-0x1000]
	call	tstrcpy@PLT
	test	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFF80
	jz	$_019
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_018
	lea	rcx, [DS0008+rip]
	call	AddLineQueue@PLT
	jmp	$_019

$_018:	lea	rcx, [DS0009+rip]
	call	AddLineQueue@PLT
$_019:	mov	dword ptr [rsi+0x28], 0
	mov	dword ptr [rsi+0x18], 0
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	dword ptr [rsi+0x10], eax
	lea	rcx, [rbp-0x1010]
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	rdx, rcx
	mov	ecx, eax
	call	GetLabelStr@PLT
	mov	qword ptr [rsp+0x28], rdi
	mov	dword ptr [rsp+0x20], 0
	xor	r9d, r9d
	mov	r8, rbx
	lea	rdx, [rbp+0x28]
	mov	rcx, rsi
	call	EvaluateHllExpression@PLT
	mov	dword ptr [rbp-0x1014], eax
	test	eax, eax
	jne	$_033
	mov	rcx, rdi
	call	AddLineQueue@PLT
	test	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFF80
	jz	$_021
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_020
	lea	rcx, [DS000A+rip]
	call	AddLineQueue@PLT
	jmp	$_021

$_020:	lea	rcx, [DS000B+rip]
	call	AddLineQueue@PLT
$_021:	mov	rdx, rdi
	mov	ecx, dword ptr [rsi+0x10]
	call	GetLabelStr@PLT
	lea	r9, [DS000D+rip]
	mov	r8, rax
	lea	rdx, [rbp-0x1010]
	lea	rcx, [DS000C+rip]
	call	AddLineQueueX@PLT
	test	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFF80
	jz	$_023
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_022
	lea	rcx, [DS000A+rip]
	call	AddLineQueue@PLT
	jmp	$_023

$_022:	lea	rcx, [DS000B+rip]
	call	AddLineQueue@PLT
$_023:	cmp	byte ptr [rdi], 0
	je	$_033
	mov	rax, qword ptr [ModuleInfo+0x338+rip]
	test	rax, rax
	jnz	$_024
	lea	rax, [DS000E+rip]
	mov	qword ptr [ModuleInfo+0x338+rip], rax
$_024:	mov	rdx, rax
	lea	rcx, [DS000F+rip]
	call	AddLineQueueX@PLT
	lea	rcx, [DS0010+rip]
	call	AddLineQueue@PLT
	lea	rbx, [rbp-0x1000]
	jmp	$_027

$_025:	mov	byte ptr [rax], 0
	xchg	rax, rbx
	inc	rbx
	cmp	byte ptr [rax], 0
	jz	$_026
	mov	rdx, rax
	lea	rcx, [DS0011+rip]
	call	AddLineQueueX@PLT
	jmp	$_027

$_026:	lea	rcx, [DS0012+rip]
	call	AddLineQueue@PLT
$_027:	mov	edx, 34
	mov	rcx, rbx
	call	tstrchr@PLT
	test	rax, rax
	jnz	$_025
	cmp	byte ptr [rbx], 0
	jz	$_028
	mov	rdx, rbx
	lea	rcx, [DS0013+rip]
	call	AddLineQueueX@PLT
$_028:	lea	r8, [DS000D+rip]
	lea	rdx, [rbp-0x1010]
	lea	rcx, [DS0014+rip]
	call	AddLineQueueX@PLT
	jmp	$_033

$_029:	mov	dword ptr [rsi+0x2C], 262144
	jmp	$_002

$_030:	mov	dword ptr [rsi+0x2C], 131072
	jmp	$_002

$_031:	mov	dword ptr [rsi+0x2C], 65536
	jmp	$_002

$_032:	cmp	eax, 422
	je	$_002
	cmp	eax, 425
	jz	$_029
	cmp	eax, 424
	jz	$_030
	cmp	eax, 423
	jz	$_031
$_033:	cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_034
	call	GetCurrOffset@PLT
	xor	r8d, r8d
	mov	edx, eax
	mov	ecx, 4
	call	LstWrite@PLT
$_034:	cmp	qword ptr [ModuleInfo+0xC8+rip], 0
	jz	$_035
	call	RunLineQueue@PLT
$_035:	mov	eax, dword ptr [rbp-0x1014]
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret


.SECTION .data
	.ALIGN	16

assert_stack:
	.zero  124 * 1

assert_stid:
	.int   0x00000000

DS0000:
	.asciz "CODE"

DS0001:
	.asciz "ENDS"

DS0002:
	.asciz "PUSH"

DS0003:
	.asciz "POP"

DS0004:
	.asciz "ON"

DS0005:
	.asciz "OFF"

DS0006:
	.asciz "PUSHF"

DS0007:
	.asciz "POPF"

DS0008:
	.ascii " pushfq\n"
	.asciz " sub rsp,28h"

DS0009:
	.asciz " pushfd"

DS000A:
	.ascii " add rsp,28h\n"
	.asciz " popfq"

DS000B:
	.asciz " popfd"

DS000C:
	.ascii "jmp %s\n"
	.asciz "%s%s"

DS000D:
	.asciz ":"

DS000E:
	.asciz "assert_exit"

DS000F:
	.asciz "%s()"

DS0010:
	.asciz "db @CatStr(!\",%@FileName,<(>,%@Line,<): >,!\")"

DS0011:
	.asciz "db \"%s\",22h"

DS0012:
	.asciz "db 22h"

DS0013:
	.asciz "db \"%s\""

DS0014:
	.ascii "db 0\n"
	.asciz "%s%s"


.att_syntax prefix
