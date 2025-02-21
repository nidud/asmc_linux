
.intel_syntax noprefix

.global omf_GetGrpIdx
.global omf_OutSelect
.global omf_FlushCurrSeg
.global omf_check_flush
.global omf_set_filepos
.global omf_init
.global LastCodeBufSize

.extern SortSegments
.extern cv_write_debug_tables
.extern ftruncate
.extern GetFName
.extern OmfFixGenFixModend
.extern OmfFixGenFix
.extern omf_write_record
.extern Mangle
.extern GetGroup
.extern GetSegIdx
.extern CreateIntSegment
.extern GetCurrOffset
.extern GetSymOfssize
.extern SizeFromMemtype
.extern SymTables
.extern tstrcpy
.extern tstrlen
.extern tmemcpy
.extern tstrupr
.extern asmerr
.extern LinnumQueue
.extern write_to_file
.extern Options
.extern ModuleInfo
.extern ftell
.extern fseek
.extern fileno
.extern stat
.extern localtime


.SECTION .text
	.ALIGN	16

$_001:	xor	eax, eax
	mov	dword ptr [rcx], eax
	mov	dword ptr [rcx+0x4], eax
	mov	qword ptr [rcx+0x8], rax
	mov	byte ptr [rcx+0x10], dl
	mov	byte ptr [rcx+0x11], al
	ret

$_002:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	lea	rdi, [rbp+0x20]
	call	localtime@PLT
	test	rax, rax
	jz	$_003
	mov	rcx, rax
	mov	eax, dword ptr [rcx+0x14]
	sub	eax, 80
	shl	eax, 9
	mov	edx, dword ptr [rcx+0x10]
	inc	edx
	shl	edx, 5
	or	eax, edx
	mov	edx, dword ptr [rcx+0xC]
	shl	edx, 0
	or	eax, edx
	shl	eax, 16
	mov	edx, dword ptr [rcx+0x8]
	shl	edx, 11
	or	eax, edx
	mov	edx, dword ptr [rcx+0x4]
	shl	edx, 5
	or	eax, edx
	mov	edx, dword ptr [rcx]
	shr	edx, 1
	shl	edx, 0
	or	eax, edx
	jmp	$_004

$_003:	mov	rax, qword ptr [rbp+0x20]
$_004:	leave
	pop	rdi
	pop	rsi
	ret

$_005:
	mov	eax, dword ptr [rcx+0x4]
	inc	dword ptr [rcx+0x4]
	add	rax, qword ptr [rcx+0x8]
	mov	byte ptr [rax], dl
	ret

$_006:
	mov	eax, dword ptr [rcx+0x4]
	add	dword ptr [rcx+0x4], 2
	add	rax, qword ptr [rcx+0x8]
	mov	word ptr [rax], dx
	ret

$_007:
	mov	eax, dword ptr [rcx+0x4]
	add	dword ptr [rcx+0x4], 4
	add	rax, qword ptr [rcx+0x8]
	mov	dword ptr [rax], edx
	ret

$_008:
	mov	eax, dword ptr [rcx+0x4]
	add	rax, qword ptr [rcx+0x8]
	inc	dword ptr [rcx+0x4]
	cmp	edx, 127
	jbe	$_009
	or	dh, 0xFFFFFF80
	mov	byte ptr [rax], dh
	inc	dword ptr [rcx+0x4]
	inc	rax
$_009:	mov	byte ptr [rax], dl
	ret

$_010:
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	eax, dword ptr [rbp+0x30]
	mov	edi, dword ptr [rcx+0x4]
	add	rdi, qword ptr [rcx+0x8]
	add	dword ptr [rcx+0x4], eax
	mov	rsi, rdx
	mov	ecx, eax
	rep movsb
	leave
	pop	rdi
	pop	rsi
	ret

$_011:
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	eax, r8d
	mov	edx, dword ptr [rcx+0x4]
	add	rdx, qword ptr [rcx+0x8]
	inc	dword ptr [rcx+0x4]
	mov	byte ptr [rdx], al
	mov	r8d, eax
	mov	rdx, qword ptr [rbp+0x18]
	call	$_010
	leave
	ret

$_012:
	mov	qword ptr [rsp+0x18], r8
	push	rbp
	mov	rbp, rsp
	mov	qword ptr [rcx+0x8], rdx
	mov	rax, qword ptr [rbp+0x20]
	mov	dword ptr [rcx], eax
	leave
	ret

omf_GetGrpIdx:
	xor	eax, eax
	test	rcx, rcx
	jz	$_013
	mov	rdx, qword ptr [rcx+0x68]
	mov	eax, dword ptr [rdx+0x8]
$_013:	ret

omf_OutSelect:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 104
	mov	rbx, qword ptr [ModuleInfo+0x1F8+rip]
	mov	rbx, qword ptr [rbx+0x68]
	test	ecx, ecx
	jz	$_016
	cmp	byte ptr [rbx+0x6E], 0
	jnz	$_014
	cmp	dword ptr [rbx+0x48], 1
	jz	$_015
$_014:	jmp	$_020

$_015:	call	GetCurrOffset@PLT
	mov	dword ptr [sel_start+rip], eax
	mov	byte ptr [rbx+0x6E], 1
	jmp	$_020

$_016:	cmp	byte ptr [rbx+0x6E], 0
	je	$_020
	mov	byte ptr [rbx+0x6E], 0
	cmp	dword ptr [write_to_file+rip], 1
	jne	$_020
	mov	edx, 136
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	byte ptr [rbp-0x1C], -128
	mov	byte ptr [rbp-0x1B], -3
	mov	rcx, qword ptr [ModuleInfo+0x1F8+rip]
	call	GetSegIdx@PLT
	mov	dword ptr [rbp-0x38], eax
	mov	r8d, 11
	lea	rdx, [rbp-0x44]
	lea	rcx, [rbp-0x30]
	call	$_012
	call	GetCurrOffset@PLT
	mov	dword ptr [rbp-0x34], eax
	cmp	dword ptr [sel_start+rip], 65535
	ja	$_017
	cmp	dword ptr [rbp-0x34], 65535
	jbe	$_018
$_017:	mov	edx, 83
	lea	rcx, [rbp-0x30]
	call	$_005
	mov	edx, dword ptr [rbp-0x38]
	lea	rcx, [rbp-0x30]
	call	$_008
	mov	edx, dword ptr [sel_start+rip]
	lea	rcx, [rbp-0x30]
	call	$_007
	mov	edx, dword ptr [rbp-0x34]
	lea	rcx, [rbp-0x30]
	call	$_007
	jmp	$_019

$_018:	mov	edx, 115
	lea	rcx, [rbp-0x30]
	call	$_005
	mov	edx, dword ptr [rbp-0x38]
	lea	rcx, [rbp-0x30]
	call	$_008
	mov	edx, dword ptr [sel_start+rip]
	lea	rcx, [rbp-0x30]
	call	$_006
	mov	edx, dword ptr [rbp-0x34]
	lea	rcx, [rbp-0x30]
	call	$_006
