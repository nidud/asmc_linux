
.intel_syntax noprefix

.global StartupExitDirective
.global EndDirective

.extern idata_fixup
.extern ProcCheckOpen
.extern LstWriteSrcLine
.extern CurrStruct
.extern EvalOperand
.extern RunLineQueue
.extern AddLineQueueX
.extern AddLineQueue
.extern AddPublicData
.extern SegmentModuleExit
.extern optable_idx
.extern InstrTable
.extern asmerr
.extern Options
.extern ModuleInfo
.extern Parse_Pass
.extern CollectLinkObject


.SECTION .text
	.ALIGN	16

StartupExitDirective:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 168
	mov	dword ptr [rbp-0x4], 0
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	call	LstWriteSrcLine@PLT
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 0
	jnz	$_001
	mov	ecx, 2013
	call	asmerr@PLT
	jmp	$_024

$_001:	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jbe	$_002
	mov	ecx, 2199
	call	asmerr@PLT
	jmp	$_024

$_002:	jmp	$_021

$_003:	xor	edi, edi
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 1
	jnz	$_004
	lea	rcx, [DS0014+rip]
	call	AddLineQueue@PLT
$_004:	lea	rdx, [DS0016+rip]
	lea	rcx, [DS0015+rip]
	call	AddLineQueueX@PLT
	cmp	byte ptr [ModuleInfo+0x1B7+rip], 0
	jnz	$_010
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 1
	jnz	$_005
	jmp	$_010

$_005:	cmp	byte ptr [ModuleInfo+0x1B4+rip], 0
	jnz	$_008
	mov	eax, dword ptr [ModuleInfo+0x1BC+rip]
	and	eax, 0x7F
	cmp	eax, 1
	ja	$_006
	lea	rsi, [StartupDosNear0+rip]
	mov	edi, 12
	jmp	$_007

$_006:	lea	rsi, [StartupDosNear1+rip]
	mov	edi, 7
$_007:	jmp	$_009

$_008:	lea	rsi, [StartupDosFar+rip]
	mov	edi, 2
$_009:	test	edi, edi
	jz	$_010
	lodsq
	mov	rcx, rax
	call	AddLineQueue@PLT
	dec	edi
	jmp	$_009

$_010:	mov	byte ptr [ModuleInfo+0x1DF+rip], 1
	add	rbx, 24
	jmp	$_022

$_011:	cmp	byte ptr [ModuleInfo+0x1B7+rip], 0
	jnz	$_012
	lea	rsi, [ExitDos+rip]
	mov	edi, 2
	jmp	$_013

$_012:	lea	rsi, [ExitOS2+rip]
	mov	edi, 4
$_013:	add	rbx, 24
	cmp	byte ptr [rbx], 0
	je	$_019
	cmp	byte ptr [ModuleInfo+0x1B7+rip], 1
	jnz	$_014
	mov	rdx, qword ptr [rbx+0x10]
	lea	rcx, [DS0017+rip]
	call	AddLineQueueX@PLT
	imul	ebx, dword ptr [ModuleInfo+0x220+rip], 24
	jmp	$_018

$_014:	inc	dword ptr [rbp+0x28]
	mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0x70]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	jnz	$_015
	mov	rax, -1
	jmp	$_024

$_015:	cmp	dword ptr [rbp-0x34], 0
	jnz	$_016
	cmp	dword ptr [rbp-0x70], 256
	jge	$_016
	mov	edx, dword ptr [rbp-0x70]
	lea	rcx, [DS0018+rip]
	call	AddLineQueueX@PLT
	jmp	$_017

$_016:	mov	rdx, qword ptr [rbx+0x10]
	lea	rcx, [DS0019+rip]
	call	AddLineQueueX@PLT
$_017:	imul	ebx, dword ptr [rbp+0x28], 24
$_018:	add	rbx, qword ptr [rbp+0x30]
	lodsq
	dec	edi
$_019:	test	edi, edi
	jz	$_020
	lodsq
	mov	rcx, rax
	call	AddLineQueue@PLT
	dec	edi
	jmp	$_019

$_020:	jmp	$_022

$_021:	cmp	dword ptr [rbx+0x4], 453
	je	$_003
	cmp	dword ptr [rbx+0x4], 452
	je	$_011
$_022:	cmp	byte ptr [rbx], 0
	jz	$_023
	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	mov	dword ptr [rbp-0x4], -1
$_023:	call	RunLineQueue@PLT
	mov	eax, dword ptr [rbp-0x4]
$_024:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

