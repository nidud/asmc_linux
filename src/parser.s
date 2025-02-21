

.intel_syntax noprefix

.global sym_add_table
.global sym_remove_table
.global sym_ext2int
.global GetLangType
.global SizeFromRegister
.global SizeFromMemtype
.global MemtypeFromSize
.global OperandSize
.global set_frame
.global set_frame2
.global segm_override
.global idata_fixup
.global ParseLine
.global ProcessFile
.global SegOverride
.global SymTables

.extern EnumDirective
.extern CurrEnum
.extern NewDirective
.extern imm2xmm
.extern mem2mem
.extern PublicDirective
.extern ProcType
.extern ExpandHllProcEx
.extern ExpandLine
.extern process_branch
.extern directive_tab
.extern ResWordTable
.extern Frame_Datum
.extern Frame_Type
.extern vex_flags
.extern opnd_clstab
.extern ProcStatus
.extern ProcessOperator
.extern GetOperator
.extern HandleIndirection
.extern quad_resize
.extern AddPublicData
.extern omf_OutSelect
.extern StoreLine
.extern UseSavedState
.extern StoreState
.extern data_dir
.extern LstWrite
.extern LstWriteSrcLine
.extern Tokenize
.extern GetTextLine
.extern write_prologue
.extern RetInstr
.extern CurrProc
.extern GetOverrideAssume
.extern GetAssume
.extern StdAssumeTable
.extern SegAssumeTable
.extern GetGroup
.extern GetCurrOffset
.extern GetSymOfssize
.extern CreateLabel
.extern CurrStruct
.extern EmitConstError
.extern EvalOperand
.extern codegen
.extern GetResWName
.extern RemoveResWord
.extern PreprocessLine
.extern WritePreprocessedLine
.extern optable_idx
.extern SpecialTable
.extern InstrTable
.extern SetFixupFrame
.extern CreateFixup
.extern MemFree
.extern MemAlloc
.extern tstricmp
.extern tstrcat
.extern tstrcpy
.extern asmerr
.extern Options
.extern ModuleInfo
.extern Parse_Pass
.extern SymFind


.SECTION .text
	.ALIGN	16

sym_add_table:
	xor	eax, eax
	cmp	qword ptr [rcx], rax
	jnz	$_0001
	mov	qword ptr [rcx], rdx
	mov	qword ptr [rcx+0x8], rdx
	mov	qword ptr [rdx+0x70], rax
	mov	qword ptr [rdx+0x78], rax
	jmp	$_0002

$_0001: mov	rax, qword ptr [rcx+0x8]
	mov	qword ptr [rdx+0x78], rax
	mov	qword ptr [rax+0x70], rdx
	mov	qword ptr [rcx+0x8], rdx
	mov	qword ptr [rdx+0x70], 0
$_0002: ret

sym_remove_table:
	push	rbx
	push	rbp
	mov	rbp, rsp
	cmp	qword ptr [rdx+0x78], 0
	jz	$_0003
	mov	rax, qword ptr [rdx+0x70]
	mov	rbx, qword ptr [rdx+0x78]
	mov	qword ptr [rbx+0x70], rax
$_0003: cmp	qword ptr [rdx+0x70], 0
	jz	$_0004
	mov	rax, qword ptr [rdx+0x78]
	mov	rbx, qword ptr [rdx+0x70]
	mov	qword ptr [rbx+0x78], rax
$_0004: cmp	qword ptr [rcx], rdx
	jnz	$_0005
	mov	rax, qword ptr [rdx+0x70]
	mov	qword ptr [rcx], rax
$_0005: cmp	qword ptr [rcx+0x8], rdx
	jnz	$_0006
	mov	rax, qword ptr [rdx+0x78]
	mov	qword ptr [rcx+0x8], rax
$_0006: mov	qword ptr [rdx+0x70], 0
	mov	qword ptr [rdx+0x78], 0
	leave
	pop	rbx
	ret

sym_ext2int:
	mov	qword ptr [rsp+0x8], rcx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	test	byte ptr [rcx+0x15], 0x08
	jnz	$_0007
	test	dword ptr [rcx+0x14], 0x80
	jnz	$_0007
	or	dword ptr [rcx+0x14], 0x80
	call	AddPublicData@PLT
$_0007: mov	rdx, qword ptr [rbp+0x10]
	lea	rcx, [SymTables+0x10+rip]
	call	sym_remove_table
	mov	rcx, qword ptr [rbp+0x10]
	test	byte ptr [rcx+0x15], 0x08
	jnz	$_0008
	mov	dword ptr [rcx+0x38], 0
$_0008: mov	byte ptr [rcx+0x18], 1
	leave
	ret

GetLangType:
	mov	qword ptr [rsp+0x18], r8
	push	rbp
	mov	rbp, rsp
	imul	eax, dword ptr [rcx], 24
	add	rdx, rax
	mov	rax, qword ptr [rdx+0x8]
	mov	eax, dword ptr [rax]
	or	al, 0x20
	cmp	byte ptr [rdx], 8
	jnz	$_0010
	cmp	ax, 99
	jnz	$_0010
	cmp	dword ptr [rdx-0x14], 539
	jnz	$_0009
	cmp	byte ptr [rdx+0x18], 58
	jz	$_0010
$_0009: mov	byte ptr [rdx], 7
	mov	dword ptr [rdx+0x4], 277
	mov	byte ptr [rdx+0x1], 1
$_0010: cmp	byte ptr [rdx], 7
	jnz	$_0011
	cmp	dword ptr [rdx+0x4], 277
	jc	$_0011
	cmp	dword ptr [rdx+0x4], 286
	ja	$_0011
	inc	dword ptr [rcx]
	mov	al, byte ptr [rdx+0x1]
	mov	rcx, qword ptr [rbp+0x20]
	mov	byte ptr [rcx], al
	xor	eax, eax
	jmp	$_0012

$_0011: mov	rax, -1
$_0012: leave
	ret

SizeFromRegister:
	lea	rdx, [SpecialTable+rip]
	imul	eax, ecx, 12
	add	rdx, rax
	mov	eax, dword ptr [rdx+0x4]
	and	eax, 0x7F
	jnz	$_0013
	movzx	eax, byte ptr [ModuleInfo+0x1CE+rip]
	test	byte ptr [rdx+0x3], 0x0C
	jnz	$_0013
	mov	eax, 4
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_0013
	mov	eax, 8
$_0013: ret

SizeFromMemtype:
	mov	qword ptr [rsp+0x18], r8
	push	rbp
	mov	rbp, rsp
	movzx	eax, cl
	cmp	al, 63
	jnz	$_0014
	mov	eax, 64
	jmp	$_0026

$_0014: and	ecx, 0x80
	jnz	$_0015
	and	eax, 0x1F
	inc	eax
	jmp	$_0026

$_0015: mov	ecx, edx
	cmp	ecx, 254
	jnz	$_0016
	movzx	ecx, byte ptr [ModuleInfo+0x1CC+rip]
$_0016: mov	edx, 2
	shl	edx, cl
	jmp	$_0025

$_0017: mov	eax, edx
	jmp	$_0026

$_0018: lea	eax, [rdx+0x2]
	jmp	$_0026

$_0019: mov	eax, edx
	mov	rcx, qword ptr [rbp+0x20]
	test	rcx, rcx
	jz	$_0020
	cmp	byte ptr [rcx+0x1C], 0
	jz	$_0020
	add	eax, 2
$_0020: jmp	$_0026

$_0021: mov	eax, edx
	movzx	ecx, byte ptr [ModuleInfo+0x1B5+rip]
	mov	edx, 1
	shl	edx, cl
	and	edx, 0x68
	jz	$_0022
	add	eax, 2
$_0022: jmp	$_0026

$_0023: mov	rcx, qword ptr [rbp+0x20]
	test	rcx, rcx
	jz	$_0024
	mov	eax, dword ptr [rcx+0x50]
	jmp	$_0026

$_0024: xor	eax, eax
	jmp	$_0026

$_0025: cmp	eax, 129
	jz	$_0017
	cmp	eax, 130
	jz	$_0018
	cmp	eax, 128
	jz	$_0019
	cmp	eax, 195
	jz	$_0021
	cmp	eax, 196
	jz	$_0023
	jmp	$_0024

$_0026:
	leave
	ret

MemtypeFromSize:
	push	rbx
	push	rbp
	mov	rbp, rsp
	lea	rbx, [SpecialTable+rip]
	add	rbx, 2460
$_0027: cmp	byte ptr [rbx+0xB], 6
	jnz	$_0030
	mov	al, byte ptr [rbx+0xA]
	and	eax, 0x80
	jnz	$_0029
	mov	al, byte ptr [rbx+0xA]
	cmp	al, 63
	jz	$_0028
	and	eax, 0x1F
$_0028: inc	eax
	cmp	eax, ecx
	jnz	$_0029
	mov	al, byte ptr [rbx+0xA]
	mov	byte ptr [rdx], al
	xor	eax, eax
	jmp	$_0031

$_0029: add	rbx, 12
	jmp	$_0027

$_0030: mov	rax, -1
$_0031: leave
	pop	rbx
	ret

OperandSize:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	jmp	$_0045

$_0032: xor	eax, eax
	jmp	$_0047

$_0033: mov	cl, byte ptr [rdx+0x60]
	xor	r8d, r8d
	movzx	edx, byte ptr [rdx+0x63]
	movzx	ecx, cl
	call	SizeFromMemtype
	jmp	$_0047

$_0034: mov	eax, 1
	jmp	$_0047

$_0035: mov	eax, 2
	jmp	$_0047

$_0036: mov	eax, 4
	jmp	$_0047

$_0037: mov	eax, 8
	jmp	$_0047

$_0038: mov	eax, 6
	jmp	$_0047

$_0039: mov	eax, 10
	jmp	$_0047

$_0040: mov	eax, 16
	jmp	$_0047

$_0041: mov	eax, 32
	jmp	$_0047

$_0042: mov	eax, 64
	jmp	$_0047

$_0043: mov	eax, 4
	cmp	byte ptr [rdx+0x63], 2
	jnz	$_0044
	mov	eax, 8
$_0044: jmp	$_0047

	jmp	$_0046

$_0045: test	ecx, ecx
	je	$_0032
	cmp	ecx, 4202240
	je	$_0033
	test	ecx, 0x10101
	jne	$_0034
	test	ecx, 0xC020202
	jne	$_0035
	test	ecx, 0x40404
	jne	$_0036
	test	ecx, 0x188808
	jne	$_0037
	test	ecx, 0x40200000
	jne	$_0038
	test	ecx, 0x30400000
	jne	$_0039
	test	ecx, 0x1010
	jne	$_0040
	test	ecx, 0x2020
	jne	$_0041
	test	ecx, 0x4040
	jne	$_0042
	test	ecx, 0x2000000
	jne	$_0043
$_0046: xor	eax, eax
$_0047: leave
	ret

$_0048:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	cmp	ecx, 12
	jnz	$_0051
	cmp	edx, 15
	jnz	$_0049
	xor	eax, eax
	jmp	$_0056

$_0049: cmp	edx, 16
	jnz	$_0050
	mov	eax, 1
	jmp	$_0056

$_0050: jmp	$_0055

$_0051: cmp	ecx, 14
	jnz	$_0054
	cmp	edx, 15
	jnz	$_0052
	mov	eax, 2
	jmp	$_0056

$_0052: cmp	edx, 16
	jnz	$_0053
	mov	eax, 3
	jmp	$_0056

$_0053: jmp	$_0055

$_0054: mov	ecx, 2030
	call	asmerr@PLT
	jmp	$_0056

$_0055: mov	ecx, 2029
	call	asmerr@PLT
$_0056: leave
	ret

$_0057:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	test	rdx, rdx
	jz	$_0058
	cmp	byte ptr [rdx+0x18], 0
	jnz	$_0058
	jmp	$_0064

$_0058: lea	r9, [rbp-0x10]
	mov	r8d, dword ptr [rbp+0x20]
	mov	rcx, qword ptr [SegOverride+rip]
	call	GetAssume@PLT
	mov	dword ptr [rbp-0x4], eax
	xor	edx, edx
	mov	rcx, qword ptr [rbp-0x10]
	call	SetFixupFrame@PLT
	mov	rdx, qword ptr [rbp+0x18]
	cmp	dword ptr [rbp-0x4], -2
	jnz	$_0063
	test	rdx, rdx
	jz	$_0061
	cmp	qword ptr [rdx+0x30], 0
	jz	$_0059
	mov	rdx, qword ptr [rdx+0x8]
	mov	ecx, 2074
	call	asmerr@PLT
	jmp	$_0060

$_0059: mov	rax, qword ptr [rbp+0x10]
	mov	ecx, dword ptr [rbp+0x20]
	mov	dword ptr [rax+0x4], ecx
$_0060: jmp	$_0062

$_0061: mov	rdx, qword ptr [SegOverride+rip]
	mov	rdx, qword ptr [rdx+0x8]
	mov	ecx, 2074
	call	asmerr@PLT
$_0062: jmp	$_0064

$_0063: cmp	dword ptr [rbp+0x20], -2
	jz	$_0064
	mov	rax, qword ptr [rbp+0x10]
	mov	ecx, dword ptr [rbp-0x4]
	mov	dword ptr [rax+0x4], ecx
$_0064: leave
	ret

$_0065:
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	rbx, rcx
	mov	ecx, edx
	mov	rax, qword ptr [rbx+0x58]
	movzx	eax, byte ptr [rax+0x2]
	and	eax, 0x07
	cmp	eax, 2
	je	$_0080
	cmp	eax, 3
	je	$_0080
	cmp	word ptr [rbx+0xE], 742
	jnz	$_0066
	mov	dword ptr [rbx+0x4], -2
	xor	edx, edx
	mov	rcx, qword ptr [rbp+0x28]
	call	SetFixupFrame@PLT
	jmp	$_0080

$_0066: jmp	$_0069

$_0067: mov	dword ptr [rbp-0x4], 2
	jmp	$_0070

$_0068: mov	dword ptr [rbp-0x4], 3
	jmp	$_0070

$_0069: cmp	ecx, 14
	jz	$_0067
	cmp	ecx, 22
	jz	$_0067
	cmp	ecx, 21
	jz	$_0067
	jmp	$_0068

$_0070: cmp	dword ptr [rbx+0x4], -2
	jz	$_0076
	mov	ecx, dword ptr [rbx+0x4]
	call	GetOverrideAssume@PLT
	mov	qword ptr [rbp-0x10], rax
	cmp	qword ptr [rbp+0x28], 0
	jz	$_0072
	mov	rax, qword ptr [rbp-0x10]
	test	rax, rax
	jnz	$_0071
	mov	rax, qword ptr [rbp+0x28]
$_0071: xor	edx, edx
	mov	rcx, rax
	call	SetFixupFrame@PLT
	jmp	$_0075

$_0072: cmp	dword ptr [rbp+0x30], 0
	jz	$_0075
	cmp	qword ptr [rbp-0x10], 0
	jz	$_0073
	mov	rcx, qword ptr [rbp-0x10]
	call	GetSymOfssize@PLT
	cmp	byte ptr [rbx+0x63], al
	setne	al
	mov	byte ptr [rbx+0x9], al
	jmp	$_0075

$_0073: cmp	byte ptr [ModuleInfo+0x1D6+rip], 0
	jz	$_0074
	mov	al, byte ptr [ModuleInfo+0x1CC+rip]
	cmp	byte ptr [rbx+0x63], al
	setne	al
	mov	byte ptr [rbx+0x9], al
	jmp	$_0075

$_0074: mov	al, byte ptr [ModuleInfo+0x1CD+rip]
	cmp	byte ptr [rbx+0x63], al
	setne	al
	mov	byte ptr [rbx+0x9], al
$_0075: jmp	$_0079

$_0076: cmp	qword ptr [rbp+0x28], 0
	jnz	$_0077
	cmp	qword ptr [SegOverride+rip], 0
	jz	$_0078
$_0077: mov	r8d, dword ptr [rbp-0x4]
	mov	rdx, qword ptr [rbp+0x28]
	mov	rcx, rbx
	call	$_0057
$_0078: cmp	qword ptr [rbp+0x28], 0
	jnz	$_0079
	cmp	qword ptr [SegOverride+rip], 0
	jz	$_0079
	mov	rax, qword ptr [ModuleInfo+0x200+rip]
	cmp	qword ptr [SegOverride+rip], rax
	jz	$_0079
	cmp	byte ptr [rbx+0x63], 2
	jz	$_0079
	mov	rcx, qword ptr [SegOverride+rip]
	call	GetSymOfssize@PLT
	cmp	byte ptr [rbx+0x63], al
	setne	al
	mov	byte ptr [rbx+0x9], al
$_0079: mov	eax, dword ptr [rbp-0x4]
	cmp	dword ptr [rbx+0x4], eax
	jnz	$_0080
	mov	dword ptr [rbx+0x4], -2
$_0080: leave
	pop	rbx
	ret

set_frame:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rax, qword ptr [SegOverride+rip]
	test	rax, rax
	jz	$_0081
	mov	rcx, rax
$_0081: xor	edx, edx
	call	SetFixupFrame@PLT
	leave
	ret

set_frame2:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rax, qword ptr [SegOverride+rip]
	test	rax, rax
	jz	$_0082
	mov	rcx, rax
$_0082: mov	edx, 1
	call	SetFixupFrame@PLT
	leave
	ret

$_0083:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	byte ptr [rbp-0x6], 0
	mov	byte ptr [rbp-0x9], 0
	mov	byte ptr [rbp-0xA], 0
	mov	byte ptr [rbp-0xB], 0
	mov	rsi, qword ptr [rbp+0x28]
	imul	ebx, dword ptr [rbp+0x30], 24
	cmp	dword ptr [rbp+0x48], 131
	jnz	$_0084
	or	byte ptr [rsi+0x66], 0xFFFFFF80
$_0084: cmp	qword ptr [rsi+rbx+0x18], 0
	jz	$_0085
	mov	byte ptr [rbp-0x5], -128
	jmp	$_0090

$_0085: cmp	dword ptr [rsi+rbx+0x20], 0
	jz	$_0086
	cmp	dword ptr [rbp+0x48], 131
	jnz	$_0087
$_0086: mov	byte ptr [rbp-0x5], 0
	jmp	$_0090

$_0087: cmp	dword ptr [rsi+rbx+0x20], 127
	jg	$_0088
	cmp	dword ptr [rsi+rbx+0x20], -128
	jge	$_0089
$_0088: mov	byte ptr [rbp-0x5], -128
	jmp	$_0090

$_0089: mov	byte ptr [rbp-0x5], 64
$_0090: cmp	dword ptr [rbp+0x40], -2
	jne	$_0100
	cmp	dword ptr [rbp+0x48], -2
	jne	$_0100
	or	byte ptr [rsi+0x66], 0x02
	mov	byte ptr [rbp-0x5], 0
	mov	r9d, 1
	mov	r8, qword ptr [rbp+0x50]
	mov	edx, 28
	mov	rcx, rsi
	call	$_0065
	cmp	byte ptr [rsi+0x63], 0
	jnz	$_0091
	cmp	byte ptr [rsi+0x9], 0
	jz	$_0092
$_0091: cmp	byte ptr [rsi+0x63], 1
	jnz	$_0097
	cmp	byte ptr [rsi+0x9], 1
	jnz	$_0097
$_0092: cmp	dword ptr [rsi+rbx+0x20], 65535
	jg	$_0093
	cmp	dword ptr [rsi+rbx+0x20], -65535
	jge	$_0095
$_0093: mov	byte ptr [rbp-0x6], 5
	xor	byte ptr [rsi+0x9], 0x01
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0094
	mov	ecx, 7009
	call	asmerr@PLT
$_0094: jmp	$_0096

$_0095: mov	byte ptr [rbp-0x6], 6
$_0096: jmp	$_0099

$_0097: mov	byte ptr [rbp-0x6], 5
	cmp	byte ptr [rsi+0x63], 2
	jnz	$_0099
	mov	rax, qword ptr [rsi+rbx+0x18]
	test	rax, rax
	jnz	$_0098
	mov	byte ptr [rbp-0x6], 4
	mov	byte ptr [rsi+0x62], 37
	jmp	$_0099

$_0098: cmp	byte ptr [rax+0x18], 6
	jnz	$_0099
	mov	byte ptr [rax+0x18], 3
$_0099: jmp	$_0125

$_0100: cmp	dword ptr [rbp+0x40], -2
	jne	$_0112
	cmp	dword ptr [rbp+0x48], -2
	je	$_0112
	jmp	$_0110

$_0101: mov	byte ptr [rbp-0x6], 4
	jmp	$_0111

$_0102: mov	byte ptr [rbp-0x6], 5
	jmp	$_0111

$_0103: mov	byte ptr [rbp-0x6], 6
	cmp	byte ptr [rbp-0x5], 0
	jnz	$_0104
	cmp	dword ptr [rbp+0x48], 131
	jz	$_0104
	mov	byte ptr [rbp-0x5], 64
$_0104: jmp	$_0111

$_0105: mov	byte ptr [rbp-0x6], 7
	jmp	$_0111

$_0106: mov	byte ptr [rbp-0x7], 5
	cmp	dword ptr [rbp+0x48], 131
	jz	$_0107
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x48], 12
	mov	al, byte ptr [r11+rax+0xA]
	mov	byte ptr [rbp-0x7], al
$_0107: mov	al, byte ptr [rbp-0x7]
	shr	al, 3
	mov	byte ptr [rbp-0x9], al
	and	byte ptr [rbp-0x7], 0x07
	mov	al, byte ptr [rbp-0x7]
	mov	byte ptr [rbp-0x6], al
	cmp	byte ptr [rbp-0x7], 4
	jnz	$_0108
	mov	byte ptr [rsi+0x62], 36
	jmp	$_0109

$_0108: cmp	byte ptr [rbp-0x7], 5
	jnz	$_0109
	cmp	byte ptr [rbp-0x5], 0
	jnz	$_0109
	cmp	dword ptr [rbp+0x48], 131
	jz	$_0109
	mov	byte ptr [rbp-0x5], 64
$_0109: mov	al, byte ptr [rbp-0x9]
	mov	byte ptr [rbp-0xB], al
	jmp	$_0111

$_0110: cmp	dword ptr [rbp+0x48], 15
	je	$_0101
	cmp	dword ptr [rbp+0x48], 16
	je	$_0102
	cmp	dword ptr [rbp+0x48], 14
	je	$_0103
	cmp	dword ptr [rbp+0x48], 12
	je	$_0105
	jmp	$_0106

