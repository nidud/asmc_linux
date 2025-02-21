
.intel_syntax noprefix

.global ComAlloc

.extern ClearStruct
.extern InsertLineQueue
.extern RunLineQueue
.extern AddLineQueueX
.extern tstricmp
.extern tstrcat
.extern tstrcpy
.extern tsprintf
.extern ModuleInfo
.extern SymFind


.SECTION .text
	.ALIGN	16

$_001:	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 312
	mov	rsi, rdx
	cmp	dword ptr [rsi+0x50], 0
	je	$_007
	mov	rdx, qword ptr [rsi+0x68]
	mov	rdi, qword ptr [rdx]
$_002:	test	rdi, rdi
	je	$_007
	cmp	qword ptr [rdi+0x20], 0
	je	$_006
	mov	rdx, qword ptr [rdi+0x20]
	cmp	word ptr [rdx+0x5A], 1
	jnz	$_003
	mov	r9d, dword ptr [rbp+0x40]
	mov	r8d, dword ptr [rbp+0x38]
	mov	rcx, qword ptr [rbp+0x28]
	call	$_001
	mov	dword ptr [rbp+0x40], eax
	jmp	$_006

$_003:	mov	rdx, qword ptr [rbp+0x28]
	lea	rcx, [rbp-0x100]
	call	tstrcpy@PLT
	lea	rdx, [DS0000+rip]
	mov	rcx, rax
	call	tstrcat@PLT
	mov	ebx, 1
	mov	rdx, qword ptr [rdi+0x8]
	mov	rcx, rax
	call	tstrcat@PLT
	mov	rcx, rax
	call	SymFind@PLT
	test	rax, rax
	jz	$_005
	cmp	byte ptr [rax+0x18], 9
	jz	$_004
	cmp	byte ptr [rax+0x18], 10
	jnz	$_005
$_004:	xor	ebx, ebx
$_005:	test	ebx, ebx
	jz	$_006
	mov	ebx, dword ptr [rbp+0x38]
	dec	ebx
	lea	r8, [rbp-0x100]
	mov	edx, ebx
	lea	rcx, [DS0001+rip]
	call	AddLineQueueX@PLT
	movzx	eax, byte ptr [ModuleInfo+0x1CC+rip]
	shl	eax, 2
	mov	dword ptr [rsp+0x20], ebx
	mov	r9d, eax
	mov	r8d, dword ptr [rbp+0x40]
	mov	edx, dword ptr [rbp+0x38]
	lea	rcx, [DS0002+rip]
	call	AddLineQueueX@PLT
$_006:	mov	rdi, qword ptr [rdi+0x68]
	inc	dword ptr [rbp+0x40]
	jmp	$_002

$_007:
	mov	eax, dword ptr [rbp+0x40]
	dec	eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

ComAlloc:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 72
	mov	rbx, rdx
	lea	rdx, [DS0003+rip]
	mov	rcx, qword ptr [rbx+0x8]
	call	tstricmp@PLT
	mov	edi, eax
	test	edi, edi
	jz	$_011
	jmp	$_010

$_008:	cmp	byte ptr [rbx], 8
	jnz	$_009
	lea	rdx, [DS0003+rip]
	mov	rcx, qword ptr [rbx+0x8]
	call	tstricmp@PLT
	mov	edi, eax
	test	eax, eax
	jz	$_011
$_009:	add	rbx, 24
$_010:	cmp	byte ptr [rbx], 0
	jnz	$_008
$_011:	test	edi, edi
	jz	$_012
	xor	eax, eax
	jmp	$_029

$_012:	add	rbx, 48
	cmp	byte ptr [rbx-0x18], 40
	jz	$_013
	xor	eax, eax
	jmp	$_029

$_013:	mov	rcx, qword ptr [rbx+0x8]
	call	SymFind@PLT
	test	rax, rax
	jz	$_014
	cmp	byte ptr [rax+0x18], 10
	jnz	$_014
	mov	rcx, qword ptr [rax+0x28]
	call	SymFind@PLT
$_014:	test	rax, rax
	jnz	$_015
	mov	rax, -1
	jmp	$_029

$_015:	cmp	byte ptr [rax+0x18], 7
	jnz	$_018
	jmp	$_017

$_016:	mov	rax, qword ptr [rax+0x20]
$_017:	cmp	qword ptr [rax+0x20], 0
	jnz	$_016
