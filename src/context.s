
.intel_syntax noprefix

.global ContextDirective
.global ContextSaveState
.global ContextInit

.extern sym_Cpu
.extern GetStdAssumeTable
.extern SetStdAssumeTable
.extern GetSegAssumeTable
.extern SetSegAssumeTable
.extern LclAlloc
.extern tstricmp
.extern asmerr
.extern Options
.extern ModuleInfo


.SECTION .text
	.ALIGN	16

ContextDirective:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 72
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	mov	qword ptr [rbp-0x8], rbx
	mov	eax, dword ptr [rbx+0x4]
	mov	dword ptr [rbp-0xC], eax
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	jmp	$_033

$_001:	lea	rsi, [contextnames+rip]
	mov	dword ptr [rbp-0x10], 0
	mov	edi, 4294967295
$_002:	cmp	dword ptr [rbp-0x10], 6
	jge	$_004
	mov	ecx, dword ptr [rbp-0x10]
	mov	rdx, qword ptr [rbx+0x8]
	mov	rcx, qword ptr [rsi+rcx*8]
	call	tstricmp@PLT
	test	rax, rax
	jnz	$_003
	mov	edx, dword ptr [rbp-0x10]
	lea	rcx, [typetab+rip]
	mov	edi, dword ptr [rcx+rdx*4]
	jmp	$_004

$_003:	inc	dword ptr [rbp-0x10]
	jmp	$_002

$_004:	cmp	edi, -1
	je	$_034
	cmp	byte ptr [Options+0xC6+rip], 0
	jz	$_006
	cmp	edi, 16
	jnz	$_005
	jmp	$_034

	jmp	$_006

$_005:	and	edi, 0xFFFFFFEF
$_006:	mov	dword ptr [rbp-0x14], edi
	cmp	dword ptr [rbp-0xC], 560
	jne	$_021
	mov	qword ptr [rbp-0x20], 0
	mov	rdi, qword ptr [ModuleInfo+0x128+rip]
$_007:	test	rdi, rdi
	je	$_019
	cmp	dword ptr [rbp-0x14], 0
	je	$_019
	mov	rax, qword ptr [rdi]
	mov	qword ptr [rbp-0x28], rax
	mov	ecx, dword ptr [rdi+0x8]
	test	dword ptr [rbp-0x14], ecx
	jnz	$_008
	mov	qword ptr [rbp-0x20], rdi
	jmp	$_018

$_008:	not	ecx
	and	dword ptr [rbp-0x14], ecx
	cmp	qword ptr [rbp-0x20], 0
	jz	$_009
	mov	rcx, qword ptr [rbp-0x20]
	mov	qword ptr [rcx], rax
	jmp	$_010

$_009:	mov	qword ptr [ModuleInfo+0x128+rip], rax
$_010:	mov	rax, qword ptr [ModuleInfo+0x130+rip]
	mov	qword ptr [rdi], rax
	mov	qword ptr [ModuleInfo+0x130+rip], rdi
	mov	eax, dword ptr [rdi+0x8]
	jmp	$_017

$_011:	lea	rcx, [rdi+0x10]
	call	SetSegAssumeTable@PLT
	lea	rdx, [rdi+0x170]
	lea	rcx, [rdi+0x70]
	call	SetStdAssumeTable@PLT
	jmp	$_018

$_012:	mov	al, byte ptr [rdi+0x10]
	mov	byte ptr [ModuleInfo+0x1C4+rip], al
	jmp	$_018

$_013:	mov	al, byte ptr [rdi+0x10]
	mov	byte ptr [ModuleInfo+0x1C5+rip], al
	mov	al, byte ptr [rdi+0x11]
	mov	byte ptr [ModuleInfo+0x1C7+rip], al
	jmp	$_018

$_014:	mov	eax, dword ptr [rdi+0x10]
	mov	dword ptr [ModuleInfo+0x1C8+rip], eax
	mov	al, byte ptr [rdi+0x14]
	mov	byte ptr [ModuleInfo+0x1DB+rip], al
	mov	al, byte ptr [rdi+0x15]
	mov	byte ptr [ModuleInfo+0x1DC+rip], al
	mov	al, byte ptr [rdi+0x16]
	mov	byte ptr [ModuleInfo+0x1DD+rip], al
	mov	al, byte ptr [rdi+0x17]
	mov	byte ptr [ModuleInfo+0x1DE+rip], al
	jmp	$_018

