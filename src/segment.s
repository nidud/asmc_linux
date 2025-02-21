
.intel_syntax noprefix

.global UpdateCurPC
.global GetCurrOffset
.global GetCurrSegAlign
.global GrpDir
.global UpdateWordSize
.global SetOfssize
.global DefineFlatGroup
.global GetSegIdx
.global GetGroup
.global GetSymOfssize
.global SetSymSegOfs
.global TypeFromClassName
.global CreateIntSegment
.global EndsDir
.global SegmentDir
.global SortSegments
.global SegmentModuleExit
.global SegmentFini
.global SegmentInit
.global SegmentSaveState
.global CV8Label
.global symCurSeg

.extern CreateLabel
.extern EndstructDirective
.extern CurrStruct
.extern LstWrite
.extern SegAssumeTable
.extern UseSavedState
.extern omf_FlushCurrSeg
.extern omf_OutSelect
.extern EvalOperand
.extern ModelSimSegmExit
.extern GetCodeClass
.extern Set64Bit
.extern sym_remove_table
.extern sym_add_table
.extern SymTables
.extern LclAlloc
.extern tstricmp
.extern tstrcmp
.extern tstrlen
.extern tmemcmp
.extern tmemcpy
.extern tstrupr
.extern asmerr
.extern write_to_file
.extern Options
.extern ModuleInfo
.extern Parse_Pass
.extern QAddItem
.extern SymCmpFunc
.extern SymFind
.extern SymCreate
.extern SymFree
.extern SymAlloc


.SECTION .text
	.ALIGN	16

$_001:	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rsi, rdx
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

UpdateCurPC:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rdx, qword ptr [CurrStruct+rip]
	test	rdx, rdx
	jz	$_007
	mov	byte ptr [rcx+0x19], -64
	mov	qword ptr [rcx+0x30], 0
	mov	eax, dword ptr [rdx+0x28]
	cmp	qword ptr [rdx+0x70], 0
	jz	$_006
	mov	rdx, qword ptr [rdx+0x70]
	add	eax, dword ptr [rdx+0x28]
$_006:	mov	dword ptr [rcx+0x28], eax
	jmp	$_009

$_007:	cmp	qword ptr [ModuleInfo+0x1F8+rip], 0
	jz	$_008
	mov	byte ptr [rcx+0x19], -127
	mov	rax, qword ptr [ModuleInfo+0x1F8+rip]
	mov	qword ptr [rcx+0x30], rax
	call	GetCurrOffset
	mov	dword ptr [rcx+0x28], eax
	jmp	$_009

$_008:	mov	ecx, 2034
	call	asmerr@PLT
$_009:	leave
	ret

$_010:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rdx, rcx
	lea	rcx, [ModuleInfo+0x20+rip]
	call	QAddItem@PLT
	leave
	ret

$_011:
	push	rsi
	push	rdi
	sub	rsp, 40
	mov	rdi, qword ptr [ModuleInfo+0x20+rip]
$_012:	test	rdi, rdi
	jz	$_014
	mov	rsi, qword ptr [rdi]
	mov	rcx, qword ptr [rdi+0x8]
	cmp	byte ptr [rcx+0x18], 11
	jnz	$_013
	call	SymFree@PLT
$_013:	mov	rdi, rsi
	jmp	$_012

$_014:
	add	rsp, 40
	pop	rdi
	pop	rsi
	ret

$_015:
	push	rsi
	push	rdi
	sub	rsp, 8
	mov	rcx, qword ptr [symCurSeg+rip]
	mov	rdi, qword ptr [ModuleInfo+0x1F8+rip]
	lea	rax, [SegAssumeTable+rip]
	lea	rsi, [rax+0x10]
	test	rdi, rdi
	jnz	$_016
	mov	qword ptr [rsi], 0
	mov	byte ptr [rsi+0x9], 0
	mov	byte ptr [rsi+0x8], 1
	lea	rax, [DS001A+0x5+rip]
	mov	qword ptr [rcx+0x28], rax
	jmp	$_020

$_016:	mov	byte ptr [rsi+0x9], 0
	mov	byte ptr [rsi+0x8], 0
	mov	rdx, qword ptr [rdi+0x68]
	cmp	qword ptr [rdx], 0
	jz	$_018
	mov	rax, qword ptr [rdx]
	mov	qword ptr [rsi], rax
	cmp	rax, qword ptr [ModuleInfo+0x200+rip]
	jnz	$_017
	mov	byte ptr [rsi+0x9], 1
$_017:	jmp	$_019

$_018:	mov	qword ptr [rsi], rdi
$_019:	mov	rax, qword ptr [rdi+0x8]
	mov	qword ptr [rcx+0x28], rax
$_020:	add	rsp, 8
	pop	rdi
	pop	rsi
	ret

$_021:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	edx, dword ptr [stkindex+rip]
	cmp	edx, 20
	jc	$_022
	mov	ecx, 1007
	call	asmerr@PLT
	jmp	$_023

$_022:	inc	dword ptr [stkindex+rip]
	mov	rax, qword ptr [ModuleInfo+0x1F8+rip]
	mov	qword ptr [ModuleInfo+0x1F8+rip], rcx
	lea	rcx, [SegStack+rip]
	mov	qword ptr [rcx+rdx*8], rax
	call	$_015
$_023:	leave
	ret

$_024:
	sub	rsp, 8
	cmp	dword ptr [stkindex+rip], 0
	jz	$_025
	dec	dword ptr [stkindex+rip]
	mov	ecx, dword ptr [stkindex+rip]
	lea	rdx, [SegStack+rip]
	mov	rax, qword ptr [rdx+rcx*8]
	mov	qword ptr [ModuleInfo+0x1F8+rip], rax
	call	$_015
$_025:	add	rsp, 8
	ret

GetCurrOffset:
	sub	rsp, 8
	mov	rax, qword ptr [ModuleInfo+0x1F8+rip]
	test	rax, rax
	jz	$_026
	mov	rax, qword ptr [rax+0x68]
	mov	eax, dword ptr [rax+0xC]
$_026:	add	rsp, 8
	ret

GetCurrSegAlign:
	sub	rsp, 8
	mov	rax, qword ptr [ModuleInfo+0x1F8+rip]
	test	rax, rax
	jz	$_028
	mov	rcx, qword ptr [rax+0x68]
	cmp	byte ptr [rcx+0x6A], -1
	jnz	$_027
	mov	eax, 16
	jmp	$_028

$_027:	mov	cl, byte ptr [rcx+0x6A]
	mov	eax, 1
	shl	eax, cl
$_028:	add	rsp, 8
	ret

$_029:
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rsi, rcx
	call	SymFind@PLT
	mov	rdi, rax
	test	rdi, rdi
	jz	$_030
	cmp	byte ptr [rdi+0x18], 0
	jnz	$_033
$_030:	test	rdi, rdi
	jnz	$_031
	mov	rcx, rsi
	call	SymCreate@PLT
	mov	rdi, rax
	jmp	$_032

$_031:	mov	rdx, rdi
	lea	rcx, [SymTables+rip]
	call	sym_remove_table@PLT
$_032:	mov	byte ptr [rdi+0x18], 4
	mov	ecx, 24
	call	LclAlloc@PLT
	mov	qword ptr [rdi+0x68], rax
	mov	qword ptr [rax], 0
	mov	dword ptr [rax+0x10], 0
	mov	rdx, rdi
	lea	rcx, [SymTables+0x30+rip]
	call	sym_add_table@PLT
	or	byte ptr [rdi+0x15], 0x01
	mov	rcx, qword ptr [rdi+0x68]
	inc	dword ptr [grpdefidx+rip]
	mov	eax, dword ptr [grpdefidx+rip]
	mov	dword ptr [rcx+0x8], eax
	mov	rcx, rdi
	call	$_010
	jmp	$_034

$_033:	cmp	byte ptr [rdi+0x18], 4
	jz	$_034
	mov	rdx, rsi
	mov	ecx, 2005
	call	asmerr@PLT
	xor	eax, eax
	jmp	$_035

$_034:	or	byte ptr [rdi+0x14], 0x02
	mov	rax, rdi
$_035:	leave
	pop	rdi
	pop	rsi
	ret