$_019:	lea	rcx, [rbp-0x30]
	mov	eax, dword ptr [rcx+0x4]
	mov	dword ptr [rcx], eax
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
$_020:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_021:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 88
	mov	rsi, qword ptr [LinnumQueue+rip]
	mov	rdi, qword ptr [ModuleInfo+0x188+rip]
$_022:	test	rsi, rsi
	jz	$_025
	mov	rbx, qword ptr [rsi]
	mov	eax, dword ptr [rsi+0x8]
	stosw
	mov	eax, dword ptr [rsi+0xC]
	test	cl, cl
	jz	$_023
	stosd
	jmp	$_024

$_023:	stosw
$_024:	mov	rsi, rbx
	jmp	$_022

$_025:
	mov	qword ptr [LinnumQueue+rip], 0
	sub	rdi, qword ptr [ModuleInfo+0x188+rip]
	test	rdi, rdi
	jz	$_026
	mov	esi, ecx
	mov	edx, 148
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	eax, esi
	mov	byte ptr [rbp-0x1F], al
	mov	r8, rdi
	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	lea	rcx, [rbp-0x30]
	call	$_012
	mov	rbx, qword ptr [ModuleInfo+0x1F8+rip]
	mov	rdi, qword ptr [rbx+0x68]
	mov	rcx, rbx
	call	GetGroup@PLT
	mov	rcx, rax
	call	omf_GetGrpIdx
	mov	word ptr [rbp-0x1C], ax
	mov	eax, dword ptr [rdi+0x44]
	mov	word ptr [rbp-0x1A], ax
	mov	word ptr [rbp-0x18], 0
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
$_026:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_027:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 104
	mov	dword ptr [rbp-0x8], 0
	mov	byte ptr [rbp-0x39], dl
	test	dl, dl
	jz	$_028
	mov	dword ptr [rbp-0x8], 1
$_028:	mov	rbx, rcx
	mov	rsi, qword ptr [rbx+0x68]
	mov	rbx, qword ptr [rsi+0x28]
	jmp	$_037

$_029:	mov	rdi, qword ptr [ModuleInfo+0x188+rip]
	mov	dword ptr [rbp-0x4], 0
$_030:	test	rbx, rbx
	jz	$_036
	jmp	$_033

$_031:	cmp	byte ptr [rbp-0x39], 0
	jz	$_035
	jmp	$_034

$_032:	cmp	byte ptr [rbp-0x39], 0
	jnz	$_035
	jmp	$_034

$_033:	cmp	byte ptr [rbx+0x18], 3
	jz	$_031
	cmp	byte ptr [rbx+0x18], 6
	jz	$_031
	cmp	byte ptr [rbx+0x18], 10
	jz	$_031
	jmp	$_032

$_034:	cmp	dword ptr [rbp-0x4], 1009
	ja	$_036
	mov	r9d, dword ptr [rbp-0x8]
	mov	r8, rdi
	mov	edx, dword ptr [rsi+0x8]
	mov	rcx, rbx
	call	OmfFixGenFix@PLT
	add	rdi, rax
	mov	rax, rdi
	sub	rax, qword ptr [ModuleInfo+0x188+rip]
	mov	dword ptr [rbp-0x4], eax
$_035:	mov	rbx, qword ptr [rbx+0x8]
	jmp	$_030

$_036:	cmp	dword ptr [rbp-0x4], 0
	jz	$_037
	mov	edx, 156
	lea	rcx, [rbp-0x38]
	call	$_001
	mov	al, byte ptr [rbp-0x39]
	mov	byte ptr [rbp-0x27], al
	mov	r8d, dword ptr [rbp-0x4]
	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	lea	rcx, [rbp-0x38]
	call	$_012
	lea	rcx, [rbp-0x38]
	call	omf_write_record@PLT
$_037:	test	rbx, rbx
	jne	$_029
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_038:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 88
	mov	rbx, rcx
	mov	rsi, qword ptr [rbx+0x68]
	mov	edi, dword ptr [rsi+0xC]
	sub	edi, dword ptr [rsi+0x8]
	cmp	edi, 0
	jle	$_048
	cmp	dword ptr [write_to_file+rip], 1
	jne	$_048
	mov	dword ptr [LastCodeBufSize+rip], edi
	cmp	byte ptr [rsi+0x73], 0
	je	$_046
	test	byte ptr [rbx+0x14], 0x01
	jz	$_039
	mov	edx, 188
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	r8d, 4
	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	lea	rcx, [rbp-0x30]
	call	$_012
	mov	edx, dword ptr [rsi+0x58]
	lea	rcx, [rbp-0x30]
	call	$_008
	xor	edx, edx
	lea	rcx, [rbp-0x30]
	call	$_008
	lea	rcx, [rbp-0x30]
	mov	eax, dword ptr [rcx+0x4]
	mov	dword ptr [rcx], eax
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	cmp	dword ptr [rsi+0x44], 0
	jnz	$_039
	mov	eax, dword ptr [startext+rip]
	mov	dword ptr [rsi+0x44], eax
	inc	dword ptr [startext+rip]
$_039:	mov	edx, 194
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	r8d, edi
	mov	rdx, qword ptr [rsi+0x10]
	lea	rcx, [rbp-0x30]
	call	$_012
	cmp	dword ptr [rsi+0x8], 65535
	jbe	$_040
	mov	byte ptr [rbp-0x1F], 1
$_040:	mov	byte ptr [rbp-0x1C], 0
	cmp	dword ptr [rsi+0x48], 1
	jnz	$_043
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 7
	jnz	$_041
	mov	byte ptr [rbp-0x1B], 3
	jmp	$_042

$_041:	mov	byte ptr [rbp-0x1B], 1
$_042:	jmp	$_045

$_043:	cmp	byte ptr [ModuleInfo+0x1B5+rip], 7
	jnz	$_044
	mov	byte ptr [rbp-0x1B], 4
	jmp	$_045

$_044:	mov	byte ptr [rbp-0x1B], 2
$_045:	movzx	ecx, byte ptr [rsi+0x6A]
	call	$_080
	mov	byte ptr [rbp-0x1A], al
	mov	eax, dword ptr [rsi+0x8]
	mov	dword ptr [rbp-0x18], eax
	mov	word ptr [rbp-0x14], 0
	mov	eax, dword ptr [rsi+0x58]
	mov	word ptr [rbp-0xC], ax
	jmp	$_047

$_046:	mov	edx, 160
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	r8d, edi
	mov	rdx, qword ptr [rsi+0x10]
	lea	rcx, [rbp-0x30]
	call	$_012
	mov	eax, dword ptr [rsi+0x44]
	mov	word ptr [rbp-0x1C], ax
	mov	eax, dword ptr [rsi+0x8]
	mov	dword ptr [rbp-0x18], eax
	cmp	dword ptr [rbp-0x18], 65535
	jbe	$_047
	mov	byte ptr [rbp-0x1F], 1
$_047:	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	cmp	qword ptr [rsi+0x28], 0
	jz	$_048
	xor	edx, edx
	mov	rcx, rbx
	call	$_027
	mov	edx, 1
	mov	rcx, rbx
	call	$_027
	mov	qword ptr [rsi+0x28], 0
	mov	qword ptr [rsi+0x30], 0
$_048:	mov	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rsi+0x8], eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

