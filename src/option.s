

.intel_syntax noprefix

.global OptionDirective

.extern UpdateProcStatus
.extern UpdateStackBase
.extern sym_Interface
.extern InputExtend
.extern CreateVariable
.extern EmitConstError
.extern EvalOperand
.extern RenameKeyword
.extern DisableKeyword
.extern IsKeywordDisabled
.extern FindResWord
.extern GetLangType
.extern SpecialTable
.extern LclDup
.extern LclAlloc
.extern tstricmp
.extern tstrcmp
.extern tstrcpy
.extern tstrlen
.extern tstrupr
.extern SetMasm510
.extern asmerr
.extern Options
.extern ModuleInfo
.extern Parse_Pass
.extern StringBuffer
.extern SymSetCmpFunc


.SECTION .text
	.ALIGN	16

$_001:	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	movzx	eax, byte ptr [ModuleInfo+0x1CC+rip]
	lea	rdx, [ModuleInfo+rip]
	mov	dword ptr [rdx+rax*4+0x224], ecx
	cmp	qword ptr [ModuleInfo+0x148+rip], 0
	jnz	$_002
	xor	edx, edx
	lea	rcx, [DS0032+rip]
	call	CreateVariable@PLT
	mov	qword ptr [ModuleInfo+0x148+rip], rax
	mov	rcx, rax
	or	byte ptr [rcx+0x14], 0x20
	lea	rax, [UpdateStackBase@PLT+rip]
	mov	qword ptr [rcx+0x58], rax
	xor	edx, edx
	lea	rcx, [DS0033+rip]
	call	CreateVariable@PLT
	mov	qword ptr [ModuleInfo+0x150+rip], rax
	mov	rcx, rax
	mov	dword ptr [rcx+0x14], 32
	lea	rax, [UpdateProcStatus@PLT+rip]
	mov	qword ptr [rcx+0x58], rax
$_002:	leave
	ret

$_003:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rbp
	mov	rbp, rsp
	sub	rsp, 160
	mov	byte ptr [rsp+0x20], 2
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x18]
	mov	rcx, qword ptr [rbp+0x10]
	call	EvalOperand@PLT
	cmp	eax, -1
	jnz	$_004
	jmp	$_011

$_004:	cmp	dword ptr [rbp-0x2C], 0
	jz	$_005
	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_011

$_005:	mov	eax, dword ptr [rbp+0x20]
	cmp	dword ptr [rbp-0x68], eax
	jle	$_006
	mov	ecx, 2064
	call	asmerr@PLT
	jmp	$_011

$_006:	cmp	dword ptr [rbp-0x68], 0
	jz	$_010
	xor	eax, eax
	mov	ecx, 1
$_007:	cmp	ecx, dword ptr [rbp-0x68]
	jnc	$_008
	shl	ecx, 1
	inc	eax
	jmp	$_007

$_008:	cmp	ecx, dword ptr [rbp-0x68]
	jz	$_009
	mov	edx, dword ptr [rbp-0x68]
	mov	ecx, 2063
	call	asmerr@PLT
	jmp	$_011

$_009:	mov	rdx, qword ptr [rbp+0x28]
	mov	byte ptr [rdx], al
$_010:	xor	eax, eax
$_011:	leave
	ret

OptionDirective:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 232
	mov	dword ptr [rbp-0x6C], -1
	inc	dword ptr [rbp+0x28]
	mov	edx, dword ptr [rbp+0x28]
	mov	rax, qword ptr [rbp+0x30]
	imul	edx, edx, 24
	add	rax, rdx
	mov	rbx, rax
	jmp	$_174

$_012:	mov	rsi, qword ptr [rbx+0x8]
	mov	rcx, rsi
	call	tstrupr@PLT
	xor	edi, edi
$_013:	cmp	edi, 50
	jnc	$_014
	lea	rdx, [optiontab+rip]
	mov	rdx, qword ptr [rdx+rdi*8]
	mov	rcx, rsi
	call	tstrcmp@PLT
	test	eax, eax
	jz	$_014
	inc	edi
	jmp	$_013

$_014:	cmp	edi, 50
	jnc	$_175
	mov	dword ptr [rbp-0x6C], edi
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	edi, 19
	jc	$_017
	cmp	byte ptr [rbx], 58
	jz	$_015
	lea	rdx, [DS0033+0xB+rip]
	mov	ecx, 2065
	call	asmerr@PLT
	jmp	$_178

$_015:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx], 0
	jnz	$_016
	sub	rbx, 48
	jmp	$_175

$_016:	cmp	edi, 29
	jc	$_017
	cmp	byte ptr [Options+0xC6+rip], 0
	jz	$_017
	sub	rbx, 48
	jmp	$_175

$_017:	mov	rsi, qword ptr [rbx+0x8]
	jmp	$_173

$C0017: mov	byte ptr [ModuleInfo+0x1D4+rip], 1
	jmp	$C0018

$C0019: mov	byte ptr [ModuleInfo+0x1D4+rip], 0
	jmp	$C0018

$C001A: mov	ecx, 1
	call	SetMasm510@PLT
	jmp	$C0018

$C001B: xor	ecx, ecx
	call	SetMasm510@PLT
	jmp	$C0018

$C001C: mov	byte ptr [ModuleInfo+0x1D7+rip], 1
	jmp	$C0018

$C001D: mov	byte ptr [ModuleInfo+0x1D7+rip], 0
	jmp	$C0018

$C001E: mov	byte ptr [ModuleInfo+0x1D8+rip], 1
	jmp	$C0018

$C001F: mov	byte ptr [ModuleInfo+0x1D8+rip], 0
	jmp	$C0018

$C0020: mov	byte ptr [ModuleInfo+0x1D9+rip], 1
	jmp	$C0018

$C0021: mov	byte ptr [ModuleInfo+0x1D9+rip], 0
	jmp	$C0018

$C0022: mov	byte ptr [ModuleInfo+0x1D5+rip], 1
	jmp	$C0018

