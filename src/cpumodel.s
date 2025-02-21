
.intel_syntax noprefix

.global ModelDirective
.global SetCPU
.global CpuDirective
.global sym_Interface
.global sym_Cpu
.global ModelToken

.extern pe_create_PE_header
.extern AddPredefinedText
.extern sym_ReservedStack
.extern LstWriteSrcLine
.extern RunLineQueue
.extern CreateVariable
.extern ModelAssumeInit
.extern SetModelDefaultSegNames
.extern ModelSimSegmInit
.extern SimGetSegName
.extern DefineFlatGroup
.extern SetOfssize
.extern GetLangType
.extern SpecialTable
.extern tstricmp
.extern asmerr
.extern szDgroup
.extern Options
.extern ModuleInfo
.extern Parse_Pass


.SECTION .text
	.ALIGN	16

$_001:	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rsi, qword ptr [rbp+0x28]
	xor	edi, edi
$_002:	cmp	edi, dword ptr [rbp+0x30]
	jge	$_004
	lodsq
	mov	rdx, qword ptr [rbp+0x20]
	mov	rcx, rax
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_003
	mov	eax, edi
	jmp	$_005

$_003:	inc	edi
	jmp	$_002

$_004:	mov	rax, -1
$_005:	leave
	pop	rdi
	pop	rsi
	ret

$_006:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	call	CreateVariable@PLT
	test	rax, rax
	jz	$_007
	or	byte ptr [rax+0x14], 0x20
$_007:	leave
	ret

$_008:
	cmp	qword ptr [ModuleInfo+0x1F8+rip], 0
	jnz	$_009
	mov	byte ptr [ModuleInfo+0x1CD+rip], cl
$_009:	call	SetOfssize@PLT
	ret

$_010:
	push	rsi
	push	rdi
	push	rbx
	sub	rsp, 32
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 7
	jnz	$_018
	mov	byte ptr [ModuleInfo+0x1BB+rip], 1
	mov	esi, dword ptr [ModuleInfo+0x1C0+rip]
	and	esi, 0xF0
	mov	eax, 1
	cmp	esi, 112
	jc	$_011
	mov	eax, 2
$_011:	mov	ecx, eax
	call	$_008
	mov	al, byte ptr [ModuleInfo+0x1B6+rip]
	mov	ah, byte ptr [ModuleInfo+0x1B9+rip]
	cmp	esi, 112
	jc	$_016
	cmp	al, 7
	jz	$_012
	cmp	al, 2
	jz	$_012
	cmp	al, 8
	jnz	$_015
$_012:	cmp	al, 8
	jnz	$_013
	mov	ah, 5
	jmp	$_015

$_013:	cmp	dword ptr [Options+0xA4+rip], 3
	jz	$_014
	mov	ah, 2
	jmp	$_015

$_014:	mov	ah, 3
$_015:	jmp	$_017

$_016:	cmp	al, 8
	jnz	$_017
	mov	ah, 4
$_017:	mov	byte ptr [ModuleInfo+0x1B9+rip], ah
	call	DefineFlatGroup@PLT
	jmp	$_019

$_018:	mov	byte ptr [ModuleInfo+0x1BB+rip], 0
$_019:	movzx	ecx, byte ptr [ModuleInfo+0x1B5+rip]
	call	ModelSimSegmInit@PLT
	call	ModelAssumeInit@PLT
	cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_020
	call	LstWriteSrcLine@PLT
$_020:	call	RunLineQueue@PLT
	cmp	dword ptr [Parse_Pass+rip], 0
	jne	$_030
	mov	eax, 1
	mov	cl, byte ptr [ModuleInfo+0x1B5+rip]
	shl	eax, cl
	and	eax, 0x70
	setne	al
	mov	edx, eax
	lea	rcx, [DS000B+rip]
	call	$_006
	mov	qword ptr [sym_CodeSize+rip], rax
	xor	ecx, ecx
	call	SimGetSegName@PLT
	mov	rdx, rax
	lea	rcx, [DS000C+rip]
	call	AddPredefinedText@PLT
	mov	cl, byte ptr [ModuleInfo+0x1B5+rip]
	xor	eax, eax
	jmp	$_023