omf_FlushCurrSeg:
	sub	rsp, 40
	mov	rcx, qword ptr [ModuleInfo+0x1F8+rip]
	call	$_038
	cmp	byte ptr [Options+0x1+rip], 0
	jz	$_049
	movzx	ecx, byte ptr [ln_is32+rip]
	call	$_021
	mov	word ptr [ln_size+rip], 0
$_049:	add	rsp, 40
	ret

$_050:
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	rsi, rcx
	mov	edx, 128
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	rcx, rsi
	call	tstrlen@PLT
	mov	edi, eax
	lea	ecx, [rax+0x1]
	mov	r8d, ecx
	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	lea	rcx, [rbp-0x30]
	call	$_012
	mov	r8d, edi
	mov	rdx, rsi
	lea	rcx, [rbp-0x30]
	call	$_011
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	leave
	pop	rdi
	pop	rsi
	ret

omf_check_flush:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, rcx
	mov	eax, dword ptr [ln_srcfile+rip]
	cmp	dword ptr [rsi+0x10], eax
	jz	$_052
	cmp	qword ptr [LinnumQueue+rip], 0
	jz	$_051
	call	omf_FlushCurrSeg
$_051:	mov	ecx, dword ptr [rsi+0x10]
	call	GetFName@PLT
	mov	rcx, rax
	call	$_050
	mov	eax, dword ptr [rsi+0x10]
	mov	dword ptr [ln_srcfile+rip], eax
	jmp	$_059

$_052:	mov	eax, 0
	cmp	dword ptr [rsi+0xC], 65535
	jbe	$_053
	mov	eax, 1
$_053:	mov	byte ptr [rbp-0x1], al
	cmp	byte ptr [ln_is32+rip], al
	jz	$_055
	cmp	qword ptr [LinnumQueue+rip], 0
	jz	$_054
	call	omf_FlushCurrSeg
$_054:	mov	al, byte ptr [rbp-0x1]
	mov	byte ptr [ln_is32+rip], al
	jmp	$_059

$_055:	mov	eax, 2
	cmp	byte ptr [rbp-0x1], 0
	jz	$_056
	add	eax, 4
	jmp	$_057

$_056:	add	eax, 2
$_057:	mov	word ptr [rbp-0x4], ax
	add	ax, word ptr [ln_size+rip]
	cmp	ax, 1016
	jbe	$_058
	cmp	qword ptr [LinnumQueue+rip], 0
	jz	$_058
	call	omf_FlushCurrSeg
$_058:	mov	ax, word ptr [rbp-0x4]
	add	word ptr [ln_size+rip], ax
$_059:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_060:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	edx, 136
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	byte ptr [rbp-0x1C], 0
	mov	byte ptr [rbp-0x1B], -94
	mov	r8d, 1
	lea	rdx, [DS0004+rip]
	lea	rcx, [rbp-0x30]
	call	$_012
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	leave
	ret

omf_set_filepos:
	push	rsi
	push	rdi
	sub	rsp, 8
	xor	edx, edx
	mov	esi, dword ptr [end_of_header+rip]
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fseek@PLT
	add	rsp, 8
	pop	rdi
	pop	rsi
	ret

$_061:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	edx, 136
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	byte ptr [rbp-0x1C], -128
	mov	byte ptr [rbp-0x1B], -98
	xor	r8d, r8d
	lea	rdx, [DS0004+0x1+rip]
	lea	rcx, [rbp-0x30]
	call	$_012
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	leave
	ret

$_062:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 88
	mov	rsi, qword ptr [ModuleInfo+0x40+rip]
$_063:	test	rsi, rsi
	jz	$_064
	mov	rdi, qword ptr [rsi]
	lea	rbx, [rsi+0x8]
	mov	edx, 136
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	byte ptr [rbp-0x1C], -128
	mov	byte ptr [rbp-0x1B], -97
	mov	rcx, rbx
	call	tstrlen@PLT
	mov	r8, rax
	mov	rdx, rbx
	lea	rcx, [rbp-0x30]
	call	$_012
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	mov	rsi, rdi
	jmp	$_063

$_064:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_065:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 104
	mov	rsi, qword ptr [SymTables+0x40+rip]
$_066:	test	rsi, rsi
	je	$_073
	mov	rbx, qword ptr [rsi+0x68]
	test	byte ptr [rbx+0x40], 0x04
	je	$_072
	mov	edx, 136
	lea	rcx, [rbp-0x38]
	call	$_001
	mov	byte ptr [rbp-0x24], 0
	mov	byte ptr [rbp-0x23], -96
	mov	rdi, qword ptr [ModuleInfo+0x188+rip]
	cmp	byte ptr [Options+0x90+rip], 0
	jnz	$_067
	lea	rdx, [rdi+0x3]
	mov	rcx, rsi
	call	Mangle@PLT
	mov	dword ptr [rbp-0x3C], eax
	jmp	$_068

$_067:	mov	rdx, qword ptr [rsi+0x8]
	lea	rcx, [rdi+0x3]
	call	tstrcpy@PLT
	mov	eax, dword ptr [rsi+0x10]
	mov	dword ptr [rbp-0x3C], eax
$_068:	cmp	byte ptr [ModuleInfo+0x1D1+rip], 0
	jz	$_069
	lea	rcx, [rdi+0x3]
	call	tstrupr@PLT
$_069:	mov	ecx, dword ptr [rbp-0x3C]
	add	ecx, 4
	mov	r8d, ecx
	mov	rdx, rdi
	lea	rcx, [rbp-0x38]
	call	$_012
	mov	edx, 2
	lea	rcx, [rbp-0x38]
	call	$_005
	mov	rdx, qword ptr [rbx+0x8]
	xor	ecx, ecx
$_070:	test	rdx, rdx
	jz	$_071
	mov	rdx, qword ptr [rdx+0x78]
	inc	ecx
	jmp	$_070

$_071:	and	ecx, 0x1F
	movzx	edx, cl
	lea	rcx, [rbp-0x38]
	call	$_005
	movzx	edx, byte ptr [rbp-0x3C]
	lea	rcx, [rbp-0x38]
	call	$_005
	mov	eax, dword ptr [rbp-0x3C]
	add	dword ptr [rbp-0x34], eax
	xor	edx, edx
	lea	rcx, [rbp-0x38]
	call	$_005
	lea	rcx, [rbp-0x38]
	call	omf_write_record@PLT
$_072:	mov	rsi, qword ptr [rsi+0x78]
	jmp	$_066

$_073:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_074:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 104
	mov	rsi, qword ptr [SymTables+0x30+rip]
$_075:	test	rsi, rsi
	je	$_079
	mov	edx, 154
	lea	rcx, [rbp-0x48]
	call	$_001
	mov	rdi, qword ptr [rsi+0x68]
	mov	eax, dword ptr [rdi+0x8]
	mov	word ptr [rbp-0x34], ax
	imul	ecx, dword ptr [rdi+0x10], 3
	add	ecx, 2
	mov	r8d, ecx
	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	lea	rcx, [rbp-0x48]
	call	$_012
	mov	edx, dword ptr [rdi+0xC]
	lea	rcx, [rbp-0x48]
	call	$_008
	mov	rdi, qword ptr [rdi]