$_036:
	mov	qword ptr [rsp+0x18], r8
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rdi, rcx
	test	rcx, rcx
	jnz	$_039
	cmp	dword ptr [rbp+0x28], 0
	jz	$_037
	mov	rcx, rdx
	call	SymCreate@PLT
	jmp	$_038

$_037:	mov	rcx, rdx
	call	SymAlloc@PLT
$_038:	mov	rdi, rax
	jmp	$_040

$_039:	cmp	byte ptr [rdi+0x18], 0
	jnz	$_040
	mov	rdx, rdi
	lea	rcx, [SymTables+rip]
	call	sym_remove_table@PLT
$_040:	test	rdi, rdi
	jz	$_042
	mov	byte ptr [rdi+0x18], 3
	mov	ecx, 120
	call	LclAlloc@PLT
	mov	qword ptr [rdi+0x68], rax
	mov	rcx, rax
	mov	al, byte ptr [ModuleInfo+0x1CD+rip]
	mov	byte ptr [rcx+0x68], al
	mov	byte ptr [rcx+0x6A], 4
	mov	byte ptr [rcx+0x72], 0
	mov	qword ptr [rdi+0x70], 0
	cmp	qword ptr [SymTables+0x20+rip], 0
	jnz	$_041
	mov	qword ptr [SymTables+0x20+rip], rdi
	mov	qword ptr [SymTables+0x28+rip], rdi
	jmp	$_042

$_041:	mov	rcx, qword ptr [SymTables+0x28+rip]
	mov	qword ptr [rcx+0x70], rdi
	mov	qword ptr [SymTables+0x28+rip], rdi
$_042:	mov	rax, rdi
	leave
	pop	rdi
	ret