$_0111: xor	r9d, r9d
	mov	r8, qword ptr [rbp+0x50]
	mov	edx, dword ptr [rbp+0x48]
	mov	rcx, rsi
	call	$_0065
	jmp	$_0125

$_0112: cmp	dword ptr [rbp+0x40], -2
	je	$_0114
	cmp	dword ptr [rbp+0x48], -2
	jne	$_0114
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x40], 12
	mov	al, byte ptr [r11+rax+0xA]
	mov	byte ptr [rbp-0x8], al
	mov	al, byte ptr [rbp-0x8]
	shr	al, 3
	mov	byte ptr [rbp-0xA], al
	and	byte ptr [rbp-0x8], 0x07
	mov	byte ptr [rbp-0x5], 0
	mov	byte ptr [rbp-0x6], 4
	mov	al, byte ptr [rbp-0x8]
	shl	al, 3
	or	al, byte ptr [rbp+0x38]
	or	al, 0x05
	mov	byte ptr [rsi+0x62], al
	mov	al, byte ptr [rbp-0xA]
	shl	al, 1
	mov	byte ptr [rbp-0xB], al
	xor	r9d, r9d
	mov	r8, qword ptr [rbp+0x50]
	mov	edx, 28
	mov	rcx, rsi
	call	$_0065
	mov	rax, qword ptr [rsi+0x58]
	test	byte ptr [rax+0x3], 0x08
	jz	$_0113
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x40], 12
	mov	al, byte ptr [r11+rax+0xA]
	mov	byte ptr [rsi+0x64], al
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x40], 12
	cmp	dword ptr [r11+rax], 16
	jbe	$_0113
	or	byte ptr [rsi+0x64], 0x40
$_0113: jmp	$_0125

$_0114: mov	byte ptr [rbp-0x7], 5
	cmp	dword ptr [rbp+0x48], 131
	jz	$_0115
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x48], 12
	mov	al, byte ptr [r11+rax+0xA]
	mov	byte ptr [rbp-0x7], al
$_0115: lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x40], 12
	mov	al, byte ptr [r11+rax+0xA]
	mov	byte ptr [rbp-0x8], al
	mov	al, byte ptr [rbp-0x7]
	shr	al, 3
	mov	byte ptr [rbp-0x9], al
	mov	al, byte ptr [rbp-0x8]
	shr	al, 3
	mov	byte ptr [rbp-0xA], al
	and	byte ptr [rbp-0x7], 0x07
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x48], 12
	mov	ecx, dword ptr [r11+rax+0x4]
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x40], 12
	and	ecx, dword ptr [r11+rax+0x4]
	and	ecx, 0x7F
	test	ecx, ecx
	jnz	$_0118
	mov	rcx, qword ptr [rsi+0x58]
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x40], 12
	cmp	dword ptr [r11+rax], 8
	jbe	$_0117
	test	byte ptr [rcx+0x3], 0x08
	jz	$_0117
	mov	al, byte ptr [rbp-0x8]
	mov	byte ptr [rsi+0x64], al
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x40], 12
	cmp	dword ptr [r11+rax], 16
	jbe	$_0116
	or	byte ptr [rsi+0x64], 0x40
$_0116: jmp	$_0118

$_0117: mov	ecx, 2082
	call	asmerr@PLT
	jmp	$_0129

$_0118: and	byte ptr [rbp-0x8], 0x07
	jmp	$_0124

$_0119: mov	edx, dword ptr [rbp+0x48]
	mov	ecx, dword ptr [rbp+0x40]
	call	$_0048
	cmp	eax, -1
	je	$_0129
	mov	byte ptr [rbp-0x6], al
	xor	r9d, r9d
	mov	r8, qword ptr [rbp+0x50]
	mov	edx, dword ptr [rbp+0x40]
	mov	rcx, rsi
	call	$_0065
	jmp	$_0125

$_0120: mov	edx, dword ptr [rbp+0x40]
	mov	ecx, dword ptr [rbp+0x48]
	call	$_0048
	cmp	eax, -1
	je	$_0129
	mov	byte ptr [rbp-0x6], al
	xor	r9d, r9d
	mov	r8, qword ptr [rbp+0x50]
	mov	edx, dword ptr [rbp+0x48]
	mov	rcx, rsi
	call	$_0065
	jmp	$_0125

$_0121: mov	ecx, 2032
	call	asmerr@PLT
	jmp	$_0129

$_0122: cmp	byte ptr [rbp-0x7], 5
	jnz	$_0123
	cmp	dword ptr [rbp+0x48], 131
	jz	$_0123
	cmp	byte ptr [rbp-0x5], 0
	jnz	$_0123
	mov	byte ptr [rbp-0x5], 64
$_0123: or	byte ptr [rbp-0x6], 0x04
	mov	al, byte ptr [rbp-0x8]
	shl	al, 3
	or	al, byte ptr [rbp+0x38]
	or	al, byte ptr [rbp-0x7]
	mov	byte ptr [rsi+0x62], al
	mov	al, byte ptr [rbp-0xA]
	shl	al, 1
	add	al, byte ptr [rbp-0x9]
	mov	byte ptr [rbp-0xB], al
	xor	r9d, r9d
	mov	r8, qword ptr [rbp+0x50]
	mov	edx, dword ptr [rbp+0x48]
	mov	rcx, rsi
	call	$_0065
	jmp	$_0125

$_0124: cmp	dword ptr [rbp+0x40], 12
	je	$_0119
	cmp	dword ptr [rbp+0x40], 14
	je	$_0119
	cmp	dword ptr [rbp+0x40], 15
	je	$_0120
	cmp	dword ptr [rbp+0x40], 16
	je	$_0120
	cmp	dword ptr [rbp+0x40], 119
	je	$_0121
	cmp	dword ptr [rbp+0x40], 131
	je	$_0121
	cmp	dword ptr [rbp+0x40], 21
	je	$_0121
	jmp	$_0122

$_0125: cmp	dword ptr [rbp+0x48], 131
	jnz	$_0126
	and	byte ptr [rbp-0x5], 0x07
$_0126: cmp	dword ptr [rbp+0x30], 1
	jnz	$_0127
	mov	al, byte ptr [rbp-0x6]
	shl	al, 3
	mov	cl, byte ptr [rsi+0x61]
	and	cl, 0x07
	or	al, byte ptr [rbp-0x5]
	or	al, cl
	mov	byte ptr [rsi+0x61], al
	mov	al, byte ptr [rbp-0xB]
	mov	cl, al
	mov	dl, al
	shr	al, 2
	and	cl, 0x02
	and	dl, 0x01
	shl	dl, 2
	or	al, cl
	or	al, dl
	or	byte ptr [rsi+0x8], al
	jmp	$_0128

$_0127: cmp	dword ptr [rbp+0x30], 0
	jnz	$_0128
	mov	al, byte ptr [rbp-0x5]
	or	al, byte ptr [rbp-0x6]
	mov	byte ptr [rsi+0x61], al
	mov	al, byte ptr [rbp-0xB]
	or	byte ptr [rsi+0x8], al
$_0128: xor	eax, eax
$_0129: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

segm_override:
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, qword ptr [rbp+0x30]
	mov	rdi, qword ptr [rcx+0x30]
	test	rdi, rdi
	je	$_0136
	cmp	byte ptr [rdi], 2
	jnz	$_0133
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rdi+0x4], 12
	movzx	ebx, byte ptr [r11+rax+0xA]
	imul	eax, ebx, 16
	lea	rcx, [SegAssumeTable+rip]
	cmp	byte ptr [rcx+rax+0x8], 0
	jz	$_0130
	mov	ecx, 2108
	call	asmerr@PLT
	jmp	$_0137

$_0130: test	rsi, rsi
	jz	$_0131
	cmp	byte ptr [rsi+0x63], 2
	jnz	$_0131
	cmp	ebx, 4
	jnc	$_0131
	mov	ecx, 2202
	call	asmerr@PLT
	jmp	$_0137

$_0131: mov	ecx, ebx
	call	GetOverrideAssume@PLT
	test	rsi, rsi
	jz	$_0132
	mov	ecx, dword ptr [rsi+0x4]
	mov	dword ptr [LastRegOverride+rip], ecx
	mov	dword ptr [rsi+0x4], ebx
$_0132: jmp	$_0134

$_0133: mov	rcx, qword ptr [rdi+0x8]
	call	SymFind@PLT
$_0134: test	rax, rax
	jz	$_0136
	cmp	byte ptr [rax+0x18], 4
	jz	$_0135
	cmp	byte ptr [rax+0x18], 3
	jnz	$_0136
$_0135: mov	qword ptr [SegOverride+rip], rax
$_0136: xor	eax, eax
$_0137: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_0138:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	dword ptr [rbp-0xC], 0
	mov	rsi, rcx
	mov	rdi, r8
	imul	ebx, dword ptr [rbp+0x30], 24
	cmp	word ptr [rsi+0xE], 562
	jc	$_0139
	cmp	word ptr [rsi+0xE], 611
	ja	$_0139
	mov	r8, qword ptr [rbp+0x38]
	mov	edx, dword ptr [rbp+0x30]
	mov	rcx, qword ptr [rbp+0x28]
	call	process_branch@PLT
	jmp	$_0189

$_0139: cmp	byte ptr [rdi+0x40], 47
	jne	$_0146
	mov	eax, 4
	movzx	ecx, word ptr [rsi+0xE]
	jmp	$_0144

$_0140: mov	eax, 8
	mov	dword ptr [rbp-0xC], 8
	jmp	$_0145

$_0141: cmp	edx, 1
	jnz	$_0143
	cmp	byte ptr [rsi+0x63], 2
	jnz	$_0142
	test	byte ptr [rsi+0x10], 0x08
	jz	$_0142
	mov	eax, 8
	jmp	$_0143

$_0142: test	byte ptr [rsi+0x10], 0x02
	jz	$_0143
	mov	eax, 2
$_0143: jmp	$_0145

$_0144: cmp	ecx, 963
	jz	$_0140
	cmp	ecx, 987
	jz	$_0140
	cmp	ecx, 979
	jz	$_0140
	cmp	ecx, 967
	jz	$_0140
	cmp	ecx, 643
	jz	$_0140
	cmp	ecx, 1059
	jz	$_0140
	cmp	ecx, 1030
	jz	$_0140
	cmp	ecx, 1154
	jz	$_0140
	cmp	ecx, 713
	jz	$_0141
$_0145: mov	edx, eax
	mov	rcx, rdi
	call	quad_resize@PLT
$_0146: mov	eax, dword ptr [rdi]
	mov	dword ptr [rbp-0x8], eax
	mov	dword ptr [rsi+rbx+0x20], eax
	cmp	dword ptr [rdi+0x8], 0
	jnz	$_0147
	cmp	dword ptr [rdi+0xC], 0
	jz	$_0148
$_0147: call	EmitConstError@PLT
	jmp	$_0189

$_0148: mov	edx, dword ptr [rdi+0x4]
	xor	ecx, ecx
	add	eax, -2147483648
	adc	edx, 0
	test	edx, edx
	seta	cl
	cmp	dword ptr [rbp-0xC], 0
	jnz	$_0149
	cmp	byte ptr [rsi+0x63], 2
	jnz	$_0150
	cmp	word ptr [rsi+0xE], 713
	jnz	$_0150
	cmp	dword ptr [rbp+0x30], 1
	jnz	$_0150
	test	byte ptr [rsi+0x10], 0x08
	jz	$_0150
	test	ecx, ecx
	jnz	$_0149
	test	byte ptr [rdi+0x43], 0x02
	jz	$_0150
	cmp	byte ptr [rdi+0x40], 7
	jz	$_0149
	cmp	byte ptr [rdi+0x40], 71
	jnz	$_0150
$_0149: mov	dword ptr [rsi+rbx+0x10], 524288
	mov	eax, dword ptr [rdi+0x4]
	mov	dword ptr [rsi+rbx+0x24], eax
	xor	eax, eax
	jmp	$_0189

$_0150: mov	eax, dword ptr [rdi]
	mov	edx, dword ptr [rdi+0x4]
	add	eax, 0
	adc	edx, 1
	cmp	edx, 1
	jbe	$_0152
	cmp	byte ptr [rsi+0x63], 1
	jc	$_0151
	cmp	word ptr [rsi+0xE], 1030
	jnz	$_0151
	cmp	dword ptr [rbp+0x30], 1
	jnz	$_0151
	cmp	dword ptr [rsi+0x10], 2048
	jnz	$_0151
	mov	dword ptr [rsi+rbx+0x10], 524288
	mov	eax, dword ptr [rdi+0x4]
	mov	dword ptr [rsi+rbx+0x24], eax
	xor	eax, eax
	jmp	$_0189

$_0151: call	EmitConstError@PLT
	jmp	$_0189

$_0152: test	byte ptr [rdi+0x43], 0x02
	je	$_0160
	or	byte ptr [rsi+0x66], 0x08
	mov	r8, qword ptr [rdi+0x60]
	movzx	edx, byte ptr [rdi+0x42]
	movzx	ecx, byte ptr [rdi+0x40]
	call	SizeFromMemtype
	jmp	$_0158

$_0153: mov	dword ptr [rbp-0x4], 65536
	jmp	$_0159

$_0154: mov	dword ptr [rbp-0x4], 131072
	jmp	$_0159

$_0155: mov	dword ptr [rbp-0x4], 262144
	jmp	$_0159

$_0156: cmp	byte ptr [rsi+0x63], 2
	jnz	$_0157
	cmp	byte ptr [rdi+0x40], 39
	jnz	$_0157
	cmp	dword ptr [rbp-0x8], 0
	jnz	$_0157
	cmp	dword ptr [rdi+0x4], 0
	jnz	$_0157
	mov	dword ptr [rbp-0x4], 524288
	mov	dword ptr [rsi+rbx+0x24], 0
	jmp	$_0159

$_0157: mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0189

	jmp	$_0159

$_0158: cmp	rax, 1
	jz	$_0153
	cmp	rax, 2
	jz	$_0154
	cmp	rax, 4
	jz	$_0155
	cmp	rax, 8
	jz	$_0156
	jmp	$_0157

$_0159: jmp	$_0163

$_0160: movsx	eax, byte ptr [rbp-0x8]
	cmp	eax, dword ptr [rbp-0x8]
	jnz	$_0161
	mov	dword ptr [rbp-0x4], 65536
	jmp	$_0163

$_0161: cmp	dword ptr [rbp-0x8], 65535
	jg	$_0162
	cmp	dword ptr [rbp-0x8], -65535
	jl	$_0162
	mov	dword ptr [rbp-0x4], 131072
	jmp	$_0163

$_0162: mov	dword ptr [rbp-0x4], 262144
$_0163: jmp	$_0186

$_0164: cmp	dword ptr [rdi+0x4], 0
	jne	$_0187
	cmp	byte ptr [ModuleInfo+0x337+rip], 0
	jne	$_0187
	mov	edx, dword ptr [rsi+0x10]
	test	byte ptr [rdi+0x43], 0x02
	jne	$_0177
	cmp	byte ptr [rsi+0x63], 0
	jbe	$_0177
	cmp	edx, 512
	jz	$_0165
	cmp	edx, 1024
	jz	$_0165
	cmp	edx, 2048
	jne	$_0177
$_0165: sub	rdi, 104
	mov	byte ptr [rsi+0x8], 0
	cmp	dword ptr [rbp-0x4], 65536
	jnz	$_0166
	mov	byte ptr [rdi+0x40], 0
	jmp	$_0176

$_0166: mov	eax, dword ptr [rdi+0x68]
	xor	ecx, ecx
	jmp	$_0170

$_0167: inc	ecx
	shr	eax, 8
$_0168: inc	ecx
	shr	eax, 8
$_0169: inc	ecx
	shr	eax, 8
	jmp	$_0174

$_0170: cmp	edx, 512
	jz	$_0171
	test	eax, 0xFFFFFF
	jz	$_0167
$_0171: cmp	edx, 512
	jz	$_0172
	test	eax, 0xFF00FFFF
	jz	$_0168
$_0172: cmp	edx, 512
	jz	$_0173
	test	eax, 0xFFFF00FF
	jz	$_0169
$_0173: cmp	edx, 512
	jnz	$_0174
	test	eax, 0xFF
	jz	$_0169
$_0174: test	ecx, ecx
	jz	$_0175
	mov	dword ptr [rbp-0x4], 65536
	mov	byte ptr [rdi+0x40], 0
	add	dword ptr [rdi], ecx
	adc	dword ptr [rdi+0x4], 0
	mov	dword ptr [rsi+rbx+0x20], eax
	mov	dword ptr [rdi+0x68], eax
	jmp	$_0176

$_0175: mov	dword ptr [rbp-0x4], 262144
	mov	byte ptr [rdi+0x40], 3
$_0176: xor	r9d, r9d
	mov	r8, rdi
	xor	edx, edx
	mov	rcx, rsi
	call	$_0316
$_0177: jmp	$_0187

$_0178: test	byte ptr [rdi+0x43], 0x02
	jnz	$_0179
	cmp	byte ptr [rsi+0x63], 0
	jbe	$_0179
	cmp	dword ptr [rbp-0x4], 131072
	jnz	$_0179
	mov	dword ptr [rbp-0x4], 262144
$_0179: cmp	dword ptr [rbp-0x4], 131072
	jnz	$_0180
	xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	setne	al
	mov	byte ptr [rsi+0xA], al
	jmp	$_0181

$_0180: cmp	dword ptr [rbp-0x4], 262144
	jnz	$_0181
	xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	sete	al
	mov	byte ptr [rsi+0xA], al
$_0181: jmp	$_0187

$_0182: cmp	dword ptr [rbp-0x4], 262144
	jz	$_0183
	mov	dword ptr [rbp-0x4], 131072
	movsx	eax, byte ptr [rbp-0x8]
	movsx	ecx, word ptr [rbp-0x8]
	cmp	eax, ecx
	jnz	$_0183
	mov	dword ptr [rbp-0x4], 65536
$_0183: jmp	$_0187

$_0184: cmp	dword ptr [rbp-0x4], 131072
	jnz	$_0185
	mov	dword ptr [rbp-0x4], 262144
$_0185: jmp	$_0187

$_0186:
	cmp	word ptr [rsi+0xE], 613
	je	$_0164
	cmp	word ptr [rsi+0xE], 768
	je	$_0164
	cmp	word ptr [rsi+0xE], 708
	je	$_0178
	cmp	word ptr [rsi+0xE], 710
	jz	$_0182
	cmp	word ptr [rsi+0xE], 672
	jz	$_0184
$_0187: cmp	dword ptr [rbp+0x30], 1
	jnz	$_0188
	test	byte ptr [rsi+0x60], 0xFFFFFF80
	jnz	$_0188
	test	byte ptr [rsi+0x60], 0x1F
	jz	$_0188
	or	byte ptr [rsi+0x66], 0x01
$_0188: mov	eax, dword ptr [rbp-0x4]
	mov	dword ptr [rsi+rbx+0x10], eax
	xor	eax, eax
$_0189: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

idata_fixup:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	dword ptr [rbp-0x8], 0
	mov	rsi, rcx
	mov	rdi, r8
	imul	ebx, dword ptr [rbp+0x30], 24
	cmp	word ptr [rsi+0xE], 562
	jc	$_0190
	cmp	word ptr [rsi+0xE], 611
	ja	$_0190
	mov	r8, qword ptr [rbp+0x38]
	mov	edx, dword ptr [rbp+0x30]
	mov	rcx, rsi
	call	process_branch@PLT
	jmp	$_0275

$_0190: mov	eax, dword ptr [rdi]
	mov	dword ptr [rsi+rbx+0x20], eax
	mov	rcx, qword ptr [rdi+0x50]
	cmp	byte ptr [rdi+0x42], -2
	jz	$_0191
	mov	al, byte ptr [rdi+0x42]
	mov	byte ptr [rbp-0xD], al
	jmp	$_0197

$_0191: test	rcx, rcx
	jnz	$_0193
	xor	edx, edx
	mov	rcx, rdi
	call	segm_override
	cmp	qword ptr [SegOverride+rip], 0
	jz	$_0192
	mov	rcx, qword ptr [SegOverride+rip]
	call	GetSymOfssize@PLT
	mov	byte ptr [rbp-0xD], al
$_0192: jmp	$_0197

$_0193: cmp	byte ptr [rcx+0x18], 3
	jz	$_0194
	cmp	byte ptr [rcx+0x18], 4
	jz	$_0194
	cmp	dword ptr [rdi+0x38], 252
	jnz	$_0195
$_0194: mov	byte ptr [rbp-0xD], 0
	jmp	$_0197

$_0195: test	byte ptr [rdi+0x43], 0x04
	jz	$_0196
	mov	byte ptr [rbp-0xD], 0
	jmp	$_0197

$_0196: call	GetSymOfssize@PLT
	mov	byte ptr [rbp-0xD], al
$_0197: cmp	dword ptr [rdi+0x38], 253
	jnz	$_0198
	mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0275

$_0198: test	byte ptr [rdi+0x43], 0x02
	jz	$_0199
	test	byte ptr [rdi+0x43], 0x04
	jnz	$_0199
	or	byte ptr [rsi+0x66], 0x08
	cmp	byte ptr [rsi+0x60], -64
	jnz	$_0199
	mov	al, byte ptr [rdi+0x40]
	mov	byte ptr [rsi+0x60], al
$_0199: cmp	byte ptr [rsi+0x60], -64
	jne	$_0220
	cmp	dword ptr [rbp+0x30], 0
	jbe	$_0220
	cmp	byte ptr [rdi+0x42], -2
	jne	$_0220
	mov	rdx, rsi
	mov	ecx, dword ptr [rsi+0x10]
	call	OperandSize
	mov	ecx, dword ptr [rdi+0x38]
	cmp	dword ptr [Parse_Pass+rip], 0
	jbe	$_0206
	cmp	dword ptr [rdi+0x38], -2
	je	$_0206
	jmp	$_0205

$_0200: test	eax, eax
	jz	$_0201
	cmp	eax, 2
	jnc	$_0201
	mov	r8d, 2
	mov	edx, eax
	mov	ecx, 2022
	call	asmerr@PLT
	jmp	$_0275

$_0201: jmp	$_0206

$_0202: test	eax, eax
	jz	$_0204
	cmp	eax, 2
	jc	$_0203
	cmp	byte ptr [rbp-0xD], 0
	jz	$_0204
	cmp	eax, 4
	jnc	$_0204
$_0203: movzx	ecx, byte ptr [rbp-0xD]
	mov	edx, 2
	shl	edx, cl
	mov	r8d, edx
	mov	edx, eax
	mov	ecx, 2022
	call	asmerr@PLT
	jmp	$_0275

$_0204: jmp	$_0206