$_076:	test	rdi, rdi
	jz	$_078
	mov	edx, 255
	lea	rcx, [rbp-0x48]
	call	$_005
	mov	rcx, qword ptr [rdi+0x8]
	mov	rcx, qword ptr [rcx+0x68]
	mov	edx, dword ptr [rcx+0x44]
	lea	rcx, [rbp-0x48]
	call	$_008
	cmp	dword ptr [rbp-0x44], 4070
	jbe	$_077
	mov	rdx, qword ptr [rsi+0x8]
	mov	ecx, 8018
	call	asmerr@PLT
	jmp	$_078

$_077:	mov	rdi, qword ptr [rdi]
	jmp	$_076

$_078:	lea	rcx, [rbp-0x48]
	mov	eax, dword ptr [rcx+0x4]
	mov	dword ptr [rcx], eax
	lea	rcx, [rbp-0x48]
	call	omf_write_record@PLT
	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_075

$_079:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_080:
	jmp	$_086

$_081:	mov	eax, 2
	jmp	$_088

$_082:	mov	eax, 5
	jmp	$_088

$_083:	mov	eax, 3
	jmp	$_088

$_084:	mov	eax, 4
	jmp	$_088

$_085:	xor	eax, eax
	jmp	$_088

	jmp	$_087

$_086:	cmp	cl, 1
	jz	$_081
	cmp	cl, 2
	jz	$_082
	cmp	cl, 4
	jz	$_083
	cmp	cl, 8
	jz	$_084
	cmp	cl, -1
	jz	$_085
$_087:	mov	eax, 1
$_088:	ret

$_089:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 104
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_090:	test	rsi, rsi
	je	$_099
	mov	rdi, qword ptr [rsi+0x68]
	cmp	byte ptr [rdi+0x73], 0
	jne	$_098
	mov	edx, 152
	lea	rcx, [rbp-0x38]
	call	$_001
	cmp	byte ptr [rdi+0x68], 0
	jbe	$_094
	cmp	byte ptr [rdi+0x6D], 0
	jnz	$_091
	cmp	dword ptr [rsi+0x50], 65536
	jl	$_092
$_091:	mov	byte ptr [rbp-0x27], 1
	jmp	$_093

$_092:	mov	byte ptr [rbp-0x27], 0
$_093:	jmp	$_095

$_094:	mov	byte ptr [rbp-0x27], 0
$_095:	mov	eax, dword ptr [rdi+0x44]
	mov	word ptr [rbp-0x24], ax
	xor	eax, eax
	cmp	byte ptr [rdi+0x68], 0
	jbe	$_096
	inc	eax
$_096:	mov	byte ptr [rbp-0x22], al
	movzx	ecx, byte ptr [rdi+0x6A]
	call	$_080
	mov	byte ptr [rbp-0x21], al
	mov	al, byte ptr [rdi+0x72]
	mov	byte ptr [rbp-0x20], al
	mov	eax, dword ptr [rdi+0x58]
	mov	word ptr [rbp-0x1C], ax
	mov	eax, dword ptr [rdi+0x60]
	mov	dword ptr [rbp-0x18], eax
	mov	eax, dword ptr [rsi+0x50]
	mov	dword ptr [rbp-0x14], eax
	mov	eax, dword ptr [rdi+0x4C]
	mov	word ptr [rbp-0x10], ax
	mov	eax, 1
	mov	rcx, qword ptr [rdi+0x50]
	test	rcx, rcx
	jz	$_097
	mov	eax, dword ptr [rcx+0x28]
$_097:	mov	word ptr [rbp-0xE], ax
	mov	word ptr [rbp-0xC], 1
	lea	rcx, [rbp-0x38]
	call	omf_write_record@PLT
	cmp	dword ptr [rdi+0x48], 1
	jnz	$_098
	cmp	byte ptr [Options+0x8A+rip], 0
	jnz	$_098
	mov	edx, 136
	lea	rcx, [rbp-0x38]
	call	$_001
	mov	byte ptr [rbp-0x24], -128
	mov	byte ptr [rbp-0x23], -2
	mov	r8d, 3
	lea	rdx, [rbp-0x3C]
	lea	rcx, [rbp-0x38]
	call	$_012
	mov	edx, 79
	lea	rcx, [rbp-0x38]
	call	$_005
	mov	edx, dword ptr [rdi+0x44]
	lea	rcx, [rbp-0x38]
	call	$_008
	lea	rcx, [rbp-0x38]
	mov	eax, dword ptr [rcx+0x4]
	mov	dword ptr [rcx], eax
	lea	rcx, [rbp-0x38]
	call	omf_write_record@PLT
$_098:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_090

$_099:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_100:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 1112
	mov	byte ptr [rbp-0x438], 0
	lea	rdi, [rbp-0x437]
	mov	dword ptr [rbp-0x8], 1
	mov	dword ptr [startitem+rip], 1
	mov	rsi, qword ptr [ModuleInfo+0x20+rip]
$_101:	xor	ebx, ebx
	xor	ecx, ecx
	test	rsi, rsi
	jz	$_102
	mov	rbx, qword ptr [rsi+0x8]
	mov	ecx, dword ptr [rbx+0x10]
$_102:	lea	rax, [rbp-0x438]
	mov	rdx, rdi
	sub	rdx, rax
	mov	dword ptr [rbp-0x4], edx
	lea	rcx, [rcx+rdx+0x4]
	test	rbx, rbx
	jz	$_103
	cmp	ecx, 1024
	jbe	$_105
$_103:	test	edx, edx
	jz	$_104
	mov	edx, 150
	lea	rcx, [rbp-0x38]
	call	$_001
	mov	eax, dword ptr [startitem+rip]
	mov	word ptr [rbp-0x24], ax
	mov	eax, dword ptr [rbp-0x8]
	mov	word ptr [rbp-0x22], ax
	movsxd	r8, dword ptr [rbp-0x4]
	lea	rdx, [rbp-0x438]
	lea	rcx, [rbp-0x38]
	call	$_012
	lea	rcx, [rbp-0x38]
	call	omf_write_record@PLT
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [startitem+rip], eax
$_104:	test	rbx, rbx
	jz	$_112
	lea	rdi, [rbp-0x438]
$_105:	mov	eax, dword ptr [rbx+0x10]
	stosb
	inc	eax
	mov	r8d, eax
	mov	rdx, qword ptr [rbx+0x8]
	mov	rcx, rdi
	call	tmemcpy@PLT
	cmp	byte ptr [ModuleInfo+0x1D0+rip], 0
	jnz	$_106
	mov	rcx, rdi
	call	tstrupr@PLT
$_106:	mov	eax, dword ptr [rbx+0x10]
	add	rdi, rax
	inc	dword ptr [rbp-0x8]
	mov	eax, dword ptr [rbp-0x8]
	jmp	$_110

$_107:	mov	rcx, qword ptr [rbx+0x68]
	mov	dword ptr [rcx+0x4C], eax
	jmp	$_111

$_108:	mov	rcx, qword ptr [rbx+0x68]
	mov	dword ptr [rcx+0xC], eax
	jmp	$_111