$_015:	mov	eax, dword ptr [rdi+0x10]
	mov	dword ptr [ModuleInfo+0x1BC+rip], eax
	mov	rcx, qword ptr [sym_Cpu+rip]
	test	rcx, rcx
	jz	$_016
	mov	eax, dword ptr [rdi+0x10]
	mov	dword ptr [rcx+0x28], eax
$_016:	mov	eax, dword ptr [rdi+0x14]
	mov	dword ptr [ModuleInfo+0x1C0+rip], eax
	jmp	$_018

$_017:	cmp	eax, 1
	je	$_011
	cmp	eax, 2
	je	$_012
	cmp	eax, 16
	jz	$_013
	cmp	eax, 4
	jz	$_014
	cmp	eax, 8
	jz	$_015
$_018:	mov	rdi, qword ptr [rbp-0x28]
	jmp	$_007

$_019:	cmp	dword ptr [rbp-0x14], 0
	jz	$_020
	mov	rcx, qword ptr [rbp-0x8]
	mov	rdx, qword ptr [rcx+0x10]
	mov	ecx, 1010
	call	asmerr@PLT
	jmp	$_037

$_020:	jmp	$_032

$_021:	xor	esi, esi
$_022:	cmp	esi, 6
	jnc	$_032
	cmp	dword ptr [rbp-0x14], 0
	je	$_032
	lea	rcx, [typetab+rip]
	mov	eax, dword ptr [rcx+rsi*4]
	test	dword ptr [rbp-0x14], eax
	je	$_031
	not	eax
	and	dword ptr [rbp-0x14], eax
	cmp	qword ptr [ModuleInfo+0x130+rip], 0
	jz	$_023
	mov	rdi, qword ptr [ModuleInfo+0x130+rip]
	mov	rax, qword ptr [rdi]
	mov	qword ptr [ModuleInfo+0x130+rip], rax
	jmp	$_024

$_023:	mov	ecx, 752
	call	LclAlloc@PLT
	mov	rdi, rax
$_024:	mov	rax, qword ptr [ModuleInfo+0x128+rip]
	mov	qword ptr [rdi], rax
	lea	rcx, [typetab+rip]
	mov	eax, dword ptr [rcx+rsi*4]
	mov	dword ptr [rdi+0x8], eax
	mov	qword ptr [ModuleInfo+0x128+rip], rdi
	jmp	$_030

$_025:	lea	rcx, [rdi+0x10]
	call	GetSegAssumeTable@PLT
	lea	rdx, [rdi+0x170]
	lea	rcx, [rdi+0x70]
	call	GetStdAssumeTable@PLT
	jmp	$_031

$_026:	mov	al, byte ptr [ModuleInfo+0x1C4+rip]
	mov	byte ptr [rdi+0x10], al
	jmp	$_031

$_027:	mov	al, byte ptr [ModuleInfo+0x1C5+rip]
	mov	byte ptr [rdi+0x10], al
	mov	al, byte ptr [ModuleInfo+0x1C7+rip]
	mov	byte ptr [rdi+0x11], al
	jmp	$_031

$_028:	mov	eax, dword ptr [ModuleInfo+0x1C8+rip]
	mov	dword ptr [rdi+0x10], eax
	mov	al, byte ptr [ModuleInfo+0x1DB+rip]
	mov	byte ptr [rdi+0x14], al
	mov	al, byte ptr [ModuleInfo+0x1DC+rip]
	mov	byte ptr [rdi+0x15], al
	mov	al, byte ptr [ModuleInfo+0x1DD+rip]
	mov	byte ptr [rdi+0x16], al
	mov	al, byte ptr [ModuleInfo+0x1DE+rip]
	mov	byte ptr [rdi+0x17], al
	jmp	$_031

$_029:	mov	eax, dword ptr [ModuleInfo+0x1BC+rip]
	mov	dword ptr [rdi+0x10], eax
	mov	eax, dword ptr [ModuleInfo+0x1C0+rip]
	mov	dword ptr [rdi+0x14], eax
	jmp	$_031