$_0205: cmp	ecx, 252
	jz	$_0200
	cmp	ecx, 249
	jz	$_0202
	cmp	ecx, 246
	jz	$_0202
	cmp	ecx, 239
	jz	$_0202
	cmp	ecx, 251
	jz	$_0202
$_0206: jmp	$_0219

$_0207: test	byte ptr [rdi+0x43], 0x04
	jnz	$_0208
	cmp	ecx, 242
	jz	$_0208
	cmp	ecx, 235
	jz	$_0208
	cmp	ecx, 243
	jz	$_0208
	cmp	ecx, 236
	jnz	$_0209
$_0208: mov	byte ptr [rsi+0x60], 0
$_0209: jmp	$_0220

$_0210: test	byte ptr [rdi+0x43], 0x04
	jnz	$_0211
	cmp	byte ptr [rsi+0x63], 0
	jz	$_0211
	cmp	ecx, 245
	jz	$_0211
	cmp	ecx, 238
	jnz	$_0212
$_0211: mov	byte ptr [rsi+0x60], 1
$_0212: jmp	$_0220

$_0213: mov	byte ptr [rsi+0x60], 3
	jmp	$_0220

$_0214: cmp	byte ptr [rbp-0xD], 2
	jnz	$_0218
	cmp	ecx, 261
	jz	$_0215
	cmp	ecx, 260
	jz	$_0215
	cmp	word ptr [rsi+0xE], 713
	jnz	$_0216
	test	byte ptr [rsi+0x10], 0x08
	jz	$_0216
$_0215: mov	byte ptr [rsi+0x60], 7
	jmp	$_0218

$_0216: cmp	ecx, 244
	jz	$_0217
	cmp	ecx, 237
	jnz	$_0218
$_0217: mov	byte ptr [rsi+0x60], 3
$_0218: jmp	$_0220

$_0219: cmp	eax, 1
	je	$_0207
	cmp	eax, 2
	jz	$_0210
	cmp	eax, 4
	jz	$_0213
	cmp	eax, 8
	jz	$_0214
$_0220: cmp	byte ptr [rsi+0x60], -64
	jne	$_0241
	test	byte ptr [rdi+0x43], 0x04
	jz	$_0225
	cmp	byte ptr [rdi+0x40], -64
	jz	$_0221
	mov	al, byte ptr [rdi+0x40]
	mov	byte ptr [rsi+0x60], al
	jmp	$_0224

$_0221:
	cmp	word ptr [rsi+0xE], 710
	jnz	$_0222
	mov	byte ptr [rsi+0x60], 1
	jmp	$_0224

$_0222: mov	ecx, 1
	xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	sete	al
	cmp	byte ptr [rsi+0xA], al
	jnz	$_0223
	mov	ecx, 3
$_0223: mov	byte ptr [rsi+0x60], cl
$_0224: jmp	$_0241

$_0225: movzx	eax, word ptr [rsi+0xE]
	jmp	$_0235

$_0226: cmp	byte ptr [rdi+0x40], -64
	jnz	$_0230
	mov	eax, dword ptr [rdi+0x38]
	jmp	$_0229

$_0227: mov	byte ptr [rdi+0x40], 0
	jmp	$_0230

$_0228: mov	byte ptr [rdi+0x40], 3
	jmp	$_0230

$_0229: cmp	eax, -2
	jz	$_0227
	cmp	eax, 242
	jz	$_0227
	cmp	eax, 235
	jz	$_0227
	cmp	eax, 243
	jz	$_0227
	cmp	eax, 236
	jz	$_0227
	cmp	eax, 244
	jz	$_0228
	cmp	eax, 239
	jz	$_0228
	cmp	eax, 251
	jz	$_0228
$_0230: cmp	byte ptr [rdi+0x40], -126
	jnz	$_0231
	test	byte ptr [rdi+0x43], 0x02
	jnz	$_0231
	mov	byte ptr [rdi+0x40], -127
$_0231:
	cmp	word ptr [rsi+0xE], 710
	jnz	$_0233
	mov	r8, qword ptr [rdi+0x60]
	movzx	edx, byte ptr [rbp-0xD]
	movzx	ecx, byte ptr [rdi+0x40]
	call	SizeFromMemtype
	cmp	rax, 2
	jnc	$_0232
	mov	byte ptr [rdi+0x40], 1
$_0232: jmp	$_0234

$_0233:
	cmp	word ptr [rsi+0xE], 672
	jnz	$_0234
	mov	r8, qword ptr [rdi+0x60]
	movzx	edx, byte ptr [rbp-0xD]
	movzx	ecx, byte ptr [rdi+0x40]
	call	SizeFromMemtype
	cmp	rax, 4
	jnc	$_0234
	mov	byte ptr [rdi+0x40], 3
$_0234: jmp	$_0236

$_0235: cmp	eax, 710
	je	$_0226
	cmp	eax, 672
	je	$_0226
	cmp	eax, 708
	je	$_0226
$_0236: mov	rcx, qword ptr [rdi+0x50]
	cmp	byte ptr [rdi+0x40], -64
	jz	$_0237
	mov	al, byte ptr [rdi+0x40]
	mov	byte ptr [rsi+0x60], al
	jmp	$_0241

$_0237: cmp	byte ptr [rcx+0x18], 0
	jnz	$_0238
	mov	byte ptr [rsi+0x60], 0
	mov	dword ptr [rbp-0x8], 5
	jmp	$_0241

$_0238: mov	eax, 1
	cmp	byte ptr [rbp-0xD], 2
	jnz	$_0239
	mov	eax, 7
	jmp	$_0240

$_0239: cmp	byte ptr [rbp-0xD], 1
	jnz	$_0240
	mov	eax, 3
$_0240: mov	byte ptr [rsi+0x60], al
$_0241: xor	r8d, r8d
	movzx	edx, byte ptr [rbp-0xD]
	movzx	ecx, byte ptr [rsi+0x60]
	call	SizeFromMemtype
	mov	dword ptr [rbp-0xC], eax
	jmp	$_0253

$_0242: mov	dword ptr [rsi+rbx+0x10], 65536
	mov	byte ptr [rsi+0xA], 0
	jmp	$_0254

$_0243: mov	dword ptr [rsi+rbx+0x10], 131072
	xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	setne	al
	mov	byte ptr [rsi+0xA], al
	jmp	$_0254

$_0244: mov	dword ptr [rsi+rbx+0x10], 262144
	xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	sete	al
	mov	byte ptr [rsi+0xA], al
	jmp	$_0254

$_0245: mov	al, byte ptr [rdi+0x40]
	and	eax, 0x1F
	xor	ecx, ecx
	mov	edx, dword ptr [rdi+0x4]
	cmp	edx, ecx
	jnz	$_0246
	cmp	dword ptr [rdi], 2147483647
$_0246: setg	cl
	cmp	edx, -1
	jnz	$_0247
	cmp	dword ptr [rdi], -2147483648
$_0247: setl	ch
	test	ecx, ecx
	jnz	$_0248
	test	byte ptr [rdi+0x43], 0x02
	jz	$_0249
	cmp	eax, 7
	jnz	$_0249
$_0248: mov	dword ptr [rsi+rbx+0x10], 524288
	mov	eax, dword ptr [rdi+0x4]
	mov	dword ptr [rsi+rbx+0x24], eax
	jmp	$_0252

$_0249: cmp	byte ptr [rbp-0xD], 2
	jnz	$_0251
	cmp	dword ptr [rdi+0x38], 249
	jz	$_0250
	cmp	word ptr [rsi+0xE], 713
	jnz	$_0251
	test	byte ptr [rsi+0x10], 0x08
	jz	$_0251
$_0250: mov	dword ptr [rsi+rbx+0x10], 524288
	mov	eax, dword ptr [rdi+0x4]
	mov	dword ptr [rsi+rbx+0x24], eax
	jmp	$_0252

$_0251: mov	dword ptr [rsi+rbx+0x10], 262144
$_0252: xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	sete	al
	mov	byte ptr [rsi+0xA], al
	jmp	$_0254

$_0253: cmp	eax, 1
	je	$_0242
	cmp	eax, 2
	je	$_0243
	cmp	eax, 4
	je	$_0244
	cmp	eax, 8
	je	$_0245
$_0254: cmp	dword ptr [rdi+0x38], 252
	jnz	$_0255
	mov	dword ptr [rbp-0x4], 8
	jmp	$_0267

$_0255: cmp	byte ptr [rsi+0x60], 0
	jnz	$_0259
	cmp	dword ptr [rdi+0x38], 235
	jz	$_0256
	cmp	dword ptr [rdi+0x38], 236
	jnz	$_0257
$_0256: mov	dword ptr [rbp-0x4], 11
	jmp	$_0258

$_0257: mov	dword ptr [rbp-0x4], 4
$_0258: jmp	$_0267

$_0259: xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	sete	al
	cmp	byte ptr [rsi+0xA], al
	jnz	$_0266
	cmp	dword ptr [rsi+rbx+0x10], 524288
	jnz	$_0261
	cmp	dword ptr [rdi+0x38], -2
	jz	$_0260
	cmp	dword ptr [rdi+0x38], 249
	jnz	$_0261
$_0260: mov	dword ptr [rbp-0x4], 7
	jmp	$_0265

$_0261: cmp	dword ptr [rbp-0xC], 4
	jl	$_0264
	cmp	dword ptr [rdi+0x38], 245
	jz	$_0264
	test	byte ptr [rdi+0x43], 0x02
	jz	$_0262
	cmp	byte ptr [rbp-0xD], 0
	jnz	$_0262
	cmp	byte ptr [rdi+0x40], -126
	jnz	$_0262
	mov	dword ptr [rbp-0x4], 9
	jmp	$_0263

$_0262: mov	dword ptr [rbp-0x4], 6
$_0263: jmp	$_0265

$_0264: mov	dword ptr [rbp-0x4], 5
$_0265: jmp	$_0267

$_0266: mov	dword ptr [rbp-0x4], 5
$_0267: cmp	dword ptr [rbp+0x30], 1
	jnz	$_0268
	cmp	dword ptr [rbp-0xC], 1
	jz	$_0268
	or	byte ptr [rsi+0x66], 0x01
$_0268: xor	edx, edx
	mov	rcx, rdi
	call	segm_override
	cmp	byte ptr [ModuleInfo+0x1BB+rip], 2
	jnz	$_0270
	cmp	dword ptr [rdi+0x38], 249
	jz	$_0269
	cmp	dword ptr [rdi+0x38], 252
	jnz	$_0270
$_0269: mov	rcx, qword ptr [rdi+0x50]
	call	set_frame2
	jmp	$_0271

$_0270: mov	rcx, qword ptr [rdi+0x50]
	call	set_frame
$_0271: mov	r8d, dword ptr [rbp-0x8]
	mov	edx, dword ptr [rbp-0x4]
	mov	rcx, qword ptr [rdi+0x50]
	call	CreateFixup@PLT
	mov	qword ptr [rsi+rbx+0x18], rax
	cmp	dword ptr [rdi+0x38], 246
	jnz	$_0272
	or	byte ptr [rax+0x1B], 0x01
$_0272: cmp	dword ptr [rdi+0x38], 239
	jnz	$_0273
	cmp	dword ptr [rbp-0x4], 6
	jnz	$_0273
	mov	byte ptr [rax+0x18], 12
$_0273: cmp	dword ptr [rdi+0x38], 251
	jnz	$_0274
	cmp	dword ptr [rbp-0x4], 6
	jnz	$_0274
	mov	byte ptr [rax+0x18], 13
$_0274: xor	eax, eax
$_0275: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_0276:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, rcx
	mov	rdi, rdx
	xor	ebx, ebx
	mov	rdx, qword ptr [rdi+0x50]
	cmp	qword ptr [rdi+0x58], 0
	jz	$_0277
	mov	rdx, qword ptr [rdi+0x58]
$_0277: test	byte ptr [rdi+0x43], 0x02
	jz	$_0280
	cmp	qword ptr [rdi+0x60], 0
	jz	$_0280
	mov	rcx, qword ptr [rdi+0x60]
	mov	ebx, dword ptr [rcx+0x50]
	cmp	byte ptr [rcx+0x1C], 0
	jz	$_0278
	or	byte ptr [rsi+0x66], 0x04
	jmp	$_0279

$_0278: and	byte ptr [rsi+0x66], 0xFFFFFFFB
$_0279: jmp	$_0292

$_0280: test	rdx, rdx
	je	$_0290
	cmp	qword ptr [rdx+0x20], 0
	jz	$_0284
	mov	rcx, qword ptr [rdx+0x20]
	mov	ebx, dword ptr [rcx+0x50]
	cmp	byte ptr [rcx+0x1C], 0
	jz	$_0281
	or	byte ptr [rsi+0x66], 0x04
	jmp	$_0282

$_0281: and	byte ptr [rsi+0x66], 0xFFFFFFFB
$_0282: mov	al, byte ptr [rcx+0x38]
	cmp	ebx, 4
	jnz	$_0283
	cmp	al, byte ptr [rsi+0x63]
	jz	$_0283
	mov	byte ptr [rdi+0x42], al
$_0283: jmp	$_0289

$_0284: cmp	byte ptr [rdx+0x19], -61
	jnz	$_0287
	mov	ecx, 129
	cmp	byte ptr [rdx+0x1C], 0
	jz	$_0285
	mov	ecx, 130
$_0285: mov	qword ptr [rbp-0x8], rdx
	xor	r8d, r8d
	movzx	edx, byte ptr [rdx+0x38]
	movzx	ecx, cl
	call	SizeFromMemtype
	mov	ebx, eax
	and	byte ptr [rsi+0x66], 0xFFFFFFFB
	mov	rdx, qword ptr [rbp-0x8]
	cmp	byte ptr [rdx+0x1C], 0
	jz	$_0286
	or	byte ptr [rsi+0x66], 0x04
$_0286: jmp	$_0289

$_0287: test	byte ptr [rdx+0x15], 0x02
	jz	$_0288
	mov	ecx, dword ptr [rdx+0x58]
	mov	eax, dword ptr [rdx+0x50]
	xor	edx, edx
	div	ecx
	mov	ebx, eax
	jmp	$_0289

$_0288: mov	ebx, dword ptr [rdx+0x50]
$_0289: jmp	$_0292

$_0290: mov	cl, byte ptr [ModuleInfo+0x1B5+rip]
	mov	eax, 1
	shl	eax, cl
	test	cl, 0x68
	jz	$_0291
	mov	ebx, 2
$_0291: mov	cl, byte ptr [ModuleInfo+0x1CD+rip]
	mov	eax, 2
	shl	eax, cl
	add	ebx, eax
$_0292: test	ebx, ebx
	jz	$_0293
	lea	rdx, [rdi+0x40]
	mov	ecx, ebx
	call	MemtypeFromSize
$_0293: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_0294:
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rsi, rcx
	cmp	word ptr [rsi+0xE], 742
	jnz	$_0295
	jmp	$_0315

$_0295: movzx	eax, byte ptr [rbp+0x30]
	cmp	al, -64
	je	$_0315
	cmp	al, -60
	je	$_0315
	cmp	al, -127
	je	$_0315
	cmp	al, -126
	je	$_0315
	mov	byte ptr [rsi+0x60], al
	mov	rbx, qword ptr [rsi+0x58]
	cmp	byte ptr [rsi+0x63], 0
	jbe	$_0307
	cmp	al, 1
	jz	$_0296
	cmp	al, 65
	jnz	$_0297
$_0296: mov	byte ptr [rsi+0xA], 1
	jmp	$_0306

$_0297: mov	ah, al
	and	al, 0xFFFFFFC0
	and	ah, 0x1F
	cmp	al, -128
	jnc	$_0306
	cmp	ah, 7
	jne	$_0306
	movzx	eax, word ptr [rsi+0xE]
	jmp	$_0305

$_0298: jmp	$_0306

$_0299: movzx	eax, byte ptr [rbx]
	imul	eax, eax, 12
	lea	rcx, [opnd_clstab+rip]
	cmp	dword ptr [rcx+rax], 6323968
	je	$_0306
	test	byte ptr [rbx+0x4], 0x07
	jne	$_0306
	test	byte ptr [rbx+0x5], 0xFFFFFFFF
	jz	$_0303
	movzx	eax, word ptr [rsi+0xE]
	jmp	$_0301

$_0300: or	byte ptr [rsi+0x8], 0x08
	jmp	$_0302

$_0301: cmp	eax, 1040
	jz	$_0300
	cmp	eax, 1041
	jz	$_0300
	cmp	eax, 1240
	jz	$_0300
	cmp	eax, 1241
	jz	$_0300
	cmp	eax, 1058
	jz	$_0300
	cmp	eax, 1403
	jz	$_0300
	cmp	eax, 1404
	jz	$_0300
	cmp	eax, 1493
	jz	$_0300
	cmp	eax, 1494
	jz	$_0300
	cmp	eax, 1426
	jz	$_0300
$_0302: jmp	$_0304

$_0303: or	byte ptr [rsi+0x8], 0x08
$_0304: jmp	$_0306

$_0305: cmp	eax, 708
	je	$_0298
	cmp	eax, 709
	je	$_0298
	cmp	eax, 725
	je	$_0298
	cmp	eax, 1324
	je	$_0298
	cmp	eax, 1325
	je	$_0298
	cmp	eax, 1326
	je	$_0298
	cmp	eax, 1327
	je	$_0298
	jmp	$_0299

$_0306: jmp	$_0315

$_0307: mov	ah, al
	and	al, 0xFFFFFFC0
	and	ah, 0x1F
	cmp	al, -128
	jnc	$_0312
	cmp	ah, 3
	jnz	$_0312
	movzx	eax, word ptr [rsi+0xE]
	jmp	$_0310

$_0308: jmp	$_0311

$_0309: mov	byte ptr [rsi+0xA], 1
	jmp	$_0311

$_0310: cmp	eax, 662
	jz	$_0308
	cmp	eax, 663
	jz	$_0308
	cmp	eax, 744
	jz	$_0308
	cmp	eax, 745
	jz	$_0308
	cmp	eax, 746
	jz	$_0308
	cmp	eax, 562
	jz	$_0308
	cmp	eax, 563
	jz	$_0308
	jmp	$_0309

$_0311: jmp	$_0315

$_0312: mov	al, byte ptr [rbp+0x30]
	mov	ah, al
	and	al, 0xFFFFFFC0
	and	ah, 0x1F
	cmp	al, -128
	jnc	$_0315
	cmp	ah, 7
	jnz	$_0315
	movzx	eax, byte ptr [rbx]
	imul	eax, eax, 12
	lea	rcx, [opnd_clstab+rip]
	cmp	dword ptr [rcx+rax], 6323968
	jnz	$_0313
	jmp	$_0315

$_0313: test	dword ptr [rbx+0x4], 0xFF07
	jz	$_0314
	jmp	$_0315

$_0314:
	cmp	word ptr [rsi+0xE], 725
	jz	$_0315
	or	byte ptr [rsi+0x8], 0x08
$_0315: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_0316:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 88
	mov	byte ptr [rbp-0x16], 0
	mov	rsi, rcx
	mov	rdi, r8
	imul	ebx, dword ptr [rbp+0x30], 24
	mov	rax, qword ptr [rdi]
	mov	qword ptr [rsi+rbx+0x20], rax
	mov	dword ptr [rsi+rbx+0x10], 4202240
	mov	rax, qword ptr [rdi+0x50]
	mov	qword ptr [rbp-0x8], rax
	mov	rdx, rsi
	mov	rcx, rdi
	call	segm_override
	mov	al, byte ptr [rdi+0x40]
	mov	ah, al
	and	ah, 0xFFFFFFC0
	cmp	al, -61
	jnz	$_0317
	mov	rdx, rdi
	mov	rcx, rsi
	call	$_0276
	jmp	$_0319

$_0317: cmp	ah, -128
	jnz	$_0319
	cmp	byte ptr [rdi+0x42], -2
	jnz	$_0318
	cmp	qword ptr [rbp-0x8], 0
	jz	$_0318
	mov	rcx, qword ptr [rbp-0x8]
	call	GetSymOfssize@PLT
	mov	byte ptr [rdi+0x42], al
$_0318: mov	r8, qword ptr [rdi+0x60]
	movzx	edx, byte ptr [rdi+0x42]
	movzx	ecx, byte ptr [rdi+0x40]
	call	SizeFromMemtype
	mov	ecx, eax
	lea	rdx, [rdi+0x40]
	call	MemtypeFromSize
$_0319: movzx	edx, byte ptr [rdi+0x40]
	mov	rcx, rsi
	call	$_0294
	mov	rcx, qword ptr [rdi+0x58]
	test	rcx, rcx
	jz	$_0321
	cmp	byte ptr [rcx+0x19], -60
	jnz	$_0320
	cmp	byte ptr [rdi+0x40], -64
	jnz	$_0320
	lea	rdx, [rbp-0x15]
	mov	ecx, dword ptr [rcx+0x50]
	call	MemtypeFromSize
	test	eax, eax
	jnz	$_0320
	movzx	edx, byte ptr [rbp-0x15]
	mov	rcx, rsi
	call	$_0294
$_0320: mov	rcx, qword ptr [rdi+0x58]
	cmp	byte ptr [rcx+0x18], 0
	jnz	$_0321
	or	byte ptr [rsi+0x66], 0x40
$_0321: jmp	$_0333

$_0322: cmp	byte ptr [rsi+0x60], -64
	jnz	$_0326
	cmp	byte ptr [ModuleInfo+0x1D6+rip], 0
	jnz	$_0323
	cmp	dword ptr [Parse_Pass+rip], 0
	jbe	$_0323
	cmp	qword ptr [rdi+0x50], 0
	jnz	$_0323
	mov	ecx, 2023
	call	asmerr@PLT
	jmp	$_0405

$_0323: mov	eax, 1
	cmp	byte ptr [rsi+0x63], 2
	jnz	$_0324
	mov	eax, 7
	jmp	$_0325

$_0324: cmp	byte ptr [rsi+0x63], 1
	jnz	$_0325
	mov	eax, 3
$_0325: mov	byte ptr [rdi+0x40], al
	movzx	edx, al
	mov	rcx, rsi
	call	$_0294
$_0326: xor	r8d, r8d
	movzx	edx, byte ptr [rsi+0x63]
	movzx	ecx, byte ptr [rsi+0x60]
	call	SizeFromMemtype
	cmp	eax, 1
	jz	$_0327
	cmp	eax, 6
	jbe	$_0328
$_0327: cmp	byte ptr [rsi+0x63], 2
	jz	$_0328
	mov	ecx, 2024
	call	asmerr@PLT
	jmp	$_0405

