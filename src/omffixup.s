
.intel_syntax noprefix

.global OmfFixGenFixModend
.global OmfFixGenFix

.extern omf_GetGrpIdx
.extern szNull
.extern GetSegIdx
.extern asmerr
.extern ModuleInfo


.SECTION .text
	.ALIGN	16

$_001:	cmp	dx, 127
	jbe	$_002
	or	dh, 0xFFFFFF80
	mov	byte ptr [rax], dh
	inc	rax
$_002:	mov	byte ptr [rax], dl
	inc	rax
	ret

$_003:
	mov	word ptr [rax], dx
	add	rax, 2
	ret

$_004:
	mov	dword ptr [rax], edx
	add	rax, 4
	ret

$_005:
	mov	qword ptr [rsp+0x18], r8
	push	rbp
	mov	rbp, rsp
	jmp	$_007

$_006:	movzx	edx, word ptr [rbp+0x20]
	mov	rax, rcx
	call	$_001
	jmp	$_009

	jmp	$_008

$_007:	cmp	dl, 0
	jz	$_006
	cmp	dl, 1
	jz	$_006
	cmp	dl, 2
	jz	$_006
$_008:	mov	rax, rcx
$_009:	leave
	ret

$_010:
	mov	qword ptr [rsp+0x18], r8
	push	rbp
	mov	rbp, rsp
	movzx	edx, word ptr [rbp+0x20]
	mov	rax, rcx
	call	$_001
	leave
	ret

$_011:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, rcx
	mov	bl, byte ptr [rsi+0x5]
	cmp	dword ptr [rsi+0x8], 0
	jnz	$_012
	cmp	byte ptr [rsi+0x4], 0
	jz	$_012
	or	bl, 0x04
$_012:	mov	rdi, qword ptr [rbp+0x30]
	mov	al, byte ptr [rsi]
	shl	al, 4
	or	al, bl
	stosb
	movzx	r8d, word ptr [rsi+0x2]
	movzx	edx, byte ptr [rsi]
	mov	rcx, rdi
	call	$_005
	mov	rdi, rax
	movzx	r8d, word ptr [rsi+0x6]
	movzx	edx, bl
	mov	rcx, rdi
	call	$_010
	mov	rdi, rax
	test	bl, 0x04
	jnz	$_014
	mov	edx, dword ptr [rsi+0x8]
	cmp	dword ptr [rbp+0x38], 1
	jnz	$_013
	mov	rax, rdi
	call	$_004
	mov	rdi, rax
	jmp	$_014

$_013:	movzx	edx, dx
	mov	rax, rdi
	call	$_003
	mov	rdi, rax
$_014:	mov	rax, rdi
	sub	rax, qword ptr [rbp+0x30]
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

OmfFixGenFixModend:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	rbx, rcx
	mov	rdi, qword ptr [rbx+0x30]
	mov	byte ptr [rbp-0xC], 0
	mov	eax, dword ptr [rdi+0x28]
	add	eax, dword ptr [rbp+0x30]
	mov	dword ptr [rbp-0x8], eax
	mov	ax, word ptr [rbx+0x22]
	mov	word ptr [rbp-0xE], ax
	cmp	byte ptr [rdi+0x18], 2
	jnz	$_016
	mov	byte ptr [rbp-0xB], 2
	mov	ax, word ptr [rdi+0x60]
	mov	word ptr [rbp-0xA], ax
	cmp	byte ptr [rbx+0x20], 1
	jnz	$_015
	cmp	word ptr [rbx+0x22], 0
	jnz	$_015
	mov	rcx, rdi
	call	omf_GetGrpIdx@PLT
	mov	word ptr [rbp-0xE], ax
$_015:	jmp	$_017

$_016:	mov	byte ptr [rbp-0xB], 0
	mov	rcx, qword ptr [rdi+0x30]
	call	GetSegIdx@PLT
	mov	word ptr [rbp-0xA], ax
$_017:	cmp	byte ptr [rbx+0x20], 6
	jz	$_018
	cmp	byte ptr [rbx+0x20], 0
	jz	$_018
	mov	al, byte ptr [rbx+0x20]
	mov	byte ptr [rbp-0x10], al
	jmp	$_019

$_018:	mov	byte ptr [rbp-0x10], 5
$_019:	mov	r8d, dword ptr [rbp+0x38]
	mov	rdx, qword ptr [rbp+0x28]
	lea	rcx, [rbp-0x10]
	call	$_011
	leave
	pop	rbx
	pop	rdi
	ret