$_021:	mov	eax, 1
	jmp	$_024

$_022:	mov	eax, 2
	jmp	$_024

$_023:	cmp	cl, 3
	jz	$_021
	cmp	cl, 5
	jz	$_021
	cmp	cl, 6
	jz	$_022
$_024:	mov	edx, eax
	lea	rcx, [DS000D+rip]
	call	$_006
	mov	qword ptr [sym_DataSize+rip], rax
	lea	rsi, [szDgroup+rip]
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 7
	jnz	$_025
	lea	rsi, [DS0006+rip]
$_025:	mov	rdx, rsi
	lea	rcx, [DS000E+rip]
	call	AddPredefinedText@PLT
	cmp	byte ptr [ModuleInfo+0x1B4+rip], 1
	jnz	$_026
	lea	rsi, [DS0008+0x3+rip]
$_026:	mov	rdx, rsi
	lea	rcx, [DS000F+rip]
	call	AddPredefinedText@PLT
	movzx	edx, byte ptr [ModuleInfo+0x1B5+rip]
	lea	rcx, [DS0010+rip]
	call	$_006
	mov	qword ptr [sym_Model+rip], rax
	movzx	edx, byte ptr [ModuleInfo+0x1B6+rip]
	lea	rcx, [DS0011+rip]
	call	$_006
	mov	qword ptr [sym_Interface+rip], rax
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_028
	cmp	byte ptr [ModuleInfo+0x1B9+rip], 2
	jz	$_027
	cmp	byte ptr [ModuleInfo+0x1B9+rip], 5
	jz	$_027
	cmp	byte ptr [ModuleInfo+0x1B9+rip], 3
	jnz	$_028
$_027:	xor	edx, edx
	lea	rcx, [DS0012+rip]
	call	$_006
	mov	qword ptr [sym_ReservedStack+rip], rax
$_028:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jz	$_029
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jnz	$_030
	cmp	dword ptr [Options+0xA4+rip], 0
	jnz	$_030
$_029:	call	pe_create_PE_header@PLT
$_030:	add	rsp, 32
	pop	rbx
	pop	rdi
	pop	rsi
	ret

ModelDirective:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	cmp	dword ptr [Parse_Pass+rip], 0
	jz	$_031
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 0
	jz	$_031
	call	$_010
	xor	eax, eax
	jmp	$_052

$_031:	inc	dword ptr [rbp+0x28]
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	cmp	byte ptr [rbx], 0
	jnz	$_032
	mov	ecx, 2013
	call	asmerr@PLT
	jmp	$_052

$_032:	mov	edi, dword ptr [rbp+0x28]
	xor	esi, esi
	mov	r8d, 7
	lea	rdx, [ModelToken+rip]
	mov	rcx, qword ptr [rbx+0x8]
	call	$_001
	cmp	eax, 0
	jl	$_034
	lea	esi, [rax+0x1]
	add	rbx, 24
	inc	edi
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 0
	jz	$_033
	mov	ecx, 4011
	call	asmerr@PLT
$_033:	jmp	$_035

$_034:	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_052

$_035:	mov	byte ptr [rbp-0x4], 0
	jmp	$_043

$_036:	cmp	edi, dword ptr [ModuleInfo+0x220+rip]
	jge	$_044
	inc	edi
	add	rbx, 24
	cmp	byte ptr [rbx], 44
	je	$_043
	mov	dword ptr [rbp+0x28], 0
	lea	r8, [rbp-0x2]
	mov	rdx, rbx
	lea	rcx, [rbp+0x28]
	call	GetLangType@PLT
	test	eax, eax
	jnz	$_037
	inc	edi
	add	rbx, 24
	mov	cl, 1
	jmp	$_041

$_037:	mov	r8d, 7
	lea	rdx, [ModelAttr+rip]
	mov	rcx, qword ptr [rbx+0x8]
	call	$_001
	cmp	eax, 0
	jl	$_044
	lea	rdx, [ModelAttrValue+rip]
	mov	cl, byte ptr [rdx+rax*2+0x1]
	mov	al, byte ptr [rdx+rax*2]
	cmp	cl, 2
	jnz	$_039
	cmp	esi, 7
	jnz	$_038
	mov	ecx, 2178
	call	asmerr@PLT
	jmp	$_052