$_109:	mov	dword ptr [rbx+0x28], eax
	jmp	$_111

$_110:	cmp	byte ptr [rbx+0x18], 3
	jz	$_107
	cmp	byte ptr [rbx+0x18], 4
	jz	$_108
	jmp	$_109

$_111:	mov	rsi, qword ptr [rsi]
	jmp	$_101

$_112:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_113:
	cmp	byte ptr [rcx+0xA], 0
	jnz	$_117
$_114:	cmp	qword ptr [rcx], 0
	jz	$_116
	mov	rdx, qword ptr [rcx]
	mov	rax, qword ptr [rdx+0x70]
	mov	qword ptr [rcx], rax
	test	byte ptr [rdx+0x3B], 0x01
	jnz	$_115
	mov	rax, qword ptr [rdx+0x58]
	test	rax, rax
	jz	$_115
	test	byte ptr [rax+0x15], 0x40
	jnz	$_115
	mov	dx, word ptr [rcx+0x8]
	inc	word ptr [rcx+0x8]
	mov	word ptr [rax+0x62], dx
	or	byte ptr [rax+0x15], 0x40
	jmp	$_120

$_115:	jmp	$_114

$_116:	inc	byte ptr [rcx+0xA]
	mov	rax, qword ptr [SymTables+0x10+rip]
	mov	qword ptr [rcx], rax
$_117:	cmp	qword ptr [rcx], 0
	jz	$_119
	mov	rdx, qword ptr [rcx]
	mov	rax, qword ptr [rdx+0x70]
	mov	qword ptr [rcx], rax
	test	byte ptr [rdx+0x3B], 0x03
	jnz	$_118
	mov	ax, word ptr [rcx+0x8]
	inc	word ptr [rcx+0x8]
	mov	word ptr [rdx+0x60], ax
	mov	rax, rdx
	jmp	$_120

$_118:	jmp	$_117

$_119:	xor	eax, eax
$_120:	ret

$_121:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 1400
	mov	rax, qword ptr [SymTables+0x10+rip]
	mov	qword ptr [rbp-0x58], rax
	mov	word ptr [rbp-0x50], 1
	mov	byte ptr [rbp-0x4E], 0
	mov	word ptr [rbp-0x1C], 0
	lea	rcx, [rbp-0x58]
	call	$_113
	mov	qword ptr [rbp-0x38], rax
	jmp	$_126

$_122:	mov	dword ptr [rbp-0x44], 0
	mov	word ptr [rbp-0x1A], 0
$_123:	cmp	qword ptr [rbp-0x38], 0
	je	$_125
	lea	rdx, [rbp-0x554]
	mov	rcx, qword ptr [rbp-0x38]
	call	Mangle@PLT
	mov	dword ptr [rbp-0x48], eax
	cmp	byte ptr [ModuleInfo+0x1D1+rip], 0
	jz	$_124
	lea	rcx, [rbp-0x554]
	call	tstrupr@PLT
$_124:	mov	eax, dword ptr [rbp-0x44]
	add	eax, dword ptr [rbp-0x48]
	add	eax, 2
	cmp	eax, 1020
	jnc	$_125
	inc	word ptr [rbp-0x1A]
	mov	ecx, dword ptr [rbp-0x44]
	mov	eax, dword ptr [rbp-0x48]
	mov	byte ptr [rbp+rcx-0x454], al
	inc	dword ptr [rbp-0x44]
	lea	rcx, [rbp+rcx-0x453]
	mov	r8d, dword ptr [rbp-0x48]
	lea	rdx, [rbp-0x554]
	call	tmemcpy@PLT
	mov	eax, dword ptr [rbp-0x48]
	add	dword ptr [rbp-0x44], eax
	mov	ecx, dword ptr [rbp-0x44]
	mov	byte ptr [rbp+rcx-0x454], 0
	inc	dword ptr [rbp-0x44]
	lea	rcx, [rbp-0x58]
	call	$_113
	mov	qword ptr [rbp-0x38], rax
	jmp	$_123

$_125:	cmp	dword ptr [rbp-0x44], 0
	jz	$_126
	mov	edx, 140
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	r8d, dword ptr [rbp-0x44]
	lea	rdx, [rbp-0x454]
	lea	rcx, [rbp-0x30]
	call	$_012
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	mov	ax, word ptr [rbp-0x1A]
	add	word ptr [rbp-0x1C], ax
$_126:	cmp	qword ptr [rbp-0x38], 0
	jne	$_122
	mov	rsi, qword ptr [SymTables+0x10+rip]
$_127:	test	rsi, rsi
	jz	$_129
	test	byte ptr [rsi+0x3B], 0x01
	jnz	$_128
	cmp	qword ptr [rsi+0x58], 0
	jz	$_128
	mov	edx, 136
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	byte ptr [rbp-0x1C], -128
	mov	byte ptr [rbp-0x1B], -88
	mov	r8d, 4
	lea	rdx, [rbp-0x554]
	lea	rcx, [rbp-0x30]
	call	$_012
	movzx	edx, word ptr [rsi+0x60]
	lea	rcx, [rbp-0x30]
	call	$_008
	mov	rcx, qword ptr [rsi+0x58]
	movzx	edx, word ptr [rcx+0x62]
	lea	rcx, [rbp-0x30]
	call	$_008
	lea	rcx, [rbp-0x30]
	mov	eax, dword ptr [rcx+0x4]
	mov	dword ptr [rcx], eax
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
$_128:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_127

$_129:
	mov	rsi, qword ptr [SymTables+0x10+rip]
$_130:	test	rsi, rsi
	jz	$_132
	mov	rcx, qword ptr [rsi+0x58]
	test	byte ptr [rsi+0x3B], 0x01
	jnz	$_131
	test	rcx, rcx
	jz	$_131
	cmp	byte ptr [rcx+0x18], 2
	jz	$_131
	mov	dword ptr [rcx+0x60], 0
$_131:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_130

$_132:
	movzx	eax, word ptr [rbp-0x50]
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_133:
	mov	eax, ecx
	cmp	eax, 128
	jnc	$_134
	mov	eax, 1
	jmp	$_137

	jmp	$_137

$_134:	cmp	eax, 65535
	ja	$_135
	mov	eax, 3
	jmp	$_137

	jmp	$_137

$_135:	cmp	eax, 16777215
	ja	$_136
	mov	eax, 4
	jmp	$_137

	jmp	$_137

$_136:	mov	eax, 5
	jmp	$_137

$_137:
	ret

$_138:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rdi, rcx
	mov	esi, edx
	mov	ecx, esi
	call	$_133
	mov	ebx, eax
	jmp	$_143

$_139:	mov	eax, esi
	mov	byte ptr [rdi], al
	jmp	$_144

$_140:	mov	al, -127
	stosb
	jmp	$_144

$_141:	mov	al, -124
	stosb
	jmp	$_144

$_142:	mov	al, -120
	stosb
	jmp	$_144

$_143:	cmp	ebx, 1
	jz	$_139
	cmp	ebx, 3
	jz	$_140
	cmp	ebx, 4
	jz	$_141
	cmp	ebx, 5
	jz	$_142
$_144:	mov	dword ptr [rbp-0x4], 256
	mov	ecx, 1