$_0328: cmp	byte ptr [rdi+0x40], -126
	jz	$_0331
	cmp	byte ptr [rsi+0x60], 5
	jz	$_0331
	cmp	byte ptr [rsi+0x60], 9
	jnz	$_0329
	cmp	byte ptr [rsi+0x63], 2
	jz	$_0331
$_0329: cmp	byte ptr [rsi+0x60], 3
	jnz	$_0332
	cmp	byte ptr [rsi+0x63], 0
	jnz	$_0330
	cmp	byte ptr [rdi+0x42], 1
	jnz	$_0331
$_0330: cmp	byte ptr [rsi+0x63], 1
	jnz	$_0332
	cmp	byte ptr [rdi+0x42], 0
	jnz	$_0332
$_0331: or	byte ptr [rsi+0x66], 0x04
$_0332: jmp	$_0334

$_0333:
	cmp	word ptr [rsi+0xE], 563
	je	$_0322
	cmp	word ptr [rsi+0xE], 562
	je	$_0322
$_0334: mov	al, byte ptr [rsi+0x60]
	and	eax, 0x80
	jne	$_0347
	mov	al, byte ptr [rsi+0x60]
	and	eax, 0x3F
	cmp	eax, 63
	jnz	$_0335
	mov	dword ptr [rsi+rbx+0x10], 16384
	jmp	$_0346

$_0335: mov	al, byte ptr [rsi+0x60]
	and	eax, 0x1F
	mov	ecx, dword ptr [rsi+rbx+0x10]
	jmp	$_0344

$_0336: mov	ecx, 256
	jmp	$_0345

$_0337: mov	ecx, 512
	jmp	$_0345

$_0338: mov	ecx, 1024
	jmp	$_0345

$_0339: mov	ecx, 2097152
	jmp	$_0345

$_0340: mov	ecx, 2048
	jmp	$_0345

$_0341: mov	ecx, 4194304
	jmp	$_0345

$_0342: mov	ecx, 4096
	jmp	$_0345

$_0343: mov	ecx, 8192
	jmp	$_0345

$_0344: cmp	eax, 0
	jz	$_0336
	cmp	eax, 1
	jz	$_0337
	cmp	eax, 3
	jz	$_0338
	cmp	eax, 5
	jz	$_0339
	cmp	eax, 7
	jz	$_0340
	cmp	eax, 9
	jz	$_0341
	cmp	eax, 15
	jz	$_0342
	cmp	eax, 31
	jz	$_0343
$_0345: mov	dword ptr [rsi+rbx+0x10], ecx
$_0346: jmp	$_0353

$_0347: cmp	byte ptr [rsi+0x60], -64
	jnz	$_0353
	movzx	eax, word ptr [rsi+0xE]
	jmp	$_0352

$_0348: cmp	qword ptr [rdi+0x50], 0
	jnz	$_0349
	mov	ecx, 2023
	call	asmerr@PLT
	jmp	$_0405

$_0349: jmp	$_0353

$_0350: cmp	byte ptr [rdi+0x40], -60
	jnz	$_0351
	mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0405

$_0351: jmp	$_0353

$_0352: cmp	eax, 706
	jz	$_0348
	cmp	eax, 707
	jz	$_0348
	cmp	eax, 708
	jz	$_0350
	cmp	eax, 709
	jz	$_0350
$_0353: mov	rax, qword ptr [rdi+0x18]
	mov	ecx, 4294967294
	test	rax, rax
	jz	$_0354
	mov	ecx, dword ptr [rax+0x4]
$_0354: mov	dword ptr [rbp-0x10], ecx
	mov	rax, qword ptr [rdi+0x20]
	mov	edx, 4294967294
	test	rax, rax
	jz	$_0355
	mov	edx, dword ptr [rax+0x4]
$_0355: mov	dword ptr [rbp-0xC], edx
	cmp	ecx, -2
	jz	$_0360
	lea	r11, [SpecialTable+rip]
	imul	eax, ecx, 12
	mov	eax, dword ptr [r11+rax]
	mov	cl, byte ptr [rsi+0x63]
	test	eax, 0x4
	jz	$_0356
	cmp	cl, 1
	jz	$_0358
$_0356: test	eax, 0x8
	jz	$_0357
	cmp	cl, 2
	jz	$_0358
$_0357: test	eax, 0x2
	jz	$_0359
	test	cl, cl
	jnz	$_0359
$_0358: mov	byte ptr [rsi+0x9], 0
	jmp	$_0360

$_0359: mov	byte ptr [rsi+0x9], 1
	test	eax, 0x2
	jz	$_0360
	cmp	cl, 2
	jnz	$_0360
	mov	ecx, 2085
	call	asmerr@PLT
	jmp	$_0405

$_0360: cmp	dword ptr [rbp-0xC], -2
	je	$_0381
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp-0xC], 12
	mov	eax, dword ptr [r11+rax]
	mov	cl, byte ptr [rsi+0x63]
	test	eax, 0x4
	jz	$_0361
	cmp	cl, 1
	jz	$_0363
$_0361: test	eax, 0x8
	jz	$_0362
	cmp	cl, 2
	jz	$_0363
$_0362: test	eax, 0x2
	jz	$_0364
	test	cl, cl
	jnz	$_0364
$_0363: mov	byte ptr [rsi+0x9], 0
	jmp	$_0365

$_0364: mov	byte ptr [rsi+0x9], 1
$_0365: mov	rax, qword ptr [rsi+0x58]
	mov	cl, byte ptr [rax+0x3]
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp-0xC], 12
	cmp	byte ptr [r11+rax+0xA], 4
	jnz	$_0368
	test	cl, 0x08
	jnz	$_0368
	cmp	byte ptr [rdi+0x41], 0
	jz	$_0366
	xor	edx, edx
	mov	ecx, dword ptr [rbp-0xC]
	call	GetResWName@PLT
	mov	rdx, rax
	mov	ecx, 2031
	call	asmerr@PLT
	jmp	$_0367

$_0366: mov	ecx, 2029
	call	asmerr@PLT
$_0367: jmp	$_0405

$_0368: mov	cl, byte ptr [rsi+0x63]
	test	cl, cl
	jnz	$_0369
	cmp	byte ptr [rsi+0x9], 1
	jz	$_0370
$_0369: cmp	cl, 2
	jz	$_0370
	cmp	cl, 1
	jnz	$_0380
	cmp	byte ptr [rsi+0x9], 0
	jnz	$_0380
$_0370: mov	eax, dword ptr [ModuleInfo+0x1C0+rip]
	and	eax, 0xF0
	cmp	eax, 48
	jc	$_0378
	movzx	eax, byte ptr [rdi+0x41]
	jmp	$_0376

$_0371: jmp	$_0377

$_0372: mov	byte ptr [rbp-0x16], 64
	jmp	$_0377

$_0373: mov	byte ptr [rbp-0x16], -128
	jmp	$_0377

$_0374: mov	byte ptr [rbp-0x16], -64
	jmp	$_0377

$_0375: mov	ecx, 2083
	call	asmerr@PLT
	jmp	$_0405

	jmp	$_0377

$_0376: cmp	eax, 0
	jz	$_0371
	cmp	eax, 1
	jz	$_0371
	cmp	eax, 2
	jz	$_0372
	cmp	eax, 4
	jz	$_0373
	cmp	eax, 8
	jz	$_0374
	jmp	$_0375

$_0377: jmp	$_0379

$_0378: mov	ecx, 2085
	call	asmerr@PLT
	jmp	$_0405

$_0379: jmp	$_0381

$_0380: cmp	byte ptr [rdi+0x41], 0
	jz	$_0381
	mov	ecx, 2032
	call	asmerr@PLT
	jmp	$_0405

$_0381: cmp	dword ptr [rbp+0x40], 0
	je	$_0399
	mov	byte ptr [rbp-0x17], 0
	mov	dword ptr [rbp-0x1C], 0
	test	byte ptr [rdi+0x43], 0x04
	jz	$_0383
	xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	sete	al
	cmp	byte ptr [rsi+0x9], al
	jnz	$_0382
	inc	byte ptr [rbp-0x17]
$_0382: jmp	$_0386

$_0383: cmp	qword ptr [rbp-0x8], 0
	jz	$_0384
	mov	rcx, qword ptr [rbp-0x8]
	call	GetSymOfssize@PLT
	mov	byte ptr [rbp-0x17], al
	jmp	$_0386

$_0384: cmp	qword ptr [SegOverride+rip], 0
	jz	$_0385
	mov	rcx, qword ptr [SegOverride+rip]
	call	GetSymOfssize@PLT
	mov	byte ptr [rbp-0x17], al
	jmp	$_0386

$_0385: mov	al, byte ptr [rsi+0x63]
	mov	byte ptr [rbp-0x17], al
$_0386: cmp	dword ptr [rbp-0x10], -2
	jnz	$_0393
	cmp	dword ptr [rbp-0xC], -2
	jnz	$_0393
	mov	al, byte ptr [rbp-0x17]
	cmp	byte ptr [rsi+0x63], al
	setne	al
	mov	byte ptr [rsi+0x9], al
	cmp	byte ptr [rbp-0x17], 2
	jz	$_0387
	cmp	byte ptr [rsi+0x63], 2
	jnz	$_0390
$_0387: cmp	qword ptr [rdi+0x30], 0
	jz	$_0388
	mov	rax, qword ptr [ModuleInfo+0x200+rip]
	cmp	qword ptr [SegOverride+rip], rax
	jz	$_0388
	mov	dword ptr [rbp-0x1C], 6
	jmp	$_0389

$_0388: mov	dword ptr [rbp-0x1C], 3
$_0389: jmp	$_0392

$_0390: cmp	byte ptr [rbp-0x17], 0
	jz	$_0391
	mov	dword ptr [rbp-0x1C], 6
	jmp	$_0392

$_0391: mov	dword ptr [rbp-0x1C], 5
$_0392: jmp	$_0396

$_0393: cmp	byte ptr [rbp-0x17], 2
	jnz	$_0394
	mov	dword ptr [rbp-0x1C], 6
	jmp	$_0396

$_0394: xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	sete	al
	cmp	byte ptr [rsi+0x9], al
	jnz	$_0395
	mov	dword ptr [rbp-0x1C], 6
	jmp	$_0396

$_0395: mov	dword ptr [rbp-0x1C], 5
	cmp	byte ptr [rbp-0x17], 0
	jz	$_0396
	cmp	dword ptr [Parse_Pass+rip], 1
	jnz	$_0396
	mov	rax, qword ptr [rbp-0x8]
	mov	rdx, qword ptr [rax+0x8]
	mov	ecx, 8007
	call	asmerr@PLT
$_0396: cmp	dword ptr [rbp-0x1C], 6
	jnz	$_0398
	cmp	dword ptr [rdi+0x38], 239
	jnz	$_0397
	mov	dword ptr [rbp-0x1C], 12
	jmp	$_0398

$_0397: cmp	dword ptr [rdi+0x38], 251
	jnz	$_0398
	mov	dword ptr [rbp-0x1C], 13
$_0398:
	cmp	word ptr [rsi+0xE], 775
	jz	$_0399
	cmp	word ptr [rsi+0xE], 776
	jz	$_0399
	xor	r8d, r8d
	mov	edx, dword ptr [rbp-0x1C]
	mov	rcx, qword ptr [rbp-0x8]
	call	CreateFixup@PLT
	mov	qword ptr [rsi+rbx+0x18], rax
$_0399: cmp	dword ptr [rdi+0x4], 0
	jz	$_0402
	cmp	dword ptr [rdi+0x4], -1
	jnz	$_0400
	cmp	dword ptr [rdi], 0
	jl	$_0402
$_0400: cmp	byte ptr [rsi+0x63], 2
	jnz	$_0401
	test	byte ptr [rdi+0x43], 0x01
	jz	$_0402
$_0401: call	EmitConstError@PLT
	jmp	$_0405

$_0402: mov	rax, qword ptr [rbp-0x8]
	mov	qword ptr [rsp+0x28], rax
	mov	eax, dword ptr [rbp-0x10]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, dword ptr [rbp-0xC]
	movzx	r8d, byte ptr [rbp-0x16]
	mov	edx, dword ptr [rbp+0x30]
	mov	rcx, rsi
	call	$_0083
	cmp	eax, -1
	jnz	$_0403
	jmp	$_0405

$_0403: mov	rcx, qword ptr [rsi+rbx+0x18]
	test	rcx, rcx
	jz	$_0404
	mov	al, byte ptr [Frame_Type+rip]
	mov	byte ptr [rcx+0x20], al
	mov	ax, word ptr [Frame_Datum+rip]
	mov	word ptr [rcx+0x22], ax
$_0404: xor	eax, eax
$_0405: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_0406:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, rcx
	mov	rdi, r8
	mov	ebx, edx
	mov	rcx, qword ptr [rdi+0x50]
	test	byte ptr [rdi+0x43], 0x01
	jz	$_0409
	mov	rcx, qword ptr [rdi+0x50]
	test	rcx, rcx
	jz	$_0407
	cmp	byte ptr [rcx+0x18], 5
	jnz	$_0408
$_0407: xor	r9d, r9d
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	$_0316
	jmp	$_0440

$_0408: jmp	$_0439

$_0409: cmp	dword ptr [rdi+0x38], -2
	jz	$_0414
	mov	rcx, qword ptr [rdi+0x30]
	cmp	qword ptr [rdi+0x50], 0
	jnz	$_0411
	test	rcx, rcx
	jz	$_0410
	cmp	byte ptr [rcx], 2
	jnz	$_0411
$_0410: mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	$_0138
	jmp	$_0440

	jmp	$_0413

$_0411:
	cmp	word ptr [rsi+0xE], 742
	jnz	$_0412
	cmp	dword ptr [rdi+0x38], 249
	jnz	$_0412
	mov	r9d, 1
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	$_0316
	jmp	$_0440

$_0412: mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	idata_fixup
	jmp	$_0440

$_0413: jmp	$_0439

$_0414: cmp	qword ptr [rdi+0x50], 0
	jnz	$_0420
	cmp	qword ptr [rdi+0x30], 0
	jz	$_0418
	mov	rcx, qword ptr [rdi+0x30]
	cmp	byte ptr [rcx], 2
	jz	$_0415
	cmp	byte ptr [rsi+0x63], 2
	jnz	$_0416
$_0415: xor	r9d, r9d
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	$_0316
	jmp	$_0440

	jmp	$_0417

$_0416: mov	r9d, 1
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	$_0316
	jmp	$_0440

$_0417: jmp	$_0419

$_0418: mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	$_0138
	jmp	$_0440

$_0419: jmp	$_0439

$_0420: cmp	byte ptr [rcx+0x18], 0
	jne	$_0431
	test	byte ptr [rdi+0x43], 0x02
	jne	$_0431
	cmp	word ptr [rsi+0xE], 562
	jc	$_0421
	cmp	word ptr [rsi+0xE], 611
	ja	$_0421
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	process_branch@PLT
	jmp	$_0440

$_0421: jmp	$_0429

$_0422: mov	eax, dword ptr [ModuleInfo+0x1C0+rip]
	and	eax, 0xF0
	cmp	eax, 0
	jbe	$_0423
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	idata_fixup
	jmp	$_0440

$_0423: jmp	$_0430

$_0424: mov	eax, dword ptr [rsi+0x10]
	and	eax, 0xC000000
	cmp	ebx, 1
	jnz	$_0427
	test	eax, eax
	jnz	$_0427
	mov	rcx, qword ptr [rsi+0x58]
$_0425: movzx	eax, byte ptr [rcx]
	imul	eax, eax, 12
	lea	rdx, [opnd_clstab+rip]
	test	byte ptr [rdx+rax+0x6], 0x07
	jz	$_0426
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	idata_fixup
	jmp	$_0440

$_0426: add	rcx, 8
	test	byte ptr [rcx+0x2], 0x08
	jz	$_0425
$_0427: cmp	ebx, 2
	jnz	$_0428
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	idata_fixup
	jmp	$_0440

$_0428: jmp	$_0430

$_0429:
	cmp	word ptr [rsi+0xE], 708
	je	$_0422
	cmp	word ptr [rsi+0xE], 710
	je	$_0422
	cmp	word ptr [rsi+0xE], 672
	je	$_0422
	jmp	$_0424

$_0430: jmp	$_0439

$_0431: cmp	byte ptr [rcx+0x18], 3
	jz	$_0432
	cmp	byte ptr [rcx+0x18], 4
	jnz	$_0433
$_0432: mov	dword ptr [rdi+0x38], 252
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	idata_fixup
	jmp	$_0440

	jmp	$_0439

$_0433: test	byte ptr [rdi+0x43], 0x04
	jz	$_0434
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	idata_fixup
	jmp	$_0440

$_0434: cmp	byte ptr [rdi+0x40], -127
	jz	$_0435
	cmp	byte ptr [rdi+0x40], -126
	jnz	$_0439
$_0435: xor	eax, eax
	mov	rcx, qword ptr [rdi+0x28]
	test	rcx, rcx
	jz	$_0436
	cmp	byte ptr [rsi+0x63], 2
	jnz	$_0436
	cmp	byte ptr [rcx-0x18], 38
	jnz	$_0436
	inc	eax
$_0436: test	eax, eax
	jnz	$_0437
	cmp	word ptr [rsi+0xE], 742
	jz	$_0437
	cmp	qword ptr [rdi+0x58], 0
	jz	$_0438
$_0437: mov	r9d, 1
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	$_0316
	jmp	$_0440

$_0438: mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	idata_fixup
	jmp	$_0440

$_0439: mov	r9d, 1
	mov	r8, rdi
	mov	edx, ebx
	mov	rcx, rsi
	call	$_0316
$_0440: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_0441:
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rbx, r8
	test	byte ptr [rbx+0x40], 0x20
	jz	$_0442
	mov	qword ptr [rbx+0x10], 0
$_0442: mov	rax, qword ptr [rbx+0x10]
	test	rax, rax
	jz	$_0443
	cmp	dword ptr [rax+0x4], 0
	jnz	$_0443
	mov	ecx, 2047
	call	asmerr@PLT
	jmp	$_0445

$_0443: mov	rax, qword ptr [rcx+0x58]
	mov	al, byte ptr [rax+0x6]
	and	eax, 0xF7
	cmp	eax, 194
	jnz	$_0444
	test	edx, edx
	jnz	$_0444
	cmp	dword ptr [rbx], 0
	jnz	$_0444
	xor	eax, eax
	jmp	$_0445

$_0444: mov	r8, rbx
	call	$_0138
$_0445: leave
	pop	rbx
	ret

$_0446:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	rsi, rcx
	mov	rdi, r8
	imul	ebx, dword ptr [rbp+0x30], 24
	imul	eax, dword ptr [rbp+0x30], 104
	mov	rax, qword ptr [rdi+rax+0x18]
	mov	eax, dword ptr [rax+0x4]
	mov	dword ptr [rbp-0x4], eax
	lea	r11, [SpecialTable+rip]
	imul	eax, eax, 12
	movzx	eax, byte ptr [r11+rax+0xA]
	mov	dword ptr [rbp-0x8], eax
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp-0x4], 12
	mov	eax, dword ptr [r11+rax]
	mov	dword ptr [rbp-0xC], eax
	mov	dword ptr [rsi+rbx+0x10], eax
	cmp	eax, 16
	jz	$_0447
	cmp	eax, 32
	jnz	$_0448
$_0447: cmp	dword ptr [rbp-0x8], 15
	jg	$_0449
$_0448: test	eax, 0x40
	jz	$_0453
$_0449: mov	byte ptr [rsi+0xB], 1
	cmp	eax, 64
	jnz	$_0450
	or	byte ptr [rsi+0xD], 0x10
$_0450: cmp	dword ptr [rbp-0x8], 15
	jle	$_0452
	mov	ecx, dword ptr [rbp+0x40]
	mov	edx, 1
	shl	edx, cl
	cmp	eax, 64
	jnz	$_0451
	cmp	dword ptr [rbp-0x8], 23
	jle	$_0451
	or	edx, 0x80
$_0451: or	byte ptr [rsi+0xD], dl
	jmp	$_0453

$_0452: cmp	eax, 64
	jnz	$_0453
	cmp	dword ptr [rbp-0x8], 7
	jle	$_0453
	or	byte ptr [rsi+0xD], 0x40
$_0453: test	eax, 0x1
	jz	$_0459
	cmp	eax, 8388609
	jz	$_0454
	and	byte ptr [rsi+0x66], 0xFFFFFFFE
$_0454: cmp	byte ptr [rsi+0x63], 2
	jnz	$_0456
	cmp	dword ptr [rbp-0x8], 4
	jl	$_0456
	cmp	dword ptr [rbp-0x8], 7
	jg	$_0456
	mov	eax, dword ptr [rbp-0x4]
	imul	eax, eax, 12
	lea	rcx, [SpecialTable+rip]
	cmp	word ptr [rcx+rax+0x8], 0
	jnz	$_0455
	or	byte ptr [rsi+0x66], 0x10
	jmp	$_0456

$_0455: or	byte ptr [rsi+0x66], 0x20
$_0456: imul	eax, dword ptr [rbp-0x8], 16
	mov	ecx, 1
	cmp	dword ptr [rbp-0x4], 5
	jl	$_0457
	cmp	dword ptr [rbp-0x4], 8
	jg	$_0457
	mov	ecx, 16
$_0457: lea	rdx, [StdAssumeTable+rip]
	test	byte ptr [rdx+rax+0x8], cl
	jz	$_0458
	mov	ecx, 2108
	call	asmerr@PLT
	jmp	$_0485

$_0458: jmp	$_0480

$_0459: test	eax, 0xF
	jz	$_0464
	or	byte ptr [rsi+0x66], 0x01
	imul	ecx, dword ptr [rbp-0x8], 16
	and	al, 0x0F
	lea	rdx, [StdAssumeTable+rip]
	test	byte ptr [rdx+rcx+0x8], al
	jz	$_0460
	mov	ecx, 2108
	call	asmerr@PLT
	jmp	$_0485

$_0460: test	byte ptr [rbp-0xC], 0x02
	jz	$_0462
	cmp	byte ptr [rsi+0x63], 0
	jbe	$_0461
	mov	byte ptr [rsi+0xA], 1
$_0461: jmp	$_0463

$_0462: cmp	byte ptr [rsi+0x63], 0
	jnz	$_0463
	mov	byte ptr [rsi+0xA], 1
$_0463: jmp	$_0480

$_0464: test	eax, 0xC000000
	jz	$_0469
	cmp	dword ptr [rbp-0x8], 1
	jnz	$_0465
	cmp	word ptr [rsi+0xE], 709
	jnz	$_0465
	lea	rdx, [DS0000+rip]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0485