$_030:	cmp	eax, 1
	je	$_025
	cmp	eax, 2
	jz	$_026
	cmp	eax, 16
	jz	$_027
	cmp	eax, 4
	jz	$_028
	cmp	eax, 8
	jz	$_029
$_031:	inc	esi
	jmp	$_022

$_032:	add	rbx, 24
	cmp	byte ptr [rbx], 44
	jnz	$_033
	cmp	byte ptr [rbx+0x18], 0
	jz	$_033
	add	rbx, 24
$_033:	cmp	byte ptr [rbx], 8
	je	$_001
$_034:	cmp	byte ptr [rbx], 0
	jnz	$_035
	cmp	dword ptr [rbp-0x14], -1
	jnz	$_036
$_035:	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_037

$_036:	xor	eax, eax
$_037:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

ContextSaveState:
	push	rsi
	push	rdi
	push	rbx
	sub	rsp, 32
	xor	ecx, ecx
	mov	rdx, qword ptr [ModuleInfo+0x128+rip]
$_038:	test	rdx, rdx
	jz	$_039
	inc	ecx
	mov	rdx, qword ptr [rdx]
	jmp	$_038

$_039:
	test	ecx, ecx
	jz	$_041
	mov	dword ptr [ModuleInfo+0x140+rip], ecx
	imul	ecx, ecx, 752
	call	LclAlloc@PLT
	mov	qword ptr [ModuleInfo+0x138+rip], rax
	mov	rsi, qword ptr [ModuleInfo+0x128+rip]
	mov	rdi, rax
$_040:	test	rsi, rsi
	jz	$_041
	mov	rdx, rsi
	mov	ecx, 752
	rep movsb
	mov	rsi, rdx
	mov	rsi, qword ptr [rsi]
	jmp	$_040

$_041:
	add	rsp, 32
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_042:
	push	rsi
	push	rdi
	push	rbx
	sub	rsp, 32
	mov	ebx, dword ptr [ModuleInfo+0x140+rip]
$_043:	test	ebx, ebx
	jz	$_046
	cmp	qword ptr [ModuleInfo+0x130+rip], 0
	jz	$_044
	mov	rdi, qword ptr [ModuleInfo+0x130+rip]
	mov	rax, qword ptr [rdi]
	mov	qword ptr [ModuleInfo+0x130+rip], rax
	jmp	$_045

$_044:	mov	ecx, 752
	call	LclAlloc@PLT
	mov	rdi, rax
$_045:	lea	rax, [rbx-0x1]
	imul	esi, eax, 752
	add	rsi, qword ptr [ModuleInfo+0x138+rip]
	mov	ecx, 752
	mov	rdx, rdi
	rep movsb
	mov	rdi, rdx
	mov	rax, qword ptr [ModuleInfo+0x128+rip]
	mov	qword ptr [rdi], rax
	mov	qword ptr [ModuleInfo+0x128+rip], rdi
	dec	ebx
	jmp	$_043

$_046:
	add	rsp, 32
	pop	rbx
	pop	rdi
	pop	rsi
	ret

ContextInit:
	mov	qword ptr [rsp+0x8], rcx
	push	rbp
	mov	rbp, rsp
	cmp	dword ptr [rbp+0x10], 0
	jle	$_047
	call	$_042
$_047:	leave
	ret


.SECTION .data
	.ALIGN	16

typetab:
	.byte  0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
	.byte  0x04, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00
	.byte  0x10, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00

contextnames:
	.quad  DS0000
	.quad  DS0001
	.quad  DS0002
	.quad  DS0003
	.quad  DS0004
	.quad  DS0005


.SECTION .rodata
	.ALIGN	16

DS0000:
	.byte  0x41, 0x53, 0x53, 0x55, 0x4D, 0x45, 0x53, 0x00

DS0001:
	.byte  0x52, 0x41, 0x44, 0x49, 0x58, 0x00

DS0002:
	.byte  0x4C, 0x49, 0x53, 0x54, 0x49, 0x4E, 0x47, 0x00

DS0003:
	.byte  0x43, 0x50, 0x55, 0x00

DS0004:
	.byte  0x41, 0x4C, 0x49, 0x47, 0x4E, 0x4D, 0x45, 0x4E
	.byte  0x54, 0x00

DS0005:
	.byte  0x41, 0x4C, 0x4C, 0x00


.att_syntax prefix