GrpDir:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rbx, rdx
	cmp	dword ptr [rbp+0x28], 1
	jz	$_043
	imul	ecx, dword ptr [rbp+0x28], 24
	mov	rdx, qword ptr [rbx+rcx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_067

$_043:	cmp	dword ptr [Options+0xA4+rip], 2
	jz	$_044
	cmp	dword ptr [Options+0xA4+rip], 3
	jz	$_044
	cmp	dword ptr [Options+0xA4+rip], 0
	jnz	$_045
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jnz	$_045
$_044:	mov	ecx, 2214
	call	asmerr@PLT
	jmp	$_067

$_045:	mov	rcx, qword ptr [rbx+0x8]
	call	$_029
	mov	rdi, rax
	test	rdi, rdi
	jnz	$_046
	mov	rax, -1
	jmp	$_067

$_046:	inc	dword ptr [rbp+0x28]
	add	rbx, 48
$_047:	cmp	byte ptr [rbx], 8
	jz	$_048
	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_067

$_048:	mov	rax, qword ptr [rbx+0x8]
	mov	qword ptr [rbp-0x8], rax
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	mov	rcx, qword ptr [rbp-0x8]
	call	SymFind@PLT
	mov	rsi, rax
	cmp	dword ptr [Parse_Pass+rip], 0
	jne	$_057
	test	rsi, rsi
	jz	$_049
	mov	rcx, qword ptr [rsi+0x68]
$_049:	test	rsi, rsi
	jz	$_050
	cmp	byte ptr [rsi+0x18], 0
	jnz	$_052
$_050:	mov	r8d, 1
	mov	rdx, qword ptr [rbp-0x8]
	mov	rcx, rsi
	call	$_036
	mov	rsi, rax
	mov	rdx, qword ptr [rdi+0x68]
	cmp	qword ptr [rdx], 0
	jz	$_051
	mov	rcx, qword ptr [rsi+0x68]
	mov	al, byte ptr [rdi+0x38]
	mov	byte ptr [rcx+0x68], al
$_051:	jmp	$_054

$_052:	cmp	byte ptr [rsi+0x18], 3
	jz	$_053
	mov	rdx, qword ptr [rbp-0x8]
	mov	ecx, 2097
	call	asmerr@PLT
	jmp	$_067

	jmp	$_054

$_053:	cmp	qword ptr [rcx], 0
	jz	$_054
	mov	rax, qword ptr [ModuleInfo+0x200+rip]
	cmp	qword ptr [rcx], rax
	jz	$_054
	cmp	qword ptr [rcx], rdi
	jz	$_054
	mov	rdx, qword ptr [rbp-0x8]
	mov	ecx, 2072
	call	asmerr@PLT
	jmp	$_067

$_054:	mov	rdx, qword ptr [rdi+0x68]
	mov	rcx, qword ptr [rsi+0x68]
	cmp	qword ptr [rdx], 0
	jnz	$_055
	mov	al, byte ptr [rcx+0x68]
	mov	byte ptr [rdi+0x38], al
	jmp	$_056

$_055:	mov	al, byte ptr [rcx+0x68]
	cmp	byte ptr [rdi+0x38], al
	jz	$_056
	mov	r8, qword ptr [rsi+0x8]
	mov	rdx, qword ptr [rdi+0x8]
	mov	ecx, 2100
	call	asmerr@PLT
	jmp	$_067

$_056:	jmp	$_059

$_057:	test	rsi, rsi
	jz	$_058
	cmp	byte ptr [rsi+0x18], 3
	jnz	$_058
	cmp	qword ptr [rsi+0x30], 0
	jnz	$_059
$_058:	mov	rdx, qword ptr [rbp-0x8]
	mov	ecx, 2006
	call	asmerr@PLT
	jmp	$_067

$_059:	mov	rcx, qword ptr [rsi+0x68]
	cmp	qword ptr [rcx], 0
	jnz	$_063
	mov	qword ptr [rcx], rdi
	mov	ecx, 16
	call	LclAlloc@PLT
	mov	qword ptr [rax+0x8], rsi
	mov	qword ptr [rax], 0
	mov	rdx, qword ptr [rdi+0x68]
	inc	dword ptr [rdx+0x10]
	cmp	qword ptr [rdx], 0
	jnz	$_060
	mov	qword ptr [rdx], rax
	jmp	$_063

$_060:	mov	rcx, qword ptr [rdx]
	jmp	$_062

$_061:	mov	rcx, qword ptr [rcx]
$_062:	cmp	qword ptr [rcx], 0
	jnz	$_061
	mov	qword ptr [rcx], rax
$_063:	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	cmp	dword ptr [rbp+0x28], eax
	jge	$_066
	cmp	byte ptr [rbx], 44
	jnz	$_064
	cmp	byte ptr [rbx+0x18], 0
	jnz	$_065
$_064:	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_067

$_065:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
$_066:	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	cmp	dword ptr [rbp+0x28], eax
	jl	$_047
	xor	eax, eax
$_067:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

UpdateWordSize:
	movzx	eax, byte ptr [ModuleInfo+0x1CE+rip]
	mov	dword ptr [rcx+0x28], eax
	ret

SetOfssize:
	sub	rsp, 40
	mov	rcx, qword ptr [ModuleInfo+0x1F8+rip]
	test	rcx, rcx
	jnz	$_068
	mov	al, byte ptr [ModuleInfo+0x1CD+rip]
	mov	byte ptr [ModuleInfo+0x1CC+rip], al
	jmp	$_069

$_068:	mov	rax, qword ptr [rcx+0x68]
	movzx	ecx, byte ptr [rax+0x68]
	mov	byte ptr [ModuleInfo+0x1CC+rip], cl
	lea	rax, [min_cpu+rip]
	movzx	eax, word ptr [rax+rcx*2]
	cmp	dword ptr [ModuleInfo+0x1C0+rip], eax
	jnc	$_069
	mov	eax, 16
	shl	eax, cl
	mov	edx, eax
	mov	ecx, 2066
	call	asmerr@PLT
	jmp	$_072

$_069:	mov	eax, 2
	mov	cl, byte ptr [ModuleInfo+0x1CC+rip]
	shl	eax, cl
	mov	byte ptr [ModuleInfo+0x1CE+rip], al
	xor	eax, eax
	mov	dword ptr [ModuleInfo+0x340+rip], 9
	cmp	cl, 2
	jnz	$_070
	inc	eax
	mov	dword ptr [ModuleInfo+0x340+rip], 115
	jmp	$_071

$_070:	cmp	cl, 1
	jnz	$_071
	mov	dword ptr [ModuleInfo+0x340+rip], 17
$_071:	mov	ecx, eax
	call	Set64Bit@PLT
	xor	eax, eax
$_072:	add	rsp, 40
	ret

$_073:
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rsi, rcx
	mov	rcx, qword ptr [ModuleInfo+0x1F8+rip]
	xor	edi, edi
	test	rcx, rcx
	jnz	$_074
	inc	edi
	jmp	$_075

$_074:	movsxd	r8, dword ptr [rcx+0x10]
	mov	rdx, rsi
	mov	rcx, qword ptr [rcx+0x8]
	call	qword ptr [SymCmpFunc+rip]
	test	rax, rax
	jz	$_075
	inc	edi
$_075:	test	edi, edi
	jz	$_076
	mov	rdx, rsi
	mov	ecx, 1010
	call	asmerr@PLT
	jmp	$_078

$_076:	cmp	dword ptr [write_to_file+rip], 0
	jz	$_077
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_077
	call	omf_FlushCurrSeg@PLT
	cmp	byte ptr [Options+0x89+rip], 0
	jnz	$_077
	xor	ecx, ecx
	call	omf_OutSelect@PLT
$_077:	call	$_024
	xor	eax, eax
$_078:	leave
	pop	rdi
	pop	rsi
	ret

DefineFlatGroup:
	sub	rsp, 40
	mov	rax, qword ptr [ModuleInfo+0x200+rip]
	test	rax, rax
	jnz	$_079
	lea	rcx, [DS0011+rip]
	call	$_029
	mov	qword ptr [ModuleInfo+0x200+rip], rax
	mov	cl, byte ptr [ModuleInfo+0x1CD+rip]
	mov	byte ptr [rax+0x38], cl
$_079:	or	byte ptr [rax+0x14], 0x02
	add	rsp, 40
	ret

GetSegIdx:
	mov	rax, rcx
	test	rax, rax
	jz	$_080
	mov	rax, qword ptr [rax+0x68]
	mov	eax, dword ptr [rax+0x44]
	jmp	$_080

$_080:
	ret

GetGroup:
	mov	rax, qword ptr [rcx+0x30]
	test	rax, rax
	jz	$_081
	mov	rax, qword ptr [rax+0x68]
	mov	rax, qword ptr [rax]
	jmp	$_081

$_081:
	ret

GetSymOfssize:
	mov	rax, qword ptr [rcx+0x30]
	test	rax, rax
	jnz	$_087
	mov	rax, rcx
	cmp	byte ptr [rax+0x18], 2
	jnz	$_082
	movzx	eax, byte ptr [rax+0x1B]
	jmp	$_089

$_082:	cmp	byte ptr [rax+0x18], 5
	jz	$_083
	cmp	byte ptr [rax+0x18], 4
	jnz	$_084
$_083:	movzx	eax, byte ptr [rax+0x38]
	jmp	$_089

$_084:	cmp	byte ptr [rax+0x18], 3
	jnz	$_085
	mov	rax, qword ptr [rax+0x68]
	movzx	eax, byte ptr [rax+0x68]
	jmp	$_089

$_085:	cmp	byte ptr [rax+0x19], -64
	jnz	$_086
	xor	eax, eax
	jmp	$_089

$_086:	jmp	$_088

$_087:	mov	rax, qword ptr [rax+0x68]
	movzx	eax, byte ptr [rax+0x68]
	jmp	$_089

$_088:	movzx	eax, byte ptr [ModuleInfo+0x1CC+rip]
$_089:	ret

SetSymSegOfs:
	mov	rax, qword ptr [ModuleInfo+0x1F8+rip]
	mov	qword ptr [rcx+0x30], rax
	call	GetCurrOffset
	mov	dword ptr [rcx+0x28], eax
	ret

TypeFromClassName:
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 288
	mov	rax, qword ptr [rcx+0x68]
	cmp	byte ptr [rax+0x6A], -1
	jnz	$_090
	mov	eax, 5
	jmp	$_104

$_090:	cmp	byte ptr [rax+0x72], 5
	jnz	$_091
	mov	eax, 4
	jmp	$_104

$_091:	test	rdx, rdx
	jnz	$_092
	xor	eax, eax
	jmp	$_104

$_092:	mov	rdi, rdx
	call	GetCodeClass@PLT
	mov	rdx, rax
	mov	rcx, qword ptr [rdi+0x8]
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_093
	mov	eax, 1
	jmp	$_104

$_093:	mov	esi, dword ptr [rdi+0x10]
	lea	ecx, [rsi+0x1]
	mov	r8d, ecx
	mov	rdx, qword ptr [rdi+0x8]
	lea	rcx, [rbp-0xF8]
	call	tmemcpy@PLT
	mov	rcx, rax
	call	tstrupr@PLT
	mov	rdi, rax
	jmp	$_102

$_094:	mov	r8d, 6
	lea	rdx, [DS001B+rip]
	mov	rcx, rdi
	call	tmemcmp@PLT
	test	eax, eax
	jnz	$_095
	mov	eax, 2
	jmp	$_104

$_095:	mov	r8d, 6
	lea	rdx, [DS001C+rip]
	mov	rcx, rdi
	call	tmemcmp@PLT
	test	eax, eax
	jnz	$_096
	mov	eax, 2
	jmp	$_104

$_096:	mov	r8d, 6
	lea	rdx, [DS001D+rip]
	mov	rcx, rdi
	call	tmemcmp@PLT
	test	eax, eax
	jnz	$_097
	mov	eax, 2
	jmp	$_104

$_097:	mov	r8d, 4
	lea	rdx, [DS001E+rip]
	lea	rcx, [rdi+rsi-0x4]
	call	tmemcmp@PLT
	test	eax, eax
	jnz	$_098
	mov	eax, 1
	jmp	$_104

$_098:	mov	r8d, 4
	lea	rdx, [DS001F+rip]
	lea	rcx, [rdi+rsi-0x4]
	call	tmemcmp@PLT
	test	eax, eax
	jnz	$_099
	mov	eax, 2
	jmp	$_104

$_099:	mov	r8d, 3
	lea	rdx, [DS0020+rip]
	lea	rcx, [rdi+rsi-0x3]
	call	tmemcmp@PLT
	test	eax, eax
	jnz	$_100
	mov	eax, 3
	jmp	$_104

$_100:	jmp	$_103

$_101:	jmp	$_094

$_102:	cmp	esi, 5
	je	$_094
	cmp	esi, 4
	jz	$_097
	cmp	esi, 3
	jz	$_099
	jmp	$_101

$_103:	xor	eax, eax
$_104:	leave
	pop	rdi
	pop	rsi
	ret

$_105:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rbx, rcx
	mov	esi, edx
	mov	rdi, qword ptr [ModuleInfo+0x20+rip]
$_106:	test	rdi, rdi
	jz	$_108
	mov	rcx, qword ptr [rdi+0x8]
	cmp	byte ptr [rcx+0x18], 11
	jnz	$_107
	mov	r8d, esi
	mov	rdx, rbx
	mov	rcx, qword ptr [rcx+0x8]
	call	qword ptr [SymCmpFunc+rip]
	test	rax, rax
	jnz	$_107
	mov	rax, qword ptr [rdi+0x8]
	jmp	$_109

$_107:	mov	rdi, qword ptr [rdi]
	jmp	$_106

$_108:	xor	eax, eax
$_109:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_110:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rbx, rcx
	call	tstrlen@PLT
	mov	esi, eax
	cmp	esi, 255
	jbe	$_111
	mov	ecx, 2041
	call	asmerr@PLT
	xor	eax, eax
	jmp	$_112

$_111:	mov	edx, esi
	mov	rcx, rbx
	call	$_105
	test	rax, rax
	jnz	$_112
	mov	rcx, rbx
	call	SymAlloc@PLT
	mov	rsi, rax
	mov	byte ptr [rsi+0x18], 11
	mov	rcx, rsi
	call	$_010
	mov	rax, rsi
$_112:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_113:
	push	rsi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, rcx
	mov	rcx, rdx
	call	$_110
	test	rax, rax
	jnz	$_114
	mov	rax, -1
	jmp	$_115

$_114:	mov	rcx, qword ptr [rsi+0x68]
	mov	qword ptr [rcx+0x50], rax
	xor	eax, eax
$_115:	leave
	pop	rsi
	ret

CreateIntSegment:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rdi
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	cmp	dword ptr [rbp+0x38], 0
	jz	$_119
	mov	rcx, qword ptr [rbp+0x18]
	call	SymFind@PLT
	test	rax, rax
	jz	$_116
	cmp	byte ptr [rax+0x18], 0
	jnz	$_117
$_116:	mov	r8d, dword ptr [rbp+0x38]
	mov	rdx, qword ptr [rbp+0x18]
	mov	rcx, rax
	call	$_036
	jmp	$_118

$_117:	cmp	byte ptr [rax+0x18], 3
	jz	$_118
	mov	rdx, qword ptr [rbp+0x18]
	mov	ecx, 2005
	call	asmerr@PLT
	xor	eax, eax
	jmp	$_122

$_118:	jmp	$_120

$_119:	xor	r8d, r8d
	mov	rdx, qword ptr [rbp+0x18]
	xor	ecx, ecx
	call	$_036
$_120:	test	rax, rax
	jz	$_122
	mov	rdi, rax
	test	byte ptr [rdi+0x14], 0x02
	jnz	$_121
	inc	dword ptr [ModuleInfo+0x8+rip]
	mov	rcx, qword ptr [rdi+0x68]
	mov	eax, dword ptr [ModuleInfo+0x8+rip]
	mov	dword ptr [rcx+0x44], eax
	mov	rcx, rdi
	call	$_010
	or	byte ptr [rdi+0x14], 0x02
$_121:	mov	rcx, qword ptr [rdi+0x68]
	mov	byte ptr [rcx+0x6F], 1
	mov	qword ptr [rdi+0x30], rdi
	mov	al, byte ptr [rbp+0x28]
	mov	byte ptr [rcx+0x6A], al
	mov	al, byte ptr [rbp+0x30]
	mov	byte ptr [rcx+0x68], al
	mov	rdx, qword ptr [rbp+0x20]
	mov	rcx, rdi
	call	$_113
	mov	rax, rdi
	jmp	$_122

$_122:
	leave
	pop	rdi
	ret

EndsDir:
	mov	qword ptr [rsp+0x8], rcx
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rbx, rdx
	cmp	qword ptr [CurrStruct+rip], 0
	jz	$_123
	mov	rdx, rbx
	mov	ecx, dword ptr [rbp+0x18]
	call	EndstructDirective@PLT
	jmp	$_128

$_123:	cmp	dword ptr [rbp+0x18], 1
	jz	$_124
	imul	ecx, dword ptr [rbp+0x18], 24
	mov	rdx, qword ptr [rbx+rcx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_128

$_124:	cmp	dword ptr [Parse_Pass+rip], 0
	jz	$_125
	cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_125
	xor	r8d, r8d
	xor	edx, edx
	mov	ecx, 7
	call	LstWrite@PLT
$_125:	mov	rcx, qword ptr [rbx+0x8]
	call	$_073
	cmp	eax, -1
	jnz	$_126
	mov	rax, -1
	jmp	$_128

$_126:	inc	dword ptr [rbp+0x18]
	imul	ecx, dword ptr [rbp+0x18], 24
	cmp	byte ptr [rbx+rcx], 0
	jz	$_127
	mov	rdx, qword ptr [rbx+rcx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
$_127:	call	SetOfssize
$_128:	leave
	pop	rbx
	ret

$_129:
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rbx, rdx
	mov	rcx, qword ptr [rbx+0x8]
	call	SymFind@PLT
	mov	rdi, rax
	test	rdi, rdi
	jz	$_130
	cmp	byte ptr [rdi+0x18], 3
	jz	$_131
$_130:	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 2006
	call	asmerr@PLT
	jmp	$_134

$_131:	or	byte ptr [rdi+0x14], 0x02
	cmp	qword ptr [ModuleInfo+0x1F8+rip], 0
	jz	$_132
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_132
	call	omf_FlushCurrSeg@PLT
	cmp	byte ptr [Options+0x89+rip], 0
	jnz	$_132
	xor	ecx, ecx
	call	omf_OutSelect@PLT
$_132:	mov	rcx, rdi
	call	$_021
	call	SetOfssize
	mov	ebx, eax
	cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_133
	xor	r8d, r8d
	xor	edx, edx
	mov	ecx, 7
	call	LstWrite@PLT
$_133:	mov	eax, ebx
$_134:	leave
	pop	rbx
	pop	rdi
	ret

$_135:
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	rdx, qword ptr [SymTables+0x20+rip]
	mov	rdi, 0
$_136:	test	rdx, rdx
	jz	$_140
	cmp	rdx, rcx
	jnz	$_139
	test	rdi, rdi
	jnz	$_137
	mov	rax, qword ptr [rdx+0x70]
	mov	qword ptr [SymTables+0x20+rip], rax
	jmp	$_138

$_137:	mov	rax, qword ptr [rdx+0x70]
	mov	qword ptr [rdi+0x70], rax
$_138:	cmp	qword ptr [rdx+0x70], 0
	jnz	$_139
	mov	qword ptr [SymTables+0x28+rip], rdi
$_139:	mov	rdi, rdx
	mov	rdx, qword ptr [rdx+0x70]
	jmp	$_136

$_140:
	leave
	pop	rdi
	ret

SegmentDir:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 264
	mov	byte ptr [rbp-0x1], 0
	mov	dword ptr [rbp-0x24], 0
	mov	dword ptr [rbp-0x30], 0
	mov	byte ptr [rbp-0x34], 0
	mov	rbx, rdx
	cmp	dword ptr [Parse_Pass+rip], 0
	jz	$_141
	mov	rdx, rbx
	mov	ecx, dword ptr [rbp+0x28]
	call	$_129
	jmp	$_227

$_141:	cmp	dword ptr [rbp+0x28], 1
	jz	$_142
	imul	ecx, dword ptr [rbp+0x28], 24
	mov	rdx, qword ptr [rbx+rcx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_227

$_142:	mov	rax, qword ptr [rbx+0x8]
	mov	qword ptr [rbp-0x48], rax
	mov	rcx, qword ptr [rbp-0x48]
	call	SymFind@PLT
	mov	qword ptr [rbp-0x50], rax
	test	rax, rax
	jz	$_143
	cmp	byte ptr [rax+0x18], 0
	jnz	$_144
$_143:	mov	dword ptr [rbp-0x24], 1
	mov	r8d, 1
	mov	rdx, qword ptr [rbp-0x48]
	mov	rcx, qword ptr [rbp-0x50]
	call	$_036
	mov	qword ptr [rbp-0x50], rax
	or	byte ptr [rax+0x15], 0x01
	mov	qword ptr [rbp-0x40], rax
	mov	byte ptr [rbp-0x31], -2
	jmp	$_151

$_144:	cmp	byte ptr [rax+0x18], 3
	jne	$_150
	mov	qword ptr [rbp-0x40], rax
	mov	rdi, rax
	test	byte ptr [rax+0x14], 0x02
	jnz	$_148
	mov	rcx, rdi
	call	$_135
	mov	qword ptr [rdi+0x70], 0
	cmp	qword ptr [SymTables+0x20+rip], 0
	jnz	$_145
	mov	qword ptr [SymTables+0x20+rip], rdi
	mov	qword ptr [SymTables+0x28+rip], rdi
	jmp	$_146

$_145:	mov	rcx, qword ptr [SymTables+0x28+rip]
	mov	qword ptr [rcx+0x70], rdi
	mov	qword ptr [SymTables+0x28+rip], rdi
$_146:	mov	rcx, qword ptr [rdi+0x68]
	mov	al, byte ptr [rcx+0x68]
	mov	byte ptr [rbp-0x31], al
	cmp	al, -2
	jnz	$_147
	mov	al, byte ptr [ModuleInfo+0x1CC+rip]
	mov	byte ptr [rcx+0x68], al
$_147:	jmp	$_149

$_148:	mov	byte ptr [rbp-0x1], 1
	mov	rcx, qword ptr [rdi+0x68]
	mov	al, byte ptr [rcx+0x68]
	mov	byte ptr [rbp-0x31], al
	mov	al, byte ptr [rcx+0x6A]
	mov	byte ptr [rbp-0x32], al
	mov	al, byte ptr [rcx+0x72]
	mov	byte ptr [rbp-0x33], al
$_149:	jmp	$_151

$_150:	mov	rdx, qword ptr [rbp-0x48]
	mov	ecx, 2005
	call	asmerr@PLT
	jmp	$_227

$_151:	inc	dword ptr [rbp+0x28]
$_152:	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	cmp	dword ptr [rbp+0x28], eax
	jge	$_208
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	mov	rsi, qword ptr [rbx+0x8]
	cmp	byte ptr [rbx], 9
	jnz	$_154
	cmp	byte ptr [rbx+0x1], 34
	jz	$_153
	cmp	byte ptr [rbx+0x1], 39
	jz	$_153
	mov	rdx, rsi
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_207

$_153:	inc	rsi
	mov	ecx, dword ptr [rbx+0x4]
	mov	byte ptr [rsi+rcx], 0
	mov	rdx, rsi
	mov	rcx, qword ptr [rbp-0x40]
	call	$_113
	jmp	$_207

$_154:	mov	r8d, 27
	lea	rdx, [SegAttrToken+rip]
	mov	rcx, rsi
	call	$_001
	mov	dword ptr [rbp-0x14], eax
	cmp	dword ptr [rbp-0x14], 0
	jge	$_155
	lea	r8, [DS0021+rip]
	mov	rdx, rsi
	mov	ecx, 2015
	call	asmerr@PLT
	jmp	$_207

$_155:	lea	rcx, [SegAttrValue+rip]
	lea	rax, [rcx+rax*2]
	mov	qword ptr [rbp-0x20], rax
	movzx	edx, byte ptr [rax+0x1]
	mov	ecx, dword ptr [rbp-0x30]
	mov	eax, edx
	and	eax, 0x1F
	and	eax, ecx
	test	eax, eax
	jz	$_156
	lea	r8, [DS0021+rip]
	mov	rdx, rsi
	mov	ecx, 2015
	call	asmerr@PLT
	jmp	$_207

$_156:	or	dword ptr [rbp-0x30], edx
	mov	rcx, qword ptr [rbp-0x40]
	mov	rdi, qword ptr [rcx+0x68]
	mov	rcx, qword ptr [rbp-0x20]
	jmp	$_206

$_157:	mov	byte ptr [rdi+0x6B], 1
	jmp	$_207

$_158:	mov	al, byte ptr [rcx]
	mov	byte ptr [rdi+0x6A], al
	jmp	$_207

$_159:	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_160
	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 3006
	call	asmerr@PLT
	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	mov	dword ptr [rbp+0x28], eax
	jmp	$_207

$_160:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx], 40
	jz	$_161
	lea	rdx, [DS0022+rip]
	mov	ecx, 2065
	call	asmerr@PLT
	jmp	$_207

$_161:	inc	dword ptr [rbp+0x28]
	mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0xB8]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_207
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	cmp	byte ptr [rbx], 41
	jz	$_162
	lea	rdx, [DS0023+rip]
	mov	ecx, 2065
	call	asmerr@PLT
	jmp	$_207

$_162:	cmp	dword ptr [rbp-0x7C], 0
	jz	$_163
	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_207

$_163:	mov	ecx, 1
	xor	edx, edx
$_164:	cmp	ecx, dword ptr [rbp-0xB8]
	jge	$_165
	cmp	ecx, 8192
	jnc	$_165
	shl	ecx, 1
	inc	edx
	jmp	$_164

$_165:	cmp	ecx, dword ptr [rbp-0xB8]
	jz	$_166
	mov	dword ptr [rbp-0x28], edx
	mov	edx, dword ptr [rbp-0xB8]
	mov	ecx, 2063
	call	asmerr@PLT
	mov	edx, dword ptr [rbp-0x28]
$_166:	mov	byte ptr [rdi+0x6A], dl
	jmp	$_207

$_167:	mov	al, byte ptr [rcx]
	mov	byte ptr [rdi+0x72], al
	jmp	$_207

$_168:	mov	al, byte ptr [rcx]
	mov	byte ptr [rdi+0x72], al
	mov	byte ptr [rdi+0x6A], -1
	inc	dword ptr [rbp+0x28]
	mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0xB8]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	jz	$_170
	cmp	dword ptr [rbp-0x7C], 0
	jnz	$_169
	mov	eax, dword ptr [rbp-0xB8]
	mov	dword ptr [rdi+0x58], eax
	mov	dword ptr [rdi+0x60], 0
	jmp	$_170

$_169:	mov	ecx, 2026
	call	asmerr@PLT
$_170:	jmp	$_207

$_171:	cmp	dword ptr [Options+0xA4+rip], 2
	jz	$_172
	cmp	dword ptr [Options+0xA4+rip], 1
	jz	$_172
	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 3006
	call	asmerr@PLT
	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	mov	dword ptr [rbp+0x28], eax
	jmp	$_207

$_172:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx], 40
	jz	$_173
	lea	rdx, [DS0022+rip]
	mov	ecx, 2065
	call	asmerr@PLT
	jmp	$_207