$_038:	mov	byte ptr [rbp-0x1], al
	jmp	$_040

$_039:	cmp	cl, 4
	jnz	$_040
	mov	byte ptr [rbp-0x3], al
$_040:	inc	edi
	add	rbx, 24
$_041:	test	byte ptr [rbp-0x4], cl
	jz	$_042
	dec	edi
	sub	rbx, 24
	jmp	$_044

$_042:	or	byte ptr [rbp-0x4], cl
$_043:	cmp	byte ptr [rbx], 44
	je	$_036
$_044:	cmp	byte ptr [rbx], 0
	jz	$_045
	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_052

$_045:	cmp	esi, 7
	jnz	$_048
	mov	eax, dword ptr [ModuleInfo+0x1C0+rip]
	and	eax, 0xF0
	cmp	eax, 48
	jnc	$_046
	mov	ecx, 2085
	call	asmerr@PLT
	jmp	$_052

$_046:	cmp	eax, 112
	jc	$_048
	cmp	dword ptr [Options+0xA4+rip], 2
	jnz	$_047
	lea	rax, [coff64_fmtopt+rip]
	mov	qword ptr [ModuleInfo+0x1A8+rip], rax
	jmp	$_048

$_047:	cmp	dword ptr [Options+0xA4+rip], 3
	jnz	$_048
	lea	rax, [elf64_fmtopt+rip]
	mov	qword ptr [ModuleInfo+0x1A8+rip], rax
$_048:	mov	eax, esi
	mov	byte ptr [ModuleInfo+0x1B5+rip], al
	mov	cl, byte ptr [rbp-0x4]
	test	cl, 0x01
	jz	$_049
	mov	al, byte ptr [rbp-0x2]
	mov	byte ptr [ModuleInfo+0x1B6+rip], al
$_049:	test	cl, 0x02
	jz	$_050
	mov	al, byte ptr [rbp-0x1]
	mov	byte ptr [ModuleInfo+0x1B4+rip], al
$_050:	test	cl, 0x04
	jz	$_051
	mov	al, byte ptr [rbp-0x3]
	mov	byte ptr [ModuleInfo+0x1B7+rip], al
$_051:	call	SetModelDefaultSegNames@PLT
	call	$_010
	xor	eax, eax
$_052:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

SetCPU:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	edx, ecx
	mov	ecx, dword ptr [ModuleInfo+0x1C0+rip]
	test	edx, edx
	jz	$_053
	test	edx, 0xF0
	jz	$_056
$_053:	and	ecx, 0xFFFF0007
	mov	eax, edx
	and	eax, 0xF8
	or	ecx, eax
	mov	eax, ecx
	and	eax, 0x07
	cmp	eax, 1
	jz	$_056
	test	edx, 0x7
	jnz	$_056
	and	ecx, 0xFFFFFFF8
	mov	eax, ecx
	and	eax, 0xF0
	cmp	eax, 32
	jnc	$_054
	or	ecx, 0x02
	jmp	$_056

$_054:	cmp	eax, 48
	jnc	$_055
	or	ecx, 0x03
	jmp	$_056

$_055:	or	ecx, 0x04
$_056:	test	edx, 0x7
	jz	$_057
	and	ecx, 0xFFFFFFF8
	mov	eax, edx
	and	eax, 0x07
	or	ecx, eax
$_057:	mov	eax, edx
	and	eax, 0xF0
	cmp	eax, 112
	jnz	$_058
	or	ecx, 0xFF00
$_058:	test	edx, 0xFF00
	jz	$_059
	and	ecx, 0xFFFF00FF
	and	edx, 0xFF00
	or	ecx, edx
$_059:	mov	dword ptr [ModuleInfo+0x1C0+rip], ecx
	mov	eax, ecx
	and	eax, 0xF0
	jmp	$_067

$_060:	mov	eax, 3
	jmp	$_068

$_061:	mov	eax, 7
	jmp	$_068

$_062:	mov	eax, 15
	jmp	$_068

$_063:	mov	eax, 31
	jmp	$_068