$_018:	test	byte ptr [rax+0x16], 0x02
	jnz	$_019
	xor	eax, eax
	jmp	$_029

$_019:	mov	rsi, rax
	mov	rax, qword ptr [rsi+0x8]
	mov	qword ptr [rbp-0x18], rax
	mov	qword ptr [rbp-0x20], 0
	cmp	byte ptr [rbx+0x18], 44
	jnz	$_020
	cmp	byte ptr [rbx+0x48], 41
	jnz	$_020
	mov	rax, qword ptr [rbx+0x38]
	mov	qword ptr [rbp-0x20], rax
$_020:	cmp	qword ptr [ModuleInfo+0xC8+rip], 0
	jz	$_021
	call	RunLineQueue@PLT
$_021:	mov	edi, dword ptr [ModuleInfo+0x340+rip]
	cmp	qword ptr [rbp-0x20], 0
	jz	$_022
	mov	r8, qword ptr [rbp-0x18]
	lea	rdx, [rdi+0x1]
	lea	rcx, [DS0004+rip]
	call	AddLineQueueX@PLT
	jmp	$_023

$_022:	mov	r9, qword ptr [rbp-0x18]
	mov	r8, qword ptr [rbp-0x18]
	lea	rdx, [rdi+0x1]
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
$_023:	mov	eax, 4
	cmp	edi, 115
	jnz	$_024
	mov	eax, 8
$_024:	cmp	dword ptr [rsi+0x50], eax
	jbe	$_025
	lea	r8, [rdi+0x1]
	lea	rdx, [DS0006+rip]
	lea	rcx, [rbp-0x10]
	call	tsprintf@PLT
	mov	rdx, rsi
	lea	rcx, [rbp-0x10]
	call	ClearStruct@PLT
	cmp	qword ptr [rbp-0x20], 0
	jnz	$_025
	lea	r8, [rdi+0x1]
	mov	edx, edi
	lea	rcx, [DS0007+rip]
	call	AddLineQueueX@PLT
$_025:	cmp	qword ptr [rbp-0x20], 0
	jz	$_026
	mov	r8, qword ptr [rbp-0x20]
	mov	edx, edi
	lea	rcx, [DS0001+rip]
	call	AddLineQueueX@PLT
	mov	r8d, edi
	lea	rdx, [rdi+0x1]
	lea	rcx, [DS0008+rip]
	call	AddLineQueueX@PLT
	lea	r8, [rdi+0x1]
	mov	edx, edi
	lea	rcx, [DS0007+rip]
	call	AddLineQueueX@PLT
	jmp	$_027

$_026:	mov	r8, qword ptr [rbp-0x18]
	lea	rdx, [rdi+0x1]
	lea	rcx, [DS0009+rip]
	call	AddLineQueueX@PLT
	lea	r8, [rdi+0x1]
	mov	edx, edi
	lea	rcx, [DS0008+rip]
	call	AddLineQueueX@PLT
	xor	r9d, r9d
	lea	r8d, [rdi+0x1]
	mov	rdx, qword ptr [rsi+0x30]
	mov	rcx, qword ptr [rbp-0x18]
	call	$_001
	mov	r9, qword ptr [rbp-0x18]
	lea	r8, [rdi+0x1]
	mov	edx, edi
	lea	rcx, [DS000A+rip]
	call	AddLineQueueX@PLT
$_027:	call	InsertLineQueue@PLT
	sub	rbx, 48
	cmp	rbx, qword ptr [rbp+0x30]
	jz	$_028
	mov	r8d, edi
	lea	rdx, [DS0008+0xA+rip]
	mov	rcx, qword ptr [rbp+0x28]
	call	tsprintf@PLT
$_028:	mov	eax, 1
$_029:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret


.SECTION .data
	.ALIGN	16

DS0000:
	.asciz "_"

DS0001:
	.asciz "lea %r, %s"

DS0002:
	.asciz "mov [%r+%d*%d], %r"

DS0003:
	.asciz "@ComAlloc"

DS0004:
	.asciz "mov %r,malloc(%s)"

DS0005:
	.asciz "mov %r,malloc(%s + %sVtbl)"

DS0006:
	.asciz "[%r]"

DS0007:
	.asciz "mov %r, %r"

DS0008:
	.asciz "mov [%r], %r"

DS0009:
	.asciz "add %r, %s"

DS000A:
	.asciz "lea %r, [%r-%s]"


.att_syntax prefix