EndDirective:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 256
	inc	dword ptr [rbp+0x20]
	call	LstWriteSrcLine@PLT
	cmp	byte ptr [ModuleInfo+0x1DF+rip], 0
	jz	$_026
	mov	esi, dword ptr [ModuleInfo+0x220+rip]
	cmp	dword ptr [rbp+0x20], esi
	jge	$_025
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_025
	mov	ecx, 4003
	call	asmerr@PLT
$_025:	inc	esi
	mov	dword ptr [rbp+0x20], esi
	imul	ebx, esi, 24
	add	rbx, qword ptr [rbp+0x28]
	mov	byte ptr [rbx], 8
	lea	rax, [DS0016+rip]
	mov	qword ptr [rbx+0x8], rax
	mov	byte ptr [rbx+0x18], 0
	lea	rax, [DS0019+0x14+rip]
	mov	qword ptr [rbx+0x20], rax
	inc	esi
	mov	dword ptr [ModuleInfo+0x220+rip], esi
$_026:	mov	byte ptr [rsp+0x20], 2
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x28]
	lea	rcx, [rbp+0x20]
	call	EvalOperand@PLT
	cmp	eax, -1
	jnz	$_027
	mov	rax, -1
	jmp	$_041

$_027:	imul	ebx, dword ptr [rbp+0x20], 24
	add	rbx, qword ptr [rbp+0x28]
	cmp	byte ptr [rbx], 0
	jz	$_028
	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_041

$_028:	mov	rcx, qword ptr [CurrStruct+rip]
	test	rcx, rcx
	jz	$_031
	jmp	$_030

$_029:	mov	rcx, qword ptr [rcx+0x70]
$_030:	cmp	qword ptr [rcx+0x70], 0
	jnz	$_029
	mov	rdx, qword ptr [rcx+0x8]
	mov	ecx, 1010
	call	asmerr@PLT
$_031:	call	ProcCheckOpen@PLT
	mov	rsi, qword ptr [rbp-0x18]
	cmp	dword ptr [rbp-0x2C], 1
	jne	$_037
	test	byte ptr [rbp-0x25], 0x01
	jne	$_037
	cmp	byte ptr [rbp-0x28], -127
	jz	$_032
	cmp	byte ptr [rbp-0x28], -126
	jz	$_032
	cmp	byte ptr [rbp-0x28], -64
	jne	$_037
	cmp	dword ptr [rbp-0x30], 249
	jne	$_037
$_032:	test	rsi, rsi
	je	$_037
	cmp	byte ptr [rsi+0x18], 1
	jz	$_033
	cmp	byte ptr [rsi+0x18], 2
	jne	$_037
$_033:	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_034
	mov	qword ptr [rbp-0xB8], 0
	mov	word ptr [rbp-0xC2], 751
	movzx	eax, word ptr [optable_idx+0x17A+rip]
	lea	rcx, [InstrTable+rip]
	lea	rax, [rcx+rax*8]
	mov	qword ptr [rbp-0x78], rax
	mov	byte ptr [rbp-0x6A], 0
	mov	byte ptr [rbp-0x70], -64
	lea	r8, [rbp-0x68]
	xor	edx, edx
	lea	rcx, [rbp-0xD0]
	call	idata_fixup@PLT
	mov	rax, qword ptr [rbp-0xB8]
	mov	qword ptr [ModuleInfo+0xE0+rip], rax
	mov	eax, dword ptr [rbp-0x68]
	mov	dword ptr [ModuleInfo+0xE8+rip], eax
	jmp	$_036

$_034:	cmp	byte ptr [rsi+0x18], 2
	jz	$_035
	test	dword ptr [rsi+0x14], 0x80
	jnz	$_035
	or	dword ptr [rsi+0x14], 0x80
	mov	rcx, rsi
	call	AddPublicData@PLT
$_035:	mov	qword ptr [ModuleInfo+0xE0+rip], rsi
$_036:	jmp	$_038

$_037:	cmp	dword ptr [rbp-0x2C], -2
	jz	$_038
	mov	ecx, 2094
	call	asmerr@PLT
	jmp	$_041

$_038:	call	SegmentModuleExit@PLT
	cmp	qword ptr [ModuleInfo+0x160+rip], 0
	jz	$_039
	call	qword ptr [ModuleInfo+0x160+rip]
	jmp	$_040

$_039:	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_040
	mov	rcx, qword ptr [ModuleInfo+0x98+rip]
	test	rcx, rcx
	jz	$_040
	call	CollectLinkObject@PLT
$_040:	mov	byte ptr [ModuleInfo+0x1E0+rip], 1
	xor	eax, eax