$_0465: cmp	dword ptr [Parse_Pass+rip], 1
	jnz	$_0468
	cmp	word ptr [rsi+0xE], 672
	jnz	$_0466
	cmp	byte ptr [rsi+0x63], 0
	jz	$_0467
$_0466:
	cmp	word ptr [rsi+0xE], 710
	jnz	$_0468
	cmp	byte ptr [rsi+0x63], 0
	jbe	$_0468
$_0467: mov	ecx, 8021
	call	asmerr@PLT
$_0468: jmp	$_0480

$_0469: test	eax, 0x10000000
	jz	$_0472
	imul	eax, dword ptr [rbp+0x30], 104
	mov	eax, dword ptr [rdi+rax]
	mov	dword ptr [rbp-0x8], eax
	cmp	eax, 7
	jbe	$_0470
	mov	ecx, 2032
	call	asmerr@PLT
	jmp	$_0485

$_0470: or	byte ptr [rsi+0x61], al
	test	eax, eax
	jz	$_0471
	mov	dword ptr [rsi+rbx+0x10], 536870912
$_0471: xor	eax, eax
	jmp	$_0485

	jmp	$_0480

$_0472: test	eax, 0x2000000
	je	$_0480
	cmp	word ptr [rsi+0xE], 713
	jz	$_0474
	cmp	word ptr [rsi+0xE], 708
	jnz	$_0473
	mov	ecx, 2151
	call	asmerr@PLT
	jmp	$_0485

$_0473: mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0485

$_0474: cmp	dword ptr [rbp-0x8], 32
	jl	$_0478
	or	byte ptr [rsi+0x64], 0x04
	mov	eax, dword ptr [ModuleInfo+0x1C0+rip]
	and	eax, 0xF0
	cmp	eax, 96
	jc	$_0477
	mov	eax, 3
	cmp	dword ptr [rbp-0x8], 37
	jle	$_0475
	mov	eax, 6
$_0475: mov	ecx, 5
	cmp	dword ptr [rbp-0x8], 37
	jle	$_0476
	mov	ecx, 7
$_0476: mov	r8d, ecx
	mov	edx, eax
	mov	ecx, 3004
	call	asmerr@PLT
	jmp	$_0485

$_0477: jmp	$_0479

$_0478: cmp	dword ptr [rbp-0x8], 16
	jl	$_0479
	or	byte ptr [rsi+0x64], 0x01
$_0479: and	dword ptr [rbp-0x8], 0x0F
$_0480: imul	eax, dword ptr [rbp-0x4], 12
	lea	rcx, [SpecialTable+rip]
	movzx	eax, word ptr [rcx+rax+0x8]
	and	eax, 0xF0
	cmp	eax, 112
	jnz	$_0481
	or	byte ptr [rsi+0x8], 0x40
	test	byte ptr [rbp-0xC], 0x08
	jz	$_0481
	or	byte ptr [rsi+0x8], 0x08
$_0481: cmp	dword ptr [rbp+0x30], 0
	jnz	$_0482
	mov	eax, dword ptr [rbp-0x8]
	mov	ecx, eax
	and	eax, 0x08
	shr	eax, 3
	or	byte ptr [rsi+0x8], al
	and	ecx, 0x07
	or	ecx, 0xC0
	or	byte ptr [rsi+0x61], cl
	jmp	$_0484

$_0482:
	cmp	word ptr [rsi+0xE], 774
	jnz	$_0483
	test	dword ptr [rsi+0x10], 0x80
	jz	$_0483
	test	byte ptr [rsi+0x10], 0x01
	jnz	$_0483
	mov	eax, dword ptr [rbp-0x8]
	mov	ecx, eax
	and	eax, 0x08
	shr	eax, 3
	or	byte ptr [rsi+0x8], al
	and	ecx, 0x07
	and	byte ptr [rsi+0x61], 0xFFFFFFC0
	or	byte ptr [rsi+0x61], cl
	jmp	$_0484

$_0483: mov	eax, dword ptr [rbp-0x8]
	mov	ecx, eax
	and	eax, 0x08
	shr	eax, 1
	or	byte ptr [rsi+0x8], al
	and	ecx, 0x07
	and	byte ptr [rsi+0x61], 0xFFFFFFC7
	shl	ecx, 3
	or	byte ptr [rsi+0x61], cl
$_0484: xor	eax, eax
$_0485: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_0486:
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	imul	edx, edx, 16
	lea	rax, [SegAssumeTable+rip]
	mov	rbx, qword ptr [rdx+rax]
	cmp	qword ptr [rcx+0x30], 0
	jz	$_0487
	test	rbx, rbx
	jz	$_0487
	cmp	qword ptr [rcx+0x30], rbx
	jz	$_0487
	call	GetGroup@PLT
	cmp	rax, rbx
	jz	$_0487
	xor	eax, eax
	jmp	$_0488

$_0487: mov	eax, 1
$_0488: leave
	pop	rbx
	ret

$_0489:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	dword ptr [rbp-0x4], 0
	mov	rsi, rcx
	mov	rdi, rdx
	movzx	eax, word ptr [rsi+0xE]
	jmp	$_0518
$C029E:
$C029F:
$_0490: test	dword ptr [rsi+0x10], 0x8010
	jz	$_0491
	and	byte ptr [rsi+0x8], 0xFFFFFFF7
	jmp	$_0534

$C02A2:
$C02A5:
$_0491: cmp	dword ptr [rsi+0x28], 0
	jz	$_0492
	cmp	qword ptr [rdi+0x98], 0
	jnz	$_0492
	cmp	qword ptr [rdi+0xB8], 0
	jz	$_0492
	xor	edx, edx
	mov	rcx, qword ptr [rdi+0xB8]
	call	$_0486
	test	eax, eax
	jnz	$_0492
	mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0520

$_0492: cmp	dword ptr [rsi+0x4], -2
	jz	$_0497
	cmp	qword ptr [rdi+0x98], 0
	jz	$_0496
	cmp	dword ptr [rsi+0x4], 0
	jnz	$_0495
	cmp	dword ptr [LastRegOverride+rip], 3
	jnz	$_0493
	mov	dword ptr [rsi+0x4], -2
	jmp	$_0494

$_0493: mov	eax, dword ptr [LastRegOverride+rip]
	mov	dword ptr [rsi+0x4], eax
$_0494: jmp	$_0496

$_0495: mov	ecx, 2070
	call	asmerr@PLT
$_0496: jmp	$_0498

$_0497: cmp	dword ptr [rsi+0x10], 0
	jz	$_0498
	cmp	qword ptr [rdi+0x30], 0
	jnz	$_0498
	cmp	qword ptr [rdi+0x50], 0
	jz	$_0498
	mov	r8d, 3
	mov	rdx, qword ptr [rdi+0x50]
	mov	rcx, rsi
	call	$_0057
$_0498: cmp	dword ptr [rsi+0x4], 3
	jnz	$_0499
	mov	dword ptr [rsi+0x4], -2
$_0499: jmp	$_0520

$C02B2:
$C02B3:
$_0500: test	dword ptr [rsi+0x10], 0x8010
	jnz	$_0501
	test	dword ptr [rsi+0x28], 0x8010
	jz	$_0502
$_0501: and	byte ptr [rsi+0x8], 0xFFFFFFF7
	jmp	$_0534

$C02B7:
$C02BA:
$_0502: cmp	dword ptr [rsi+0x10], 0
	jz	$_0503
	cmp	qword ptr [rdi+0x30], 0
	jnz	$_0503
	cmp	qword ptr [rdi+0x50], 0
	jz	$_0503
	xor	edx, edx
	mov	rcx, qword ptr [rdi+0x50]
	call	$_0486
	test	eax, eax
	jnz	$_0503
	mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0520

$_0503: cmp	dword ptr [rsi+0x4], -2
	jz	$_0507
	mov	rcx, qword ptr [rdi+0x30]
	test	rcx, rcx
	jz	$_0504
	cmp	byte ptr [rcx], 2
	jnz	$_0504
	cmp	dword ptr [rcx+0x4], 25
	jz	$_0504
	mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0506

$_0504: cmp	qword ptr [rdi+0x98], 0
	jnz	$_0506
	cmp	dword ptr [rsi+0x4], 0
	jnz	$_0505
	mov	dword ptr [rsi+0x4], -2
	jmp	$_0506

$_0505: mov	ecx, 2070
	call	asmerr@PLT
$_0506: jmp	$_0508

$_0507: cmp	dword ptr [rsi+0x28], 0
	jz	$_0508
	cmp	qword ptr [rdi+0x98], 0
	jnz	$_0508
	cmp	qword ptr [rdi+0xB8], 0
	jz	$_0508
	mov	r8d, 3
	mov	rdx, qword ptr [rdi+0xB8]
	mov	rcx, rsi
	call	$_0057
$_0508: cmp	dword ptr [rsi+0x4], 3
	jnz	$_0509
	mov	dword ptr [rsi+0x4], -2
$_0509: jmp	$_0520

$C02C6: cmp	dword ptr [rsi+0x28], 0
	jz	$_0510
	cmp	qword ptr [rdi+0x98], 0
	jnz	$_0510
	cmp	qword ptr [rdi+0xB8], 0
	jz	$_0510
	mov	r8d, 3
	mov	rdx, qword ptr [rdi+0xB8]
	mov	rcx, rsi
	call	$_0057
$_0510: cmp	dword ptr [rsi+0x4], 3
	jnz	$_0511
	mov	dword ptr [rsi+0x4], -2
$_0511: mov	dword ptr [rbp-0x4], 1
	jmp	$_0520
$C02CC:
$C02D0:
$_0512: cmp	dword ptr [rsi+0x10], 0
	jz	$_0513
	cmp	qword ptr [rdi+0x30], 0
	jnz	$_0513
	cmp	qword ptr [rdi+0x50], 0
	jz	$_0513
	mov	r8d, 3
	mov	rdx, qword ptr [rdi+0x50]
	mov	rcx, rsi
	call	$_0057
$_0513: cmp	dword ptr [rsi+0x4], 3
	jnz	$_0514
	mov	dword ptr [rsi+0x4], -2
$_0514: jmp	$_0520

$C02D3: cmp	dword ptr [rsi+0x10], 0
	jz	$_0515
	cmp	qword ptr [rdi+0x30], 0
	jnz	$_0515
	cmp	qword ptr [rdi+0x50], 0
	jz	$_0515
	xor	edx, edx
	mov	rcx, qword ptr [rdi+0x50]
	call	$_0486
	test	eax, eax
	jnz	$_0515
	mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0520

$_0515: cmp	dword ptr [rsi+0x4], -2
	jz	$_0517
	cmp	dword ptr [rsi+0x4], 0
	jnz	$_0516
	mov	dword ptr [rsi+0x4], -2
	jmp	$_0517

$_0516: mov	ecx, 2070
	call	asmerr@PLT
$_0517: jmp	$_0520

$_0518: cmp	eax, 628
	jl	$C02DA
	cmp	eax, 647
	jg	$C02DA
	push	rax
	lea	r11, [$C02D3+rip]
	movzx	eax, byte ptr [r11+rax-(628)+(IT$C02D9-$C02D3)]
	movzx	eax, word ptr [r11+rax*2+($C02D9-$C02D3)]
	sub	r11, rax
	pop	rax
	jmp	r11
	.ALIGN 2
$C02D9:
	.word $C02D3-$C029F
	.word $C02D3-$C02A2
	.word $C02D3-$C02B2
	.word $C02D3-$C02B7
	.word $C02D3-$C02C6
	.word $C02D3-$C02CC
	.word 0
IT$C02D9:
	.byte 1
	.byte 1
	.byte 1
	.byte 0
	.byte 6
	.byte 6
	.byte 6
	.byte 6
	.byte 5
	.byte 5
	.byte 5
	.byte 5
	.byte 3
	.byte 3
	.byte 3
	.byte 2
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.ALIGN 2
$C02DA:
	cmp	eax, 1352
	je	$C029E
	cmp	eax, 1235
	je	$C02A5
	cmp	eax, 1436
	je	$C02B3
	cmp	eax, 1237
	je	$C02BA
	cmp	eax, 1236
	je	$C02D0
	jmp	$C02D3
$C02A8:

$_0520: mov	ecx, dword ptr [rbp-0x4]
	shl	ecx, 2
	mov	rax, qword ptr [rsi+0x58]
	movzx	eax, byte ptr [rax]
	imul	eax, eax, 12
	lea	rdx, [opnd_clstab+rip]
	add	rdx, rax
	cmp	dword ptr [rdx+rcx], 0
	jnz	$_0521
	and	byte ptr [rsi+0x66], 0xFFFFFFFE
	mov	byte ptr [rsi+0xA], 0
$_0521: mov	ebx, dword ptr [rbp-0x4]
	imul	ebx, ebx, 24
	cmp	dword ptr [rdx+rcx], 0
	je	$_0534
	cmp	dword ptr [rsi+rbx+0x10], 0
	je	$_0534
	mov	rdx, rsi
	mov	ecx, dword ptr [rsi+rbx+0x10]
	call	OperandSize
	mov	dword ptr [rbp-0x8], eax
	cmp	dword ptr [rbp-0x8], 0
	jnz	$_0525
	mov	rdx, qword ptr [rsi+rbx+0x18]
	xor	eax, eax
	test	rdx, rdx
	jz	$_0522
	mov	rcx, qword ptr [rdx+0x30]
	cmp	byte ptr [rcx+0x18], 0
	jz	$_0522
	inc	eax
$_0522: test	rdx, rdx
	jz	$_0523
	test	eax, eax
	jz	$_0524
$_0523: mov	ecx, 2023
	call	asmerr@PLT
$_0524: mov	dword ptr [rbp-0x8], 1
$_0525: jmp	$_0533

$_0526: and	byte ptr [rsi+0x66], 0xFFFFFFFE
	mov	byte ptr [rsi+0xA], 0
	jmp	$_0534

$_0527: or	byte ptr [rsi+0x66], 0x01
	xor	eax, eax
	cmp	byte ptr [rsi+0x63], 0
	jz	$_0528
	inc	eax
$_0528: mov	byte ptr [rsi+0xA], al
	jmp	$_0534

$_0529: or	byte ptr [rsi+0x66], 0x01
	xor	eax, eax
	cmp	byte ptr [rsi+0x63], 0
	jnz	$_0530
	inc	eax
$_0530: mov	byte ptr [rsi+0xA], al
	jmp	$_0534

$_0531: cmp	byte ptr [rsi+0x63], 2
	jnz	$_0532
	or	byte ptr [rsi+0x66], 0x01
	mov	byte ptr [rsi+0xA], 0
	mov	byte ptr [rsi+0x8], 8
$_0532: jmp	$_0534

$_0533: cmp	dword ptr [rbp-0x8], 1
	jz	$_0526
	cmp	dword ptr [rbp-0x8], 2
	jz	$_0527
	cmp	dword ptr [rbp-0x8], 4
	jz	$_0529
	cmp	dword ptr [rbp-0x8], 8
	jz	$_0531
$_0534: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_0535:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	rsi, rcx
	mov	rdi, rdx
	mov	ecx, dword ptr [rsi+0x10]
	mov	edx, dword ptr [rsi+0x28]
	mov	dword ptr [rbp-0xC], 0
	mov	dword ptr [rbp-0x4], ecx
	mov	dword ptr [rbp-0x8], edx
	movzx	eax, word ptr [rsi+0xE]
	jmp	$_0626

$C02ED: cmp	ecx, 65536
	jz	$_0536
	cmp	edx, 132
	jz	$_0536
	jmp	$C0368

$_0536: jmp	$_0628
$C02F0:
	cmp	dword ptr [rbp-0x8], 16777218
	jnz	$_0542
	jmp	$_0541

$_0537: jmp	$_0542
$C02F5:
$_0538: and	byte ptr [rsi+0x66], 0xFFFFFFFE
$C02F6:
$_0539: cmp	byte ptr [rsi+0x63], 0
	jz	$_0540
	mov	byte ptr [rsi+0xA], 0
$_0540: jmp	$_0542

$_0541: cmp	ecx, 130
	jz	$_0537
	cmp	ecx, 129
	jz	$_0538
	cmp	ecx, 132
	jz	$_0539
$_0542: jmp	$_0628
$C02F8:
	cmp	ecx, 16777218
	jnz	$_0548
	jmp	$_0547
$C02FB:
$_0543: jmp	$_0548
$C02FD:
$_0544: and	byte ptr [rsi+0x66], 0xFFFFFFFE
$C02FE:
$_0545: cmp	byte ptr [rsi+0x63], 0
	jz	$_0546
	mov	byte ptr [rsi+0xA], 0
$_0546: jmp	$_0548

$_0547: cmp	edx, 130
	jz	$_0543
	cmp	edx, 129
	jz	$_0544
	cmp	edx, 132
	jz	$_0545
$_0548: jmp	$_0628
$C0300:
	jmp	$_0628

$C0301: mov	rcx, qword ptr [rdi+0x50]
	cmp	dword ptr [rsi+0x10], 4202240
	jnz	$_0550
	test	byte ptr [rsi+0x66], 0x40
	jnz	$_0550
	test	rcx, rcx
	jz	$_0549
	cmp	byte ptr [rcx+0x18], 0
	jz	$_0550
$_0549: mov	ecx, 2023
	call	asmerr@PLT
	mov	dword ptr [rbp-0xC], eax
	jmp	$_0628

$_0550: mov	rcx, qword ptr [rdi+0xB8]
	cmp	dword ptr [rdi+0xA4], 1
	jnz	$_0551
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0551
	test	byte ptr [rdi+0xAB], 0x01
	jnz	$_0551
	test	rcx, rcx
	jz	$_0551
	cmp	byte ptr [rcx+0x18], 0
	jnz	$_0551
	mov	dword ptr [rsi+0x28], 65536
	mov	dword ptr [rsi+0x38], 1
$_0551: mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x4]
	call	OperandSize
	cmp	rax, 1
	jbe	$_0552
	or	byte ptr [rsi+0x66], 0x01
$_0552: cmp	dword ptr [rbp-0x8], 8388609
	jnz	$_0553
	and	byte ptr [rsi+0x61], 0xFFFFFFC7
$_0553: jmp	$_0628
$C0311:
$C030F: mov	rdx, rsi
	call	OperandSize
	add	eax, 2
	mov	dword ptr [rbp-0x10], eax
	mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x8]
	call	OperandSize
	mov	dword ptr [rbp-0x14], eax
	cmp	dword ptr [rbp-0x14], 0
	jz	$_0554
	mov	eax, dword ptr [rbp-0x14]
	cmp	dword ptr [rbp-0x10], eax
	jz	$_0554
	mov	ecx, 2024
	call	asmerr@PLT
	jmp	$_0629

$_0554: jmp	$_0628

$C0316: jmp	$_0628
$C0317:
$C0318: and	byte ptr [rsi+0x66], 0xFFFFFFFE
	mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x4]
	call	OperandSize
	mov	dword ptr [rbp-0x10], eax
	mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x8]
	call	OperandSize
	mov	dword ptr [rbp-0x14], eax
	cmp	dword ptr [rbp-0x14], 0
	jnz	$_0556
	cmp	dword ptr [Parse_Pass+rip], 1
	jnz	$_0556
	cmp	dword ptr [rbp-0x10], 2
	jnz	$_0555
	lea	rdx, [DS0001+rip]
	mov	ecx, 8019
	call	asmerr@PLT
	jmp	$_0556

$_0555: mov	ecx, 2023
	call	asmerr@PLT
$_0556: jmp	$_0564
$C031E:
$_0557: cmp	dword ptr [rbp-0x14], 2
	jge	$_0558
	jmp	$_0560

$_0558: cmp	dword ptr [rbp-0x14], 2
	jnz	$_0559
	or	byte ptr [rsi+0x66], 0x01
	jmp	$_0560

$_0559: mov	ecx, 2024
	call	asmerr@PLT
	mov	dword ptr [rbp-0xC], eax
$_0560: xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	sete	al
	mov	byte ptr [rsi+0xA], al
	jmp	$_0565
$C0323:
$_0561: cmp	dword ptr [rbp-0x14], 2
	jl	$_0562
	mov	ecx, 2024
	call	asmerr@PLT
	mov	dword ptr [rbp-0xC], eax
$_0562: xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	setne	al
	mov	byte ptr [rsi+0xA], al
	jmp	$_0565
$C0325:
$_0563: mov	ecx, 2024
	call	asmerr@PLT
	mov	dword ptr [rbp-0xC], eax
	jmp	$_0565

$_0564: cmp	dword ptr [rbp-0x10], 8
	jz	$_0557
	cmp	dword ptr [rbp-0x10], 4
	jz	$_0557
	cmp	dword ptr [rbp-0x10], 2
	jz	$_0561
	jmp	$_0563

$_0565: jmp	$_0628

$C0326: jmp	$_0628

$C0327: mov	byte ptr [rsi+0xA], 0
	jmp	$C0368
$C0328:
$C0329: and	edx, 0x401F00
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_0566
	test	edx, edx
	jnz	$_0567
$_0566: jmp	$C0368

$_0567: mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x8]
	call	OperandSize
	mov	dword ptr [rbp-0x14], eax
	cmp	eax, 2
	jz	$_0568
	test	eax, eax
	jz	$_0568
	mov	ecx, 2024
	call	asmerr@PLT
	jmp	$_0629

$_0568: mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x4]
	call	OperandSize
	mov	dword ptr [rbp-0x10], eax
	cmp	eax, 2
	jz	$_0569
	mov	byte ptr [rsi+0xA], 0
$_0569: jmp	$_0628

$C032F: cmp	dword ptr [rsi+0x40], 0
	jz	$_0572
	mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x4]
	call	OperandSize
	mov	dword ptr [rbp-0x10], eax
	mov	rdx, rsi
	mov	ecx, dword ptr [rsi+0x40]
	call	OperandSize
	cmp	dword ptr [rbp-0x10], 2
	jnz	$_0570
	cmp	eax, 2
	jbe	$_0570
	mov	r8d, eax
	mov	edx, dword ptr [rbp-0x10]
	mov	ecx, 2022
	call	asmerr@PLT
	mov	dword ptr [rbp-0xC], eax
	jmp	$_0628

$_0570: test	byte ptr [rsi+0x42], 0x06
	jz	$_0572
	mov	eax, 262144
	cmp	dword ptr [rbp-0x10], 2
	jnz	$_0571
	mov	eax, 131072
$_0571: mov	dword ptr [rsi+0x40], eax
$_0572: jmp	$C0368

$C0334:
$C0335:
$C0336:
$C0337:
$C0338:
$C033C:
$C033D:
$C033E:
$C033F: jmp	$_0628