$_020:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, rdx
	mov	rbx, rcx
	mov	rdi, qword ptr [rbx+0x30]
	test	edi, edi
	jnz	$_022
	cmp	byte ptr [rbx+0x20], 6
	jnz	$_021
	xor	eax, eax
	jmp	$_040

$_021:	mov	al, byte ptr [rbx+0x20]
	mov	byte ptr [rsi+0x5], al
	mov	ax, word ptr [rbx+0x22]
	mov	word ptr [rsi+0x6], ax
	mov	byte ptr [rsi], 5
	jmp	$_038

$_022:	cmp	byte ptr [rdi+0x18], 0
	jnz	$_023
	mov	rdx, qword ptr [rdi+0x8]
	mov	ecx, 2006
	call	asmerr@PLT
	xor	eax, eax
	jmp	$_040

	jmp	$_038

$_023:	cmp	byte ptr [rdi+0x18], 4
	jnz	$_026
	mov	byte ptr [rsi+0x5], 5
	mov	rcx, qword ptr [rdi+0x68]
	mov	eax, dword ptr [rcx+0x8]
	mov	word ptr [rsi+0x6], ax
	cmp	byte ptr [rbx+0x20], 6
	jz	$_024
	mov	al, byte ptr [rbx+0x20]
	mov	byte ptr [rsi], al
	mov	ax, word ptr [rbx+0x22]
	mov	word ptr [rsi+0x2], ax
	jmp	$_025

$_024:	mov	byte ptr [rsi], 1
	mov	ax, word ptr [rsi+0x6]
	mov	word ptr [rsi+0x2], ax
$_025:	jmp	$_038

$_026:	cmp	byte ptr [rdi+0x18], 3
	jnz	$_029
	mov	byte ptr [rsi+0x5], 4
	mov	rcx, rdi
	call	GetSegIdx@PLT
	mov	word ptr [rsi+0x6], ax
	cmp	byte ptr [rbx+0x20], 6
	jz	$_027
	mov	al, byte ptr [rbx+0x20]
	mov	byte ptr [rsi], al
	mov	ax, word ptr [rbx+0x22]
	mov	word ptr [rsi+0x2], ax
	jmp	$_028

$_027:	mov	byte ptr [rsi], 0
	mov	ax, word ptr [rsi+0x6]
	mov	word ptr [rsi+0x2], ax
$_028:	jmp	$_038

$_029:	mov	ax, word ptr [rbx+0x22]
	mov	word ptr [rsi+0x2], ax
	cmp	byte ptr [rdi+0x18], 2
	jnz	$_031
	mov	byte ptr [rsi+0x5], 6
	mov	ax, word ptr [rdi+0x60]
	mov	word ptr [rsi+0x6], ax
	cmp	byte ptr [rbx+0x20], 1
	jnz	$_030
	cmp	word ptr [rbx+0x22], 0
	jnz	$_030
	mov	rcx, rdi
	call	omf_GetGrpIdx@PLT
	mov	word ptr [rsi+0x2], ax
$_030:	jmp	$_036

$_031:	test	byte ptr [rdi+0x14], 0x40
	jz	$_033
	mov	eax, 4
	cmp	byte ptr [rbx+0x20], 1
	jnz	$_032
	mov	eax, 5
$_032:	mov	byte ptr [rsi+0x5], al
	mov	ax, word ptr [rbx+0x22]
	mov	word ptr [rsi+0x6], ax
	jmp	$_036

$_033:	cmp	qword ptr [rdi+0x30], 0
	jnz	$_034
	mov	rdx, qword ptr [rdi+0x8]
	mov	ecx, 3005
	call	asmerr@PLT
	xor	eax, eax
	jmp	$_040

	jmp	$_036

$_034:	mov	rcx, qword ptr [rdi+0x30]
	mov	rcx, qword ptr [rcx+0x68]
	cmp	byte ptr [rcx+0x73], 0
	jz	$_035
	mov	byte ptr [rsi+0x5], 6
	mov	eax, dword ptr [rcx+0x44]
	mov	word ptr [rsi+0x6], ax
	mov	byte ptr [rsi], 5
	mov	eax, 1
	jmp	$_040