$_173:	inc	dword ptr [rbp+0x28]
	mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0xB8]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_207
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	cmp	dword ptr [rbp-0x7C], 0
	jz	$_174
	mov	ecx, 2026
	call	asmerr@PLT
	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	mov	dword ptr [rbp+0x28], eax
	jmp	$_207

$_174:	cmp	dword ptr [rbp-0xB8], 1
	jl	$_175
	cmp	dword ptr [rbp-0xB8], 6
	jle	$_176
$_175:	lea	rdx, [DS0024+rip]
	mov	ecx, 2156
	call	asmerr@PLT
	jmp	$_183

$_176:	cmp	dword ptr [rbp-0xB8], 5
	jne	$_183
	cmp	byte ptr [rbx], 44
	jz	$_177
	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	mov	dword ptr [rbp+0x28], eax
	jmp	$_207

$_177:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx], 8
	jz	$_178
	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	mov	dword ptr [rbp+0x28], eax
	jmp	$_207

$_178:	mov	rcx, qword ptr [rbx+0x8]
	call	SymFind@PLT
	test	rax, rax
	jz	$_179
	mov	rcx, qword ptr [rax+0x68]
$_179:	test	rax, rax
	jz	$_180
	cmp	byte ptr [rax+0x18], 3
	jnz	$_180
	cmp	byte ptr [rcx+0x73], 0
	jz	$_180
	cmp	byte ptr [rcx+0x73], 5
	jnz	$_181