$_064:	mov	eax, 63
	jmp	$_068

$_065:	mov	eax, 95
	jmp	$_068

$_066:	mov	eax, 1
	jmp	$_068

$_067:	cmp	eax, 16
	jz	$_060
	cmp	eax, 32
	jz	$_061
	cmp	eax, 48
	jz	$_062
	cmp	eax, 64
	jz	$_063
	cmp	eax, 80
	jz	$_064
	cmp	eax, 112
	jz	$_065
	cmp	eax, 96
	jz	$_065
	jmp	$_066

$_068:
	test	ecx, 0x8
	jz	$_069
	or	eax, 0x80
$_069:	mov	edx, ecx
	and	edx, 0x07
	jmp	$_073

$_070:	or	eax, 0x100
	jmp	$_074

$_071:	or	eax, 0x500
	jmp	$_074

$_072:	or	eax, 0xD00
	jmp	$_074

$_073:	cmp	edx, 2
	jz	$_070
	cmp	edx, 3
	jz	$_071
	cmp	edx, 4
	jz	$_072
$_074:	mov	dword ptr [ModuleInfo+0x1BC+rip], eax
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 0
	jnz	$_077
	and	ecx, 0xF0
	cmp	ecx, 112
	jc	$_075
	mov	eax, 2
	jmp	$_076

$_075:	mov	eax, 0
	cmp	ecx, 48
	jc	$_076
	mov	eax, 1
$_076:	mov	ecx, eax
	call	$_008
$_077:	mov	edx, dword ptr [ModuleInfo+0x1BC+rip]
	lea	rcx, [DS0013+rip]
	call	CreateVariable@PLT
	mov	qword ptr [sym_Cpu+rip], rax
	xor	eax, eax
	leave
	ret

CpuDirective:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	imul	ebx, dword ptr [rbp+0x18], 24
	add	rbx, qword ptr [rbp+0x20]
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbx+0x4], 12
	mov	edx, dword ptr [r11+rax+0x4]
	add	rbx, 24
	cmp	byte ptr [rbx], 0
	jz	$_078
	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_079

$_078:	mov	ecx, edx
	call	SetCPU
$_079:	leave
	pop	rbx
	ret


.SECTION .data
	.ALIGN	16

sym_Interface:
	.quad  0x0000000000000000

sym_Cpu: .quad	0x0000000000000000

coff64_fmtopt:
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x12, 0x0E,  'P',  'E',  '3',  '2',  '+', 0x00

elf64_fmtopt:
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x0F,  'E',  'L',  'F',  '6',  '4', 0x00

ModelToken:
	.quad  DS0000
	.quad  DS0001
	.quad  DS0002
	.quad  DS0003
	.quad  DS0004
	.quad  DS0005
	.quad  DS0006

ModelAttr:
	.quad  DS0007
	.quad  DS0008
	.quad  DS0009
	.quad  DS000A

ModelAttrValue:
	.byte  0x00, 0x02, 0x01, 0x02, 0x00, 0x04, 0x01, 0x04

sym_CodeSize:
	.quad  0x0000000000000000

sym_DataSize:
	.quad  0x0000000000000000

sym_Model:
	.quad  0x0000000000000000

DS000B:
	.asciz "@CodeSize"

DS000C:
	.asciz "@code"

DS000D:
	.asciz "@DataSize"

DS000E:
	.asciz "@data"

DS000F:
	.asciz "@stack"

DS0010:
	.asciz "@Model"

DS0011:
	.asciz "@Interface"

DS0012:
	.asciz "@ReservedStack"

DS0013:
	.asciz "@Cpu"


.SECTION .rodata
	.ALIGN	16

DS0000:
	.asciz "TINY"

DS0001:
	.asciz "SMALL"

DS0002:
	.asciz "COMPACT"

DS0003:
	.asciz "MEDIUM"

DS0004:
	.asciz "LARGE"

DS0005:
	.asciz "HUGE"

DS0006:
	.asciz "FLAT"

DS0007:
	.asciz "NEARSTACK"

DS0008:
	.asciz "FARSTACK"

DS0009:
	.asciz "OS_OS2"

DS000A:
	.asciz "OS_DOS"


.att_syntax prefix