$_035:	mov	byte ptr [rsi+0x5], 4
	mov	rcx, qword ptr [rdi+0x30]
	call	GetSegIdx@PLT
	mov	word ptr [rsi+0x6], ax
$_036:	cmp	byte ptr [rbx+0x20], 6
	jz	$_037
	mov	al, byte ptr [rbx+0x20]
	mov	byte ptr [rsi], al
	jmp	$_038

$_037:	mov	byte ptr [rsi], 5
$_038:	mov	al, byte ptr [rsi+0x5]
	sub	al, 4
	cmp	byte ptr [rsi], al
	jnz	$_039
	mov	byte ptr [rsi], 5
$_039:	mov	eax, 1
$_040:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

OmfFixGenFix:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	byte ptr [rbp-0x2], 0
	mov	byte ptr [rbp-0x14], 1
	mov	dword ptr [rbp-0x10], 0
	mov	rbx, rcx
	jmp	$_055

$_041:	mov	byte ptr [rbp-0x2], 1
$_042:	mov	byte ptr [rbp-0x1], 0
	jmp	$_056

$_043:	mov	byte ptr [rbp-0x2], 1
$_044:	mov	al, 4
	test	byte ptr [rbx+0x1B], 0x01
	jz	$_045
	mov	al, 20
$_045:	mov	byte ptr [rbp-0x1], al
	jmp	$_056

$_046:	mov	byte ptr [rbp-0x2], 1
$_047:	mov	al, 36
	test	byte ptr [rbx+0x1B], 0x01
	jz	$_048
	mov	al, 52
$_048:	mov	byte ptr [rbp-0x1], al
	jmp	$_056

$_049:	mov	byte ptr [rbp-0x1], 16
	jmp	$_056

$_050:	mov	byte ptr [rbp-0x1], 8
	jmp	$_056

$_051:	mov	byte ptr [rbp-0x1], 12
	jmp	$_056

$_052:	mov	byte ptr [rbp-0x1], 44
	jmp	$_056

$_053:	mov	rcx, qword ptr [ModuleInfo+0x1A8+rip]
	lea	rax, [szNull+rip]
	cmp	qword ptr [rbx+0x30], 0
	jz	$_054
	mov	rax, qword ptr [rbx+0x30]
	mov	rax, qword ptr [rax+0x8]
$_054:	mov	r8, rax
	lea	rdx, [rcx+0xA]
	mov	ecx, 3001
	call	asmerr@PLT
	xor	eax, eax
	jmp	$_059

	jmp	$_056

$_055:	cmp	byte ptr [rbx+0x18], 1
	je	$_041
	cmp	byte ptr [rbx+0x18], 4
	je	$_042
	cmp	byte ptr [rbx+0x18], 2
	je	$_043
	cmp	byte ptr [rbx+0x18], 5
	je	$_044
	cmp	byte ptr [rbx+0x18], 3
	je	$_046
	cmp	byte ptr [rbx+0x18], 6
	je	$_047
	cmp	byte ptr [rbx+0x18], 11
	je	$_049
	cmp	byte ptr [rbx+0x18], 8
	je	$_050
	cmp	byte ptr [rbx+0x18], 9
	je	$_051
	cmp	byte ptr [rbx+0x18], 10
	je	$_052
	jmp	$_053

$_056:	mov	al, -64
	cmp	byte ptr [rbp-0x2], 0
	jz	$_057
	mov	al, -128
$_057:	or	byte ptr [rbp-0x1], al
	lea	rdx, [rbp-0x18]
	mov	rcx, rbx
	call	$_020
	test	rax, rax
	jnz	$_058
	xor	eax, eax
	jmp	$_059

$_058:	mov	eax, dword ptr [rbx+0x14]
	sub	eax, dword ptr [rbp+0x30]
	mov	dword ptr [rbp-0x8], eax
	or	byte ptr [rbp-0x1], ah
	mov	rcx, qword ptr [rbp+0x38]
	mov	byte ptr [rcx+0x1], al
	mov	al, byte ptr [rbp-0x1]
	mov	byte ptr [rcx], al
	add	rcx, 2
	mov	r8d, dword ptr [rbp+0x40]
	mov	rdx, rcx
	lea	rcx, [rbp-0x18]
	call	$_011
	lea	rax, [rax+0x2]
$_059:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret


.SECTION .data
	.ALIGN	16


.att_syntax prefix