$_180:	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_182

$_181:	mov	eax, dword ptr [rcx+0x44]
	mov	dword ptr [rdi+0x58], eax
$_182:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
$_183:	cmp	byte ptr [rbx], 41
	jz	$_184
	lea	rdx, [DS0023+rip]
	mov	ecx, 2065
	call	asmerr@PLT
	jmp	$_207

$_184:	mov	eax, dword ptr [rbp-0xB8]
	mov	byte ptr [rdi+0x73], al
	mov	rcx, qword ptr [rbp-0x20]
	mov	al, byte ptr [rcx]
	mov	byte ptr [rdi+0x72], al
	jmp	$_207

$_185:	cmp	byte ptr [ModuleInfo+0x1CD+rip], 0
	jnz	$_186
	mov	ecx, 2085
	call	asmerr@PLT
	jmp	$_207

$_186:	call	DefineFlatGroup
	mov	al, byte ptr [ModuleInfo+0x1CD+rip]
	mov	byte ptr [rdi+0x68], al
	mov	rax, qword ptr [ModuleInfo+0x200+rip]
	mov	qword ptr [rdi], rax
	jmp	$_207

$_187:	mov	rcx, qword ptr [rbp-0x20]
	mov	al, byte ptr [rcx]
	mov	byte ptr [rdi+0x68], al
	cmp	byte ptr [rcx], 2
	jnz	$_188
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 7
	jnz	$_188
	mov	rax, qword ptr [ModuleInfo+0x200+rip]
	mov	qword ptr [rdi], rax
$_188:	jmp	$_207

$_189:	mov	byte ptr [rdi+0x6C], 1
	jmp	$_207