$_145:	cmp	ecx, ebx
	jnc	$_146
	mov	eax, esi
	cdq
	div	dword ptr [rbp-0x4]
	mov	al, dl
	stosb
	shr	esi, 8
	inc	ecx
	jmp	$_145

$_146:
	mov	eax, ebx
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_147:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 1416
	mov	dword ptr [rbp-0x50], 0
	mov	rsi, qword ptr [SymTables+0x10+rip]
	jmp	$_156

$_148:	mov	dword ptr [rbp-0x3C], 0
	mov	dword ptr [rbp-0x40], 0
$_149:	test	rsi, rsi
	je	$_155
	test	byte ptr [rsi+0x3B], 0x01
	je	$_154
	lea	rdx, [rbp-0x150]
	mov	rcx, rsi
	call	Mangle@PLT
	mov	dword ptr [rbp-0x48], eax
	cmp	byte ptr [ModuleInfo+0x1D1+rip], 0
	jz	$_150
	lea	rcx, [rbp-0x150]
	call	tstrupr@PLT
$_150:	mov	r8, qword ptr [rsi+0x20]
	movzx	edx, byte ptr [ModuleInfo+0x1CC+rip]
	movzx	ecx, byte ptr [rsi+0x19]
	call	SizeFromMemtype@PLT
	mov	dword ptr [rbp-0x4C], eax
	movzx	eax, word ptr [rbp+0x28]
	mov	dword ptr [rsi+0x60], eax
	inc	word ptr [rbp+0x28]
	cmp	dword ptr [rbp-0x4C], 0
	jnz	$_151
	mov	eax, dword ptr [rsi+0x50]
	cdq
	div	dword ptr [rsi+0x58]
	mov	dword ptr [rbp-0x4C], eax
$_151:	mov	dword ptr [rbp-0x44], 1
	cmp	byte ptr [rsi+0x1C], 0
	jz	$_152
	mov	byte ptr [rbp-0x55C], 97
	mov	edx, dword ptr [rsi+0x58]
	lea	rcx, [rbp-0x55B]
	call	$_138
	add	dword ptr [rbp-0x44], eax
	mov	ecx, dword ptr [rbp-0x44]
	mov	edx, dword ptr [rbp-0x4C]
	lea	rcx, [rbp+rcx-0x55C]
	call	$_138
	add	dword ptr [rbp-0x44], eax
	jmp	$_153

$_152:	mov	byte ptr [rbp-0x55C], 98
	mov	eax, dword ptr [rsi+0x58]
	mul	dword ptr [rbp-0x4C]
	mov	edx, eax
	lea	rcx, [rbp-0x55B]
	call	$_138
	add	dword ptr [rbp-0x44], eax
$_153:	mov	eax, dword ptr [rbp-0x40]
	add	eax, dword ptr [rbp-0x48]
	add	eax, dword ptr [rbp-0x44]
	add	eax, 2
	cmp	eax, 1020
	ja	$_155
	lea	rdi, [rbp-0x54C]
	mov	ecx, dword ptr [rbp-0x40]
	inc	dword ptr [rbp-0x40]
	mov	eax, dword ptr [rbp-0x48]
	mov	byte ptr [rdi+rcx], al
	lea	rcx, [rdi+rcx+0x1]
	mov	r8d, dword ptr [rbp-0x48]
	lea	rdx, [rbp-0x150]
	call	tmemcpy@PLT
	mov	eax, dword ptr [rbp-0x48]
	add	dword ptr [rbp-0x40], eax
	mov	ecx, dword ptr [rbp-0x40]
	inc	dword ptr [rbp-0x40]
	mov	byte ptr [rdi+rcx], 0
	lea	rcx, [rdi+rcx+0x1]
	mov	r8d, dword ptr [rbp-0x44]
	lea	rdx, [rbp-0x55C]
	call	tmemcpy@PLT
	mov	eax, dword ptr [rbp-0x44]
	add	dword ptr [rbp-0x40], eax
	inc	dword ptr [rbp-0x3C]
$_154:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_149

$_155:	cmp	dword ptr [rbp-0x3C], 0
	jbe	$_156
	mov	edx, 176
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	eax, dword ptr [rbp-0x50]
	mov	word ptr [rbp-0x1C], ax
	mov	r8d, dword ptr [rbp-0x40]
	lea	rdx, [rbp-0x54C]
	lea	rcx, [rbp-0x30]
	call	$_012
	mov	eax, dword ptr [rbp-0x3C]
	mov	word ptr [rbp-0x1A], ax
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	mov	eax, dword ptr [rbp-0x3C]
	add	dword ptr [rbp-0x50], eax
$_156:	test	rsi, rsi
	jne	$_148
	movzx	eax, word ptr [rbp+0x28]
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_157:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 176
	lea	rsi, [rbp-0x90]
	mov	rdi, qword ptr [rbp+0x20]
	call	stat@PLT
	test	eax, eax
	jz	$_158
	xor	eax, eax
	jmp	$_159

$_158:	mov	rax, qword ptr [rbp-0x38]
$_159:	leave
	pop	rdi
	pop	rsi
	ret

$_160:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 88
	mov	rbx, qword ptr [ModuleInfo+0x188+rip]
	xor	esi, esi
$_161:	cmp	esi, dword ptr [ModuleInfo+0xB8+rip]
	jnc	$_163
	mov	edx, 136
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	byte ptr [rbp-0x1C], -128
	mov	byte ptr [rbp-0x1B], -23
	mov	rdx, qword ptr [ModuleInfo+0xB0+rip]
	mov	rdi, qword ptr [rdx+rsi*8]
	mov	rcx, rdi
	call	tstrlen@PLT
	cmp	eax, 255
	jbe	$_162
	mov	eax, 255
$_162:	mov	dword ptr [rbp-0x34], eax
	mov	rcx, rdi
	call	$_157
	mov	rcx, rax
	call	$_002
	mov	dword ptr [rbx], eax
	mov	eax, dword ptr [rbp-0x34]
	mov	byte ptr [rbx+0x4], al
	lea	rcx, [rbx+0x5]
	mov	r8d, dword ptr [rbp-0x34]
	mov	rdx, rdi
	call	tmemcpy@PLT
	mov	eax, dword ptr [rbp-0x34]
	lea	rcx, [rax+0x5]
	mov	r8, rcx
	mov	rdx, rbx
	lea	rcx, [rbp-0x30]
	call	$_012
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	inc	esi
	jmp	$_161

$_163:
	mov	edx, 136
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	byte ptr [rbp-0x1C], -128
	mov	byte ptr [rbp-0x1B], -23
	xor	r8d, r8d
	lea	rdx, [DS0004+0x1+rip]
	lea	rcx, [rbp-0x30]
	call	$_012
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	xor	eax, eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_164:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 856
	mov	rbx, qword ptr [SymTables+0x50+rip]