$C0342: cmp	edx, 4202240
	jnz	$_0573
	test	byte ptr [rdi+0xAB], 0x01
	jz	$_0573
	mov	ecx, 2023
	call	asmerr@PLT
	jmp	$_0629

$_0573: jmp	$_0628

$C0346: test	ecx, 0x20
	je	$_0628
$C0347: cmp	edx, 4202240
	jnz	$_0574
	or	byte ptr [rsi+0x29], 0x20
$_0574: jmp	$_0628

$C0349: mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x8]
	call	OperandSize
	mov	dword ptr [rbp-0x14], eax
	cmp	eax, 2
	jnc	$_0575
	mov	byte ptr [rsi+0xA], 0
	jmp	$_0577

$_0575: cmp	eax, 2
	jnz	$_0576
	xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	setne	al
	mov	byte ptr [rsi+0xA], al
	jmp	$_0577

$_0576: xor	eax, eax
	cmp	byte ptr [rsi+0x63], al
	sete	al
	mov	byte ptr [rsi+0xA], al
$_0577: jmp	$_0628

$C034D: jmp	$_0628

$C034E: test	byte ptr [rbp-0x1], 0x0C
	jz	$_0580
	mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x8]
	call	OperandSize
	mov	dword ptr [rbp-0x14], eax
	cmp	eax, 2
	jz	$_0578
	cmp	eax, 4
	jz	$_0578
	cmp	eax, 8
	jnz	$_0579
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_0579
$_0578: xor	eax, eax
	jmp	$_0629

$_0579: jmp	$C0368

$_0580: test	byte ptr [rbp-0x5], 0x0C
	jz	$_0583
	mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x4]
	call	OperandSize
	mov	dword ptr [rbp-0x10], eax
	cmp	eax, 2
	jz	$_0581
	cmp	eax, 4
	jz	$_0581
	cmp	eax, 8
	jnz	$_0582
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_0582
$_0581: xor	eax, eax
	jmp	$_0629

$_0582: jmp	$C0368

$_0583: test	dword ptr [rbp-0x4], 0x401F00
	jz	$_0587
	test	dword ptr [rbp-0x8], 0x80
	jz	$_0587
	test	byte ptr [rsi+0x66], 0x02
	jnz	$_0584
	and	dword ptr [rsi+0x28], 0xFFFFFF7F
	jmp	$_0586

$_0584: cmp	byte ptr [rsi+0x63], 2
	jnz	$_0586
	movabs	rax, 0x80000000
	mov	rdx, -2147483648
	cmp	qword ptr [rsi+0x20], rax
	jc	$_0585
	cmp	qword ptr [rsi+0x20], rdx
	jc	$_0586
$_0585: and	dword ptr [rsi+0x28], 0xFFFFFF7F
$_0586: jmp	$C0368

$_0587: test	dword ptr [rbp-0x4], 0x80
	jz	$C0368
	test	dword ptr [rbp-0x8], 0x401F00
	jz	$C0368
	test	byte ptr [rsi+0x66], 0x02
	jnz	$_0588
	and	dword ptr [rsi+0x10], 0xFFFFFF7F
	jmp	$C0368

$_0588: cmp	byte ptr [rsi+0x63], 2
	jnz	$C0368
	mov	eax, 2147483648
	mov	rdx, -2147483648
	cmp	qword ptr [rsi+0x38], rax
	jc	$_0589
	cmp	qword ptr [rsi+0x38], rdx
	jc	$C0368
$_0589: and	dword ptr [rsi+0x10], 0xFFFFFF7F
$C0368: mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x4]
	call	OperandSize
	mov	dword ptr [rbp-0x10], eax
	mov	rdx, rsi
	mov	ecx, dword ptr [rbp-0x8]
	call	OperandSize
	mov	dword ptr [rbp-0x14], eax
	cmp	dword ptr [rbp-0x10], eax
	jle	$_0590
	cmp	dword ptr [rbp-0x8], 65536
	jl	$_0590
	cmp	dword ptr [rbp-0x8], 262144
	jg	$_0590
	mov	eax, dword ptr [rbp-0x10]
	mov	dword ptr [rbp-0x14], eax
$_0590: cmp	dword ptr [rbp-0x10], 1
	jnz	$_0591
	cmp	dword ptr [rbp-0x8], 131072
	jnz	$_0591
	cmp	dword ptr [rsi+0x38], 255
	jg	$_0591
	cmp	dword ptr [rsi+0x38], -255
	jl	$_0591
	mov	eax, dword ptr [rbp-0xC]
	jmp	$_0629

$_0591: mov	eax, dword ptr [rbp-0x14]
	cmp	dword ptr [rbp-0x10], eax
	je	$_0625
	mov	eax, dword ptr [rbp-0x4]
	or	eax, dword ptr [rbp-0x8]
	test	eax, 0x108070
	jnz	$_0592
	cmp	word ptr [rsi+0xE], 1332
	jc	$_0593
$_0592: jmp	$_0597

$_0593: cmp	dword ptr [rbp-0x10], 0
	je	$_0597
	cmp	dword ptr [rbp-0x14], 0
	je	$_0597
	mov	eax, 1
	cmp	byte ptr [rsi+0x63], 0
	jbe	$_0596
	test	dword ptr [rbp-0x4], 0x607F00
	jz	$_0596
	test	dword ptr [rbp-0x8], 0x607F00
	jz	$_0596
	movzx	ecx, word ptr [rsi+0xE]
	jmp	$_0595

$_0594: xor	eax, eax
	jmp	$_0596

$_0595: cmp	ecx, 713
	jz	$_0594
	cmp	ecx, 619
	jz	$_0594
	cmp	ecx, 768
	jz	$_0594
	cmp	ecx, 614
	jz	$_0594
	cmp	ecx, 612
	jz	$_0594
	cmp	ecx, 615
	jz	$_0594
	cmp	ecx, 617
	jz	$_0594
	cmp	ecx, 616
	jz	$_0594
	cmp	ecx, 613
	jz	$_0594
	cmp	ecx, 618
	jz	$_0594
$_0596: test	eax, eax
	jz	$_0597
	mov	r8d, dword ptr [rbp-0x14]
	mov	edx, dword ptr [rbp-0x10]
	mov	ecx, 2022
	call	asmerr@PLT
	mov	dword ptr [rbp-0xC], eax
$_0597: cmp	dword ptr [rbp-0x10], 0
	jne	$_0625
	mov	eax, dword ptr [rbp-0x4]
	or	eax, dword ptr [rbp-0x8]
	test	dword ptr [rbp-0x4], 0x607F00
	je	$_0610
	test	byte ptr [rbp-0x6], 0x07
	je	$_0610
	mov	eax, dword ptr [rsi+0x38]
	cmp	dword ptr [rbp-0x14], 1
	jz	$_0599
	cmp	dword ptr [rbp-0x4], 4202240
	jnz	$_0601
	test	byte ptr [rdi+0xAB], 0x02
	jnz	$_0601
	cmp	eax, 0
	jge	$_0598
	cmp	eax, -128
	jl	$_0601
$_0598: cmp	eax, 255
	jg	$_0601
$_0599: mov	byte ptr [rsi+0x60], 0
	mov	dword ptr [rsi+0x28], 65536
	lea	rcx, [DS0001+rip]
	cmp	dword ptr [rbp-0x4], 4202240
	jnz	$_0600
	test	byte ptr [rdi+0xAB], 0x02
	jnz	$_0600
	mov	dword ptr [rsi+0x10], 256
$_0600: jmp	$_0606

$_0601: cmp	dword ptr [rbp-0x14], 2
	jnz	$_0603
	cmp	eax, 0
	jge	$_0602
	cmp	eax, 4294934528
	jl	$_0603
$_0602: cmp	eax, 65535
	jg	$_0603
	mov	byte ptr [rsi+0x60], 1
	or	byte ptr [rsi+0x66], 0x01
	mov	dword ptr [rsi+0x28], 131072
	lea	rcx, [DS0002+rip]
	jmp	$_0606

$_0603: or	byte ptr [rsi+0x66], 0x01
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jnz	$_0604
	cmp	dword ptr [rbp-0x14], 2
	jle	$_0604
	cmp	dword ptr [rsi+0x38], 65535
	jg	$_0604
	cmp	dword ptr [rsi+0x38], -65535
	jl	$_0604
	mov	dword ptr [rbp-0x14], 2
$_0604: cmp	dword ptr [rbp-0x14], 2
	jg	$_0605
	cmp	eax, 4294934528
	jle	$_0605
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jnz	$_0605
	mov	byte ptr [rsi+0x60], 1
	mov	dword ptr [rsi+0x28], 131072
	jmp	$_0606

$_0605: mov	byte ptr [rsi+0x60], 3
	mov	dword ptr [rsi+0x28], 262144
	lea	rcx, [DS0003+rip]
$_0606: test	byte ptr [rdi+0xAB], 0x02
	jnz	$_0609
	mov	rax, qword ptr [rsi+0x18]
	test	rax, rax
	jnz	$_0607
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0607
	test	byte ptr [rsi+0x66], 0x40
	jz	$_0608
$_0607: test	rax, rax
	jz	$_0609
	cmp	dword ptr [Parse_Pass+rip], 1
	jnz	$_0609
$_0608: mov	rdx, rcx
	mov	ecx, 8019
	call	asmerr@PLT
$_0609: jmp	$_0625

$_0610: test	dword ptr [rbp-0x4], 0x607F00
	jz	$_0611
	test	dword ptr [rbp-0x8], 0xC00000F
	jz	$_0611
	jmp	$_0625

$_0611: test	dword ptr [rbp-0x4], 0x8010
	jz	$_0615
	test	byte ptr [rbp-0x6], 0x07
	jz	$_0615
	mov	eax, dword ptr [rsi+0x38]
	cmp	eax, 65535
	jbe	$_0612
	mov	dword ptr [rsi+0x28], 262144
	jmp	$_0614

$_0612: cmp	eax, 255
	jbe	$_0613
	mov	dword ptr [rsi+0x28], 131072
	jmp	$_0614

$_0613: mov	dword ptr [rsi+0x28], 65536
$_0614: jmp	$_0625

$_0615: test	eax, 0x8010
	jz	$_0616
	jmp	$_0625

$_0616: jmp	$_0624

$_0617: mov	byte ptr [rsi+0x60], 0
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0618
	test	byte ptr [rbp-0x6], 0x07
	jz	$_0618
	lea	rdx, [DS0001+rip]
	mov	ecx, 8019
	call	asmerr@PLT
$_0618: jmp	$_0625

$_0619: mov	byte ptr [rsi+0x60], 1
	or	byte ptr [rsi+0x66], 0x01
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0620
	test	byte ptr [rbp-0x6], 0x07
	jz	$_0620
	lea	rdx, [DS0003+0x1+rip]
	mov	ecx, 8019
	call	asmerr@PLT
$_0620: cmp	byte ptr [rsi+0x63], 0
	jz	$_0621
	mov	byte ptr [rsi+0xA], 1
$_0621: jmp	$_0625

$_0622: mov	byte ptr [rsi+0x60], 3
	or	byte ptr [rsi+0x66], 0x01
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0623
	test	byte ptr [rbp-0x6], 0x07
	jz	$_0623
	lea	rdx, [DS0003+rip]
	mov	ecx, 8019
	call	asmerr@PLT
$_0623: jmp	$_0625

$_0624: cmp	dword ptr [rbp-0x14], 1
	je	$_0617
	cmp	dword ptr [rbp-0x14], 2
	jz	$_0619
	cmp	dword ptr [rbp-0x14], 4
	jz	$_0622
$_0625: jmp	$_0628

$_0626: cmp	eax, 713
	jl	$_0627
	cmp	eax, 752
	jg	$_0627
	push	rax
	lea	r11, [$C0368+rip]
	movzx	eax, byte ptr [r11+rax-(713)+(IT$C03A3-$C0368)]
	movzx	eax, word ptr [r11+rax*2+($C03A3-$C0368)]
	sub	r11, rax
	pop	rax
	jmp	r11
	.ALIGN	2
$C03A3:
	.word $C0368-$C02F0
	.word $C0368-$C02F8
	.word $C0368-$C0300
	.word $C0368-$C0311
	.word $C0368-$C0316
	.word $C0368-$C0317
	.word $C0368-$C0328
	.word $C0368-$C032F
	.word $C0368-$C034E
	.word 0
IT$C03A3:
	.byte 8
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 4
	.byte 9
	.byte 7
	.byte 0
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 9
	.byte 6
	.byte 6
	.byte 2
	.byte 9
	.byte 3
	.byte 3
	.byte 3
	.byte 9
	.byte 9
	.byte 5
	.byte 5
	.byte 9
	.byte 1
	.ALIGN	2
$C03A4:
$_0627: cmp	eax, 1330
	jl	$C03A6
	cmp	eax, 1357
	jg	$C03A6
	push	rax
	lea	r11, [$C0368+rip]
	movzx	eax, byte ptr [r11+rax-(1330)+(IT$C03A5-$C0368)]
	movzx	eax, word ptr [r11+rax*2+($C03A5-$C0368)]
	sub	r11, rax
	pop	rax
	jmp	r11
	.ALIGN 2
$C03A5:
	.word $C0368-$C0338
	.word $C0368-$C0342
	.word $C0368-$C0346
	.word $C0368-$C0347
	.word 0
IT$C03A5:
	.byte 0
	.byte 0
	.byte 4
	.byte 0
	.byte 0
	.byte 4
	.byte 4
	.byte 0
	.byte 0
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 3
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 1
	.byte 1
	.byte 1
	.byte 2
$C03A6:
	cmp	eax, 620
	jl	$C03A8
	cmp	eax, 663
	jg	$C03A8
	push	rax
	lea	r11, [$C0368+rip]
	movzx	eax, byte ptr [r11+rax-(620)+(IT$C03A7-$C0368)]
	movzx	eax, word ptr [r11+rax*2+($C03A7-$C0368)]
	sub	r11, rax
	pop	rax
	jmp	r11

	.ALIGN 2
$C03A7:
	.word $C0368-$C0301
	.word $C0368-$C030F
	.word 0
IT$C03A7:
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 1
	.byte 1
	.ALIGN 2
$C03A8:
	cmp	eax, 1227
	je	$C02ED
	cmp	eax, 1234
	je	$C0326
	cmp	eax, 675
	je	$C0327
	cmp	eax, 1036
	je	$C0334
	cmp	eax, 1044
	je	$C0335
	cmp	eax, 1037
	je	$C0336
	cmp	eax, 1045
	je	$C0337
	cmp	eax, 1400
	je	$C033C
	cmp	eax, 1401
	je	$C033D
	cmp	eax, 1406
	je	$C033E
	cmp	eax, 1407
	je	$C033F
	cmp	eax, 1297
	je	$C0349
	cmp	eax, 1058
	je	$C034D
	jmp	$C0368

$_0628: mov	eax, dword ptr [rbp-0xC]
$_0629: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_0630:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	call	SymFind@PLT
	test	rax, rax
	jz	$_0631
	cmp	byte ptr [rax+0x18], 7
	jnz	$_0631
	jmp	$_0632

$_0631: xor	eax, eax
$_0632: leave
	ret

$_0633:
	mov	eax, dword ptr [rcx]
	jmp	$_0651

$_0634: inc	rcx
	mov	eax, dword ptr [rcx]
	jmp	$_0651

$_0635: cmp	ah, 49
	jc	$_0652
	cmp	ah, 55
	ja	$_0652
	test	eax, 0xFF0000
	jne	$_0652
	sub	ah, 48
	or	byte ptr [rdx], ah
	mov	eax, 1
	jmp	$_0653

$_0636: cmp	ah, 116
	jne	$_0652
	shr	eax, 24
	jmp	$_0639

$_0637: cmp	byte ptr [rcx+0x4], 54
	jnz	$_0640
$_0638: or	byte ptr [rdx], 0x10
	mov	eax, 1
	jmp	$_0653

	jmp	$_0640

$_0639: cmp	al, 49
	jz	$_0637
	cmp	al, 50
	jz	$_0638
	cmp	al, 52
	jz	$_0638
	cmp	al, 56
	jz	$_0638
$_0640: jmp	$_0652

$_0641: test	ah, ah
	jne	$_0652
	or	byte ptr [rdx], 0xFFFFFF80
	mov	eax, 1
	jmp	$_0653

$_0642: cmp	byte ptr [rcx+0x2], 45
	jne	$_0652
	cmp	byte ptr [rcx+0x3], 115
	jne	$_0652
	mov	ecx, 8192
	jmp	$_0647

$_0643: or	cl, 0x50
	jmp	$_0648

$_0644: or	cl, 0x70
$_0645: or	cl, 0x30
$_0646: or	cl, 0x10
	jmp	$_0648

$_0647: cmp	ah, 117
	jz	$_0643
	cmp	ah, 122
	jz	$_0644
	cmp	ah, 100
	jz	$_0645
	cmp	ah, 110
	jz	$_0646
$_0648: test	cl, cl
	jz	$_0649
	or	word ptr [rdx], cx
	mov	eax, 1
	jmp	$_0653

$_0649: jmp	$_0652

$_0650: cmp	eax, 6644083
	jnz	$_0652
	mov	ecx, 8208
	or	word ptr [rdx], cx
	mov	eax, 1
	jmp	$_0653

	jmp	$_0652

$_0651: cmp	al, 9
	je	$_0634
	cmp	al, 32
	je	$_0634
	cmp	al, 107
	je	$_0635
	cmp	al, 49
	je	$_0636
	cmp	al, 122
	je	$_0641
	cmp	al, 114
	je	$_0642
	cmp	al, 115
	jz	$_0650
$_0652: xor	eax, eax
$_0653: ret

ParseLine:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 616
	mov	rbx, rcx
	cmp	qword ptr [CurrEnum+rip], 0
	jz	$_0654
	cmp	byte ptr [rbx], 8
	jnz	$_0654
	mov	rdx, rbx
	xor	ecx, ecx
	call	EnumDirective@PLT
	jmp	$_0873

$_0654: mov	dword ptr [rbp-0x4], 0
	cmp	dword ptr [ModuleInfo+0x220+rip], 2
	jle	$_0660
	cmp	byte ptr [rbx], 8
	jne	$_0660
	cmp	byte ptr [rbx+0x18], 58
	jz	$_0655
	cmp	byte ptr [rbx+0x18], 13
	jne	$_0660
$_0655: mov	ecx, dword ptr [ModuleInfo+0x174+rip]
	call	MemAlloc@PLT
	mov	rdi, rax
	mov	rdx, qword ptr [rbx+0x40]
	mov	rcx, rdi
	call	tstrcpy@PLT
	mov	rdx, qword ptr [rbx+0x8]
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	tstrcpy@PLT
	mov	rdx, qword ptr [rbx+0x20]
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	tstrcat@PLT
	xor	r9d, r9d
	mov	r8, rbx
	xor	edx, edx
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	Tokenize@PLT
	mov	dword ptr [ModuleInfo+0x220+rip], eax
	mov	rcx, rbx
	call	ParseLine
	cmp	eax, -1
	jnz	$_0656
	mov	rcx, rdi
	call	MemFree@PLT
	mov	rax, -1
	jmp	$_0873

$_0656: cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_0657
	and	byte ptr [ModuleInfo+0x1C6+rip], 0xFFFFFFFE
$_0657: mov	rdx, rdi
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	tstrcpy@PLT
	mov	rcx, rdi
	call	MemFree@PLT
	xor	r9d, r9d
	mov	r8, rbx
	xor	edx, edx
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	Tokenize@PLT
	mov	dword ptr [ModuleInfo+0x220+rip], eax
	mov	rdx, rbx
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	ExpandLine@PLT
	cmp	eax, -2
	jz	$_0658
	cmp	eax, -1
	jnz	$_0659
$_0658: jmp	$_0873

$_0659: mov	dword ptr [rbp-0x4], 0
	jmp	$_0668

$_0660: cmp	byte ptr [rbx], 8
	jne	$_0668
	cmp	byte ptr [rbx+0x18], 58
	jz	$_0661
	cmp	byte ptr [rbx+0x18], 13
	jne	$_0668
$_0661: mov	dword ptr [rbp-0x4], 2
	test	dword ptr [ProcStatus+rip], 0x80
	jz	$_0662
	mov	rcx, rbx
	call	write_prologue@PLT
$_0662: xor	eax, eax
	cmp	byte ptr [ModuleInfo+0x1D7+rip], 0
	jz	$_0663
	cmp	qword ptr [CurrProc+rip], 0
	jz	$_0663
	cmp	byte ptr [rbx+0x18], 13
	jz	$_0663
	inc	eax
$_0663: mov	r9d, eax
	xor	r8d, r8d
	mov	edx, 129
	mov	rcx, qword ptr [rbx+0x8]
	call	CreateLabel@PLT
	test	rax, rax
	jnz	$_0664
	mov	rax, -1
	jmp	$_0873

$_0664: cmp	byte ptr [rbx+0x18], 13
	jnz	$_0665
	cmp	byte ptr [ModuleInfo+0x1D7+rip], 0
	jz	$_0665
	cmp	qword ptr [CurrProc+rip], 0
	jnz	$_0665
	mov	byte ptr [rbx+0x18], 0
	mov	dword ptr [ModuleInfo+0x220+rip], 1
	mov	rdx, qword ptr [rbp+0x28]
	mov	ecx, 4294967295
	call	PublicDirective@PLT
$_0665: lea	rsi, [rbx+0x30]
	cmp	byte ptr [rsi], 0
	jnz	$_0668
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0666
	xor	r8d, r8d
	xor	edx, edx
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	StoreLine@PLT
$_0666: cmp	qword ptr [ModuleInfo+0x80+rip], 0
	jz	$_0667
	xor	r8d, r8d
	xor	edx, edx
	mov	ecx, 7
	call	LstWrite@PLT
$_0667: xor	eax, eax
	jmp	$_0873

$_0668: imul	esi, dword ptr [rbp-0x4], 24
	add	rsi, rbx
	mov	dword ptr [rbp-0x8], 0
	cmp	qword ptr [ModuleInfo+0x108+rip], 0
	jz	$_0670
	cmp	byte ptr [rbx], 6
	jnz	$_0669
	cmp	byte ptr [rbx+0x18], 3
	jnz	$_0669
	cmp	dword ptr [rbx+0x1C], 539
	jnz	$_0669
	inc	dword ptr [rbp-0x8]
$_0669: jmp	$_0671