$_190:	cmp	dword ptr [Options+0xA4+rip], 1
	jz	$_191
	cmp	dword ptr [Options+0xA4+rip], 0
	jnz	$_192
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jz	$_192
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jz	$_192
$_191:	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 3006
	call	asmerr@PLT
	jmp	$_193

$_192:	mov	al, byte ptr [rcx]
	or	byte ptr [rbp-0x34], al
$_193:	jmp	$_207

$_194:	cmp	dword ptr [Options+0xA4+rip], 1
	jz	$_195
	cmp	dword ptr [Options+0xA4+rip], 0
	jnz	$_196
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jz	$_196
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jz	$_196
$_195:	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 3006
	call	asmerr@PLT
	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	mov	dword ptr [rbp+0x28], eax
	jmp	$_207

$_196:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx], 40
	jz	$_197
	lea	rdx, [DS0022+rip]
	mov	ecx, 2065
	call	asmerr@PLT
	jmp	$_207

$_197:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx], 9
	jnz	$_198
	cmp	byte ptr [rbx+0x1], 34
	jz	$_199
	cmp	byte ptr [rbx+0x1], 39
	jz	$_199
$_198:	mov	rdx, qword ptr [rbp-0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	mov	dword ptr [rbp+0x28], eax
	jmp	$_207

$_199:	mov	rsi, rbx
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx], 41
	jz	$_200
	lea	rdx, [DS0023+rip]
	mov	ecx, 2065
	call	asmerr@PLT
	jmp	$_207

$_200:	mov	rbx, rsi
	cmp	byte ptr [rbp-0x1], 0
	jz	$_204
	cmp	qword ptr [rdi+0x60], 0
	jz	$_201
	mov	rcx, qword ptr [rdi+0x60]
	call	tstrlen@PLT
	mov	esi, eax
	mov	rcx, qword ptr [rbx+0x8]
	inc	rcx
	mov	r8d, dword ptr [rbx+0x4]
	mov	rdx, rcx
	mov	rcx, qword ptr [rdi+0x60]
	call	tmemcmp@PLT
$_201:	cmp	qword ptr [rdi+0x60], 0
	jz	$_202
	cmp	dword ptr [rbx+0x4], esi
	jnz	$_202
	test	eax, eax
	jz	$_203
$_202:	mov	rcx, qword ptr [rbp-0x40]
	lea	r8, [DS0025+rip]
	mov	rdx, qword ptr [rcx+0x8]
	mov	ecx, 2015
	call	asmerr@PLT
	jmp	$_207

$_203:	jmp	$_205

$_204:	mov	ecx, dword ptr [rbx+0x4]
	inc	ecx
	call	LclAlloc@PLT
	mov	qword ptr [rdi+0x60], rax
	mov	rcx, qword ptr [rbx+0x8]
	inc	rcx
	mov	esi, dword ptr [rbx+0x4]
	mov	r8d, esi
	mov	rdx, rcx
	mov	rcx, qword ptr [rdi+0x60]
	call	tmemcpy@PLT
	mov	byte ptr [rax+rsi], 0
$_205:	jmp	$_207

$_206:	cmp	edx, 1
	je	$_157
	cmp	edx, 2
	je	$_158
	cmp	edx, 130
	je	$_159
	cmp	edx, 4
	je	$_167
	cmp	edx, 132
	je	$_168
	cmp	edx, 196
	je	$_171
	cmp	edx, 136
	je	$_185
	cmp	edx, 8
	je	$_187
	cmp	edx, 160
	je	$_189
	cmp	edx, 32
	je	$_190
	cmp	edx, 16
	je	$_194
$_207:	inc	dword ptr [rbp+0x28]
	jmp	$_152

$_208:	mov	rcx, qword ptr [rbp-0x40]
	mov	rdi, qword ptr [rcx+0x68]
	cmp	dword ptr [rdi+0x48], 1
	jz	$_209
	mov	rdx, qword ptr [rdi+0x50]
	mov	rcx, qword ptr [rbp-0x40]
	call	TypeFromClassName
	test	eax, eax
	jz	$_209
	mov	dword ptr [rdi+0x48], eax
$_209:	cmp	byte ptr [rbp-0x1], 0
	jz	$_215
	xor	esi, esi
	mov	al, byte ptr [rdi+0x6A]
	cmp	byte ptr [rbp-0x32], al
	jz	$_210
	lea	rsi, [DS0026+rip]
	jmp	$_213

$_210:	mov	al, byte ptr [rdi+0x72]
	cmp	byte ptr [rbp-0x33], al
	jz	$_211
	lea	rsi, [DS0027+rip]
	jmp	$_213

$_211:	mov	al, byte ptr [rdi+0x68]
	cmp	byte ptr [rbp-0x31], al
	jz	$_212
	lea	rsi, [DS0028+rip]
	jmp	$_213

$_212:	cmp	byte ptr [rbp-0x34], 0
	jz	$_213
	mov	al, byte ptr [rdi+0x69]
	cmp	byte ptr [rbp-0x34], al
	jz	$_213
	lea	rsi, [DS0029+rip]
$_213:	test	rsi, rsi
	jz	$_214
	mov	rcx, qword ptr [rbp-0x40]
	mov	r8, rsi
	mov	rdx, qword ptr [rcx+0x8]
	mov	ecx, 2015
	call	asmerr@PLT
$_214:	jmp	$_221

$_215:	mov	rcx, qword ptr [rbp-0x50]
	or	byte ptr [rcx+0x14], 0x02
	mov	qword ptr [rcx+0x30], rcx
	mov	dword ptr [rcx+0x28], 0
	mov	al, byte ptr [rbp-0x31]
	cmp	al, -2
	jz	$_216
	cmp	al, byte ptr [rdi+0x68]
	jz	$_216
	lea	r8, [DS0028+rip]
	mov	rdx, qword ptr [rcx+0x8]
	mov	ecx, 2015
	call	asmerr@PLT
	jmp	$_219

$_216:	mov	rdx, qword ptr [rdi]
	test	rdx, rdx
	jz	$_219
	cmp	byte ptr [rdx+0x38], -2
	jnz	$_217
	mov	al, byte ptr [rdi+0x68]
	mov	byte ptr [rdx+0x38], al
	jmp	$_219

$_217:	mov	al, byte ptr [rdi+0x68]
	cmp	byte ptr [rdx+0x38], al
	jz	$_219
	cmp	rdx, qword ptr [ModuleInfo+0x200+rip]
	jnz	$_218
	cmp	byte ptr [rdi+0x68], 1
	jc	$_218
	jmp	$_219

$_218:	lea	r8, [DS0028+rip]
	mov	rdx, qword ptr [rcx+0x8]
	mov	ecx, 2015
	call	asmerr@PLT
$_219:	cmp	byte ptr [rdi+0x73], 0
	jz	$_220
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_220
	jmp	$_221

$_220:	inc	dword ptr [ModuleInfo+0x8+rip]
	mov	eax, dword ptr [ModuleInfo+0x8+rip]
	mov	dword ptr [rdi+0x44], eax
	mov	rcx, qword ptr [rbp-0x50]
	call	$_010
$_221:	cmp	byte ptr [rbp-0x34], 0
	jz	$_222
	mov	al, byte ptr [rbp-0x34]
	mov	byte ptr [rdi+0x69], al
$_222:	mov	rcx, qword ptr [rbp-0x40]
	call	$_021
	call	SetOfssize
	mov	esi, eax
	cmp	dword ptr [rbp-0x24], 0
	je	$_225
	cmp	dword ptr [rdi+0x48], 1
	jne	$_225
	cmp	byte ptr [Options+0x2+rip], 4
	jnz	$_223
	cmp	qword ptr [CV8Label+rip], 0
	jnz	$_223
	xor	r9d, r9d
	xor	r8d, r8d
	xor	edx, edx
	lea	rcx, [DS002A+rip]
	call	CreateLabel@PLT
	mov	qword ptr [CV8Label+rip], rax
$_223:	cmp	dword ptr [Options+0xA4+rip], 0
	jnz	$_225
	cmp	dword ptr [Options+0xA8+rip], 0
	jz	$_225
	cmp	qword ptr [ImageBase+rip], 0
	jnz	$_225
	lea	rcx, [DS002B+rip]
	call	SymFind@PLT
	test	rax, rax
	jnz	$_224
	lea	rcx, [DS002B+rip]
	call	SymCreate@PLT