$_165:	test	rbx, rbx
	jz	$_166
	lea	rsi, [rbp-0x148]
	mov	rdx, rsi
	mov	rcx, rbx
	call	Mangle@PLT
	mov	dword ptr [rbp-0x3C], eax
	lea	rdi, [rbp-0x338]
	stosb
	mov	ecx, eax
	mov	rdx, rsi
	rep movsb
	mov	rsi, rdx
	mov	rdx, rsi
	mov	rcx, qword ptr [rbx+0x28]
	call	Mangle@PLT
	mov	dword ptr [rbp-0x40], eax
	stosb
	mov	ecx, eax
	rep movsb
	mov	edx, 198
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	ecx, dword ptr [rbp-0x3C]
	add	ecx, dword ptr [rbp-0x40]
	add	ecx, 2
	mov	r8d, ecx
	lea	rdx, [rbp-0x338]
	lea	rcx, [rbp-0x30]
	call	$_012
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	mov	rbx, qword ptr [rbx+0x70]
	jmp	$_165

$_166:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_167:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 120
	mov	rsi, qword ptr [ModuleInfo+0x10+rip]
	jmp	$_184

$_168:	mov	dword ptr [rbp-0x14], 0
	mov	rax, qword ptr [ModuleInfo+0x188+rip]
	mov	qword ptr [rbp-0x10], rax
$_169:	test	rsi, rsi
	je	$_181
	mov	rax, qword ptr [rsi+0x8]
	mov	qword ptr [rbp-0x28], rax
	mov	rcx, qword ptr [rax+0x30]
	test	rcx, rcx
	jz	$_170
	mov	rdx, qword ptr [rcx+0x68]
$_170:	test	rcx, rcx
	je	$_174
	cmp	byte ptr [rdx+0x73], 0
	je	$_174
	cmp	dword ptr [rdx+0x58], 0
	jnz	$_173
	and	dword ptr [rcx+0x14], 0xFFFFFFFE
	test	byte ptr [rax+0x14], 0x01
	jz	$_171
	or	byte ptr [rcx+0x14], 0x01
$_171:	mov	eax, dword ptr [startitem+rip]
	mov	dword ptr [rdx+0x58], eax
	inc	dword ptr [startitem+rip]
	mov	edx, 150
	lea	rcx, [rbp-0x58]
	call	$_001
	mov	rdi, qword ptr [ModuleInfo+0x188+rip]
	inc	rdi
	mov	rdx, rdi
	mov	rcx, qword ptr [rbp-0x28]
	call	Mangle@PLT
	mov	dword ptr [rbp-0x20], eax
	mov	byte ptr [rdi-0x1], al
	cmp	byte ptr [ModuleInfo+0x1D0+rip], 0
	jnz	$_172
	mov	rcx, rdi
	call	tstrupr@PLT
$_172:	mov	ecx, dword ptr [rbp-0x20]
	inc	ecx
	mov	r8d, ecx
	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	lea	rcx, [rbp-0x58]
	call	$_012
	lea	rcx, [rbp-0x58]
	call	omf_write_record@PLT
$_173:	jmp	$_180

$_174:	xor	eax, eax
	mov	rbx, qword ptr [rbp-0x28]
	cmp	dword ptr [rbx+0x28], 65535
	seta	al
	mov	byte ptr [rbp-0x16], al
	mov	ecx, 2
	test	eax, eax
	jz	$_175
	mov	ecx, 4
$_175:	mov	eax, dword ptr [rbx+0x10]
	add	eax, dword ptr [rbp-0x14]
	lea	eax, [rax+rcx+0x12]
	mov	dword ptr [rbp-0x1C], eax
	cmp	dword ptr [rbp-0x14], 0
	jz	$_176
	mov	rax, qword ptr [rbp-0x8]
	cmp	qword ptr [rbx+0x30], rax
	jnz	$_181
	mov	al, byte ptr [rbp-0x15]
	cmp	byte ptr [rbp-0x16], al
	jnz	$_181
	cmp	dword ptr [rbp-0x1C], 1024
	ja	$_181
$_176:	mov	rdi, qword ptr [rbp-0x10]
	inc	rdi
	mov	rdx, rdi
	mov	rcx, rbx
	call	Mangle@PLT
	mov	dword ptr [rbp-0x20], eax
	cmp	byte ptr [ModuleInfo+0x1D1+rip], 0
	jz	$_177
	mov	rcx, rdi
	call	tstrupr@PLT
$_177:	mov	rax, qword ptr [rbx+0x30]
	mov	qword ptr [rbp-0x8], rax
	mov	al, byte ptr [rbp-0x16]
	mov	byte ptr [rbp-0x15], al
	mov	eax, dword ptr [rbp-0x20]
	mov	byte ptr [rdi-0x1], al
	add	rdi, rax
	mov	eax, dword ptr [rbx+0x28]
	cmp	byte ptr [rbp-0x15], 0
	jz	$_178
	stosd
	jmp	$_179

$_178:	stosw
$_179:	xor	eax, eax
	stosb
	mov	qword ptr [rbp-0x10], rdi
	sub	rdi, qword ptr [ModuleInfo+0x188+rip]
	mov	dword ptr [rbp-0x14], edi
$_180:	mov	rsi, qword ptr [rsi]
	jmp	$_169

$_181:	cmp	dword ptr [rbp-0x14], 0
	jz	$_184
	mov	edx, 144
	lea	rcx, [rbp-0x58]
	call	$_001
	mov	r8d, dword ptr [rbp-0x14]
	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	lea	rcx, [rbp-0x58]
	call	$_012
	mov	al, byte ptr [rbp-0x15]
	mov	byte ptr [rbp-0x47], al
	cmp	qword ptr [rbp-0x8], 0
	jnz	$_182
	mov	word ptr [rbp-0x44], 0
	mov	word ptr [rbp-0x42], 0
	jmp	$_183

$_182:	mov	rcx, qword ptr [rbp-0x8]
	call	GetSegIdx@PLT
	mov	word ptr [rbp-0x42], ax
	mov	rcx, qword ptr [rbp-0x8]
	call	GetGroup@PLT
	mov	rcx, rax
	call	omf_GetGrpIdx
	mov	word ptr [rbp-0x44], ax
$_183:
	mov	word ptr [rbp-0x40], 0
	lea	rcx, [rbp-0x58]
	call	omf_write_record@PLT
$_184:	test	rsi, rsi
	jne	$_168
	xor	eax, eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_185:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	edx, 138
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	rcx, qword ptr [rbp+0x10]
	test	rcx, rcx
	jnz	$_186
	mov	byte ptr [rbp-0x1C], 0
	mov	byte ptr [rbp-0x1B], 0
	jmp	$_190

$_186:	mov	byte ptr [rbp-0x1B], 1
	mov	byte ptr [rbp-0x1C], 1
	mov	rcx, qword ptr [rcx+0x30]
	call	GetSymOfssize@PLT
	cmp	eax, 0
	jbe	$_187
	mov	eax, 1
	jmp	$_188

$_187:	xor	eax, eax
$_188:	mov	byte ptr [rbp-0x1F], al
	xor	r8d, r8d
	lea	rdx, [rbp-0x39]
	lea	rcx, [rbp-0x30]
	call	$_012
	mov	ecx, 0
	cmp	byte ptr [rbp-0x1F], 0
	jz	$_189
	mov	ecx, 1