$C0023: mov	byte ptr [ModuleInfo+0x1D5+rip], 0
	jmp	$C0018

$C0024: jmp	$C0018

$C0025: jmp	$C0018

$C0026: jmp	$C0018

$C0027: jmp	$C0018

$C0028: jmp	$C0018

$C0029: jmp	$C0018

$C002A: mov	byte ptr [ModuleInfo+0x1E2+rip], 1
	jmp	$C0018

$C002B: cmp	byte ptr [rbx], 8
	jne	$_175
	lea	rdx, [DS0034+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_018
	mov	byte ptr [ModuleInfo+0x1D0+rip], 1
	mov	byte ptr [ModuleInfo+0x1D1+rip], 0
	jmp	$_021

$_018:	lea	rdx, [DS0035+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_019
	mov	byte ptr [ModuleInfo+0x1D0+rip], 0
	mov	byte ptr [ModuleInfo+0x1D1+rip], 0
	jmp	$_021

$_019:	lea	rdx, [DS0036+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_020
	mov	byte ptr [ModuleInfo+0x1D0+rip], 0
	mov	byte ptr [ModuleInfo+0x1D1+rip], 1
	jmp	$_021

$_020:	jmp	$_175

$_021:	inc	dword ptr [rbp+0x28]
	call	SymSetCmpFunc@PLT
	jmp	$C0018

$C0030: jmp	$_027

$_022:	lea	rdx, [DS0037+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_023
	mov	byte ptr [ModuleInfo+0x1D2+rip], 1
	mov	byte ptr [ModuleInfo+0x1D3+rip], 0
	inc	dword ptr [rbp+0x28]
	jmp	$_024

$_023:	lea	rdx, [DS0038+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_024
	mov	byte ptr [ModuleInfo+0x1D2+rip], 0
	mov	byte ptr [ModuleInfo+0x1D3+rip], 1
	inc	dword ptr [rbp+0x28]
$_024:	jmp	$_028

$_025:	cmp	dword ptr [rbx+0x4], 537
	jnz	$_026
	mov	byte ptr [ModuleInfo+0x1D2+rip], 0
	mov	byte ptr [ModuleInfo+0x1D3+rip], 0
	inc	dword ptr [rbp+0x28]
$_026:	jmp	$_028

$_027:	cmp	byte ptr [rbx], 8
	jz	$_022
	cmp	byte ptr [rbx], 3
	jz	$_025
$_028:	jmp	$C0018

$C0039: cmp	byte ptr [rbx], 8
	jz	$_029
	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_178

$_029:	cmp	qword ptr [ModuleInfo+0x190+rip], 0
	jz	$_030
	mov	qword ptr [ModuleInfo+0x190+rip], 0
$_030:	lea	rdx, [DS0034+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_031
	mov	byte ptr [ModuleInfo+0x1EF+rip], 2
	jmp	$_033

$_031:	lea	rdx, [DS0039+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_032
	mov	byte ptr [ModuleInfo+0x1EF+rip], 0
	jmp	$_033

$_032:	mov	byte ptr [ModuleInfo+0x1EF+rip], 1
	mov	rcx, rsi
	call	LclDup@PLT
	mov	qword ptr [ModuleInfo+0x190+rip], rax
$_033:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C003F: cmp	byte ptr [rbx], 8
	jz	$_034
	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_178

$_034:	mov	qword ptr [ModuleInfo+0x198+rip], 0
	lea	rdx, [DS0034+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_035
	mov	byte ptr [ModuleInfo+0x1F0+rip], 2
	jmp	$_037

$_035:	lea	rdx, [DS003A+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_036
	mov	byte ptr [ModuleInfo+0x1F0+rip], 0
	jmp	$_037

$_036:	mov	byte ptr [ModuleInfo+0x1F0+rip], 1
	mov	rcx, rsi
	call	LclDup@PLT
	mov	qword ptr [ModuleInfo+0x198+rip], rax
$_037:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C0044: cmp	byte ptr [rbx], 8
	jnz	$_038
	mov	eax, dword ptr [rsi]
	or	al, 0x20
	cmp	ax, 99
	jnz	$_038
	mov	byte ptr [rbx], 7
	mov	dword ptr [rbx+0x4], 277
	mov	byte ptr [rbx+0x1], 1
$_038:	cmp	byte ptr [rbx], 7
	jnz	$_040
	lea	r8, [ModuleInfo+0x1B6+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	GetLangType@PLT
	test	eax, eax
	jnz	$_040
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 0
	jz	$_039
	cmp	qword ptr [sym_Interface+rip], 0
	jz	$_039
	mov	rcx, qword ptr [sym_Interface+rip]
	movzx	eax, byte ptr [ModuleInfo+0x1B6+rip]
	mov	dword ptr [rcx+0x28], eax
$_039:	jmp	$C0018

$_040:	jmp	$_175

$C004A: cmp	dword ptr [Parse_Pass+rip], 0
	jz	$_044
	jmp	$_042

$_041:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
$_042:	cmp	byte ptr [rbx], 0
	jz	$_043
	cmp	byte ptr [rbx], 44
	jnz	$_041
$_043:	jmp	$C0018

$_044:	cmp	byte ptr [rbx], 9
	jne	$_175
	cmp	byte ptr [rbx+0x1], 60
	jne	$_175
$_045:	cmp	byte ptr [rsi], 0
	je	$_055
	jmp	$_047

$_046:	inc	rsi
$_047:	movzx	eax, byte ptr [rsi]
	test	byte ptr [r15+rax], 0x08
	jnz	$_046
	cmp	byte ptr [rsi], 0
	jz	$_051
	mov	rdi, rsi
$_048:	cmp	byte ptr [rsi], 0
	jz	$_049
	movzx	eax, byte ptr [rsi]
	test	byte ptr [r15+rax], 0x08
	jnz	$_049
	cmp	byte ptr [rsi], 44
	jz	$_049
	inc	rsi
	jmp	$_048

$_049:	mov	rcx, rsi
	sub	rcx, rdi
	mov	edx, ecx
	mov	rcx, rdi
	call	FindResWord@PLT
	test	rax, rax
	jz	$_050
	mov	ecx, eax
	call	DisableKeyword@PLT
	jmp	$_051

$_050:	mov	rcx, rsi
	sub	rcx, rdi
	mov	edx, ecx
	mov	rcx, rdi
	call	IsKeywordDisabled@PLT
	test	rax, rax
	jz	$_051
	mov	ecx, 2086
	call	asmerr@PLT
	jmp	$_178

$_051:	jmp	$_053

$_052:	inc	rsi
$_053:	movzx	eax, byte ptr [rsi]
	test	byte ptr [r15+rax], 0x08
	jnz	$_052
	cmp	byte ptr [rsi], 44
	jnz	$_054
	inc	rsi
$_054:	jmp	$_045

$_055:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C005F: lea	rdx, [DS003B+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_056
	mov	byte ptr [ModuleInfo+0x1DA+rip], 1
	inc	dword ptr [rbp+0x28]
	jmp	$_057

$_056:	lea	rdx, [DS003C+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_057
	mov	byte ptr [ModuleInfo+0x1DA+rip], 0
	inc	dword ptr [rbp+0x28]
$_057:	jmp	$C0018

$C0063: lea	rdx, [DS003D+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_058
	mov	byte ptr [ModuleInfo+0x1BB+rip], 0
	jmp	$_061

$_058:	lea	rdx, [DS003E+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_059
	mov	byte ptr [ModuleInfo+0x1BB+rip], 1
	jmp	$_061

$_059:	lea	rdx, [DS001B+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_060
	mov	byte ptr [ModuleInfo+0x1BB+rip], 2
	jmp	$_061

$_060:	jmp	$_175

$_061:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C0068: cmp	byte ptr [rbx], 7
	jnz	$_064
	cmp	dword ptr [rbx+0x4], 274
	jnz	$_064
	mov	eax, dword ptr [ModuleInfo+0x1C0+rip]
	and	eax, 0xF0
	cmp	eax, 112
	jc	$_062
	mov	byte ptr [ModuleInfo+0x1CD+rip], 2
	jmp	$_063

$_062:	mov	byte ptr [ModuleInfo+0x1CD+rip], 1
$_063:	jmp	$_070

$_064:	cmp	byte ptr [rbx], 8
	jnz	$_069
	lea	rdx, [DS003F+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_065
	mov	byte ptr [ModuleInfo+0x1CD+rip], 0
	jmp	$_068

$_065:	lea	rdx, [DS0040+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_066
	mov	byte ptr [ModuleInfo+0x1CD+rip], 1
	jmp	$_068

$_066:	lea	rdx, [DS0041+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_067
	mov	byte ptr [ModuleInfo+0x1CD+rip], 2
	jmp	$_068

$_067:	jmp	$_175

$_068:	jmp	$_070

$_069:	jmp	$_175

$_070:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C0072: lea	rdx, [DS0042+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_071
	mov	byte ptr [ModuleInfo+0x356+rip], 0
	jmp	$_076

$_071:	lea	rdx, [DS0043+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_072
	mov	byte ptr [ModuleInfo+0x356+rip], 1
	jmp	$_076

$_072:	lea	rdx, [DS0044+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_073
	mov	byte ptr [ModuleInfo+0x356+rip], 2
	jmp	$_076

$_073:	lea	rdx, [DS0045+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_074
	mov	byte ptr [ModuleInfo+0x356+rip], 4
	jmp	$_076

$_074:	lea	rdx, [DS0046+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_075
	mov	byte ptr [ModuleInfo+0x356+rip], 8
	jmp	$_076

$_075:	jmp	$_175

$_076:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C0079: lea	r9, [ModuleInfo+0x1C5+rip]
	mov	r8d, 32
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	$_003
	cmp	eax, -1
	je	$_178
	jmp	$C0018

$C007A: lea	r9, [ModuleInfo+0x1C7+rip]
	mov	r8d, 32
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	$_003
	cmp	eax, -1
	je	$_178
	jmp	$C0018

$C007B: mov	dword ptr [rbp-0xAC], 0
	lea	rdi, [ModuleInfo+0x1E4+rip]
$_077:	cmp	dword ptr [rbp-0xAC], 4
	jge	$_087
	mov	ecx, dword ptr [rbp+0x28]
	mov	rdx, rbx
$_078:	cmp	byte ptr [rdx], 0
	jz	$_079
	cmp	byte ptr [rdx], 44
	jz	$_079
	cmp	byte ptr [rdx], 58
	jz	$_079
	cmp	byte ptr [rdx], 13
	jz	$_079
	inc	ecx
	add	rdx, 24
	jmp	$_078

$_079:	mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0x68]
	mov	r8d, ecx
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_178
	mov	edx, dword ptr [rbp+0x28]
	mov	rax, qword ptr [rbp+0x30]
	imul	edx, edx, 24
	add	rax, rdx
	mov	rbx, rax
	cmp	dword ptr [rbp-0x2C], -2
	jnz	$_080
	jmp	$_084

$_080:	cmp	dword ptr [rbp-0x2C], 0
	jnz	$_083
	cmp	dword ptr [rbp-0x68], 65535
	jle	$_081
	call	EmitConstError@PLT
	jmp	$_178

$_081:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 1
	jnz	$_082
	mov	eax, dword ptr [rbp-0x68]
	mov	ecx, dword ptr [rbp-0xAC]
	mov	word ptr [rdi+rcx*2], ax
$_082:	jmp	$_084

$_083:	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_178

$_084:	cmp	byte ptr [rbx], 58
	jnz	$_085
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	jmp	$_086

$_085:	cmp	byte ptr [rbx], 13
	jnz	$_086
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	inc	dword ptr [rbp-0xAC]
$_086:	inc	dword ptr [rbp-0xAC]
	jmp	$_077

$_087:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 1
	jnz	$_092
	cmp	word ptr [ModuleInfo+0x1E4+rip], 30
	jnc	$_088
	mov	word ptr [ModuleInfo+0x1E4+rip], 30
$_088:	mov	ecx, 16
$_089:	cmp	cx, word ptr [ModuleInfo+0x1E6+rip]
	jnc	$_090
	shl	ecx, 1
	jmp	$_089

$_090:	cmp	cx, word ptr [ModuleInfo+0x1E6+rip]
	jz	$_091
	mov	edx, ecx
	mov	ecx, 2189
	call	asmerr@PLT
$_091:	mov	ax, word ptr [ModuleInfo+0x1E8+rip]
	cmp	word ptr [ModuleInfo+0x1EA+rip], ax
	jnc	$_092
	mov	word ptr [ModuleInfo+0x1EA+rip], ax
$_092:	jmp	$C0018

$C0091: lea	rdx, [DS0047+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_093
	or	byte ptr [ModuleInfo+0x1E1+rip], 0x01
	jmp	$_096

$_093:	cmp	dword ptr [rbx+0x4], 612
	jnz	$_094
	mov	byte ptr [ModuleInfo+0x1E1+rip], 3
	jmp	$_096

$_094:	lea	rdx, [DS0048+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_095
	mov	byte ptr [ModuleInfo+0x1E1+rip], 0
	jmp	$_096

$_095:	jmp	$_175

$_096:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C0096: mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_178
	cmp	dword ptr [rbp-0x2C], 0
	jnz	$_099
	cmp	dword ptr [rbp-0x68], 255
	jle	$_097
	call	EmitConstError@PLT
	jmp	$_178

$_097:	cmp	dword ptr [Options+0xA4+rip], 3
	jnz	$_098
	mov	eax, dword ptr [rbp-0x68]
	mov	byte ptr [ModuleInfo+0x1E4+rip], al
$_098:	jmp	$_100

$_099:	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_178

$_100:	jmp	$C0018

$C009B: cmp	byte ptr [rbx], 9
	jne	$_175
	cmp	byte ptr [rbx+0x1], 60
	jne	$_175
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx], 3
	jne	$_175
	cmp	byte ptr [rbx+0x1], 48
	jne	$_175
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx], 8
	jne	$_175
	mov	rcx, rsi
	call	tstrlen@PLT
	mov	edx, eax
	mov	rcx, rsi
	call	FindResWord@PLT
	mov	esi, eax
	test	esi, esi
	jnz	$_101
	mov	ecx, 2086
	call	asmerr@PLT
	jmp	$_178

$_101:	mov	rcx, qword ptr [rbx+0x8]
	call	tstrlen@PLT
	movzx	r8d, al
	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, esi
	call	RenameKeyword@PLT
	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C009D: cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jz	$_105
	jmp	$_103

$_102:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
$_103:	cmp	byte ptr [rbx], 0
	jz	$_104
	cmp	byte ptr [rbx], 44
	jnz	$_102
$_104:	jmp	$C0018

$_105:	cmp	byte ptr [rbx], 10
	jnz	$_108
	mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_178
	cmp	dword ptr [rbp-0x2C], 0
	jnz	$_107
	test	dword ptr [rbp-0x68], 0xFFFFFFF8
	jz	$_106
	call	EmitConstError@PLT
	jmp	$_178

$_106:	mov	eax, dword ptr [rbp-0x68]
	mov	byte ptr [ModuleInfo+0x1E5+rip], al
$_107:	jmp	$_123

$_108:	jmp	$_122

$_109:	cmp	byte ptr [rbx], 58
	je	$_121
	cmp	byte ptr [rbx], 44
	je	$_121
	mov	rsi, qword ptr [rbx+0x8]
	mov	edi, dword ptr [rbx+0x4]
	cmp	edi, 119
	jnz	$_110
	mov	ecx, 119
	call	$_001
	or	byte ptr [ModuleInfo+0x1E5+rip], 0x02
	jmp	$_121

$_110:	cmp	edi, 120
	jnz	$_111
	mov	ecx, 120
	call	$_001
	or	byte ptr [ModuleInfo+0x1E1+rip], 0x01
	or	byte ptr [ModuleInfo+0x1E5+rip], 0x03
	jmp	$_121

$_111:	cmp	edi, 545
	jnz	$_113
	cmp	byte ptr [ModuleInfo+0x1E5+rip], 0
	jnz	$_112
	or	byte ptr [ModuleInfo+0x1E5+rip], 0x02
$_112:	or	byte ptr [ModuleInfo+0x1E5+rip], 0x04
	jmp	$_121

$_113:	lea	rdx, [DS0049+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_114
	and	byte ptr [ModuleInfo+0x1E5+rip], 0xFFFFFFFB
	jmp	$_121

$_114:	lea	rdx, [DS004A+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_115
	or	byte ptr [ModuleInfo+0x1E5+rip], 0x01
	jmp	$_121

$_115:	lea	rdx, [DS004B+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_116
	and	byte ptr [ModuleInfo+0x1E5+rip], 0xFFFFFFFE
	jmp	$_121

$_116:	lea	rdx, [DS0048+0x2+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_117
	or	byte ptr [ModuleInfo+0x1E5+rip], 0x02
	jmp	$_121

$_117:	lea	rdx, [DS0048+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_118
	and	byte ptr [ModuleInfo+0x1E5+rip], 0xFFFFFFFD
	jmp	$_121

$_118:	cmp	edi, 276
	jnz	$_119
	mov	byte ptr [ModuleInfo+0x1E1+rip], 3
	jmp	$_121

$_119:	lea	rdx, [DS004C+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_120
	mov	byte ptr [ModuleInfo+0x1E1+rip], 0
	jmp	$_121

$_120:	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_178

$_121:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
$_122:	cmp	byte ptr [rbx], 0
	jne	$_109
$_123:	jmp	$C0018

$C00B6: cmp	byte ptr [rbx], 8
	jnz	$_125
	lea	rdx, [DS0034+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_124
	mov	qword ptr [ModuleInfo+0x1A0+rip], 0
$_124:	jmp	$_132

$_125:	cmp	byte ptr [rbx], 9
	jne	$_132
	cmp	byte ptr [rbx+0x1], 60
	jne	$_132
	cmp	dword ptr [Parse_Pass+rip], 0
	jne	$_132
	cmp	byte ptr [rsi], 0
	jnz	$_126
	xor	esi, esi
	jmp	$_131

$_126:	lea	rdi, [ModuleInfo+0x60+rip]
$_127:	cmp	qword ptr [rdi], 0
	jz	$_129
	mov	rcx, qword ptr [rdi]
	mov	rdx, rsi
	lea	rcx, [rcx+0xC]
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_128
	mov	rsi, qword ptr [rdi]
	jmp	$_131

$_128:	mov	rdi, qword ptr [rdi]
	jmp	$_127

$_129:	mov	rcx, rsi
	call	tstrlen@PLT
	add	rax, 16
	mov	ecx, eax
	call	LclAlloc@PLT
	mov	qword ptr [rdi], rax
	mov	rdi, rax
	mov	qword ptr [rdi], 0
	mov	dword ptr [rdi+0x8], 0
	mov	rdx, rsi
	lea	rcx, [rdi+0xC]
	call	tstrcpy@PLT
	lea	rax, [DS004D+rip]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jz	$_130
	inc	rax
$_130:	mov	qword ptr [ModuleInfo+0x68+rip], rax
	mov	rsi, rdi
$_131:	mov	qword ptr [ModuleInfo+0x1A0+rip], rsi
$_132:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C00C5: mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_178
	cmp	dword ptr [rbp-0x2C], 0
	jnz	$_133
	mov	eax, dword ptr [rbp-0x68]
	mov	byte ptr [ModuleInfo+0x1F2+rip], al
	jmp	$_134

$_133:	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_178

$_134:	jmp	$C0018

$C00C8: cmp	byte ptr [rbx], 2
	jne	$_175
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbx+0x4], 12
	test	dword ptr [r11+rax+0x4], 0x80
	jnz	$_135
	mov	ecx, 2031
	call	asmerr@PLT
	jmp	$_178

$_135:	mov	ecx, dword ptr [rbx+0x4]
	call	$_001
	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C00CA: lea	rdx, [DS004E+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_136
	or	byte ptr [ModuleInfo+0x334+rip], 0x01
	jmp	$_138

$_136:	lea	rdx, [DS004F+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_137
	and	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFFFE
	jmp	$_138

$_137:	jmp	$_175

$_138:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C00CE: lea	rdx, [DS004E+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_139
	mov	byte ptr [ModuleInfo+0x354+rip], 1
	jmp	$_141

$_139:	lea	rdx, [DS004F+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_140
	mov	byte ptr [ModuleInfo+0x354+rip], 0
	jmp	$_141

$_140:	jmp	$_175

$_141:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C00D2: lea	rdx, [DS0035+0x8+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_142
	and	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFFF7
	jmp	$_148

$_142:	lea	rdx, [DS0050+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_143
	or	byte ptr [ModuleInfo+0x334+rip], 0x08
	jmp	$_148

$_143:	lea	rdx, [DS0051+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_144
	and	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFFEF
	jmp	$_148

$_144:	lea	rdx, [DS0052+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_145
	or	byte ptr [ModuleInfo+0x334+rip], 0x10
	jmp	$_148

$_145:	lea	rdx, [DS0053+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_146
	or	byte ptr [ModuleInfo+0x334+rip], 0x20
	jmp	$_148

$_146:	lea	rdx, [DS0054+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_147
	and	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFFDF
	jmp	$_148

$_147:	jmp	$_175

$_148:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C00DA: lea	r9, [ModuleInfo+0x335+rip]
	mov	r8d, 16
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	$_003
	cmp	eax, -1
	je	$_178
	jmp	$C0018

$C00DB: lea	r9, [ModuleInfo+0x336+rip]
	mov	r8d, 16
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	$_003
	cmp	eax, -1
	je	$_178
	jmp	$C0018

$C00DC: lea	rdx, [DS004E+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_149
	or	byte ptr [ModuleInfo+0x334+rip], 0x02
	jmp	$_151

$_149:	lea	rdx, [DS004F+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_150
	and	byte ptr [ModuleInfo+0x334+rip], 0xFFFFFFFD
	jmp	$_151

$_150:	jmp	$_175

$_151:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C00E0: mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_178
	cmp	dword ptr [rbp-0x2C], 0
	jnz	$_153
	cmp	dword ptr [rbp-0x68], 65535
	jle	$_152
	call	EmitConstError@PLT
	jmp	$_178

$_152:	mov	eax, dword ptr [rbp-0x68]
	mov	dword ptr [ModuleInfo+0x344+rip], eax
	jmp	$_154

$_153:	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_178

$_154:	jmp	$C0018

$C00E4: lea	rdx, [DS0052+0x6+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_155
	mov	byte ptr [ModuleInfo+0x350+rip], 101
	jmp	$_159

$_155:	lea	rdx, [DS004F+0x2+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_156
	mov	byte ptr [ModuleInfo+0x350+rip], 0
	jmp	$_159

$_156:	lea	rdx, [DS002B+0x6+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_157
	mov	byte ptr [ModuleInfo+0x350+rip], 103
	jmp	$_159

$_157:	lea	rdx, [DS0053+0x4+rip]
	mov	rcx, rsi
	call	tstricmp@PLT
	test	eax, eax
	jnz	$_158
	mov	byte ptr [ModuleInfo+0x350+rip], 120
	jmp	$_159

$_158:	jmp	$_175

$_159:	inc	dword ptr [rbp+0x28]
	jmp	$C0018

$C00EA: mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	rax, -1
	je	$_178
	cmp	dword ptr [rbp-0x2C], 0
	jnz	$_161
	cmp	dword ptr [rbp-0x68], 4
	jz	$_160
	cmp	dword ptr [rbp-0x68], 8
	jz	$_160
	call	EmitConstError@PLT
	jmp	$_178

$_160:	mov	eax, dword ptr [rbp-0x68]
	mov	byte ptr [ModuleInfo+0x351+rip], al
	jmp	$_162

$_161:	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_178

$_162:	jmp	$C0018

$C00EE: mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_178
	cmp	dword ptr [rbp-0x2C], 0
	jnz	$_164
	cmp	dword ptr [rbp-0x68], 255
	jle	$_163
	call	EmitConstError@PLT
	jmp	$_178

$_163:	mov	eax, dword ptr [rbp-0x68]
	mov	dword ptr [ModuleInfo+0x34C+rip], eax
	jmp	$_165

$_164:	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_178

$_165:	jmp	$C0018

$C00F2: mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_178
	cmp	dword ptr [rbp-0x2C], 0
	jne	$_171
	cmp	dword ptr [rbp-0x68], 65535
	jle	$_166
	call	EmitConstError@PLT
	jmp	$_178

$_166:	mov	rax, qword ptr [ModuleInfo+0x178+rip]
	mov	qword ptr [rbp-0xA8], rax
	mov	qword ptr [rbp-0x98], rax
	mov	rax, qword ptr [ModuleInfo+0x180+rip]
	mov	qword ptr [rbp-0x88], rax
	mov	rax, qword ptr [StringBuffer+rip]
	mov	qword ptr [rbp-0x80], rax
	mov	qword ptr [rbp-0xA0], rax
	mov	dword ptr [rbp-0x90], 0
	mov	esi, dword ptr [ModuleInfo+0x174+rip]
	jmp	$_170

$_167:	lea	rcx, [rbp-0xA8]
	call	InputExtend@PLT
	test	eax, eax
	jnz	$_168
	mov	ecx, 1009
	call	asmerr@PLT
	jmp	$_178

$_168:	cmp	esi, dword ptr [ModuleInfo+0x174+rip]
	jnz	$_169
	mov	ecx, 1901
	call	asmerr@PLT
	jmp	$_178

$_169:	mov	esi, dword ptr [ModuleInfo+0x174+rip]
$_170:	cmp	esi, dword ptr [rbp-0x68]
	jl	$_167
	jmp	$_172

$_171:	mov	ecx, 2026
	call	asmerr@PLT
	jmp	$_178

$_172:	jmp	$C0018

$_173:	cmp	edi, 0
	jl	$C0018
	cmp	edi, 49
	jg	$C0018
	push	rax
	lea	r11, [$C0018+rip]
	movzx	eax, word ptr [r11+rdi*2+($C00FA-$C0018)]
	sub	r11, rax
	pop	rax
	jmp	r11
	.ALIGN 2
$C00FA:
	.word $C0018-$C0017
	.word $C0018-$C0019
	.word $C0018-$C001A
	.word $C0018-$C001B
	.word $C0018-$C001C
	.word $C0018-$C001D
	.word $C0018-$C001E
	.word $C0018-$C001F
	.word $C0018-$C0020
	.word $C0018-$C0021
	.word $C0018-$C0022
	.word $C0018-$C0023
	.word $C0018-$C0024
	.word $C0018-$C0025
	.word $C0018-$C0026
	.word $C0018-$C0027
	.word $C0018-$C0028
	.word $C0018-$C0029
	.word $C0018-$C002A
	.word $C0018-$C002B
	.word $C0018-$C0030
	.word $C0018-$C0039
	.word $C0018-$C003F
	.word $C0018-$C0044
	.word $C0018-$C004A
	.word $C0018-$C005F
	.word $C0018-$C0063
	.word $C0018-$C0068
	.word $C0018-$C0072
	.word $C0018-$C0079
	.word $C0018-$C007A
	.word $C0018-$C007B
	.word $C0018-$C0091
	.word $C0018-$C0096
	.word $C0018-$C009B
	.word $C0018-$C009D
	.word $C0018-$C00B6
	.word $C0018-$C00C5
	.word $C0018-$C00C8
	.word $C0018-$C00CA
	.word $C0018-$C00D2
	.word $C0018-$C00DA
	.word $C0018-$C00DB
	.word $C0018-$C00DC
	.word $C0018-$C00E0
	.word $C0018-$C00E4
	.word $C0018-$C00EE
	.word $C0018-$C00F2
	.word $C0018-$C00EA
	.word $C0018-$C00CE

$C0018: mov	edx, dword ptr [rbp+0x28]
	mov	rax, qword ptr [rbp+0x30]
	imul	edx, edx, 24
	add	rax, rdx
	mov	rbx, rax
	cmp	byte ptr [rbx], 44
	jnz	$_175
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
$_174:	cmp	byte ptr [rbx], 0
	jne	$_012
$_175:	cmp	dword ptr [rbp-0x6C], 50
	jge	$_176
	cmp	byte ptr [rbx], 0
	jz	$_177
$_176:	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_178

$_177:	xor	eax, eax
$_178:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret


.SECTION .data
	.ALIGN	16

optiontab:
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
	.quad  DS001B
	.quad  DS001C
	.quad  DS001D
	.quad  DS001E
	.quad  DS001F
	.quad  DS0020
	.quad  DS0021
	.quad  DS0022
	.quad  DS0023
	.quad  DS0024
	.quad  DS0025
	.quad  DS0026
	.quad  DS0027
	.quad  DS0028
	.quad  DS0029
	.quad  DS002A
	.quad  DS002B
	.quad  DS002C
	.quad  DS002D
	.quad  DS002E
	.quad  DS002F
	.quad  DS0030
	.quad  DS0031

DS0032:
	.byte  0x40, 0x53, 0x74, 0x61, 0x63, 0x6B, 0x42, 0x61
	.byte  0x73, 0x65, 0x00

DS0033:
	.byte  0x40, 0x50, 0x72, 0x6F, 0x63, 0x53, 0x74, 0x61
	.byte  0x74, 0x75, 0x73, 0x00

DS0034:
	.byte  0x4E, 0x4F, 0x4E, 0x45, 0x00

DS0035:
	.byte  0x4E, 0x4F, 0x54, 0x50, 0x55, 0x42, 0x4C, 0x49
	.byte  0x43, 0x00

DS0036:
	.byte  0x41, 0x4C, 0x4C, 0x00

DS0037:
	.byte  0x50, 0x52, 0x49, 0x56, 0x41, 0x54, 0x45, 0x00

DS0038:
	.byte  0x45, 0x58, 0x50, 0x4F, 0x52, 0x54, 0x00

DS0039:
	.byte  0x50, 0x52, 0x4F, 0x4C, 0x4F, 0x47, 0x55, 0x45
	.byte  0x44, 0x45, 0x46, 0x00

DS003A:
	.byte  0x45, 0x50, 0x49, 0x4C, 0x4F, 0x47, 0x55, 0x45
	.byte  0x44, 0x45, 0x46, 0x00

DS003B:
	.byte  0x54, 0x52, 0x55, 0x45, 0x00

DS003C:
	.byte  0x46, 0x41, 0x4C, 0x53, 0x45, 0x00

DS003D:
	.byte  0x47, 0x52, 0x4F, 0x55, 0x50, 0x00

DS003E:
	.byte  0x46, 0x4C, 0x41, 0x54, 0x00

DS003F:
	.byte  0x55, 0x53, 0x45, 0x31, 0x36, 0x00

DS0040:
	.byte  0x55, 0x53, 0x45, 0x33, 0x32, 0x00

DS0041:
	.byte  0x55, 0x53, 0x45, 0x36, 0x34, 0x00

DS0042:
	.byte  0x50, 0x52, 0x45, 0x46, 0x45, 0x52, 0x5F, 0x46
	.byte  0x49, 0x52, 0x53, 0x54, 0x00

DS0043:
	.byte  0x50, 0x52, 0x45, 0x46, 0x45, 0x52, 0x5F, 0x56
	.byte  0x45, 0x58, 0x00

DS0044:
	.byte  0x50, 0x52, 0x45, 0x46, 0x45, 0x52, 0x5F, 0x56
	.byte  0x45, 0x58, 0x33, 0x00

DS0045:
	.byte  0x50, 0x52, 0x45, 0x46, 0x45, 0x52, 0x5F, 0x45
	.byte  0x56, 0x45, 0x58, 0x00

DS0046:
	.byte  0x4E, 0x4F, 0x5F, 0x45, 0x56, 0x45, 0x58, 0x00

DS0047:
	.byte  0x41, 0x55, 0x54, 0x4F, 0x00

DS0048:
	.byte  0x4E, 0x4F, 0x41, 0x55, 0x54, 0x4F, 0x00

DS0049:
	.byte  0x4E, 0x4F, 0x41, 0x4C, 0x49, 0x47, 0x4E, 0x00

DS004A:
	.byte  0x53, 0x41, 0x56, 0x45, 0x00

DS004B:
	.byte  0x4E, 0x4F, 0x53, 0x41, 0x56, 0x45, 0x00

DS004C:
	.byte  0x4E, 0x4F, 0x46, 0x52, 0x41, 0x4D, 0x45, 0x00

DS004D:
	.byte  0x5F, 0x5F, 0x69, 0x6D, 0x70, 0x5F, 0x00

DS004E:
	.byte  0x4F, 0x4E, 0x00

DS004F:
	.byte  0x4F, 0x46, 0x46, 0x00

DS0050:
	.byte  0x50, 0x41, 0x53, 0x43, 0x41, 0x4C, 0x00

DS0051:
	.byte  0x54, 0x41, 0x42, 0x4C, 0x45, 0x00

DS0052:
	.byte  0x4E, 0x4F, 0x54, 0x41, 0x42, 0x4C, 0x45, 0x00

DS0053:
	.byte  0x52, 0x45, 0x47, 0x41, 0x58, 0x00

DS0054:
	.byte  0x4E, 0x4F, 0x52, 0x45, 0x47, 0x53, 0x00


.SECTION .rodata
	.ALIGN	16

DS0000:
	.byte  0x44, 0x4F, 0x54, 0x4E, 0x41, 0x4D, 0x45, 0x00

DS0001:
	.byte  0x4E, 0x4F, 0x44, 0x4F, 0x54, 0x4E, 0x41, 0x4D
	.byte  0x45, 0x00

DS0002:
	.byte  0x4D, 0x35, 0x31, 0x30, 0x00

DS0003:
	.byte  0x4E, 0x4F, 0x4D, 0x35, 0x31, 0x30, 0x00

DS0004:
	.byte  0x53, 0x43, 0x4F, 0x50, 0x45, 0x44, 0x00

DS0005:
	.byte  0x4E, 0x4F, 0x53, 0x43, 0x4F, 0x50, 0x45, 0x44
	.byte  0x00

DS0006:
	.byte  0x4F, 0x4C, 0x44, 0x53, 0x54, 0x52, 0x55, 0x43
	.byte  0x54, 0x53, 0x00

DS0007:
	.byte  0x4E, 0x4F, 0x4F, 0x4C, 0x44, 0x53, 0x54, 0x52
	.byte  0x55, 0x43, 0x54, 0x53, 0x00

DS0008:
	.byte  0x45, 0x4D, 0x55, 0x4C, 0x41, 0x54, 0x4F, 0x52
	.byte  0x00

DS0009:
	.byte  0x4E, 0x4F, 0x45, 0x4D, 0x55, 0x4C, 0x41, 0x54
	.byte  0x4F, 0x52, 0x00

DS000A:
	.byte  0x4C, 0x4A, 0x4D, 0x50, 0x00

DS000B:
	.byte  0x4E, 0x4F, 0x4C, 0x4A, 0x4D, 0x50, 0x00

DS000C:
	.byte  0x52, 0x45, 0x41, 0x44, 0x4F, 0x4E, 0x4C, 0x59
	.byte  0x00

DS000D:
	.byte  0x4E, 0x4F, 0x52, 0x45, 0x41, 0x44, 0x4F, 0x4E
	.byte  0x4C, 0x59, 0x00

DS000E:
	.byte  0x4F, 0x4C, 0x44, 0x4D, 0x41, 0x43, 0x52, 0x4F
	.byte  0x53, 0x00

DS000F:
	.byte  0x4E, 0x4F, 0x4F, 0x4C, 0x44, 0x4D, 0x41, 0x43
	.byte  0x52, 0x4F, 0x53, 0x00

DS0010:
	.byte  0x45, 0x58, 0x50, 0x52, 0x31, 0x36, 0x00

DS0011:
	.byte  0x45, 0x58, 0x50, 0x52, 0x33, 0x32, 0x00

DS0012:
	.byte  0x4E, 0x4F, 0x53, 0x49, 0x47, 0x4E, 0x45, 0x58
	.byte  0x54, 0x45, 0x4E, 0x44, 0x00

DS0013:
	.byte  0x43, 0x41, 0x53, 0x45, 0x4D, 0x41, 0x50, 0x00

DS0014:
	.byte  0x50, 0x52, 0x4F, 0x43, 0x00

DS0015:
	.byte  0x50, 0x52, 0x4F, 0x4C, 0x4F, 0x47, 0x55, 0x45
	.byte  0x00

DS0016:
	.byte  0x45, 0x50, 0x49, 0x4C, 0x4F, 0x47, 0x55, 0x45
	.byte  0x00

DS0017:
	.byte  0x4C, 0x41, 0x4E, 0x47, 0x55, 0x41, 0x47, 0x45
	.byte  0x00

DS0018:
	.byte  0x4E, 0x4F, 0x4B, 0x45, 0x59, 0x57, 0x4F, 0x52
	.byte  0x44, 0x00

DS0019:
	.byte  0x53, 0x45, 0x54, 0x49, 0x46, 0x32, 0x00

DS001A:
	.byte  0x4F, 0x46, 0x46, 0x53, 0x45, 0x54, 0x00

DS001B:
	.byte  0x53, 0x45, 0x47, 0x4D, 0x45, 0x4E, 0x54, 0x00

DS001C:
	.byte  0x41, 0x56, 0x58, 0x45, 0x4E, 0x43, 0x4F, 0x44
	.byte  0x49, 0x4E, 0x47, 0x00

DS001D:
	.byte  0x46, 0x49, 0x45, 0x4C, 0x44, 0x41, 0x4C, 0x49
	.byte  0x47, 0x4E, 0x00

DS001E:
	.byte  0x50, 0x52, 0x4F, 0x43, 0x41, 0x4C, 0x49, 0x47
	.byte  0x4E, 0x00

DS001F:
	.byte  0x4D, 0x5A, 0x00

DS0020:
	.byte  0x46, 0x52, 0x41, 0x4D, 0x45, 0x00

DS0021:
	.byte  0x45, 0x4C, 0x46, 0x00

DS0022:
	.byte  0x52, 0x45, 0x4E, 0x41, 0x4D, 0x45, 0x4B, 0x45
	.byte  0x59, 0x57, 0x4F, 0x52, 0x44, 0x00

DS0023:
	.byte  0x57, 0x49, 0x4E, 0x36, 0x34, 0x00

DS0024:
	.byte  0x44, 0x4C, 0x4C, 0x49, 0x4D, 0x50, 0x4F, 0x52
	.byte  0x54, 0x00

DS0025:
	.byte  0x43, 0x4F, 0x44, 0x45, 0x56, 0x49, 0x45, 0x57
	.byte  0x00

DS0026:
	.byte  0x53, 0x54, 0x41, 0x43, 0x4B, 0x42, 0x41, 0x53
	.byte  0x45, 0x00

DS0027:
	.byte  0x43, 0x53, 0x54, 0x41, 0x43, 0x4B, 0x00

DS0028:
	.byte  0x53, 0x57, 0x49, 0x54, 0x43, 0x48, 0x00

DS0029:
	.byte  0x4C, 0x4F, 0x4F, 0x50, 0x41, 0x4C, 0x49, 0x47
	.byte  0x4E, 0x00

DS002A:
	.byte  0x43, 0x41, 0x53, 0x45, 0x41, 0x4C, 0x49, 0x47
	.byte  0x4E, 0x00

DS002B:
	.byte  0x57, 0x53, 0x54, 0x52, 0x49, 0x4E, 0x47, 0x00

DS002C:
	.byte  0x43, 0x4F, 0x44, 0x45, 0x50, 0x41, 0x47, 0x45
	.byte  0x00

DS002D:
	.byte  0x46, 0x4C, 0x4F, 0x41, 0x54, 0x46, 0x4F, 0x52
	.byte  0x4D, 0x41, 0x54, 0x00

DS002E:
	.byte  0x46, 0x4C, 0x4F, 0x41, 0x54, 0x44, 0x49, 0x47
	.byte  0x49, 0x54, 0x53, 0x00

DS002F:
	.byte  0x4C, 0x49, 0x4E, 0x45, 0x53, 0x49, 0x5A, 0x45
	.byte  0x00

DS0030:
	.byte  0x46, 0x4C, 0x4F, 0x41, 0x54, 0x00

DS0031:
	.byte  0x44, 0x4F, 0x54, 0x4E, 0x41, 0x4D, 0x45, 0x58
	.byte  0x00


.att_syntax prefix