$_224:	mov	qword ptr [rbp-0xC8], rax
	xor	r9d, r9d
	lea	r8, [rbp-0xD0]
	mov	edx, 196
	lea	rcx, [DS002C+rip]
	call	CreateLabel@PLT
	mov	qword ptr [ImageBase+rip], rax
	mov	dword ptr [rax+0x28], -4096
$_225:	cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_226
	xor	r8d, r8d
	xor	edx, edx
	mov	ecx, 7
	call	LstWrite@PLT
$_226:	mov	eax, esi
$_227:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

SortSegments:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	dword ptr [rbp-0x4], 1
	mov	dword ptr [rbp-0x14], 1
	jmp	$_242

$_228:	xor	esi, esi
	mov	dword ptr [rbp-0x4], 0
	mov	rdi, qword ptr [SymTables+0x20+rip]
$_229:	test	rdi, rdi
	je	$_242
	cmp	qword ptr [rdi+0x70], 0
	je	$_242
	mov	dword ptr [rbp-0x8], 0
	mov	rbx, qword ptr [rdi+0x68]
	jmp	$_237

$_230:	mov	rcx, qword ptr [rdi+0x70]
	mov	rcx, qword ptr [rcx+0x68]
	mov	eax, dword ptr [rcx+0x38]
	cmp	dword ptr [rbx+0x38], eax
	jbe	$_231
	mov	dword ptr [rbp-0x8], 1
$_231:	jmp	$_238

$_232:	mov	rcx, qword ptr [rdi+0x70]
	mov	rdx, qword ptr [rcx+0x8]
	mov	rcx, qword ptr [rdi+0x8]
	call	tstrcmp@PLT
	cmp	eax, 0
	jle	$_233
	mov	dword ptr [rbp-0x8], 1
$_233:	jmp	$_238

$_234:	mov	rdx, qword ptr [rdi+0x70]
	mov	rcx, qword ptr [rdx+0x68]
	mov	eax, dword ptr [rcx+0x4C]
	cmp	dword ptr [rbx+0x4C], eax
	jle	$_235
	mov	dword ptr [rbp-0x8], 1
	jmp	$_236

$_235:	mov	eax, dword ptr [rcx+0x4C]
	cmp	dword ptr [rbx+0x4C], eax
	jnz	$_236
	mov	rdx, qword ptr [rdx+0x8]
	mov	rcx, qword ptr [rdi+0x8]
	call	tstricmp@PLT
	cmp	eax, 0
	jle	$_236
	mov	dword ptr [rbp-0x8], 1
$_236:	jmp	$_238

$_237:	cmp	dword ptr [rbp+0x28], 0
	jz	$_230
	cmp	dword ptr [rbp+0x28], 1
	jz	$_232
	cmp	dword ptr [rbp+0x28], 2
	jz	$_234
$_238:	cmp	dword ptr [rbp-0x8], 0
	jz	$_241
	mov	rdx, qword ptr [rdi+0x70]
	mov	dword ptr [rbp-0x4], 1
	test	rsi, rsi
	jnz	$_239
	mov	qword ptr [SymTables+0x20+rip], rdx
	jmp	$_240

$_239:	mov	qword ptr [rsi+0x70], rdx
$_240:	mov	rax, qword ptr [rdx+0x70]
	mov	qword ptr [rdi+0x70], rax
	mov	qword ptr [rdx+0x70], rdi
$_241:	mov	rsi, rdi
	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_229

$_242:
	cmp	dword ptr [rbp-0x4], 1
	je	$_228
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

SegmentModuleExit:
	push	rdi
	sub	rsp, 32
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 0
	jz	$_243
	call	ModelSimSegmExit@PLT
$_243:	mov	rdi, qword ptr [ModuleInfo+0x1F8+rip]
	test	rdi, rdi
	jz	$_246
	mov	rdx, qword ptr [rdi+0x8]
	mov	ecx, 1010
	call	asmerr@PLT
	jmp	$_245

$_244:	mov	rcx, qword ptr [rdi+0x8]
	call	$_073
	test	eax, eax
	jnz	$_246
	mov	rdi, qword ptr [ModuleInfo+0x1F8+rip]
$_245:	test	rdi, rdi
	jnz	$_244
$_246:	xor	eax, eax
	add	rsp, 32
	pop	rdi
	ret

SegmentFini:
	sub	rsp, 8
	call	$_011
	add	rsp, 8
	ret

SegmentInit:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	ebx, ecx
	mov	qword ptr [ModuleInfo+0x1F8+rip], 0
	mov	dword ptr [stkindex+rip], 0
	test	ecx, ecx
	jnz	$_247
	mov	dword ptr [grpdefidx+rip], 0
	mov	dword ptr [buffer_size+rip], 0
	mov	qword ptr [CV8Label+rip], 0
$_247:	cmp	qword ptr [ModuleInfo+0x208+rip], 0
	jnz	$_253
	cmp	dword ptr [Options+0xA4+rip], 1
	jz	$_253
	mov	rdi, qword ptr [SymTables+0x20+rip]
	mov	dword ptr [buffer_size+rip], 0
$_248:	test	rdi, rdi
	jz	$_252
	mov	rcx, qword ptr [rdi+0x68]
	cmp	byte ptr [rcx+0x6F], 0
	jz	$_249
	jmp	$_251

$_249:	cmp	dword ptr [rcx+0x18], 0
	jz	$_251
	mov	eax, dword ptr [rdi+0x50]
	sub	eax, dword ptr [rcx+0x8]
	cmp	dword ptr [rcx+0x48], 1
	jnz	$_250
	mov	edx, eax
	shr	eax, 2
	add	eax, edx
$_250:	add	dword ptr [buffer_size+rip], eax
$_251:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_248

$_252:	cmp	dword ptr [buffer_size+rip], 0
	jz	$_253
	mov	ecx, dword ptr [buffer_size+rip]
	call	LclAlloc@PLT
	mov	qword ptr [ModuleInfo+0x208+rip], rax
$_253:	mov	rdi, qword ptr [SymTables+0x20+rip]
	mov	rsi, qword ptr [ModuleInfo+0x208+rip]
$_254:	test	rdi, rdi
	jz	$_260
	mov	rcx, qword ptr [rdi+0x68]
	mov	dword ptr [rcx+0xC], 0
	cmp	byte ptr [rcx+0x6F], 0
	jnz	$_259
	cmp	dword ptr [rcx+0x18], 0
	jz	$_256
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_255
	lea	rax, [codebuf+rip]
	mov	qword ptr [rcx+0x10], rax
	jmp	$_256

$_255:	mov	qword ptr [rcx+0x10], rsi
	mov	eax, dword ptr [rdi+0x50]
	sub	eax, dword ptr [rcx+0x8]
	add	rsi, rax
$_256:	cmp	byte ptr [rcx+0x72], 5
	jz	$_257
	mov	dword ptr [rdi+0x50], 0
$_257:	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_258
	mov	dword ptr [rcx+0x8], 0
	mov	byte ptr [rcx+0x6E], 0
$_258:	mov	dword ptr [rcx+0x18], 0
	mov	qword ptr [rcx+0x28], 0
	mov	qword ptr [rcx+0x30], 0
$_259:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_254

$_260:
	mov	byte ptr [ModuleInfo+0x1CC+rip], 0
	test	ebx, ebx
	jz	$_262
	cmp	dword ptr [UseSavedState+rip], 1
	jnz	$_262
	mov	rax, qword ptr [saved_CurrSeg+rip]
	mov	qword ptr [ModuleInfo+0x1F8+rip], rax
	mov	eax, dword ptr [saved_stkindex+rip]
	mov	dword ptr [stkindex+rip], eax
	cmp	dword ptr [stkindex+rip], 0
	jz	$_261
	imul	ecx, dword ptr [stkindex+rip], 8
	mov	r8d, ecx
	mov	rdx, qword ptr [saved_SegStack+rip]
	lea	rcx, [SegStack+rip]
	call	tmemcpy@PLT
$_261:	call	$_015
$_262:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