$_189:	mov	r9d, ecx
	mov	r8d, dword ptr [rbp+0x18]
	lea	rdx, [rbp-0x39]
	mov	rcx, qword ptr [rbp+0x10]
	call	OmfFixGenFixModend@PLT
	mov	dword ptr [rbp-0x30], eax
$_190:	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	leave
	ret

omf_cv_flushfunc:
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rbx, rdx
	mov	eax, r8d
	mov	rdx, qword ptr [rcx+0x68]
	sub	rbx, qword ptr [rdx+0x10]
	add	eax, ebx
	test	ebx, ebx
	jz	$_191
	cmp	eax, 1016
	jbe	$_191
	mov	eax, dword ptr [rdx+0x8]
	add	eax, ebx
	mov	rbx, qword ptr [rdx+0x10]
	mov	dword ptr [rdx+0xC], eax
	call	$_038
	jmp	$_192

$_191:	add	rbx, qword ptr [rdx+0x10]
$_192:	mov	rax, rbx
	leave
	pop	rbx
	ret

$_193:
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	edx, 136
	lea	rcx, [rbp-0x30]
	call	$_001
	mov	byte ptr [rbp-0x1C], 0
	mov	byte ptr [rbp-0x1B], -95
	mov	r8d, 3
	lea	rdx, [DS0005+rip]
	lea	rcx, [rbp-0x30]
	call	$_012
	lea	rcx, [rbp-0x30]
	call	omf_write_record@PLT
	lea	rdi, [SymDebParm+rip]
	xor	ebx, ebx
$_194:	cmp	ebx, 2
	jnc	$_196
	mov	dword ptr [rsp+0x20], 1
	mov	r9d, 1
	xor	r8d, r8d
	mov	rdx, qword ptr [rdi+0x8]
	mov	rcx, qword ptr [rdi]
	call	CreateIntSegment@PLT
	lea	rcx, [SymDebSeg+rip]
	mov	qword ptr [rcx+rbx*8], rax
	test	rax, rax
	jz	$_195
	mov	rcx, qword ptr [rax+0x68]
	mov	byte ptr [rcx+0x6D], 1
	lea	rax, [omf_cv_flushfunc+rip]
	mov	qword ptr [rcx+0x20], rax
$_195:	inc	ebx
	add	rdi, 16
	jmp	$_194

$_196:
	leave
	pop	rbx
	pop	rdi
	ret

$_197:
	sub	rsp, 40
	mov	rax, qword ptr [SymDebSeg+rip]
	mov	rdx, qword ptr [SymDebSeg+0x8+rip]
	test	rax, rax
	jz	$_198
	test	rdx, rdx
	jz	$_198
	mov	rcx, qword ptr [rax+0x68]
	mov	rax, qword ptr [ModuleInfo+0x178+rip]
	mov	qword ptr [rcx+0x10], rax
	mov	rcx, qword ptr [rdx+0x68]
	add	rax, 1024
	mov	qword ptr [rcx+0x10], rax
	xor	r8d, r8d
	mov	rcx, qword ptr [SymDebSeg+rip]
	call	cv_write_debug_tables@PLT
$_198:	add	rsp, 40
	ret

omf_write_module:
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	cmp	byte ptr [Options+0x2+rip], 0
	jz	$_199
	call	$_197
$_199:	mov	edx, dword ptr [ModuleInfo+0xE8+rip]
	mov	rcx, qword ptr [ModuleInfo+0xE0+rip]
	call	$_185
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	ftell@PLT
	mov	dword ptr [rbp-0x8], eax
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fileno@PLT
	mov	dword ptr [rbp-0x4], eax
	mov	esi, dword ptr [rbp-0x8]
	mov	edi, dword ptr [rbp-0x4]
	call	ftruncate@PLT
	xor	edx, edx
	mov	esi, dword ptr [seg_pos+rip]
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fseek@PLT
	call	$_089
	xor	edx, edx
	mov	esi, dword ptr [public_pos+rip]
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fseek@PLT
	call	$_167
	xor	eax, eax
	leave
	pop	rdi
	pop	rsi
	ret

omf_write_header_initial:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	cmp	dword ptr [write_to_file+rip], 0
	jnz	$_200
	xor	eax, eax
	jmp	$_206

$_200:	mov	rcx, qword ptr [ModuleInfo+0x90+rip]
	call	$_050
	cmp	byte ptr [Options+0x2+rip], 0
	jz	$_201
	call	$_193
$_201:	cmp	byte ptr [Options+0x1+rip], 0
	jz	$_202
	call	$_160
$_202:	cmp	byte ptr [ModuleInfo+0x1BA+rip], 1
	jnz	$_203
	call	$_061
	jmp	$_204

$_203:	cmp	byte ptr [ModuleInfo+0x1BA+rip], 2
	jnz	$_204
	mov	ecx, 1
	call	SortSegments@PLT
$_204:	call	$_062
	call	$_100
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	ftell@PLT
	mov	dword ptr [seg_pos+rip], eax
	call	$_089
	call	$_074
	call	$_121
	mov	word ptr [rbp-0x2], ax
	movzx	ecx, word ptr [rbp-0x2]
	call	$_147
	mov	dword ptr [startext+rip], eax
	call	$_164
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	ftell@PLT
	mov	dword ptr [public_pos+rip], eax
	call	$_167
	call	$_065
	cmp	qword ptr [ModuleInfo+0xE0+rip], 0
	jnz	$_205
	call	$_060
$_205:	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	ftell@PLT
	mov	dword ptr [end_of_header+rip], eax
	xor	eax, eax
$_206:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

omf_init:
	sub	rsp, 8
	lea	rax, [omf_write_module+rip]
	mov	qword ptr [ModuleInfo+0x158+rip], rax
	lea	rax, [omf_write_header_initial+rip]
	mov	qword ptr [ModuleInfo+0x168+rip], rax
	mov	qword ptr [SymDebSeg+rip], 0
	mov	qword ptr [SymDebSeg+0x8+rip], 0
	mov	eax, dword ptr [ModuleInfo+0x1F4+rip]
	mov	dword ptr [ln_srcfile+rip], eax
	mov	word ptr [ln_size+rip], 0
	add	rsp, 8
	ret


.SECTION .data
	.ALIGN	16

LastCodeBufSize:
	.int   0x00000000

seg_pos: .int	0x00000000

public_pos:
	.int   0x00000000

end_of_header:
	.int   0x00000000

startitem:
	.int   0x00000000

startext: .int	 0x00000000

ln_srcfile:
	.int   0x00000000

ln_size: .short 0x0000

ln_is32:
	.byte  0x00, 0x00

SymDebParm:
	.quad  DS0000
	.quad  DS0001
	.quad  DS0002
	.quad  DS0003

SymDebSeg:
	.quad  0x0000000000000000
	.quad  0x0000000000000000

sel_start:
	.int   0x00000000

DS0004:
	.byte  0x01, 0x00

DS0005:
	.byte  0x01, 'C', 'V, 0x00


.SECTION .rodata
	.ALIGN	16

DS0000:
	.asciz "$$SYMBOLS"

DS0001:
	.asciz "DEBSYM"

DS0002:
	.asciz "$$TYPES"

DS0003:
	.asciz "DEBTYP"


.att_syntax prefix