$_041:	leave
	pop	rbx
	pop	rsi
	ret


.SECTION .data
	.ALIGN	16

StartupDosNear0:
	.quad  DS0000
	.quad  DS0001
	.quad  DS0002
	.quad  DS0003
	.quad  DS0004
	.quad  DS0004
	.quad  DS0004
	.quad  DS0004
	.quad  DS0005
	.quad  DS0006
	.quad  DS0007
	.quad  DS0008

StartupDosNear1:
	.quad  DS0009
	.quad  DS000A
	.quad  DS0002
	.quad  DS000B
	.quad  DS000C
	.quad  DS000D
	.quad  DS0007

StartupDosFar:
	.quad  DS0000
	.quad  DS0001

ExitOS2:
	.quad  DS000E
	.quad  DS000F
	.quad  DS0010
	.quad  DS0011

ExitDos:
	.quad  DS0012
	.quad  DS0013

DS0014:
	.byte  0x6F, 0x72, 0x67, 0x20, 0x31, 0x30, 0x30, 0x68
	.byte  0x00

DS0015:
	.byte  0x25, 0x73, 0x3A, 0x3A, 0x00

DS0016:
	.byte  0x40, 0x53, 0x74, 0x61, 0x72, 0x74, 0x75, 0x70
	.byte  0x00

DS0017:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x61, 0x78, 0x2C, 0x25
	.byte  0x73, 0x00

DS0018:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x61, 0x78, 0x2C, 0x34
	.byte  0x43, 0x30, 0x30, 0x68, 0x20, 0x2B, 0x20, 0x25
	.byte  0x75, 0x00

DS0019:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x61, 0x6C, 0x2C, 0x25
	.byte  0x73, 0x0A, 0x6D, 0x6F, 0x76, 0x20, 0x61, 0x68
	.byte  0x2C, 0x34, 0x43, 0x68, 0x00


.SECTION .rodata
	.ALIGN	16

DS0000:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x64, 0x78, 0x2C, 0x44
	.byte  0x47, 0x52, 0x4F, 0x55, 0x50, 0x00

DS0001:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x64, 0x73, 0x2C, 0x64
	.byte  0x78, 0x00

DS0002:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x62, 0x78, 0x2C, 0x73
	.byte  0x73, 0x00

DS0003:
	.byte  0x73, 0x75, 0x62, 0x20, 0x62, 0x78, 0x2C, 0x64
	.byte  0x78, 0x00

DS0004:
	.byte  0x73, 0x68, 0x6C, 0x20, 0x62, 0x78, 0x2C, 0x31
	.byte  0x00

DS0005:
	.byte  0x63, 0x6C, 0x69, 0x00

DS0006:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x73, 0x73, 0x2C, 0x64
	.byte  0x78, 0x00

DS0007:
	.byte  0x61, 0x64, 0x64, 0x20, 0x73, 0x70, 0x2C, 0x62
	.byte  0x78, 0x00

DS0008:
	.byte  0x73, 0x74, 0x69, 0x00

DS0009:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x61, 0x78, 0x2C, 0x44
	.byte  0x47, 0x52, 0x4F, 0x55, 0x50, 0x00

DS000A:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x64, 0x73, 0x2C, 0x61
	.byte  0x78, 0x00

DS000B:
	.byte  0x73, 0x75, 0x62, 0x20, 0x62, 0x78, 0x2C, 0x61
	.byte  0x78, 0x00

DS000C:
	.byte  0x73, 0x68, 0x6C, 0x20, 0x62, 0x78, 0x2C, 0x34
	.byte  0x00

DS000D:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x73, 0x73, 0x2C, 0x61
	.byte  0x78, 0x00

DS000E:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x61, 0x68, 0x2C, 0x30
	.byte  0x00

DS000F:
	.byte  0x70, 0x75, 0x73, 0x68, 0x20, 0x31, 0x00

DS0010:
	.byte  0x70, 0x75, 0x73, 0x68, 0x20, 0x61, 0x78, 0x00

DS0011:
	.byte  0x63, 0x61, 0x6C, 0x6C, 0x20, 0x44, 0x4F, 0x53
	.byte  0x45, 0x58, 0x49, 0x54, 0x00

DS0012:
	.byte  0x6D, 0x6F, 0x76, 0x20, 0x61, 0x68, 0x2C, 0x34
	.byte  0x63, 0x68, 0x00

DS0013:
	.byte  0x69, 0x6E, 0x74, 0x20, 0x32, 0x31, 0x68, 0x00


.att_syntax prefix