$_0670: cmp	byte ptr [rbx], 3
	jnz	$_0671
	cmp	dword ptr [rbx+0x4], 434
	jnz	$_0671
	mov	byte ptr [rbx], 8
	mov	rax, qword ptr [rbx+0x20]
	mov	qword ptr [rbx+0x8], rax
	mov	byte ptr [rbx+0x18], 3
	mov	dword ptr [rbx+0x1C], 538
	mov	byte ptr [rbx+0x19], 32
$_0671: cmp	dword ptr [rbp-0x8], 0
	jnz	$_0672
	cmp	byte ptr [rsi], 1
	je	$_0721
$_0672: mov	byte ptr [Frame_Type+rip], 6
	mov	qword ptr [SegOverride+rip], 0
	cmp	dword ptr [rbp-0x4], 0
	jnz	$_0678
	cmp	dword ptr [rbp-0x8], 0
	jnz	$_0673
	cmp	byte ptr [rbx], 8
	jnz	$_0678
$_0673: cmp	byte ptr [rbx+0x18], 3
	jnz	$_0674
	inc	dword ptr [rbp-0x4]
	add	rsi, 24
	jmp	$_0678

$_0674: mov	rcx, qword ptr [rbx+0x8]
	call	$_0630
	mov	qword ptr [rbp-0x20], rax
	test	rax, rax
	jnz	$_0675
	inc	dword ptr [rbp-0x4]
	add	rsi, 24
	jmp	$_0678

$_0675: cmp	qword ptr [CurrStruct+rip], 0
	jz	$_0678
	xor	eax, eax
	cmp	byte ptr [rbx+0x18], 6
	jnz	$_0676
	inc	eax
	jmp	$_0677

$_0676: cmp	byte ptr [rbx+0x18], 8
	jnz	$_0677
	mov	rcx, qword ptr [rbx+0x20]
	call	$_0630
$_0677: test	rax, rax
	jz	$_0678
	inc	dword ptr [rbp-0x4]
	add	rsi, 24
$_0678: movzx	eax, byte ptr [rsi]
	jmp	$_0711

$_0679: cmp	byte ptr [rsi+0x1], 8
	jnz	$_0680
	xor	r8d, r8d
	mov	rdx, qword ptr [rbp+0x28]
	mov	ecx, dword ptr [rbp-0x4]
	call	data_dir@PLT
	jmp	$_0873

$_0680: lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rsi+0x4], 12
	mov	eax, dword ptr [r11+rax]
	mov	dword ptr [rbp-0x14], eax
	cmp	dword ptr [rbp-0x8], 0
	jnz	$_0681
	cmp	qword ptr [CurrStruct+rip], 0
	je	$_0688
	test	byte ptr [rbp-0x14], 0x10
	je	$_0688
$_0681: cmp	dword ptr [rsi+0x4], 539
	jz	$_0682
	mov	ecx, 2037
	call	asmerr@PLT
	jmp	$_0873

$_0682: cmp	dword ptr [StoreState+rip], 0
	jz	$_0685
	test	byte ptr [rbp-0x13], 0x01
	jz	$_0684
	cmp	qword ptr [ModuleInfo+0x218+rip], 0
	jz	$_0684
	cmp	byte ptr [ModuleInfo+0x1DE+rip], 0
	jz	$_0684
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0683
	xor	r8d, r8d
	mov	edx, 1
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	StoreLine@PLT
$_0683: jmp	$_0685

$_0684: cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0685
	xor	r8d, r8d
	xor	edx, edx
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	StoreLine@PLT
$_0685: mov	rdx, qword ptr [rbp+0x28]
	mov	ecx, dword ptr [rbp-0x4]
	call	ProcType@PLT
	mov	edi, eax
	cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_0687
	cmp	dword ptr [Parse_Pass+rip], 0
	jz	$_0686
	cmp	dword ptr [ModuleInfo+0x210+rip], 0
	jnz	$_0686
	cmp	dword ptr [UseSavedState+rip], 0
	jnz	$_0687
$_0686: call	LstWriteSrcLine@PLT
$_0687: mov	eax, edi
	jmp	$_0873

$_0688: test	byte ptr [rbp-0x14], 0x08
	jz	$_0690
	cmp	dword ptr [rbp-0x4], 0
	jz	$_0689
	cmp	byte ptr [rbx], 8
	jz	$_0689
	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0873

$_0689: jmp	$_0691