SegmentSaveState:
	sub	rsp, 40
	mov	rax, qword ptr [ModuleInfo+0x1F8+rip]
	mov	qword ptr [saved_CurrSeg+rip], rax
	mov	eax, dword ptr [stkindex+rip]
	mov	dword ptr [saved_stkindex+rip], eax
	cmp	dword ptr [stkindex+rip], 0
	jz	$_263
	imul	ecx, dword ptr [stkindex+rip], 8
	call	LclAlloc@PLT
	mov	qword ptr [saved_SegStack+rip], rax
	imul	ecx, dword ptr [stkindex+rip], 8
	mov	r8d, ecx
	lea	rdx, [SegStack+rip]
	mov	rcx, qword ptr [saved_SegStack+rip]
	call	tmemcpy@PLT
$_263:	add	rsp, 40
	ret


.SECTION .data
	.ALIGN	16

ImageBase:
	.quad  0x0000000000000000

CV8Label: .quad	 0x0000000000000000

symCurSeg:
	.quad  0x0000000000000000

SegAttrToken:
	.quad  DS0000
	.quad  DS0001
	.quad  DS0002
	.quad  DS0003
	.quad  DS0004
	.quad  DS0005
	.quad  DS0006
	.quad  DS0007
	.quad  DS0008
	.quad  DS0009
	.quad  DS000A
	.quad  DS000B
	.quad  DS000C
	.quad  DS000D
	.quad  DS000E
	.quad  DS000F
	.quad  DS0010
	.quad  DS0011
	.quad  DS0012
	.quad  DS0013
	.quad  DS0014
	.quad  DS0015
	.quad  DS0016
	.quad  DS0017
	.quad  DS0018
	.quad  DS0019
	.quad  DS001A

SegAttrValue:
	.byte  0x00, 0x01, 0x00, 0x02, 0x01, 0x02, 0x02, 0x02
	.byte  0x04, 0x02, 0x08, 0x02, 0x00, 0x82, 0x00, 0x04
	.byte  0x02, 0x04, 0x05, 0x04, 0x06, 0x04, 0x02, 0x04
	.byte  0x00, 0x84, 0x00, 0xC4, 0x00, 0x08, 0x01, 0x08
	.byte  0x02, 0x08, 0x01, 0x88, 0x00, 0xA0, 0x02, 0x20
	.byte  0x04, 0x20, 0x08, 0x20, 0x10, 0x20, 0x20, 0x20
	.byte  0x40, 0x20, 0x80, 0x20, 0x00, 0x10, 0x00, 0x00

grpdefidx:
	.int   0x00000000, 0x00000000

SegStack:
	.zero  160

stkindex: .int	 0x00000000, 0x00000000

saved_CurrSeg:
	.quad  0x0000000000000000

saved_SegStack:
	.quad  0x0000000000000000

saved_stkindex:
	.int   0x00000000, 0x00000000

codebuf:
	.zero  1024 * 1

buffer_size:
	.int   0x00000000

min_cpu:
	.byte  0x00, 0x00, 0x30, 0x00, 0x70, 0x00

DS001B:
	.byte  0x43, 0x4F, 0x4E, 0x53, 0x54, 0x00

DS001C:
	.byte  0x44, 0x42, 0x54, 0x59, 0x50, 0x00

DS001D:
	.byte  0x44, 0x42, 0x53, 0x59, 0x4D, 0x00

DS001E:
	.byte  0x43, 0x4F, 0x44, 0x45, 0x00

DS001F:
	.byte  0x44, 0x41, 0x54, 0x41, 0x00

DS0020:
	.byte  0x42, 0x53, 0x53, 0x00

DS0021:
	.byte  0x61, 0x74, 0x74, 0x72, 0x69, 0x62, 0x75, 0x74
	.byte  0x65, 0x73, 0x00

DS0022:
	.byte  0x28, 0x00

DS0023:
	.byte  0x29, 0x00

DS0024:
	.byte  0x31, 0x2D, 0x36, 0x00

DS0025:
	.byte  0x61, 0x6C, 0x69, 0x61, 0x73, 0x00

DS0026:
	.byte  0x61, 0x6C, 0x69, 0x67, 0x6E, 0x6D, 0x65, 0x6E
	.byte  0x74, 0x00

DS0027:
	.byte  0x63, 0x6F, 0x6D, 0x62, 0x69, 0x6E, 0x65, 0x00

DS0028:
	.byte  0x73, 0x65, 0x67, 0x6D, 0x65, 0x6E, 0x74, 0x20
	.byte  0x77, 0x6F, 0x72, 0x64, 0x20, 0x73, 0x69, 0x7A
	.byte  0x65, 0x00

DS0029:
	.byte  0x63, 0x68, 0x61, 0x72, 0x61, 0x63, 0x74, 0x65
	.byte  0x72, 0x69, 0x73, 0x74, 0x69, 0x63, 0x73, 0x00

DS002A:
	.byte  0x24, 0x24, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30
	.byte  0x00

DS002B:
	.byte  0x49, 0x4D, 0x41, 0x47, 0x45, 0x5F, 0x44, 0x4F
	.byte  0x53, 0x5F, 0x48, 0x45, 0x41, 0x44, 0x45, 0x52
	.byte  0x00

DS002C:
	.byte  0x5F, 0x5F, 0x49, 0x6D, 0x61, 0x67, 0x65, 0x42
	.byte  0x61, 0x73, 0x65, 0x00


.SECTION .rodata
	.ALIGN	16

DS0000:
	.byte  0x52, 0x45, 0x41, 0x44, 0x4F, 0x4E, 0x4C, 0x59
	.byte  0x00

DS0001:
	.byte  0x42, 0x59, 0x54, 0x45, 0x00

DS0002:
	.byte  0x57, 0x4F, 0x52, 0x44, 0x00

DS0003:
	.byte  0x44, 0x57, 0x4F, 0x52, 0x44, 0x00

DS0004:
	.byte  0x50, 0x41, 0x52, 0x41, 0x00

DS0005:
	.byte  0x50, 0x41, 0x47, 0x45, 0x00

DS0006:
	.byte  0x41, 0x4C, 0x49, 0x47, 0x4E, 0x00

DS0007:
	.byte  0x50, 0x52, 0x49, 0x56, 0x41, 0x54, 0x45, 0x00

DS0008:
	.byte  0x50, 0x55, 0x42, 0x4C, 0x49, 0x43, 0x00

DS0009:
	.byte  0x53, 0x54, 0x41, 0x43, 0x4B, 0x00

DS000A:
	.byte  0x43, 0x4F, 0x4D, 0x4D, 0x4F, 0x4E, 0x00

DS000B:
	.byte  0x4D, 0x45, 0x4D, 0x4F, 0x52, 0x59, 0x00

DS000C:
	.byte  0x41, 0x54, 0x00

DS000D:
	.byte  0x43, 0x4F, 0x4D, 0x44, 0x41, 0x54, 0x00

DS000E:
	.byte  0x55, 0x53, 0x45, 0x31, 0x36, 0x00

DS000F:
	.byte  0x55, 0x53, 0x45, 0x33, 0x32, 0x00

DS0010:
	.byte  0x55, 0x53, 0x45, 0x36, 0x34, 0x00

DS0011:
	.byte  0x46, 0x4C, 0x41, 0x54, 0x00

DS0012:
	.byte  0x49, 0x4E, 0x46, 0x4F, 0x00

DS0013:
	.byte  0x44, 0x49, 0x53, 0x43, 0x41, 0x52, 0x44, 0x00

DS0014:
	.byte  0x4E, 0x4F, 0x43, 0x41, 0x43, 0x48, 0x45, 0x00

DS0015:
	.byte  0x4E, 0x4F, 0x50, 0x41, 0x47, 0x45, 0x00

DS0016:
	.byte  0x53, 0x48, 0x41, 0x52, 0x45, 0x44, 0x00

DS0017:
	.byte  0x45, 0x58, 0x45, 0x43, 0x55, 0x54, 0x45, 0x00

DS0018:
	.byte  0x52, 0x45, 0x41, 0x44, 0x00

DS0019:
	.byte  0x57, 0x52, 0x49, 0x54, 0x45, 0x00

DS001A:
	.byte  0x41, 0x4C, 0x49, 0x41, 0x53, 0x00


.att_syntax prefix