$_0690: cmp	dword ptr [rbp-0x4], 0
	jz	$_0691
	cmp	byte ptr [rsi-0x18], 58
	jz	$_0691
	cmp	byte ptr [rsi-0x18], 13
	jz	$_0691
	mov	rdx, qword ptr [rsi-0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0873

$_0691: test	dword ptr [ProcStatus+rip], 0x80
	jz	$_0692
	test	byte ptr [rbp-0x14], 0x40
	jz	$_0692
	mov	rcx, qword ptr [rbp+0x28]
	call	write_prologue@PLT
$_0692: cmp	dword ptr [StoreState+rip], 0
	jnz	$_0693
	test	dword ptr [rbp-0x14], 0x80
	jz	$_0696
$_0693: test	byte ptr [rbp-0x13], 0x01
	jz	$_0695
	cmp	qword ptr [ModuleInfo+0x218+rip], 0
	jz	$_0695
	cmp	byte ptr [ModuleInfo+0x1DE+rip], 0
	jz	$_0695
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0694
	xor	r8d, r8d
	mov	edx, 1
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	StoreLine@PLT
$_0694: jmp	$_0696

$_0695: cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0696
	xor	r8d, r8d
	xor	edx, edx
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	StoreLine@PLT
$_0696: cmp	byte ptr [rsi+0x1], 8
	jbe	$_0697
	movzx	eax, byte ptr [rsi+0x1]
	lea	rcx, [directive_tab+rip]
	mov	rax, qword ptr [rcx+rax*8]
	mov	rdx, rbx
	mov	ecx, dword ptr [rbp-0x4]
	call	rax
	mov	edi, eax
	jmp	$_0702

$_0697: mov	edi, 4294967295
	mov	eax, dword ptr [rsi+0x4]
	jmp	$_0701

$_0698: mov	ecx, 1008
	call	asmerr@PLT
	jmp	$_0702

$_0699: mov	ecx, 2170
	call	asmerr@PLT
	jmp	$_0702

$_0700: mov	rdx, qword ptr [rsi+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0702

$_0701: cmp	eax, 506
	jz	$_0698
	cmp	eax, 437
	jz	$_0699
	cmp	eax, 505
	jz	$_0699
	cmp	eax, 507
	jz	$_0699
	jmp	$_0700

$_0702: cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_0704
	cmp	dword ptr [Parse_Pass+rip], 0
	jz	$_0703
	cmp	dword ptr [ModuleInfo+0x210+rip], 0
	jnz	$_0703
	cmp	dword ptr [UseSavedState+rip], 0
	jnz	$_0704
$_0703: call	LstWriteSrcLine@PLT
$_0704: mov	eax, edi
	jmp	$_0873

$_0705: cmp	dword ptr [rsi+0x4], 270
	jnz	$_0712
$_0706: xor	r8d, r8d
	mov	rdx, rbx
	mov	ecx, dword ptr [rbp-0x4]
	call	data_dir@PLT
	jmp	$_0873

$_0707: mov	rcx, qword ptr [rsi+0x8]
	call	$_0630
	test	rax, rax
	jz	$_0708
	test	byte ptr [rsi+0x2], 0x08
	jnz	$_0712
	mov	r8, rax
	mov	rdx, rbx
	mov	ecx, dword ptr [rbp-0x4]
	call	data_dir@PLT
	jmp	$_0873

$_0708: jmp	$_0712

$_0709: cmp	byte ptr [rsi], 58
	jnz	$_0710
	lea	rdx, [DS0004+rip]
	mov	ecx, 2065
	call	asmerr@PLT
	jmp	$_0873

$_0710: jmp	$_0712

$_0711: cmp	eax, 3
	je	$_0679
	cmp	eax, 5
	jz	$_0705
	cmp	eax, 6
	jz	$_0706
	cmp	eax, 8
	jz	$_0707
	jmp	$_0709

$_0712: cmp	dword ptr [rbp-0x4], 0
	jz	$_0713
	cmp	byte ptr [rsi-0x18], 8
	jnz	$_0713
	dec	dword ptr [rbp-0x4]
	sub	rsi, 24
$_0713: cmp	dword ptr [rbp-0x4], 0
	jnz	$_0714
	cmp	byte ptr [rbx+0x1], 123
	je	$_0721
$_0714: cmp	qword ptr [CurrEnum+rip], 0
	jz	$_0715
	cmp	byte ptr [rbx], 9
	jnz	$_0715
	mov	rdx, rbx
	xor	ecx, ecx
	call	EnumDirective@PLT
	jmp	$_0873

$_0715: cmp	dword ptr [rbp-0x4], 0
	jnz	$_0720
	cmp	dword ptr [ModuleInfo+0x220+rip], 1
	jle	$_0720
	lea	rcx, [rbx+0x18]
	call	GetOperator@PLT
	test	rax, rax
	jz	$_0716
	mov	rcx, qword ptr [rbp+0x28]
	call	ProcessOperator@PLT
	jmp	$_0873

$_0716: cmp	byte ptr [rbx], 5
	jnz	$_0717
	cmp	dword ptr [rbx+0x4], 271
	jz	$_0718
$_0717: cmp	byte ptr [rbx], 4
	jnz	$_0720
	cmp	dword ptr [rbx+0x4], 262
	jnz	$_0720
$_0718: mov	ecx, dword ptr [rbx+0x4]
	call	RemoveResWord@PLT
	mov	byte ptr [rbx], 8
	mov	rcx, rbx
	call	PreprocessLine@PLT
	test	rax, rax
	jz	$_0719
	mov	rcx, rbx
	call	ParseLine
$_0719: jmp	$_0873

$_0720: mov	rdx, qword ptr [rsi+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0873

$_0721: cmp	qword ptr [CurrStruct+rip], 0
	jz	$_0722
	mov	ecx, 2037
	call	asmerr@PLT
	jmp	$_0873

$_0722: test	dword ptr [ProcStatus+rip], 0x80
	jz	$_0723
	mov	rcx, rbx
	call	write_prologue@PLT
$_0723: cmp	qword ptr [ModuleInfo+0x80+rip], 0
	jz	$_0724
	call	GetCurrOffset@PLT
	mov	dword ptr [rbp-0x24], eax
$_0724: xor	eax, eax
	mov	ecx, 26
	lea	rdi, [rbp-0x90]
	rep stosd
	mov	dword ptr [rbp-0x90], -2
	mov	dword ptr [rbp-0x8C], -2
	mov	byte ptr [rbp-0x30], -64
	mov	al, byte ptr [ModuleInfo+0x1CC+rip]
	mov	byte ptr [rbp-0x2D], al
	cmp	dword ptr [rbp-0x4], 0
	jnz	$_0726
	cmp	byte ptr [rbx+0x1], 123
	jnz	$_0726
	lea	rdx, [DS0005+rip]
	mov	rcx, qword ptr [rbx+0x8]
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_0725
	mov	byte ptr [rbp-0x85], 1
	inc	dword ptr [rbp-0x4]
	add	rsi, 24
	jmp	$_0726

$_0725: mov	rdx, qword ptr [rsi+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0873

$_0726: cmp	dword ptr [rsi+0x4], 689
	jc	$_0727
	cmp	dword ptr [rsi+0x4], 694
	ja	$_0727
	mov	eax, dword ptr [rsi+0x4]
	mov	dword ptr [rbp-0x90], eax
	inc	dword ptr [rbp-0x4]
	add	rsi, 24
	cmp	byte ptr [rsi], 1
	jz	$_0727
	mov	ecx, 2068
	call	asmerr@PLT
	jmp	$_0873

$_0727: cmp	qword ptr [CurrProc+rip], 0
	je	$_0734
	jmp	$_0733

$_0728: test	byte ptr [ProcStatus+rip], 0x02
	jnz	$_0731
	cmp	byte ptr [ModuleInfo+0x1F0+rip], 2
	jz	$_0731
	xor	eax, eax
	cmp	qword ptr [ModuleInfo+0x218+rip], 0
	jz	$_0729
	cmp	byte ptr [ModuleInfo+0x1DE+rip], 0
	jz	$_0729
	inc	eax
$_0729: cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0730
	xor	r8d, r8d
	mov	edx, eax
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	StoreLine@PLT
$_0730: or	byte ptr [ProcStatus+rip], 0x02
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x28]
	mov	ecx, dword ptr [rbp-0x4]
	call	RetInstr@PLT
	and	dword ptr [ProcStatus+rip], 0xFFFFFFFD
	jmp	$_0873

$_0731: cmp	dword ptr [rsi+0x4], 757
	jnz	$_0732
	mov	rax, qword ptr [CurrProc+rip]
	cmp	byte ptr [rax+0x19], -126
	jnz	$_0732
	mov	dword ptr [rsi+0x4], 759
$_0732: jmp	$_0734

$_0733: cmp	dword ptr [rsi+0x4], 757
	je	$_0728
	cmp	dword ptr [rsi+0x4], 735
	je	$_0728
	cmp	dword ptr [rsi+0x4], 736
	je	$_0728
	cmp	dword ptr [rsi+0x4], 1232
	je	$_0728
$_0734: test	byte ptr [rbx+0x2], 0x40
	je	$_0743
	lea	rsi, [rbx+0x18]
	mov	dword ptr [rbp-0x8], 1
$_0735: cmp	byte ptr [rsi], 0
	je	$_0743
	test	byte ptr [rsi+0x2], 0x08
	je	$_0742
	mov	byte ptr [rbp-0x231], 0
	mov	ecx, dword ptr [ModuleInfo+0x174+rip]
	cmp	ecx, 2048
	jbe	$_0736
	mov	byte ptr [rbp-0x231], 1
	call	MemAlloc@PLT
	jmp	$_0737

$_0736: mov	eax, ecx
	add	eax, 15
	and	eax, 0xFFFFFFF0
	sub	rsp, rax
	lea	rax, [rsp+0x30]
$_0737: mov	rdi, rax
	mov	r8, rbx
	mov	edx, dword ptr [rbp-0x8]
	mov	rcx, rdi
	call	ExpandHllProcEx@PLT
	mov	dword ptr [rbp-0x10], eax
	cmp	byte ptr [rbp-0x231], 0
	jz	$_0738
	mov	rcx, rdi
	call	MemFree@PLT
$_0738: cmp	dword ptr [rbp-0x10], -1
	jnz	$_0739
	mov	rax, -1
	jmp	$_0873

$_0739: cmp	dword ptr [rbp-0x10], 1
	jnz	$_0741
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0740
	xor	r8d, r8d
	xor	edx, edx
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	StoreLine@PLT
$_0740: xor	eax, eax
	jmp	$_0873

$_0741: jmp	$_0743

$_0742: inc	dword ptr [rbp-0x8]
	add	rsi, 24
	jmp	$_0735

$_0743: cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0744
	xor	r8d, r8d
	xor	edx, edx
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	StoreLine@PLT
$_0744: imul	esi, dword ptr [rbp-0x4], 24
	add	rsi, rbx
	mov	eax, dword ptr [rsi+0x4]
	mov	word ptr [rbp-0x82], ax
	sub	eax, 562
	lea	rcx, [optable_idx+rip]
	movzx	eax, word ptr [rcx+rax*2]
	lea	rcx, [InstrTable+rip]
	lea	rax, [rcx+rax*8]
	mov	qword ptr [rbp-0x38], rax
	inc	dword ptr [rbp-0x4]
	add	rsi, 24
	mov	rax, qword ptr [ModuleInfo+0x1F8+rip]
	test	rax, rax
	jnz	$_0745
	mov	ecx, 2034
	call	asmerr@PLT
	jmp	$_0873

$_0745: mov	rax, qword ptr [rax+0x68]
	cmp	dword ptr [rax+0x48], 0
	jnz	$_0746
	mov	dword ptr [rax+0x48], 1
$_0746: cmp	byte ptr [ModuleInfo+0x1EE+rip], 0
	jz	$_0747
	xor	ecx, ecx
	call	omf_OutSelect@PLT
$_0747: mov	dword ptr [rbp-0x8], 0
$_0748: cmp	dword ptr [rbp-0x8], 4
	jge	$_0778
	cmp	byte ptr [rsi], 0
	je	$_0778
	cmp	dword ptr [rbp-0x8], 0
	jz	$_0749
	cmp	byte ptr [rsi], 44
	jne	$_0778
	inc	dword ptr [rbp-0x4]
$_0749: imul	edi, dword ptr [rbp-0x8], 104
	lea	rcx, [rbp+rdi-0x230]
	mov	byte ptr [rsp+0x20], 0
	mov	r9, rcx
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x28]
	lea	rcx, [rbp-0x4]
	call	EvalOperand@PLT
	cmp	eax, -1
	jnz	$_0750
	jmp	$_0873

$_0750: imul	esi, dword ptr [rbp-0x4], 24
	add	rsi, qword ptr [rbp+0x28]
	test	byte ptr [rsi-0x16], 0x10
	jz	$_0753
	mov	byte ptr [rbp-0x85], 1
	lea	rbx, [rsi-0x18]
$_0751: lea	rdx, [rbp-0x84]
	mov	rcx, qword ptr [rbx+0x8]
	call	$_0633
	test	rax, rax
	jnz	$_0752
	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0873

$_0752: sub	rbx, 24
	test	byte ptr [rbx+0x2], 0x10
	jnz	$_0751
	cmp	dword ptr [rbp+rdi-0x1F4], -2
	jnz	$_0753
	dec	dword ptr [rbp-0x8]
	jmp	$_0777

$_0753: jmp	$_0776

$_0754: cmp	dword ptr [rbp-0x8], 1
	jz	$_0755
	cmp	word ptr [rbp-0x82], 708
	jz	$_0755
	cmp	word ptr [rbp-0x82], 672
	jne	$_0767
$_0755: cmp	byte ptr [Options+0xC6+rip], 0
	jne	$_0766
	cmp	byte ptr [rbp+rdi-0x1F0], -64
	je	$_0766
	movzx	eax, byte ptr [ModuleInfo+0x1CE+rip]
	cmp	dword ptr [rbp-0x8], 0
	jz	$_0758
	cmp	dword ptr [rbp+rdi-0x25C], 2
	jnz	$_0756
	test	byte ptr [rbp+rdi-0x255], 0x01
	jnz	$_0756
	mov	rax, qword ptr [rbp+rdi-0x280]
	mov	ecx, dword ptr [rax+0x4]
	call	SizeFromRegister
	jmp	$_0758

$_0756: cmp	dword ptr [rbp+rdi-0x25C], 1
	jz	$_0757
	cmp	dword ptr [rbp+rdi-0x25C], 2
	jnz	$_0758
$_0757: mov	r8, qword ptr [rbp+rdi-0x238]
	movzx	edx, byte ptr [rbp+rdi-0x256]
	movzx	ecx, byte ptr [rbp+rdi-0x258]
	call	SizeFromMemtype
$_0758: xor	ecx, ecx
	jmp	$_0763

$_0759: mov	ecx, 33
	jmp	$_0764

$_0760: mov	ecx, 35
	jmp	$_0764

$_0761: mov	ecx, 39
	jmp	$_0764

$_0762: mov	ecx, 47
	jmp	$_0764

$_0763: cmp	eax, 2
	jz	$_0759
	cmp	eax, 4
	jz	$_0760
	cmp	eax, 8
	jz	$_0761
	cmp	eax, 16
	jz	$_0762
$_0764: test	ecx, ecx
	jz	$_0766
	lea	rdx, [rbp+rdi-0x230]
	mov	dword ptr [rbp+rdi-0x1F4], 0
	mov	byte ptr [rbp+rdi-0x1F0], cl
	cmp	eax, 16
	jz	$_0765
	mov	rcx, rdx
	mov	edx, eax
	call	quad_resize@PLT
$_0765: jmp	$_0777

$_0766: mov	ecx, 2050
	call	asmerr@PLT
	jmp	$_0873

$_0767: cmp	dword ptr [rbp-0x4], 1
	jle	$_0774
	cmp	byte ptr [rsi], 3
	jne	$_0774
	cmp	dword ptr [rsi+0x4], 438
	jne	$_0774
	mov	byte ptr [rbp-0x231], 0
	mov	ecx, dword ptr [ModuleInfo+0x174+rip]
	cmp	ecx, 2048
	jbe	$_0768
	mov	byte ptr [rbp-0x231], 1
	call	MemAlloc@PLT
	jmp	$_0769

$_0768: mov	eax, ecx
	add	eax, 15
	and	eax, 0xFFFFFFF0
	sub	rsp, rax
	lea	rax, [rsp+0x30]
$_0769: mov	rbx, rax
	mov	rax, qword ptr [rbp+0x28]
	mov	rax, qword ptr [rax+0x10]
	mov	rcx, qword ptr [rsi+0x10]
	sub	rcx, rax
	mov	rsi, rax
	mov	rdi, rbx
	rep movsb
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_0770
	mov	eax, 7889266
	jmp	$_0771

$_0770: mov	eax, 7889253
$_0771: stosd
	mov	rdx, qword ptr [rbp+0x28]
	mov	ecx, dword ptr [rbp-0x4]
	call	NewDirective@PLT
	cmp	dword ptr [Parse_Pass+rip], 0
	jbe	$_0772
	mov	rdx, rbx
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	tstrcpy@PLT
	xor	r9d, r9d
	mov	r8, qword ptr [rbp+0x28]
	xor	edx, edx
	mov	rcx, rax
	call	Tokenize@PLT
	mov	dword ptr [ModuleInfo+0x220+rip], eax
	mov	rcx, rbx
	call	MemFree@PLT
	mov	rcx, qword ptr [rbp+0x28]
	call	ParseLine
	jmp	$_0873

$_0772: cmp	byte ptr [rbp-0x231], 0
	jz	$_0773
	mov	rcx, rbx
	call	MemFree@PLT
$_0773: xor	eax, eax
	jmp	$_0873

$_0774: mov	eax, dword ptr [ModuleInfo+0x220+rip]
	cmp	dword ptr [rbp-0x4], eax
	jnz	$_0775
	sub	rsi, 24
$_0775: mov	rdx, qword ptr [rsi+0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0873

	jmp	$_0777

$_0776: cmp	dword ptr [rbp+rdi-0x1F4], 3
	je	$_0754
	cmp	dword ptr [rbp+rdi-0x1F4], -2
	je	$_0767
	cmp	dword ptr [rbp+rdi-0x1F4], -1
	jz	$_0775
$_0777: inc	dword ptr [rbp-0x8]
	jmp	$_0748

$_0778: cmp	byte ptr [rsi], 0
	jz	$_0779
	mov	rdx, qword ptr [rsi+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0873

$_0779: cmp	dword ptr [rbp-0x8], 3
	jl	$_0780
	or	byte ptr [rbp-0x83], 0x08
$_0780: mov	dword ptr [rbp-0xC], 0
	xor	ebx, ebx
$_0781: cmp	ebx, dword ptr [rbp-0x8]
	jge	$_0822
	cmp	ebx, 3
	jnc	$_0822
	mov	byte ptr [Frame_Type+rip], 6
	mov	qword ptr [SegOverride+rip], 0
	imul	edx, ebx, 104
	movzx	eax, word ptr [rbp-0x82]
	mov	ecx, dword ptr [rbp-0x80]
	cmp	eax, 1332
	jc	$_0809
	cmp	ebx, 1
	jne	$_0809
	test	ecx, 0x507F7C
	je	$_0809
	lea	rdi, [vex_flags+rip]
	movzx	edi, byte ptr [rdi+rax-0x534]
	cmp	eax, 1613
	jc	$_0782
	cmp	eax, 1621
	jbe	$_0783
$_0782: test	ecx, 0xC
	jz	$_0783
	jmp	$_0809

$_0783: test	edi, 0x2
	jz	$_0784
	jmp	$_0809

$_0784: test	edi, 0x8
	jz	$_0785
	cmp	dword ptr [rbp-0x124], 0
	jnz	$_0785
	cmp	dword ptr [rbp-0x8], 2
	jle	$_0785
	jmp	$_0809

$_0785: test	edi, 0x20
	jz	$_0786
	test	ecx, 0x70
	jz	$_0786
	test	byte ptr [rbp+rdx-0x1ED], 0x01
	jz	$_0786
	mov	byte ptr [rbp-0x2F], 0
	jmp	$_0809

$_0786: test	edi, 0x10
	jz	$_0789
	test	ecx, 0x401F00
	jnz	$_0788
	cmp	eax, 1436
	jz	$_0787
	cmp	eax, 1437
	jnz	$_0789
$_0787: cmp	dword ptr [rbp-0x18C], 2
	jnz	$_0788
	test	byte ptr [rbp-0x185], 0x01
	jz	$_0789
$_0788: jmp	$_0809

$_0789: cmp	dword ptr [rbp-0x18C], 2
	jz	$_0790
	mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0873

$_0790: mov	rax, qword ptr [rbp+rdx-0x218]
	mov	eax, dword ptr [rax+0x4]
	lea	r11, [SpecialTable+rip]
	imul	eax, eax, 12
	test	dword ptr [r11+rax], 0x10007C
	jnz	$_0791
	mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0873

$_0791: cmp	dword ptr [rbp-0x8], 2
	jg	$_0793
	movzx	eax, word ptr [rbp-0x82]
	lea	rcx, [ResWordTable+rip]
	imul	eax, eax, 16
	test	byte ptr [rcx+rax+0x3], 0x10
	jz	$_0792
	inc	dword ptr [rbp-0x8]
$_0792: jmp	$_0808

$_0793: test	edi, 0x4
	je	$_0798
	cmp	dword ptr [rbp-0x124], 0
	jne	$_0798
	cmp	qword ptr [rbp-0x218], 0
	je	$_0797
	mov	rcx, qword ptr [rbp+rdx-0x218]
	mov	eax, dword ptr [rcx+0x4]
	lea	r11, [SpecialTable+rip]
	imul	eax, eax, 12
	mov	eax, dword ptr [r11+rax]
	mov	rcx, qword ptr [rbp-0x218]
	mov	cl, byte ptr [rcx+0x1]
	inc	cl
	mov	byte ptr [rbp-0x2B], cl
	test	eax, 0x40
	jz	$_0794
	or	byte ptr [rbp-0x2B], 0xFFFFFF80
	jmp	$_0795

$_0794: test	eax, 0x20
	jz	$_0795
	or	byte ptr [rbp-0x2B], 0x40
$_0795: lea	rdi, [rbp-0x230]
	lea	rax, [rbp+rdx-0x230]
	xchg	rax, rsi
	mov	ecx, 312
	rep movsb
	mov	rsi, rax
	mov	byte ptr [rbp-0x2F], 0
	mov	r9d, dword ptr [rbp-0xC]
	lea	r8, [rbp-0x230]
	xor	edx, edx
	lea	rcx, [rbp-0x90]
	call	$_0446
	cmp	eax, -1
	jnz	$_0796
	jmp	$_0873

$_0796: inc	dword ptr [rbp-0xC]
$_0797: jmp	$_0808

$_0798: mov	rcx, qword ptr [rbp+rdx-0x218]
	mov	eax, dword ptr [rcx+0x4]
	lea	r11, [SpecialTable+rip]
	imul	eax, eax, 12
	mov	eax, dword ptr [r11+rax]
	cmp	dword ptr [rbp-0x80], 4202240
	jnz	$_0799
	jmp	$_0802

$_0799: test	eax, 0x1010
	jz	$_0800
	test	dword ptr [rbp-0x80], 0x2020
	jnz	$_0801
$_0800: test	eax, 0x2020
	jz	$_0802
	test	dword ptr [rbp-0x80], 0x1010
	jz	$_0802
$_0801: mov	ecx, 2070
	call	asmerr@PLT
	jmp	$_0873

$_0802: mov	edi, eax
	mov	al, byte ptr [rcx+0x1]
	inc	al
	mov	byte ptr [rbp-0x2B], al
	cmp	byte ptr [rbp-0x2B], 16
	ja	$_0803
	test	edi, 0x40
	jz	$_0806
$_0803: mov	byte ptr [rbp-0x85], 1
	cmp	byte ptr [rbp-0x2B], 16
	jbe	$_0804
	or	byte ptr [rbp-0x83], 0x02
$_0804: test	edi, 0x40
	jz	$_0805
	or	byte ptr [rbp-0x2B], 0xFFFFFF80
	or	byte ptr [rbp-0x83], 0x10
$_0805: jmp	$_0807

$_0806: test	edi, 0x20
	jz	$_0807
	or	byte ptr [rbp-0x2B], 0x40
$_0807: inc	dword ptr [rbp-0xC]
	lea	rdi, [rbp+rdx-0x230]
	lea	rax, [rbp+rdx-0x1C8]
	xchg	rax, rsi
	mov	ecx, 208
	rep movsb
	mov	rsi, rax
$_0808: dec	dword ptr [rbp-0x8]
$_0809: imul	edx, ebx, 104
	jmp	$_0820

$_0810: lea	r8, [rbp+rdx-0x230]
	mov	edx, ebx
	lea	rcx, [rbp-0x90]
	call	$_0406
	cmp	eax, -1
	jnz	$_0811
	jmp	$_0873

$_0811: jmp	$_0821

$_0812: lea	r8, [rbp+rdx-0x230]
	mov	edx, ebx
	lea	rcx, [rbp-0x90]
	call	$_0441
	cmp	eax, -1
	jnz	$_0813
	jmp	$_0873

$_0813: jmp	$_0821

$_0814: test	byte ptr [rbp+rdx-0x1ED], 0x01
	jz	$_0816
	lea	r8, [rbp+rdx-0x230]
	mov	edx, ebx
	lea	rcx, [rbp-0x90]
	call	$_0406
	cmp	eax, -1
	jnz	$_0815
	jmp	$_0873

$_0815: jmp	$_0819

$_0816: cmp	ebx, 2
	jnz	$_0818
	mov	rcx, qword ptr [rbp+rdx-0x218]
	mov	eax, dword ptr [rcx+0x4]
	lea	r11, [SpecialTable+rip]
	imul	eax, eax, 12
	mov	eax, dword ptr [r11+rax]
	mov	dword ptr [rbp-0x50], eax
	movzx	eax, byte ptr [rcx+0x1]
	mov	dword ptr [rbp-0x40], eax
	mov	rcx, qword ptr [rbp-0x38]
	test	byte ptr [rcx+0x3], 0x08
	jz	$_0817
	mov	cl, byte ptr [rbp-0x2C]
	and	cl, 0xFFFFFFF0
	or	al, cl
	mov	byte ptr [rbp-0x2C], al
$_0817: jmp	$_0819

$_0818: mov	r9d, dword ptr [rbp-0xC]
	lea	r8, [rbp-0x230]
	mov	edx, ebx
	lea	rcx, [rbp-0x90]
	call	$_0446
	cmp	eax, -1
	jnz	$_0819
	jmp	$_0873

$_0819: jmp	$_0821

$_0820: cmp	dword ptr [rbp+rdx-0x1F4], 1
	je	$_0810
	cmp	dword ptr [rbp+rdx-0x1F4], 0
	je	$_0812
	cmp	dword ptr [rbp+rdx-0x1F4], 2
	je	$_0814
$_0821: inc	ebx
	inc	dword ptr [rbp-0xC]
	jmp	$_0781

$_0822: cmp	ebx, 2
	jne	$_0830
	cmp	dword ptr [rbp-0x1F4], 2
	jnz	$_0823
	cmp	dword ptr [rbp-0x18C], 1
	jz	$_0824
$_0823: cmp	dword ptr [rbp-0x1F4], 1
	jne	$_0830
	cmp	dword ptr [rbp-0x18C], 1
	je	$_0830
$_0824: mov	ecx, 1
	lea	rdi, [rbp-0x230]
	cmp	dword ptr [rdi+0x3C], 2
	jnz	$_0825
	add	rdi, 104
	dec	ecx
$_0825: mov	rbx, qword ptr [rdi+0x18]
	mov	rax, qword ptr [rdi+0x50]
	mov	rdx, qword ptr [rdi+0x58]
	test	rbx, rbx
	jz	$_0829
	test	rax, rax
	jz	$_0829
	test	rdx, rdx
	jz	$_0829
	test	byte ptr [rdi+0x43], 0xFFFFFF80
	jz	$_0829
	mov	rdx, qword ptr [rax+0x40]
	test	rdx, rdx
	jz	$_0829
	cmp	byte ptr [rax+0x19], -61
	jnz	$_0829
	cmp	byte ptr [rax+0x39], 0
	jz	$_0829
	cmp	byte ptr [rdx+0x18], 7
	jnz	$_0829
	cmp	byte ptr [rbx], 8
	jnz	$_0829
	cmp	byte ptr [rbx+0x18], 46
	jz	$_0826
	cmp	byte ptr [rbx+0x18], 91
	jnz	$_0829
$_0826: test	ecx, ecx
	jnz	$_0827
	cmp	byte ptr [rbx-0x48], 1
	jnz	$_0827
	cmp	byte ptr [rbx-0x30], 2
	jnz	$_0827
	cmp	byte ptr [rbx-0x18], 44
	jz	$_0828
$_0827: test	ecx, ecx
	jz	$_0829
	cmp	byte ptr [rbx-0x18], 1
	jnz	$_0829
$_0828: mov	r8d, ecx
	mov	rdx, rbx
	mov	rcx, rax
	call	HandleIndirection@PLT
	jmp	$_0873

$_0829: mov	ebx, 2
$_0830: cmp	ebx, dword ptr [rbp-0x8]
	jz	$_0833
$_0831: cmp	byte ptr [rsi], 44
	jz	$_0832
	dec	dword ptr [rbp-0x4]
	sub	rsi, 24
	jmp	$_0831

$_0832: mov	rdx, qword ptr [rsi+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0873

$_0833: test	byte ptr [rbp-0x2A], 0x04
	jz	$_0835
	cmp	word ptr [rbp-0x82], 562
	jz	$_0834
	cmp	word ptr [rbp-0x82], 563
	jnz	$_0835
$_0834: add	qword ptr [rbp-0x38], 8
	mov	rdx, qword ptr [rbp-0x38]
	test	byte ptr [rdx+0x2], 0x08
	jz	$_0834
$_0835: mov	rdx, qword ptr [rbp-0x38]
	mov	al, byte ptr [rdx+0x2]
	and	eax, 0x07
	cmp	eax, 2
	jz	$_0836
	cmp	eax, 3
	jnz	$_0838
$_0836: cmp	byte ptr [ModuleInfo+0x337+rip], 0
	jnz	$_0837
	cmp	word ptr [rbp-0x82], 643
	jnz	$_0837
	cmp	dword ptr [rbp-0x80], 16
	jnz	$_0837
	test	dword ptr [rbp-0x68], 0x400F0000
	jz	$_0837
	mov	r8d, 8
	lea	rdx, [rbp-0x1C8]
	mov	rcx, qword ptr [rbp+0x28]
	call	imm2xmm@PLT
	jmp	$_0873

$_0837: lea	rdx, [rbp-0x230]
	lea	rcx, [rbp-0x90]
	call	$_0489
	jmp	$_0872

$_0838: cmp	ebx, 1
	jbe	$_0849
	cmp	ebx, 2
	jbe	$_0844
	mov	rdx, qword ptr [rbp-0x38]
$_0839: movzx	eax, byte ptr [rdx]
	imul	eax, eax, 12
	lea	rcx, [opnd_clstab+rip]
	cmp	byte ptr [rcx+rax+0x8], 0
	jnz	$_0843
	add	rdx, 8
	test	byte ptr [rdx+0x2], 0x08
	jz	$_0842
$_0840: cmp	byte ptr [rsi], 44
	jz	$_0841
	sub	rsi, 24
	jmp	$_0840

$_0841: mov	rdx, qword ptr [rsi+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_0873

$_0842: jmp	$_0839

$_0843: mov	qword ptr [rbp-0x38], rdx
$_0844:
	cmp	word ptr [rbp-0x82], 729
	jnz	$_0848
	mov	rax, qword ptr [rbp-0x60]
	test	rax, rax
	jz	$_0845
	mov	rax, qword ptr [rax+0x30]
$_0845: cmp	dword ptr [rbp-0x50], 0
	jnz	$_0847
	test	byte ptr [rbp-0x66], 0x07
	jz	$_0847
	test	byte ptr [rbp-0x88], 0x01
	jz	$_0846
	or	byte ptr [rbp-0x88], 0x04
$_0846: mov	al, byte ptr [rbp-0x2F]
	mov	dl, al
	and	al, 0xFFFFFFC7
	and	dl, 0x07
	shl	dl, 3
	or	al, dl
	mov	byte ptr [rbp-0x2F], al
	jmp	$_0848

$_0847: cmp	dword ptr [rbp-0x50], 0
	jz	$_0848
	test	byte ptr [rbp-0x66], 0x07
	jz	$_0848
	test	rax, rax
	jz	$_0848
	cmp	byte ptr [rax+0x18], 0
	jnz	$_0848
	mov	dword ptr [rbp-0x68], 4202240
$_0848: lea	rdx, [rbp-0x230]
	lea	rcx, [rbp-0x90]
	call	$_0535
	cmp	eax, -1
	jnz	$_0849
	jmp	$_0873

$_0849: cmp	byte ptr [rbp-0x2D], 2
	jne	$_0861
	test	byte ptr [rbp-0x2A], 0x10
	jz	$_0850
	cmp	byte ptr [rbp-0x88], 0
	jz	$_0850
	mov	ecx, 3012
	call	asmerr@PLT
$_0850: movzx	eax, word ptr [rbp-0x82]
	cmp	eax, 1332
	jnc	$_0851
	cmp	eax, 961
	jc	$_0851
	cmp	dword ptr [rbp-0x8], 1
	jle	$_0851
	cmp	dword ptr [rbp-0x18C], 0
	jnz	$_0851
	mov	rdx, qword ptr [rbp-0x1B8]
	test	rdx, rdx
	jz	$_0851
	cmp	byte ptr [rdx], 9
	jnz	$_0851
	cmp	byte ptr [rdx+0x1], 123
	jnz	$_0851
	mov	eax, 1061
$_0851: mov	ecx, 4
	jmp	$_0860

$_0852: and	byte ptr [rbp-0x88], 0x07
	jmp	$_0861

$_0853: and	byte ptr [rbp-0x88], 0x07
	jmp	$_0861

$_0854: add	ecx, 8
$_0855: add	ecx, 4
$_0856: cmp	byte ptr [ModuleInfo+0x337+rip], 0
	jne	$_0861
	cmp	dword ptr [rbp-0x80], 16
	jne	$_0861
	test	dword ptr [rbp-0x68], 0x400F0000
	je	$_0861
	mov	r8d, ecx
	lea	rdx, [rbp-0x1C8]
	mov	rcx, qword ptr [rbp+0x28]
	call	imm2xmm@PLT
	jmp	$_0873

$_0857: test	byte ptr [rbp-0x7D], 0x02
	jnz	$_0858
	test	byte ptr [rbp-0x65], 0x02
	jz	$_0859
$_0858: and	byte ptr [rbp-0x88], 0x07
$_0859: jmp	$_0861

$_0860: cmp	eax, 708
	jz	$_0852
	cmp	eax, 709
	jz	$_0852
	cmp	eax, 562
	jz	$_0853
	cmp	eax, 563
	je	$_0853
	cmp	eax, 1328
	je	$_0853
	cmp	eax, 1329
	je	$_0853
	cmp	eax, 1061
	je	$_0854
	cmp	eax, 1059
	je	$_0855
	cmp	eax, 643
	je	$_0855
	cmp	eax, 963
	je	$_0855
	cmp	eax, 987
	je	$_0855
	cmp	eax, 979
	je	$_0855
	cmp	eax, 967
	je	$_0855
	cmp	eax, 1030
	je	$_0855
	cmp	eax, 1154
	je	$_0855
	cmp	eax, 964
	je	$_0856
	cmp	eax, 988
	je	$_0856
	cmp	eax, 980
	je	$_0856
	cmp	eax, 968
	je	$_0856
	cmp	eax, 1031
	je	$_0856
	cmp	eax, 1155
	je	$_0856
	cmp	eax, 1058
	je	$_0856
	cmp	eax, 1081
	je	$_0856
	cmp	eax, 713
	je	$_0857
$_0861: cmp	byte ptr [rbp-0x2D], 0
	jbe	$_0872
	cmp	byte ptr [ModuleInfo+0x337+rip], 0
	jne	$_0872
	movzx	eax, word ptr [rbp-0x82]
	mov	ecx, dword ptr [rbp-0x80]
	mov	edx, dword ptr [rbp-0x68]
	test	ecx, 0x607F00
	jz	$_0864
	test	edx, 0x607F00
	jz	$_0864
	jmp	$_0863

$_0862: lea	r9, [rbp-0x230]
	mov	r8, qword ptr [rbp+0x28]
	call	mem2mem@PLT
	jmp	$_0873

	jmp	$_0864

$_0863: cmp	eax, 713
	jz	$_0862
	cmp	eax, 619
	jz	$_0862
	cmp	eax, 768
	jz	$_0862
	cmp	eax, 614
	jz	$_0862
	cmp	eax, 612
	jz	$_0862
	cmp	eax, 615
	jz	$_0862
	cmp	eax, 617
	jz	$_0862
	cmp	eax, 616
	jz	$_0862
	cmp	eax, 613
	jz	$_0862
	cmp	eax, 618
	jz	$_0862
	cmp	eax, 1031
	jz	$_0862
	cmp	eax, 1030
	jz	$_0862
$_0864: xor	ebx, ebx
	cmp	eax, 1031
	jnz	$_0865
	cmp	ecx, 1024
	jnz	$_0865
	test	edx, 0x400F0000
	jz	$_0865
	inc	ebx
	mov	ecx, 4
	jmp	$_0871

$_0865: cmp	eax, 1030
	jnz	$_0866
	cmp	ecx, 2048
	jnz	$_0866
	test	edx, 0x400F0000
	jz	$_0866
	inc	ebx
	mov	ecx, 8
	jmp	$_0871

$_0866: cmp	ecx, 16
	jne	$_0871
	test	edx, 0x400F0000
	je	$_0871
	mov	ecx, 4
	jmp	$_0870

$_0867: add	ecx, 8
$_0868: add	ecx, 4
$_0869: inc	ebx
	jmp	$_0871

$_0870: cmp	eax, 1061
	jz	$_0867
	cmp	eax, 1059
	jz	$_0868
	cmp	eax, 643
	jz	$_0868
	cmp	eax, 963
	jz	$_0868
	cmp	eax, 987
	jz	$_0868
	cmp	eax, 979
	jz	$_0868
	cmp	eax, 967
	jz	$_0868
	cmp	eax, 1030
	jz	$_0868
	cmp	eax, 1154
	jz	$_0868
	cmp	eax, 964
	jz	$_0869
	cmp	eax, 988
	jz	$_0869
	cmp	eax, 980
	jz	$_0869
	cmp	eax, 968
	jz	$_0869
	cmp	eax, 1031
	jz	$_0869
	cmp	eax, 1155
	jz	$_0869
	cmp	eax, 1058
	jz	$_0869
	cmp	eax, 1081
	jz	$_0869
$_0871: test	ebx, ebx
	jz	$_0872
	mov	r8d, ecx
	lea	rdx, [rbp-0x1C8]
	mov	rcx, qword ptr [rbp+0x28]
	call	imm2xmm@PLT
	jmp	$_0873

$_0872: mov	edx, dword ptr [rbp-0x24]
	lea	rcx, [rbp-0x90]
	call	codegen@PLT
$_0873: leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

ProcessFile:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	GetTextLine@PLT
	cmp	byte ptr [ModuleInfo+0x1E0+rip], 0
	jnz	$_0876
	test	rax, rax
	jz	$_0876
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	mov	eax, dword ptr [rcx]
	and	eax, 0xFFFFFF
	cmp	eax, 12565487
	jnz	$_0874
	lea	rax, [rcx+0x3]
	mov	rdx, rax
	call	tstrcpy@PLT
$_0874: mov	rcx, qword ptr [ModuleInfo+0x180+rip]
	call	PreprocessLine@PLT
	test	rax, rax
	jz	$_0875
	mov	rcx, qword ptr [ModuleInfo+0x180+rip]
	call	ParseLine
	cmp	byte ptr [Options+0x96+rip], 1
	jnz	$_0875
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_0875
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	WritePreprocessedLine@PLT
$_0875: mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	GetTextLine@PLT
	cmp	byte ptr [ModuleInfo+0x1E0+rip], 0
	jnz	$_0876
	test	rax, rax
	jnz	$_0874
$_0876: leave
	ret


.SECTION .data
	.ALIGN	16

SegOverride:
	.quad  0x0000000000000000

LastRegOverride:
	.int   0x00000000

DS0000:
	.asciz "POP CS"

DS0001:
	.asciz "BYTE"

DS0002:
	.asciz "WORD"

DS0003:
	.asciz "DWORD"

DS0004:
	.asciz ":"

DS0005:
	.asciz "evex"


.SECTION .bss
	.ALIGN	16

SymTables:
	.zero	96 * 1


.att_syntax prefix
