

.intel_syntax noprefix

.global SwitchDirective

.extern HllContinueIf
.extern ExpandHllExpression
.extern ExpandHllProc
.extern EvaluateHllExpression
.extern ExpandCStrings
.extern GetLabelStr
.extern GetResWName
.extern Tokenize
.extern RunLineQueue
.extern AddLineQueueX
.extern AddLineQueue
.extern LstWrite
.extern GetCurrOffset
.extern EvalOperand
.extern SizeFromMemtype
.extern LclDup
.extern LclAlloc
.extern tstricmp
.extern tstrcmp
.extern tstrcpy
.extern tstrchr
.extern tmemcpy
.extern tsprintf
.extern asmerr
.extern ModuleInfo
.extern Parse_Pass
.extern SymFind


.SECTION .text
	.ALIGN	16

$_001:	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 88
	mov	rsi, rcx
	mov	rbx, rdx
	mov	rdi, r8
	mov	rcx, qword ptr [rbx+0x20]
	test	rcx, rcx
	jnz	$_002
	mov	edx, dword ptr [rbx+0x18]
	lea	rcx, [DS0000+rip]
	call	AddLineQueueX@PLT
	jmp	$_004

$_002:	mov	edx, 46
	call	tstrchr@PLT
	test	rax, rax
	jz	$_003
	cmp	byte ptr [rax+0x1], 46
	jnz	$_003
	mov	byte ptr [rax], 0
	lea	rdi, [rax+0x2]
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	ecx, eax
	lea	rax, [DS0002+rip]
	mov	qword ptr [rsp+0x40], rax
	mov	dword ptr [rsp+0x38], ecx
	mov	eax, dword ptr [rbx+0x18]
	mov	dword ptr [rsp+0x30], eax
	mov	qword ptr [rsp+0x28], rdi
	mov	rax, qword ptr [rsi+0x20]
	mov	qword ptr [rsp+0x20], rax
	mov	r9d, ecx
	mov	r8, qword ptr [rbx+0x20]
	mov	rdx, qword ptr [rsi+0x20]
	lea	rcx, [DS0001+rip]
	call	AddLineQueueX@PLT
	jmp	$_004

$_003:	mov	r9d, dword ptr [rbx+0x18]
	mov	r8, qword ptr [rbx+0x20]
	mov	rdx, qword ptr [rsi+0x20]
	lea	rcx, [DS0003+rip]
	call	AddLineQueueX@PLT
$_004:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_005:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, rcx
	mov	rdi, rdx
	lea	r8, [DS0002+rip]
	mov	rdx, rdi
	lea	rcx, [DS0004+rip]
	call	AddLineQueueX@PLT
	mov	rbx, qword ptr [rsi+0x8]
	jmp	$_007

$_006:	mov	r8, rdi
	mov	rdx, rbx
	mov	rcx, rsi
	call	$_001
	mov	rbx, qword ptr [rbx+0x8]
$_007:	test	rbx, rbx
	jnz	$_006
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_008:
	mov	qword ptr [rsp+0x18], r8
	push	rbp
	mov	rbp, rsp
	add	rdx, qword ptr [rbp+0x20]
	xor	eax, eax
	mov	rcx, qword ptr [rcx+0x8]
	jmp	$_011

$_009:	test	byte ptr [rcx+0x2D], 0x40
	jz	$_010
	cmp	rdx, qword ptr [rcx+0x10]
	jl	$_010
	add	eax, 1
$_010:	mov	rcx, qword ptr [rcx+0x8]
$_011:	test	rcx, rcx
	jnz	$_009
	leave
	ret

$_012:
	mov	qword ptr [rsp+0x18], r8
	push	rbp
	mov	rbp, rsp
	sub	rdx, qword ptr [rbp+0x20]
	xor	eax, eax
	mov	rcx, qword ptr [rcx+0x8]
	jmp	$_015

$_013:	test	byte ptr [rcx+0x2D], 0x40
	jz	$_014
	cmp	rdx, qword ptr [rcx+0x10]
	jg	$_014
	add	eax, 1
$_014:	mov	rcx, qword ptr [rcx+0x8]
$_015:	test	rcx, rcx
	jnz	$_013
	leave
	ret

$_016:
	mov	qword ptr [rsp+0x20], r9
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rbx, r8
	add	rbx, qword ptr [rbp+0x30]
	xor	eax, eax
	mov	rcx, qword ptr [rcx+0x8]
	jmp	$_019

$_017:	test	byte ptr [rcx+0x2D], 0x40
	jz	$_018
	cmp	rbx, qword ptr [rcx+0x10]
	jge	$_018
	and	dword ptr [rcx+0x2C], 0xFFFFBFFF
	dec	dword ptr [rdx]
	inc	eax
$_018:	mov	rcx, qword ptr [rcx+0x8]
$_019:	test	rcx, rcx
	jnz	$_017
	mov	edx, dword ptr [rdx]
	leave
	pop	rbx
	ret

$_020:
	mov	qword ptr [rsp+0x20], r9
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rbx, r8
	sub	rbx, qword ptr [rbp+0x30]
	xor	eax, eax
	mov	rcx, qword ptr [rcx+0x8]
	jmp	$_023

$_021:	test	byte ptr [rcx+0x2D], 0x40
	jz	$_022
	cmp	rbx, qword ptr [rcx+0x10]
	jle	$_022
	and	dword ptr [rcx+0x2C], 0xFFFFBFFF
	dec	dword ptr [rdx]
	inc	eax
$_022:	mov	rcx, qword ptr [rcx+0x8]
$_023:	test	rcx, rcx
	jnz	$_021
	mov	edx, dword ptr [rdx]
	leave
	pop	rbx
	ret

$_024:
	mov	rax, qword ptr [rcx+0x8]
	jmp	$_027

$_025:	test	byte ptr [rax+0x2D], 0x40
	jz	$_026
	cmp	qword ptr [rax+0x10], rdx
	jnz	$_026
	jmp	$_028

$_026:	mov	rcx, rax
	mov	rax, qword ptr [rax+0x8]
$_027:	test	rax, rax
	jnz	$_025
$_028:	ret

$_029:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	call	$_024
	test	rax, rax
	jz	$_030
	and	dword ptr [rax+0x2C], 0xFFFFBFFF
	mov	eax, 1
$_030:	leave
	ret

$_031:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 184
	mov	byte ptr [rbp-0x74], 1
	xor	edi, edi
	xor	ebx, ebx
	mov	rax, qword ptr [rdx+0x10]
	mov	qword ptr [rbp-0x80], rax
	mov	rsi, qword ptr [rbp+0x28]
	mov	eax, dword ptr [rsi+0x2C]
	and	eax, 0xE00
	cmp	eax, 512
	jnz	$_032
	inc	byte ptr [rbp-0x74]
	jmp	$_034

$_032:	cmp	eax, 1024
	jnz	$_033
	mov	byte ptr [rbp-0x74], 4
	jmp	$_034

$_033:	cmp	eax, 2048
	jnz	$_034
	mov	byte ptr [rbp-0x74], 8
$_034:	mov	rsi, qword ptr [rsi+0x8]
	jmp	$_042

$_035:	test	byte ptr [rsi+0x2D], 0x20
	je	$_040
	or	byte ptr [rsi+0x2D], 0x40
	xor	r9d, r9d
	mov	r8, qword ptr [rbp+0x30]
	xor	edx, edx
	mov	rcx, qword ptr [rsi+0x20]
	call	Tokenize@PLT
	mov	dword ptr [ModuleInfo+0x220+rip], eax
	mov	dword ptr [rbp-0x4], 0
	mov	ecx, eax
	mov	byte ptr [rsp+0x20], 1
	lea	r9, [rbp-0x70]
	mov	r8d, ecx
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp-0x4]
	call	EvalOperand@PLT
	test	eax, eax
	jnz	$_043
	mov	rax, qword ptr [rbp-0x70]
	cmp	byte ptr [rbp-0x74], 1
	jnz	$_036
	movsx	rax, al
	jmp	$_038

$_036:	cmp	byte ptr [rbp-0x74], 2
	jnz	$_037
	movsx	rax, ax
	jmp	$_038

$_037:	cmp	byte ptr [rbp-0x74], 4
	jnz	$_038
	movsxd	rax, eax
$_038:	cmp	dword ptr [rbp-0x34], 1
	jnz	$_039
	mov	rcx, qword ptr [rbp-0x20]
	mov	ecx, dword ptr [rcx+0x28]
	add	rax, rcx
$_039:	mov	qword ptr [rsi+0x10], rax
	inc	ebx
	jmp	$_041

$_040:	cmp	qword ptr [rsi+0x20], 0
	jz	$_041
	inc	edi
$_041:	mov	rsi, qword ptr [rsi+0x8]
$_042:	test	rsi, rsi
	jne	$_035
$_043:	xor	r9d, r9d
	mov	r8, qword ptr [rbp+0x30]
	xor	edx, edx
	mov	rcx, qword ptr [rbp-0x80]
	call	Tokenize@PLT
	mov	dword ptr [ModuleInfo+0x220+rip], eax
	mov	rax, qword ptr [rbp+0x38]
	mov	dword ptr [rax], edi
	mov	rax, qword ptr [rbp+0x40]
	mov	dword ptr [rax], ebx
	test	ebx, ebx
	jz	$_047
	cmp	dword ptr [Parse_Pass+rip], 0
	jz	$_047
	mov	rsi, qword ptr [rbp+0x28]
	mov	rsi, qword ptr [rsi+0x8]
	mov	rdi, qword ptr [rsi+0x8]
	jmp	$_046

$_044:	test	byte ptr [rsi+0x2D], 0x20
	jz	$_045
	mov	edx, dword ptr [rsi+0x10]
	mov	rcx, rsi
	call	$_024
	test	rax, rax
	jz	$_045
	mov	rcx, rax
	mov	eax, dword ptr [rcx+0x10]
	mov	dword ptr [rsp+0x20], eax
	mov	r9, qword ptr [rcx+0x20]
	mov	r8d, dword ptr [rsi+0x10]
	mov	rdx, qword ptr [rsi+0x20]
	mov	ecx, 3022
	call	asmerr@PLT
$_045:	mov	rsi, qword ptr [rsi+0x8]
	mov	rdi, qword ptr [rsi+0x8]
$_046:	test	rdi, rdi
	jnz	$_044
$_047:	mov	eax, ebx
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_048:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rsi, rcx
	xor	edi, edi
	movabs	rax, 0x8000000000000000
	movabs	rdx, 0x7FFFFFFFFFFFFFFF
	mov	rsi, qword ptr [rsi+0x8]
	jmp	$_051

$_049:	test	byte ptr [rsi+0x2D], 0x40
	jz	$_050
	inc	edi
	mov	rcx, qword ptr [rsi+0x10]
	cmp	rcx, rax
	cmovg	rax, rcx
	cmp	rcx, rdx
	cmovl	rdx, rcx
$_050:	mov	rsi, qword ptr [rsi+0x8]
$_051:	test	rsi, rsi
	jnz	$_049
	test	edi, edi
	jnz	$_052
	xor	eax, eax
	xor	edx, edx
$_052:	mov	rbx, qword ptr [rbp+0x38]
	mov	rcx, qword ptr [rbp+0x30]
	mov	qword ptr [rbx], rax
	mov	qword ptr [rcx], rdx
	mov	rsi, qword ptr [rbp+0x28]
	mov	ecx, 1
	mov	eax, 8
	test	byte ptr [rsi+0x2C], 0x40
	jz	$_053
	mov	eax, 1
	jmp	$_054

$_053:	test	dword ptr [rsi+0x2C], 0x80
	jnz	$_054
	add	eax, 2
	add	ecx, 1
	test	byte ptr [rsi+0x2D], 0x0E
	jnz	$_054
	add	eax, 1
	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jnz	$_054
	add	eax, 10
$_054:	mov	rsi, qword ptr [rbp+0x40]
	mov	dword ptr [rsi], eax
	mov	rsi, qword ptr [rbp+0x48]
	mov	eax, edi
	shl	eax, cl
	mov	dword ptr [rsi], eax
	mov	rax, qword ptr [rbx]
	sub	rax, rdx
	mov	ecx, edi
	add	rax, 1
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_055:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rsi, rcx
	xor	edi, edi
	xor	edx, edx
	jmp	$_063

$_056:	mov	al, byte ptr [rsi]
	mov	ah, byte ptr [rsi-0x18]
	mov	ecx, dword ptr [rsi-0x14]
	jmp	$_061

$_057:	inc	edx
	jmp	$_062

$_058:	dec	edx
	jmp	$_062

$_059:	test	edx, edx
	jnz	$_062
	cmp	ah, 2
	jnz	$_060
	cmp	ecx, 25
	jc	$_060
	cmp	ecx, 31
	jbe	$_062
$_060:	mov	byte ptr [rsi], 0
	mov	rdi, rsi
	jmp	$_064

$_061:	cmp	al, 40
	jz	$_057
	cmp	al, 41
	jz	$_058
	cmp	al, 58
	jz	$_059
$_062:	add	rsi, 24
$_063:	cmp	byte ptr [rsi], 0
	jnz	$_056
$_064:	mov	rax, rdi
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_065:
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
	mov	rbx, r9
	add	rbx, 24
	mov	rax, rbx
	mov	rsi, rbx
	xor	edi, edi
	mov	dword ptr [rbp-0x4], edi
	mov	rcx, rbx
	call	$_055
	mov	qword ptr [rbp-0x10], rax
$_066:	mov	al, byte ptr [rbx]
	jmp	$_071

$_067:	jmp	$_073

$_068:	inc	edi
	jmp	$_072

$_069:	dec	edi
	jmp	$_072

$_070:	test	edi, edi
	jnz	$_072
	mov	rdi, qword ptr [rbx+0x10]
	mov	byte ptr [rdi], 0
	mov	rdx, qword ptr [rsi+0x10]
	mov	rcx, qword ptr [rbp+0x38]
	call	tstrcpy@PLT
	lea	rsi, [rbx+0x18]
	mov	byte ptr [rdi], 44
	xor	edi, edi
	inc	dword ptr [rbp-0x4]
	mov	rdx, qword ptr [rbp+0x38]
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
	mov	byte ptr [rbx], 0
	jmp	$_072

$_071:	cmp	al, 0
	jz	$_067
	cmp	al, 40
	jz	$_068
	cmp	al, 41
	jz	$_069
	cmp	al, 44
	jz	$_070
$_072:	add	rbx, 24
	jmp	$_066

$_073:
	mov	rbx, qword ptr [rbp-0x10]
	test	rbx, rbx
	jz	$_074
	mov	byte ptr [rbx], 58
$_074:	mov	eax, dword ptr [rbp-0x4]
	test	eax, eax
	jz	$_079
	mov	rdx, qword ptr [rsi+0x10]
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
	mov	rbx, qword ptr [rbp+0x40]
	xor	eax, eax
	jmp	$_076

$_075:	add	eax, 1
	add	rbx, 24
$_076:	cmp	byte ptr [rbx], 0
	jnz	$_075
	mov	rbx, qword ptr [rbp+0x30]
	mov	dword ptr [rbx], eax
	mov	rsi, qword ptr [rbp+0x28]
	test	byte ptr [rsi+0x2E], 0x10
	jz	$_078
	and	dword ptr [rsi+0x2C], 0xFFEFFFFF
	cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_077
	call	GetCurrOffset@PLT
	xor	r8d, r8d
	mov	edx, eax
	mov	ecx, 4
	call	LstWrite@PLT
$_077:	call	RunLineQueue@PLT
	or	byte ptr [rsi+0x2E], 0x10
$_078:	mov	eax, 1
$_079:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_080:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	rax, qword ptr [rbp+0x28]
	mov	qword ptr [rsp+0x30], rax
	mov	rax, qword ptr [rbp+0x18]
	mov	qword ptr [rsp+0x28], rax
	mov	rax, qword ptr [rbp+0x10]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp+0x28]
	mov	r8, qword ptr [rbp+0x20]
	mov	rdx, qword ptr [rbp+0x10]
	lea	rcx, [DS0006+rip]
	call	AddLineQueueX@PLT
	leave
	ret

$_081:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 104
	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jnz	$_082
	mov	edx, dword ptr [rbp+0x18]
	lea	rcx, [DS0007+rip]
	call	AddLineQueueX@PLT
$_082:	lea	rdx, [rbp-0x40]
	mov	ecx, dword ptr [rbp+0x18]
	call	GetResWName@PLT
	mov	eax, dword ptr [rbp+0x20]
	mov	edx, dword ptr [rbp+0x18]
	mov	rbx, qword ptr [rbp+0x28]
	test	eax, 0xE00
	jnz	$_088
	mov	ecx, dword ptr [ModuleInfo+0x1C0+rip]
	and	ecx, 0xF0
	cmp	ecx, 48
	jc	$_085
	test	eax, 0x100
	jz	$_083
	mov	r8, rbx
	lea	rcx, [DS0008+rip]
	call	AddLineQueueX@PLT
	jmp	$_084

$_083:	mov	r8, rbx
	lea	rcx, [DS0009+rip]
	call	AddLineQueueX@PLT
$_084:	jmp	$_087

$_085:	mov	rdx, rbx
	lea	rcx, [DS000A+rip]
	call	tstricmp@PLT
	test	eax, eax
	jz	$_086
	mov	rdx, rbx
	lea	rcx, [DS000B+rip]
	call	AddLineQueueX@PLT
$_086:	lea	rcx, [DS000C+rip]
	call	AddLineQueue@PLT
$_087:	jmp	$_101

$_088:	test	eax, 0x200
	jz	$_094
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jnz	$_091
	test	eax, 0x100
	jz	$_089
	mov	r8, rbx
	lea	rcx, [DS000D+rip]
	call	AddLineQueueX@PLT
	jmp	$_090

$_089:	lea	rdx, [rbp-0x40]
	mov	rcx, rbx
	call	tstricmp@PLT
	test	eax, eax
	jz	$_090
	mov	r8, rbx
	lea	rcx, [DS000E+rip]
	call	AddLineQueueX@PLT
$_090:	jmp	$_093

$_091:	test	eax, 0x100
	jz	$_092
	mov	r8, rbx
	lea	rcx, [DS000F+rip]
	call	AddLineQueueX@PLT
	jmp	$_093

$_092:	mov	r8, rbx
	lea	rcx, [DS0009+rip]
	call	AddLineQueueX@PLT
$_093:	jmp	$_101

$_094:	test	eax, 0x400
	jz	$_100
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 1
	jnz	$_097
	test	eax, 0x100
	jz	$_095
	mov	r8, rbx
	lea	rcx, [DS0010+rip]
	call	AddLineQueueX@PLT
	jmp	$_096

$_095:	lea	rdx, [rbp-0x40]
	mov	rcx, rbx
	call	tstricmp@PLT
	test	eax, eax
	jz	$_096
	mov	r8, rbx
	lea	rcx, [DS0011+rip]
	call	AddLineQueueX@PLT
$_096:	jmp	$_099

$_097:	test	eax, 0x100
	jz	$_098
	mov	r8, rbx
	lea	rcx, [DS0012+rip]
	call	AddLineQueueX@PLT
	jmp	$_099

$_098:	mov	r8, rbx
	lea	rcx, [DS0013+rip]
	call	AddLineQueueX@PLT
$_099:	jmp	$_101

$_100:	mov	r8, rbx
	lea	rcx, [DS0014+rip]
	call	AddLineQueueX@PLT
$_101:	leave
	pop	rbx
	ret

$_102:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	ecx, 713
	mov	edx, 4
	cmp	dword ptr [rbp+0x10], 205
	jnz	$_103
	mov	edx, 1
	mov	ecx, 750
	jmp	$_104

$_103:	cmp	dword ptr [rbp+0x10], 207
	jnz	$_104
	mov	edx, 2
	mov	ecx, 750
$_104:	mov	rax, qword ptr [rbp+0x30]
	mov	qword ptr [rsp+0x40], rax
	mov	rax, qword ptr [rbp+0x28]
	mov	qword ptr [rsp+0x38], rax
	mov	dword ptr [rsp+0x30], edx
	mov	rax, qword ptr [rbp+0x20]
	mov	qword ptr [rsp+0x28], rax
	mov	dword ptr [rsp+0x20], edx
	mov	r9d, dword ptr [rbp+0x18]
	mov	r8d, dword ptr [rbp+0x10]
	mov	edx, ecx
	lea	rcx, [DS0015+rip]
	call	AddLineQueueX@PLT
	leave
	ret

$_105:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 232
	lea	rax, [rbp-0x28]
	mov	qword ptr [rbp-0x48], rax
	lea	rax, [rbp-0x18]
	mov	qword ptr [rbp-0x50], rax
	mov	rax, qword ptr [rbp+0x40]
	mov	qword ptr [rbp-0x58], rax
	mov	rsi, rcx
	mov	rdi, r8
	lea	r9, [rbp-0x60]
	lea	r8, [rbp-0x5C]
	mov	rdx, qword ptr [rbp+0x30]
	mov	rcx, rsi
	call	$_031
	test	eax, eax
	jz	$_106
	test	byte ptr [rsi+0x2C], 0x40
	jz	$_106
	add	eax, 8
$_106:	test	byte ptr [ModuleInfo+0x334+rip], 0x10
	jnz	$_107
	cmp	eax, 8
	jnc	$_108
$_107:	mov	rdx, rdi
	mov	rcx, rsi
	call	$_005
	jmp	$_225

$_108:	mov	dword ptr [rbp-0x64], 210
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jnz	$_109
	mov	dword ptr [rbp-0x64], 207
$_109:	mov	rdx, rdi
	mov	rcx, qword ptr [rbp-0x50]
	call	tstrcpy@PLT
	mov	qword ptr [rbp-0x70], 0
	test	byte ptr [rsi+0x2C], 0x01
	jz	$_112
	mov	rax, rsi
	mov	rbx, qword ptr [rsi+0x8]
$_110:	test	rbx, rbx
	jz	$_112
	test	byte ptr [rbx+0x2C], 0x10
	jz	$_111
	mov	qword ptr [rax+0x8], 0
	mov	qword ptr [rbp-0x70], rbx
	mov	rdx, qword ptr [rbp+0x40]
	mov	ecx, dword ptr [rbx+0x18]
	call	GetLabelStr@PLT
	jmp	$_112

$_111:	mov	rax, rbx
	mov	rbx, qword ptr [rbx+0x8]
	jmp	$_110

$_112:	cmp	byte ptr [ModuleInfo+0x336+rip], 0
	jz	$_113
	test	byte ptr [rsi+0x2E], 0x40
	jnz	$_113
	mov	cl, byte ptr [ModuleInfo+0x336+rip]
	mov	eax, 1
	shl	eax, cl
	mov	edx, eax
	lea	rcx, [DS0016+rip]
	call	AddLineQueueX@PLT
	jmp	$_114

$_113:	test	byte ptr [rsi+0x2C], 0x40
	jz	$_114
	test	byte ptr [rsi+0x2E], 0x20
	jz	$_114
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_114
	test	byte ptr [rsi+0x2E], 0x40
	jnz	$_114
	lea	rcx, [DS0017+rip]
	call	AddLineQueue@PLT
$_114:	lea	r8, [DS0002+rip]
	mov	rdx, qword ptr [rbp-0x50]
	lea	rcx, [DS0004+rip]
	call	AddLineQueueX@PLT
	cmp	dword ptr [rbp-0x5C], 0
	jz	$_117
	mov	rax, rsi
	mov	rbx, qword ptr [rsi+0x8]
$_115:	test	rbx, rbx
	jz	$_117
	test	byte ptr [rbx+0x2D], 0x20
	jnz	$_116
	mov	rcx, qword ptr [rbx+0x8]
	mov	qword ptr [rax+0x8], rcx
	mov	r8, rdi
	mov	rdx, rbx
	mov	rcx, rsi
	call	$_001
$_116:	mov	rax, rbx
	mov	rbx, qword ptr [rbx+0x8]
	jmp	$_115

$_117:	jmp	$_221

$_118:	lea	rax, [rbp-0x88]
	mov	qword ptr [rsp+0x20], rax
	lea	r9, [rbp-0x84]
	lea	r8, [rbp-0x80]
	lea	rdx, [rbp-0x78]
	mov	rcx, rsi
	call	$_048
	mov	qword ptr [rbp-0x90], rax
	mov	dword ptr [rbp-0x94], ecx
	mov	dword ptr [rbp-0x98], 0
	cmp	ecx, dword ptr [rbp-0x84]
	jc	$_222
	mov	ebx, ecx
$_119:	cmp	ebx, dword ptr [rbp-0x84]
	jc	$_126
	cmp	qword ptr [rbp-0x80], rdx
	jle	$_126
	cmp	eax, dword ptr [rbp-0x88]
	jbe	$_126
	mov	r8d, dword ptr [rbp-0x88]
	mov	rdx, qword ptr [rbp-0x78]
	mov	rcx, rsi
	call	$_008
	mov	ebx, eax
	mov	r8d, dword ptr [rbp-0x88]
	mov	rdx, qword ptr [rbp-0x80]
	mov	rcx, rsi
	call	$_012
	jmp	$_124

$_120:	mov	rdx, qword ptr [rbp-0x78]
	mov	rcx, rsi
	call	$_029
	test	rax, rax
	je	$_126
	sub	dword ptr [rbp-0x94], eax
	jmp	$_125

$_121:	mov	rdx, qword ptr [rbp-0x80]
	mov	rcx, rsi
	call	$_029
	test	rax, rax
	je	$_126
	sub	dword ptr [rbp-0x94], eax
	jmp	$_125

$_122:	mov	ebx, dword ptr [rbp-0x94]
	mov	r9d, dword ptr [rbp-0x88]
	mov	r8, qword ptr [rbp-0x78]
	lea	rdx, [rbp-0x94]
	mov	rcx, rsi
	call	$_016
	jmp	$_125

$_123:	mov	ebx, dword ptr [rbp-0x94]
	mov	r9d, dword ptr [rbp-0x88]
	mov	r8, qword ptr [rbp-0x80]
	lea	rdx, [rbp-0x94]
	mov	rcx, rsi
	call	$_020
	jmp	$_125

$_124:	cmp	ebx, dword ptr [rbp-0x84]
	jc	$_120
	cmp	eax, dword ptr [rbp-0x84]
	jc	$_121
	cmp	ebx, eax
	jnc	$_122
	jmp	$_123

$_125:	add	dword ptr [rbp-0x98], eax
	lea	rax, [rbp-0x88]
	mov	qword ptr [rsp+0x20], rax
	lea	r9, [rbp-0x84]
	lea	r8, [rbp-0x80]
	lea	rdx, [rbp-0x78]
	mov	rcx, rsi
	call	$_048
	mov	qword ptr [rbp-0x90], rax
	cmp	ebx, dword ptr [rbp-0x94]
	jz	$_126
	mov	ebx, dword ptr [rbp-0x94]
	jmp	$_119

$_126:	mov	eax, dword ptr [rbp-0x94]
	cmp	eax, dword ptr [rbp-0x84]
	jc	$_222
	mov	byte ptr [rbp-0x39], 0
	cmp	rax, qword ptr [rbp-0x90]
	jge	$_127
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_127
	inc	byte ptr [rbp-0x39]
$_127:	test	byte ptr [rsi+0x2C], 0x40
	jz	$_128
	test	byte ptr [rsi+0x2E], 0x20
	jz	$_128
	mov	rdx, qword ptr [rbp-0x50]
	mov	rcx, qword ptr [rbp-0x48]
	call	tstrcpy@PLT
	mov	r8, qword ptr [rbp-0x78]
	mov	rdx, rax
	lea	rcx, [DS0018+rip]
	call	AddLineQueueX@PLT
	jmp	$_129

$_128:	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	rdx, qword ptr [rbp-0x48]
	mov	ecx, eax
	call	GetLabelStr@PLT
$_129:	mov	rdi, qword ptr [rbp+0x40]
	cmp	dword ptr [rbp-0x98], 0
	jz	$_130
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	rdx, qword ptr [rbp-0x50]
	mov	ecx, eax
	call	GetLabelStr@PLT
	mov	rdi, rax
$_130:	mov	rbx, qword ptr [rsi+0x20]
	test	byte ptr [rsi+0x2C], 0x40
	jnz	$_131
	mov	r9, rdi
	mov	r8, qword ptr [rbp-0x78]
	mov	rdx, qword ptr [rbp-0x80]
	mov	rcx, rbx
	call	$_080
$_131:	mov	cl, byte ptr [ModuleInfo+0x1CC+rip]
	test	byte ptr [rsi+0x2C], 0x40
	jz	$_134
	test	byte ptr [rsi+0x2E], 0x20
	jz	$_134
	test	byte ptr [rsi+0x2E], 0x40
	jz	$_132
	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0019+rip]
	call	AddLineQueueX@PLT
	jmp	$_133

$_132:	cmp	cl, 2
	jnz	$_133
	mov	dword ptr [rbp-0x64], 214
$_133:	jmp	$_192

$_134:	test	cl, cl
	jne	$_146
	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jnz	$_135
	lea	rcx, [DS001A+rip]
	call	AddLineQueue@PLT
$_135:	test	dword ptr [rsi+0x2C], 0x80
	jz	$_139
	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jz	$_137
	mov	rdx, rbx
	lea	rcx, [DS001A+0x6+rip]
	call	tstricmp@PLT
	test	eax, eax
	jz	$_136
	mov	rdx, rbx
	lea	rcx, [DS001B+rip]
	call	AddLineQueueX@PLT
$_136:	lea	rcx, [DS001C+rip]
	call	AddLineQueue@PLT
	jmp	$_138

$_137:	lea	rcx, [DS001D+rip]
	call	AddLineQueue@PLT
	mov	rdx, rbx
	lea	rcx, [DS001C+0xA+rip]
	call	tstricmp@PLT
	test	eax, eax
	jz	$_138
	mov	rdx, rbx
	lea	rcx, [DS001E+rip]
	call	AddLineQueueX@PLT
$_138:	jmp	$_142

$_139:	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jnz	$_140
	lea	rcx, [DS001F+rip]
	call	AddLineQueue@PLT
$_140:	mov	r8, rbx
	mov	edx, dword ptr [rsi+0x2C]
	mov	ecx, 9
	call	$_081
	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jz	$_141
	lea	rcx, [DS001C+rip]
	call	AddLineQueue@PLT
	jmp	$_142

$_141:	lea	rcx, [DS0020+rip]
	call	AddLineQueue@PLT
$_142:	cmp	qword ptr [rbp-0x78], 0
	jz	$_143
	mov	rdx, qword ptr [rbp-0x78]
	lea	rcx, [DS0021+rip]
	call	AddLineQueueX@PLT
$_143:	lea	rcx, [DS0022+rip]
	call	AddLineQueue@PLT
	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jz	$_144
	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0023+rip]
	call	AddLineQueueX@PLT
	jmp	$_145

$_144:	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0024+rip]
	call	AddLineQueueX@PLT
$_145:	jmp	$_190

$_146:	cmp	cl, 1
	jne	$_163
	test	dword ptr [rsi+0x2C], 0x80
	jne	$_155
	mov	r8, rbx
	mov	edx, dword ptr [rsi+0x2C]
	mov	ecx, 17
	call	$_081
	cmp	byte ptr [rbp-0x39], 0
	jz	$_151
	cmp	qword ptr [rbp-0x90], 256
	jge	$_147
	mov	r8, qword ptr [rbp-0x78]
	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0025+rip]
	call	AddLineQueueX@PLT
	jmp	$_148

$_147:	mov	r8, qword ptr [rbp-0x78]
	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0026+rip]
	call	AddLineQueueX@PLT
$_148:	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jz	$_149
	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0027+rip]
	call	AddLineQueueX@PLT
	jmp	$_150

$_149:	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0028+rip]
	call	AddLineQueueX@PLT
$_150:	jmp	$_153

$_151:	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jz	$_152
	mov	r8, qword ptr [rbp-0x78]
	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0029+rip]
	call	AddLineQueueX@PLT
	jmp	$_153

$_152:	mov	r8, qword ptr [rbp-0x78]
	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS002A+rip]
	call	AddLineQueueX@PLT
$_153:	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jnz	$_154
	lea	rcx, [DS002B+rip]
	call	AddLineQueue@PLT
$_154:	jmp	$_162

$_155:	cmp	byte ptr [rbp-0x39], 0
	je	$_161
	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jnz	$_156
	mov	rdx, rbx
	lea	rcx, [DS002C+rip]
	call	AddLineQueueX@PLT
$_156:	cmp	qword ptr [rbp-0x90], 256
	jge	$_157
	mov	rax, qword ptr [rbp-0x78]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, rbx
	mov	rdx, rbx
	lea	rcx, [DS002D+rip]
	call	AddLineQueueX@PLT
	jmp	$_158

$_157:	mov	rax, qword ptr [rbp-0x78]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, rbx
	mov	rdx, rbx
	lea	rcx, [DS002E+rip]
	call	AddLineQueueX@PLT
$_158:	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jz	$_159
	mov	r8, qword ptr [rbp-0x48]
	mov	rdx, rbx
	lea	rcx, [DS002F+rip]
	call	AddLineQueueX@PLT
	jmp	$_160

$_159:	mov	qword ptr [rsp+0x20], rbx
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, rbx
	mov	rdx, rbx
	lea	rcx, [DS0030+rip]
	call	AddLineQueueX@PLT
$_160:	jmp	$_162

$_161:	mov	r9, qword ptr [rbp-0x78]
	mov	r8, qword ptr [rbp-0x48]
	mov	rdx, rbx
	lea	rcx, [DS0031+rip]
	call	AddLineQueueX@PLT
$_162:	jmp	$_190

$_163:	mov	dword ptr [rbp-0x9C], 0
	mov	qword ptr [rbp-0xA8], rsi
	mov	rsi, qword ptr [rsi+0x8]
$_164:	test	rsi, rsi
	jz	$_167
	test	byte ptr [rsi+0x2D], 0x40
	jz	$_166
	lea	rdx, [rbp-0x38]
	mov	ecx, dword ptr [rsi+0x18]
	call	GetLabelStr@PLT
	mov	rcx, rax
	call	SymFind@PLT
	test	rax, rax
	jz	$_165
	mov	eax, dword ptr [rax+0x28]
	mov	dword ptr [rbp-0x9C], eax
$_165:	jmp	$_167

$_166:	mov	rsi, qword ptr [rsi+0x8]
	jmp	$_164

$_167:	mov	rsi, qword ptr [rbp-0xA8]
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_168
	cmp	qword ptr [rbp-0x70], 0
	jnz	$_168
	call	GetCurrOffset@PLT
	add	rax, 34
	add	eax, dword ptr [rbp-0x60]
	jmp	$_169

$_168:	mov	rcx, qword ptr [rbp-0x58]
	call	SymFind@PLT
	test	rax, rax
	jz	$_169
	mov	eax, dword ptr [rax+0x28]
$_169:	cmp	dword ptr [rbp-0x9C], 0
	jz	$_171
	test	eax, eax
	jz	$_171
	sub	eax, dword ptr [rbp-0x9C]
	test	eax, 0xFFFFFF00
	jnz	$_170
	mov	dword ptr [rbp-0x64], 205
	jmp	$_171

$_170:	test	eax, 0xFFFF0000
	jnz	$_171
	mov	dword ptr [rbp-0x64], 207
$_171:	cmp	byte ptr [rbp-0x39], 0
	jne	$_176
	test	dword ptr [rsi+0x2C], 0x1080
	je	$_176
	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	je	$_176
	mov	ebx, dword ptr [rsi+0x30]
	cmp	ebx, 126
	jz	$_172
	cmp	ebx, 110
	jnz	$_173
$_172:	lea	rdx, [DS0032+rip]
	mov	ecx, 2008
	call	asmerr@PLT
$_173:	lea	rcx, [DS0033+rip]
	call	AddLineQueue@PLT
	test	byte ptr [rsi+0x2D], 0x10
	jz	$_175
	mov	rax, qword ptr [rbp-0x78]
	cmp	rax, 0
	jge	$_174
	mov	edx, ebx
	lea	rcx, [DS0034+rip]
	call	AddLineQueueX@PLT
	mov	ebx, 115
	jmp	$_175

$_174:	mov	ecx, ebx
	lea	ebx, [rbx+0x62]
	cmp	ecx, 107
	jc	$_175
	lea	ebx, [rcx+0x10]
$_175:	mov	rdx, qword ptr [rbp-0x58]
	lea	rcx, [DS0035+rip]
	call	AddLineQueueX@PLT
	mov	rax, qword ptr [rbp-0x58]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, qword ptr [rbp-0x78]
	mov	edx, ebx
	mov	ecx, dword ptr [rbp-0x64]
	call	$_102
	lea	rcx, [DS0036+rip]
	call	AddLineQueueX@PLT
	jmp	$_190

$_176:	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	je	$_183
	lea	rcx, [DS0033+rip]
	call	AddLineQueue@PLT
	mov	rcx, rbx
	mov	ebx, dword ptr [rsi+0x30]
	test	dword ptr [rsi+0x2C], 0x1080
	jnz	$_177
	mov	r8, rcx
	mov	edx, dword ptr [rsi+0x2C]
	mov	ecx, 115
	call	$_081
	mov	ebx, 115
	jmp	$_179

$_177:	test	byte ptr [rsi+0x2D], 0x10
	jz	$_179
	mov	rax, qword ptr [rbp-0x78]
	cmp	rax, 0
	jge	$_178
	mov	edx, ebx
	lea	rcx, [DS0034+rip]
	call	AddLineQueueX@PLT
	mov	ebx, 115
	jmp	$_179

$_178:	mov	ecx, ebx
	lea	ebx, [rbx+0x62]
	cmp	ecx, 107
	jc	$_179
	lea	ebx, [rcx+0x10]
$_179:	mov	rdx, qword ptr [rbp-0x58]
	lea	rcx, [DS0035+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp-0x78]
	cmp	byte ptr [rbp-0x39], 0
	jz	$_182
	cmp	qword ptr [rbp-0x90], 256
	jge	$_180
	mov	rax, qword ptr [rbp-0x58]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, rcx
	mov	edx, ebx
	lea	rcx, [DS0037+rip]
	call	AddLineQueueX@PLT
	jmp	$_181

$_180:	mov	rax, qword ptr [rbp-0x58]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, rcx
	mov	edx, ebx
	lea	rcx, [DS0038+rip]
	call	AddLineQueueX@PLT
$_181:	xor	ecx, ecx
	mov	ebx, 115
$_182:	mov	rax, qword ptr [rbp-0x58]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, rcx
	mov	edx, ebx
	mov	ecx, dword ptr [rbp-0x64]
	call	$_102
	lea	rcx, [DS0036+rip]
	call	AddLineQueue@PLT
	jmp	$_190

$_183:	mov	rcx, rbx
	mov	ebx, dword ptr [rsi+0x30]
	test	dword ptr [rsi+0x2C], 0x1080
	jnz	$_184
	mov	r8, rcx
	mov	edx, dword ptr [rsi+0x2C]
	mov	ecx, 115
	call	$_081
	mov	ebx, 115
	jmp	$_186

$_184:	lea	rcx, [DS0033+rip]
	call	AddLineQueue@PLT
	test	byte ptr [rsi+0x2D], 0x10
	jz	$_186
	mov	rax, qword ptr [rbp-0x78]
	cmp	rax, 0
	jge	$_185
	mov	edx, ebx
	lea	rcx, [DS0034+rip]
	call	AddLineQueueX@PLT
	mov	ebx, 115
	jmp	$_186

$_185:	mov	ecx, ebx
	lea	ebx, [rbx+0x62]
	cmp	ecx, 107
	jc	$_186
	lea	ebx, [rcx+0x10]
$_186:	mov	rdx, qword ptr [rbp-0x58]
	lea	rcx, [DS0039+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp-0x78]
	cmp	byte ptr [rbp-0x39], 0
	jz	$_189
	cmp	qword ptr [rbp-0x90], 256
	jge	$_187
	mov	rax, qword ptr [rbp-0x58]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, rcx
	mov	edx, ebx
	lea	rcx, [DS0037+rip]
	call	AddLineQueueX@PLT
	jmp	$_188

$_187:	mov	rax, qword ptr [rbp-0x58]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, rcx
	mov	edx, ebx
	lea	rcx, [DS0038+rip]
	call	AddLineQueueX@PLT
$_188:	xor	ecx, ecx
	mov	ebx, 115
$_189:	mov	rax, qword ptr [rbp-0x58]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x48]
	mov	r8, rcx
	mov	edx, ebx
	mov	ecx, dword ptr [rbp-0x64]
	call	$_102
	lea	rcx, [DS003A+rip]
	call	AddLineQueue@PLT
$_190:	cmp	dword ptr [rbp-0x64], 205
	jz	$_191
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003B+rip]
	call	AddLineQueueX@PLT
$_191:	lea	r8, [DS0002+rip]
	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0004+rip]
	call	AddLineQueueX@PLT
$_192:	cmp	byte ptr [rbp-0x39], 0
	je	$_211
	mov	qword ptr [rbp-0xA8], rdi
	mov	ebx, 4294967295
	mov	edi, 4294967295
	mov	rsi, qword ptr [rsi+0x8]
$_193:	test	rsi, rsi
	jz	$_196
	test	byte ptr [rsi+0x2D], 0x40
	jz	$_195
	lea	rdx, [rbp-0x38]
	mov	ecx, dword ptr [rsi+0x18]
	call	GetLabelStr@PLT
	mov	rcx, rax
	call	SymFind@PLT
	test	rax, rax
	jz	$_196
	cmp	ebx, dword ptr [rax+0x28]
	jz	$_194
	mov	ebx, dword ptr [rax+0x28]
	inc	edi
$_194:	mov	qword ptr [rsi], rdi
$_195:	mov	rsi, qword ptr [rsi+0x8]
	jmp	$_193

$_196:	inc	edi
	mov	dword ptr [rbp-0x4], edi
	mov	rdi, qword ptr [rbp-0xA8]
	mov	rsi, qword ptr [rbp+0x28]
	mov	ebx, 4294967295
	mov	rsi, qword ptr [rsi+0x8]
$_197:	test	rsi, rsi
	jz	$_201
	test	byte ptr [rsi+0x2D], 0x40
	jz	$_200
	cmp	rbx, qword ptr [rsi]
	jz	$_200
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_198
	mov	r9d, dword ptr [rsi+0x18]
	mov	r8, qword ptr [rbp-0x58]
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003C+rip]
	call	AddLineQueueX@PLT
	jmp	$_199

$_198:	mov	r8d, dword ptr [rsi+0x18]
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003D+rip]
	call	AddLineQueueX@PLT
$_199:	mov	rbx, qword ptr [rsi]
$_200:	mov	rsi, qword ptr [rsi+0x8]
	jmp	$_197

$_201:	mov	rsi, qword ptr [rbp+0x28]
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_202
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003E+rip]
	call	AddLineQueueX@PLT
	jmp	$_203

$_202:	mov	r8, qword ptr [rbp+0x40]
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003F+rip]
	call	AddLineQueueX@PLT
$_203:	mov	rax, qword ptr [rbp-0x80]
	sub	rax, qword ptr [rbp-0x78]
	inc	eax
	mov	dword ptr [rbp-0x8], eax
	mov	ecx, 205
	cmp	eax, 256
	jle	$_205
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jnz	$_204
	mov	r8d, 2
	mov	edx, 1
	mov	ecx, 2022
	call	asmerr@PLT
	jmp	$_225

$_204:	mov	ecx, 207
$_205:	mov	dword ptr [rbp-0xAC], ecx
	mov	r8d, ecx
	mov	rdx, qword ptr [rbp-0x48]
	lea	rcx, [DS0040+rip]
	call	AddLineQueueX@PLT
	xor	ebx, ebx
$_206:	cmp	ebx, dword ptr [rbp-0x8]
	jnc	$_209
	mov	rax, qword ptr [rbp-0x78]
	add	rax, rbx
	mov	rdx, rax
	mov	rcx, rsi
	call	$_024
	test	rax, rax
	jz	$_207
	mov	rdx, qword ptr [rax+0x8]
	mov	qword ptr [rcx+0x8], rdx
	mov	r8, qword ptr [rax]
	mov	edx, dword ptr [rbp-0xAC]
	lea	rcx, [DS0041+rip]
	call	AddLineQueueX@PLT
	jmp	$_208

$_207:	mov	r8d, dword ptr [rbp-0x4]
	mov	edx, dword ptr [rbp-0xAC]
	lea	rcx, [DS0041+rip]
	call	AddLineQueueX@PLT
$_208:	inc	ebx
	jmp	$_206

$_209:	cmp	dword ptr [rbp-0x64], 205
	jz	$_210
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003B+rip]
	call	AddLineQueueX@PLT
$_210:	jmp	$_218

$_211:	xor	ebx, ebx
$_212:	cmp	rbx, qword ptr [rbp-0x90]
	jge	$_218
	mov	rax, qword ptr [rbp-0x78]
	add	rax, rbx
	mov	rdx, rax
	mov	rcx, rsi
	call	$_024
	test	rax, rax
	jz	$_215
	mov	rdx, qword ptr [rax+0x8]
	mov	qword ptr [rcx+0x8], rdx
	mov	ecx, dword ptr [rax+0x18]
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_213
	mov	r9d, ecx
	mov	r8, qword ptr [rbp-0x58]
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003C+rip]
	call	AddLineQueueX@PLT
	jmp	$_214

$_213:	mov	r8d, ecx
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003D+rip]
	call	AddLineQueueX@PLT
$_214:	jmp	$_217

$_215:	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_216
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003E+rip]
	call	AddLineQueueX@PLT
	jmp	$_217

$_216:	mov	r8, qword ptr [rbp+0x40]
	mov	edx, dword ptr [rbp-0x64]
	lea	rcx, [DS003F+rip]
	call	AddLineQueueX@PLT
$_217:	inc	ebx
	jmp	$_212

$_218:	test	byte ptr [rsi+0x2E], 0x40
	jz	$_219
	lea	rcx, [DS0042+rip]
	call	AddLineQueue@PLT
$_219:	cmp	dword ptr [rbp-0x98], 0
	jz	$_221
	lea	r8, [DS0002+rip]
	mov	rdx, qword ptr [rbp-0x50]
	lea	rcx, [DS0004+rip]
	call	AddLineQueueX@PLT
	mov	rbx, qword ptr [rsi+0x8]
$_220:	test	rbx, rbx
	jz	$_221
	or	byte ptr [rbx+0x2D], 0x40
	mov	rbx, qword ptr [rbx+0x8]
	jmp	$_220

$_221:	cmp	qword ptr [rsi+0x20], 0
	jne	$_118
$_222:	mov	rbx, qword ptr [rsi+0x8]
$_223:	test	rbx, rbx
	jz	$_224
	mov	r8, qword ptr [rbp+0x38]
	mov	rdx, rbx
	mov	rcx, rsi
	call	$_001
	mov	rbx, qword ptr [rbx+0x8]
	jmp	$_223

$_224:	cmp	qword ptr [rbp-0x70], 0
	jz	$_225
	cmp	qword ptr [rsi+0x8], 0
	jz	$_225
	mov	rdx, qword ptr [rbp+0x40]
	lea	rcx, [DS0043+rip]
	call	AddLineQueueX@PLT
$_225:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_226:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 168
	mov	rsi, rcx
	lea	rdi, [rbp-0x20]
	cmp	dword ptr [rsi+0x14], 0
	jnz	$_227
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	dword ptr [rsi+0x14], eax
$_227:	cmp	dword ptr [rsi+0x1C], 0
	jnz	$_228
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	dword ptr [rsi+0x1C], eax
$_228:	lea	r8, [DS0002+rip]
	mov	edx, dword ptr [rsi+0x1C]
	lea	rcx, [DS0001+0x2F+rip]
	call	AddLineQueueX@PLT
	mov	rdx, rdi
	mov	ecx, dword ptr [rsi+0x18]
	call	GetLabelStr@PLT
	lea	rdx, [rbp-0x10]
	mov	ecx, dword ptr [rsi+0x14]
	call	GetLabelStr@PLT
	mov	ebx, dword ptr [rsi+0x30]
	mov	cl, byte ptr [ModuleInfo+0x1CC+rip]
	test	cl, cl
	jnz	$_233
	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jz	$_230
	cmp	ebx, 9
	jz	$_229
	mov	edx, ebx
	lea	rcx, [DS0044+rip]
	call	AddLineQueueX@PLT
$_229:	mov	rdx, rdi
	lea	rcx, [DS0045+rip]
	call	AddLineQueueX@PLT
	jmp	$_232

$_230:	lea	rcx, [DS0046+rip]
	call	AddLineQueue@PLT
	cmp	ebx, 12
	jz	$_231
	mov	edx, ebx
	lea	rcx, [DS0047+rip]
	call	AddLineQueueX@PLT
$_231:	mov	rdx, rdi
	lea	rcx, [DS0048+rip]
	call	AddLineQueueX@PLT
$_232:	jmp	$_244

$_233:	cmp	cl, 1
	jnz	$_236
	test	byte ptr [rsi+0x2E], 0x40
	jz	$_234
	mov	r9, rdi
	mov	r8, rdi
	mov	edx, ebx
	lea	rcx, [DS0049+rip]
	call	AddLineQueueX@PLT
	jmp	$_235

$_234:	mov	r9, rdi
	mov	r8, rdi
	mov	edx, ebx
	lea	rcx, [DS004A+rip]
	call	AddLineQueueX@PLT
$_235:	jmp	$_244

$_236:	test	byte ptr [rsi+0x2D], 0x10
	jz	$_239
	mov	r8, rdi
	lea	rdx, [DS004B+rip]
	lea	rcx, [rbp-0x40]
	call	tsprintf@PLT
	lea	rcx, [rbp-0x40]
	call	SymFind@PLT
	test	rax, rax
	jz	$_237
	mov	rcx, rax
	xor	eax, eax
	cmp	dword ptr [rcx+0x50], 0
	jge	$_237
	inc	eax
$_237:	mov	ecx, ebx
	lea	ebx, [rbx+0x62]
	cmp	ecx, 107
	jc	$_238
	lea	ebx, [rcx+0x10]
$_238:	test	eax, eax
	jz	$_239
	mov	r8d, ecx
	mov	edx, ebx
	lea	rcx, [DS004C+rip]
	call	AddLineQueueX@PLT
$_239:	test	byte ptr [ModuleInfo+0x334+rip], 0x20
	jz	$_242
	cmp	ebx, 126
	jz	$_240
	cmp	ebx, 110
	jnz	$_241
$_240:	lea	rdx, [DS0032+rip]
	mov	ecx, 2008
	call	asmerr@PLT
$_241:	lea	rax, [rbp-0x10]
	mov	qword ptr [rsp+0x28], rax
	mov	qword ptr [rsp+0x20], rdi
	mov	r9, rdi
	mov	r8d, ebx
	lea	rdx, [rbp-0x10]
	lea	rcx, [DS004D+rip]
	call	AddLineQueueX@PLT
	jmp	$_244

$_242:	mov	esi, 115
	cmp	ebx, esi
	jnz	$_243
	mov	esi, 117
$_243:	mov	dword ptr [rsp+0x50], esi
	lea	rax, [rbp-0x10]
	mov	qword ptr [rsp+0x48], rax
	mov	qword ptr [rsp+0x40], rdi
	mov	qword ptr [rsp+0x38], rdi
	mov	dword ptr [rsp+0x30], ebx
	mov	dword ptr [rsp+0x28], esi
	mov	dword ptr [rsp+0x20], esi
	lea	r9, [rbp-0x10]
	mov	r8d, esi
	mov	edx, esi
	lea	rcx, [DS004E+rip]
	call	AddLineQueueX@PLT
$_244:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_245:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 2216
	mov	dword ptr [rbp-0x870], 0
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	mov	eax, dword ptr [rbx+0x4]
	mov	dword ptr [rbp-0x86C], eax
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	mov	rsi, qword ptr [ModuleInfo+0x100+rip]
	test	rsi, rsi
	jnz	$_246
	mov	ecx, 56
	call	LclAlloc@PLT
	mov	rsi, rax
	jmp	$_247

$_246:	xor	eax, eax
	mov	ecx, 56
	mov	rdi, rsi
	rep stosb
$_247:	mov	rcx, qword ptr [rbp+0x30]
	call	ExpandCStrings@PLT
	lea	rdi, [rbp-0x800]
	mov	dword ptr [rsi+0x28], 4
	mov	eax, 4
	mov	byte ptr [rbp-0x871], 0
$_248:	cmp	byte ptr [rbx], 40
	jnz	$_249
	inc	dword ptr [rbp+0x28]
	inc	byte ptr [rbp-0x871]
	add	rbx, 24
	jmp	$_248

$_249:
	cmp	dword ptr [rbx+0x4], 563
	jnz	$_250
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	or	eax, 0x40
$_250:	cmp	byte ptr [rbx], 8
	jnz	$_251
	mov	rcx, qword ptr [rbx+0x8]
	mov	ecx, dword ptr [rcx]
	or	cl, 0x20
	cmp	cx, 99
	jnz	$_251
	mov	dword ptr [rbx+0x4], 277
	mov	byte ptr [rbx], 7
	mov	byte ptr [rbx+0x1], 1
$_251:	cmp	dword ptr [rbx+0x4], 277
	jnz	$_252
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	jmp	$_254

$_252:	cmp	dword ptr [rbx+0x4], 280
	jnz	$_253
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	or	eax, 0x100000
	jmp	$_254

$_253:	test	byte ptr [ModuleInfo+0x334+rip], 0x08
	jz	$_254
	or	eax, 0x100000
$_254:	mov	dword ptr [rsi+0x2C], eax
	cmp	byte ptr [rbx], 0
	je	$_286
	mov	r8, qword ptr [rbp+0x30]
	mov	edx, dword ptr [rbp+0x28]
	mov	rcx, rdi
	call	ExpandHllProc@PLT
	cmp	eax, -1
	jnz	$_255
	jmp	$_289

$_255:	cmp	byte ptr [rdi], 0
	jz	$_256
	mov	rcx, rdi
	call	AddLineQueue@PLT
$_256:	mov	eax, dword ptr [rbx+0x4]
	mov	dword ptr [rsi+0x30], eax
	jmp	$_271

$_257:	or	byte ptr [rsi+0x2D], 0x02
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jnz	$_258
	or	dword ptr [rsi+0x2C], 0x80
	test	byte ptr [rsi+0x2C], 0x40
	jz	$_258
	or	byte ptr [rsi+0x2E], 0x20
$_258:	jmp	$_279

$_259:	or	byte ptr [rsi+0x2D], 0x04
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 1
	jnz	$_260
	or	dword ptr [rsi+0x2C], 0x80
	test	byte ptr [rsi+0x2C], 0x40
	jz	$_260
	or	byte ptr [rsi+0x2E], 0x20
	test	byte ptr [rsi+0x2E], 0x10
	jnz	$_260
	or	byte ptr [rsi+0x2E], 0x40
$_260:	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_261
	or	byte ptr [rsi+0x2D], 0x10
	test	byte ptr [rsi+0x2C], 0x40
	jz	$_261
	or	dword ptr [rsi+0x2C], 0x200080
$_261:	jmp	$_279

$_262:	or	byte ptr [rsi+0x2D], 0x08
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_263
	or	dword ptr [rsi+0x2C], 0x80
	test	byte ptr [rsi+0x2C], 0x40
	jz	$_263
	or	byte ptr [rsi+0x2E], 0x20
$_263:	jmp	$_279

$_264:	mov	eax, dword ptr [rbp+0x28]
	mov	dword ptr [rbp-0x878], eax
	or	byte ptr [rsi+0x2D], 0x01
	mov	byte ptr [rsp+0x20], 1
	lea	r9, [rbp-0x868]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp-0x878]
	call	EvalOperand@PLT
	cmp	eax, -1
	jz	$_270
	mov	eax, 8
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jnz	$_265
	mov	eax, 2
	jmp	$_266

$_265:	cmp	byte ptr [ModuleInfo+0x1CC+rip], 1
	jnz	$_266
	mov	eax, 4
$_266:	cmp	dword ptr [rbp-0x82C], 1
	jnz	$_267
	cmp	byte ptr [rbp-0x828], -64
	jz	$_267
	mov	r8, qword ptr [rbp-0x808]
	movzx	edx, byte ptr [rbp-0x826]
	movzx	ecx, byte ptr [rbp-0x828]
	call	SizeFromMemtype@PLT
$_267:	cmp	eax, 2
	jnz	$_268
	or	byte ptr [rsi+0x2D], 0x02
	jmp	$_270

$_268:	cmp	eax, 4
	jnz	$_269
	or	byte ptr [rsi+0x2D], 0x04
	jmp	$_270

$_269:	cmp	eax, 8
	jnz	$_270
	or	byte ptr [rsi+0x2D], 0x08
$_270:	jmp	$_279

$_271:	cmp	eax, 99
	jc	$_272
	cmp	eax, 106
	jbe	$_257
$_272:	cmp	eax, 9
	jc	$_273
	cmp	eax, 16
	jbe	$_257
$_273:	cmp	eax, 87
	jc	$_274
	cmp	eax, 98
	jbe	$_258
$_274:	cmp	eax, 1
	jc	$_275
	cmp	eax, 8
	jbe	$_258
$_275:	cmp	eax, 107
	jc	$_276
	cmp	eax, 114
	jbe	$_259
$_276:	cmp	eax, 17
	jc	$_277
	cmp	eax, 24
	jbe	$_259
$_277:	cmp	eax, 115
	jc	$_278
	cmp	eax, 130
	jbe	$_262
$_278:	jmp	$_264

$_279:	imul	ecx, dword ptr [ModuleInfo+0x220+rip], 24
	add	rcx, qword ptr [rbp+0x30]
	jmp	$_281

$_280:	sub	rcx, 24
	dec	byte ptr [rbp-0x871]
$_281:	cmp	byte ptr [rbp-0x871], 0
	jz	$_282
	cmp	byte ptr [rcx-0x18], 41
	jz	$_280
$_282:	mov	rcx, qword ptr [rcx+0x10]
	jmp	$_284

$_283:	dec	rcx
$_284:	cmp	rcx, rdi
	jbe	$_285
	cmp	byte ptr [rcx-0x1], 32
	jbe	$_283
$_285:	sub	rcx, qword ptr [rbx+0x10]
	mov	edi, ecx
	inc	ecx
	call	LclAlloc@PLT
	mov	qword ptr [rsi+0x20], rax
	mov	r8d, edi
	mov	rdx, qword ptr [rbx+0x10]
	mov	rcx, rax
	call	tmemcpy@PLT
	mov	byte ptr [rax+rdi], 0
$_286:	imul	eax, dword ptr [rbp+0x28], 24
	cmp	dword ptr [rsi+0x2C], 0
	jnz	$_287
	cmp	byte ptr [rbx+rax], 0
	jz	$_287
	cmp	dword ptr [rbp-0x870], 0
	jnz	$_287
	mov	rdx, qword ptr [rbx+rax+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	mov	dword ptr [rbp-0x870], eax
$_287:	cmp	rsi, qword ptr [ModuleInfo+0x100+rip]
	jnz	$_288
	mov	rax, qword ptr [rsi]
	mov	qword ptr [ModuleInfo+0x100+rip], rax
$_288:	mov	rax, qword ptr [ModuleInfo+0xF8+rip]
	mov	qword ptr [rsi], rax
	mov	qword ptr [ModuleInfo+0xF8+rip], rsi
	mov	eax, dword ptr [rbp-0x870]
$_289:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_290:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 2120
	mov	dword ptr [rbp-0x4], 0
	mov	rsi, qword ptr [ModuleInfo+0xF8+rip]
	test	rsi, rsi
	jnz	$_291
	mov	ecx, 1011
	call	asmerr@PLT
	jmp	$_307

$_291:	mov	rax, qword ptr [rsi]
	mov	rcx, qword ptr [ModuleInfo+0x100+rip]
	mov	qword ptr [ModuleInfo+0xF8+rip], rax
	mov	qword ptr [rsi], rcx
	mov	qword ptr [ModuleInfo+0x100+rip], rsi
	lea	rdi, [rbp-0x808]
	mov	rbx, qword ptr [rbp+0x30]
	mov	ecx, dword ptr [rsi+0x28]
	cmp	ecx, 4
	jz	$_292
	mov	ecx, 1011
	call	asmerr@PLT
	jmp	$_307

$_292:	inc	dword ptr [rbp+0x28]
	cmp	dword ptr [rsi+0x10], 0
	je	$_305
	cmp	dword ptr [rsi+0x18], 0
	jnz	$_293
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	dword ptr [rsi+0x18], eax
$_293:	cmp	dword ptr [rsi+0x14], 0
	jnz	$_294
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	dword ptr [rsi+0x14], eax
$_294:	lea	rdx, [rbp-0x818]
	mov	ecx, dword ptr [rsi+0x14]
	call	GetLabelStr@PLT
	mov	rdx, rdi
	mov	ecx, dword ptr [rsi+0x18]
	call	GetLabelStr@PLT
	mov	rax, rsi
	jmp	$_296

$_295:	mov	rax, qword ptr [rax+0x8]
$_296:	cmp	qword ptr [rax+0x8], 0
	jnz	$_295
	cmp	rax, rsi
	jz	$_297
	test	byte ptr [rax+0x2D], 0xFFFFFF80
	jnz	$_297
	test	byte ptr [rsi+0x2E], 0x40
	jnz	$_297
	mov	edx, dword ptr [rsi+0x14]
	lea	rcx, [DS0000+rip]
	call	AddLineQueueX@PLT
$_297:	mov	cl, byte ptr [ModuleInfo+0x336+rip]
	test	cl, cl
	jz	$_298
	mov	eax, 1
	shl	eax, cl
	mov	edx, eax
	lea	rcx, [DS0016+0x1+rip]
	call	AddLineQueueX@PLT
$_298:	cmp	qword ptr [rsi+0x20], 0
	jne	$_304
	mov	rbx, qword ptr [rsi+0x8]
	lea	r8, [DS0002+rip]
	mov	rdx, rdi
	lea	rcx, [DS0004+rip]
	call	AddLineQueueX@PLT
	jmp	$_303

$_299:	cmp	qword ptr [rbx+0x20], 0
	jnz	$_300
	mov	edx, dword ptr [rbx+0x18]
	lea	rcx, [DS0000+rip]
	call	AddLineQueueX@PLT
	jmp	$_302

$_300:	test	byte ptr [rbx+0x2C], 0x08
	jz	$_301
	mov	dword ptr [rbp+0x28], 1
	or	byte ptr [rbx+0x2C], 0x04
	mov	qword ptr [rsp+0x28], rdi
	mov	dword ptr [rsp+0x20], 1
	mov	r9d, 2
	mov	r8, qword ptr [rbp+0x30]
	lea	rdx, [rbp+0x28]
	mov	rcx, rbx
	call	ExpandHllExpression@PLT
	jmp	$_302

$_301:	mov	rcx, qword ptr [rbx+0x20]
	call	AddLineQueue@PLT
$_302:	mov	rbx, qword ptr [rbx+0x8]
$_303:	test	rbx, rbx
	jnz	$_299
	jmp	$_305

$_304:	lea	r9, [rbp-0x818]
	mov	r8, rdi
	mov	rdx, qword ptr [rbp+0x30]
	mov	rcx, rsi
	call	$_105
$_305:	mov	eax, dword ptr [rsi+0x14]
	test	eax, eax
	jz	$_306
	lea	r8, [DS0002+rip]
	mov	edx, eax
	lea	rcx, [DS0001+0x2F+rip]
	call	AddLineQueueX@PLT
$_306:	mov	eax, dword ptr [rbp-0x4]
$_307:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_308:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 2184
	mov	dword ptr [rbp-0x4], 0
	mov	rax, qword ptr [ModuleInfo+0xF8+rip]
	mov	qword ptr [rbp-0x828], rax
	mov	rsi, rax
	test	rsi, rsi
	jnz	$_309
	mov	ecx, 1011
	call	asmerr@PLT
	jmp	$_379

$_309:	mov	rcx, qword ptr [rbp+0x30]
	call	ExpandCStrings@PLT
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	lea	rdi, [rbp-0x818]
	mov	eax, dword ptr [rbx+0x4]
	mov	dword ptr [rbp-0x8], eax
	xor	ecx, ecx
	jmp	$_376

$_310:	test	byte ptr [rsi+0x2C], 0x01
	jz	$_311
	mov	ecx, 2142
	call	asmerr@PLT
	jmp	$_379

$_311:	cmp	byte ptr [rbx+0x18], 0
	jz	$_312
	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_379

$_312:	or	byte ptr [rsi+0x2C], 0x01
$_313:	jmp	$_315

$_314:	mov	rsi, qword ptr [rsi]
$_315:	test	rsi, rsi
	jz	$_316
	cmp	dword ptr [rsi+0x28], 4
	jnz	$_314
$_316:	cmp	dword ptr [rsi+0x28], 4
	jz	$_317
	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 1010
	call	asmerr@PLT
	jmp	$_379

$_317:	cmp	dword ptr [rsi+0x18], 0
	jnz	$_320
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	dword ptr [rsi+0x18], eax
	test	byte ptr [rsi+0x2C], 0x40
	jz	$_318
	test	byte ptr [rsi+0x2E], 0x20
	jz	$_318
	mov	rcx, rsi
	call	$_226
	jmp	$_319

$_318:	mov	edx, eax
	lea	rcx, [DS0000+rip]
	call	AddLineQueueX@PLT
$_319:	jmp	$_324

$_320:	test	byte ptr [rsi+0x2E], 0x10
	jz	$_324
	cmp	dword ptr [rsi+0x14], 0
	jnz	$_321
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	dword ptr [rsi+0x14], eax
$_321:	mov	rax, rsi
	jmp	$_323

$_322:	mov	rax, qword ptr [rax+0x8]
$_323:	cmp	qword ptr [rax+0x8], 0
	jnz	$_322
	cmp	rax, rsi
	jz	$_324
	test	byte ptr [rax+0x2D], 0xFFFFFF80
	jnz	$_324
	mov	edx, dword ptr [rsi+0x14]
	lea	rcx, [DS0000+rip]
	call	AddLineQueueX@PLT
$_324:	mov	qword ptr [rbp-0x830], 0
	cmp	byte ptr [rbx+0x18], 9
	jnz	$_325
	cmp	byte ptr [rbx+0x30], 8
	jnz	$_325
	cmp	byte ptr [rbx+0x48], 9
	jnz	$_325
	mov	rax, qword ptr [rbx+0x38]
	mov	qword ptr [rbp-0x830], rax
	add	rbx, 72
	add	dword ptr [rbp+0x28], 3
$_325:	mov	r9, rbx
	mov	r8, rdi
	lea	rdx, [rbp+0x28]
	mov	rcx, rsi
	call	$_065
	test	rax, rax
	jne	$_377
	mov	cl, byte ptr [ModuleInfo+0x336+rip]
	test	cl, cl
	jz	$_326
	mov	eax, 1
	shl	eax, cl
	mov	edx, eax
	lea	rcx, [DS0016+0x1+rip]
	call	AddLineQueueX@PLT
$_326:	inc	dword ptr [rsi+0x10]
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	dword ptr [rbp-0x834], eax
	lea	r8, [DS0002+rip]
	mov	edx, eax
	lea	rcx, [DS0001+0x2F+rip]
	call	AddLineQueueX@PLT
	cmp	qword ptr [rbp-0x830], 0
	jz	$_327
	mov	rdx, qword ptr [rbp-0x830]
	lea	rcx, [DS004F+rip]
	call	AddLineQueueX@PLT
$_327:	mov	ecx, 56
	call	LclAlloc@PLT
	mov	ecx, dword ptr [rbp-0x834]
	mov	rdx, rsi
	mov	rsi, rax
	mov	rax, qword ptr [rdx+0x20]
	mov	dword ptr [rsi+0x18], ecx
	jmp	$_329

$_328:	mov	rdx, qword ptr [rdx+0x8]
$_329:	cmp	qword ptr [rdx+0x8], 0
	jnz	$_328
	mov	qword ptr [rdx+0x8], rsi
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	mov	qword ptr [rbp-0x840], rax
	mov	qword ptr [rbp-0x848], rbx
	mov	qword ptr [rbp-0x850], rsi
	xor	esi, esi
$_330:	mov	rcx, rbx
	call	$_055
	test	rax, rax
	jz	$_333
	mov	rbx, rax
	test	rsi, rsi
	jz	$_331
	mov	rax, qword ptr [rbx+0x10]
	mov	byte ptr [rax], 0
	mov	rcx, rsi
	call	AddLineQueue@PLT
	mov	rax, qword ptr [rbx+0x10]
	mov	byte ptr [rax], 58
	jmp	$_332

$_331:	sub	rax, qword ptr [rbp+0x30]
	mov	ecx, 24
	xor	edx, edx
	div	ecx
	mov	dword ptr [ModuleInfo+0x220+rip], eax
$_332:	add	rbx, 24
	mov	rsi, qword ptr [rbx+0x10]
	jmp	$_330

$_333:	test	rsi, rsi
	jz	$_334
	mov	rcx, rsi
	call	AddLineQueue@PLT
$_334:	mov	rsi, qword ptr [rbp-0x850]
	cmp	qword ptr [rbp-0x840], 0
	je	$_345
	cmp	dword ptr [rbp-0x8], 447
	je	$_345
	mov	rbx, qword ptr [rbp-0x848]
	mov	qword ptr [rbp-0x850], rdi
	xor	edi, edi
$_335:	movzx	eax, byte ptr [rbx]
	jmp	$_342

$C0190: cmp	edi, 1
	jnz	$_336
	cmp	byte ptr [rbx+0x18], 0
	jnz	$_336
	or	byte ptr [rsi+0x2D], 0x20
	jmp	$_344

$_336:	sub	edi, 2
$C0194: inc	edi
$C0195: jmp	$_343
$C019C:
$_337:	cmp	byte ptr [rbx+0x18], 0
	jnz	$_338
	or	byte ptr [rsi+0x2D], 0x20
	jmp	$_344

$_338:	jmp	$_343

$C019F: cmp	dword ptr [rbx+0x1C], 270
	je	$_344
	jmp	$_337

$C01A0: cmp	byte ptr [rbx+0x18], 46
	je	$_344
	jmp	$_337

$C01A1: cmp	dword ptr [rbx+0x4], 249
	jne	$_344
	jmp	$_337

$C01A2: mov	rcx, qword ptr [rbx+0x8]
	call	SymFind@PLT
	test	rax, rax
	jz	$_340
	cmp	byte ptr [rax+0x18], 1
	jne	$_344
	cmp	byte ptr [rax+0x19], -127
	jz	$_339
	cmp	byte ptr [rax+0x19], -64
	jnz	$_344
$_339:	jmp	$_341

$_340:	cmp	dword ptr [Parse_Pass+rip], 0
	jz	$_341
	jmp	$_344

$_341:	jmp	$_337

$C01A8: jmp	$_344

$_342:	cmp	eax, 1
	jl	$C01A8
	cmp	eax, 47
	jg	$C01A8
	push	rax
	lea	r11, [$C01A8+rip]
	movzx	eax, byte ptr [r11+rax-(1)+(IT$C01A9-$C01A8)]
	movzx	eax, byte ptr [r11+rax+($C01A9-$C01A8)]
	sub	r11, rax
	pop	rax
	jmp	r11
$C01A9:
	.byte $C01A8-$C0190
	.byte $C01A8-$C0194
	.byte $C01A8-$C0195
	.byte $C01A8-$C019C
	.byte $C01A8-$C019F
	.byte $C01A8-$C01A0
	.byte $C01A8-$C01A1
	.byte $C01A8-$C01A2
	.byte 0
IT$C01A9:
	.byte 2
	.byte 8
	.byte 8
	.byte 6
	.byte 8
	.byte 4
	.byte 8
	.byte 7
	.byte 3
	.byte 3
	.byte 5
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 8
	.byte 2
	.byte 8
	.byte 8
	.byte 1
	.byte 0
	.byte 2
	.byte 2
	.byte 8
	.byte 2
	.byte 8
	.byte 2

$_343:	add	rbx, 24
	jmp	$_335

$_344:	mov	rdi, qword ptr [rbp-0x850]
$_345:	mov	rax, qword ptr [rbp-0x840]
	mov	rbx, qword ptr [rbp-0x848]
	cmp	dword ptr [rbp-0x8], 447
	jnz	$_346
	or	byte ptr [rsi+0x2C], 0x10
	jmp	$_350

$_346:	cmp	byte ptr [rbx], 0
	jnz	$_347
	mov	rdx, qword ptr [rbx-0x8]
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_379

$_347:	test	eax, eax
	jnz	$_348
	mov	ebx, dword ptr [rbp+0x28]
	mov	qword ptr [rsp+0x28], rdi
	mov	dword ptr [rsp+0x20], 1
	mov	r9d, 2
	mov	r8, qword ptr [rbp+0x30]
	lea	rdx, [rbp+0x28]
	mov	rcx, rsi
	call	EvaluateHllExpression@PLT
	mov	dword ptr [rbp+0x28], ebx
	mov	dword ptr [rbp-0x4], eax
	cmp	eax, -1
	je	$_377
	jmp	$_349

$_348:	imul	eax, dword ptr [ModuleInfo+0x220+rip], 24
	add	rax, qword ptr [rbp+0x30]
	mov	rax, qword ptr [rax+0x10]
	sub	rax, qword ptr [rbx+0x10]
	mov	word ptr [rdi+rax], 0
	mov	r8d, eax
	mov	rdx, qword ptr [rbx+0x10]
	mov	rcx, rdi
	call	tmemcpy@PLT
$_349:	mov	rcx, rdi
	call	LclDup@PLT
	mov	qword ptr [rsi+0x20], rax
$_350:	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	mov	dword ptr [rbp+0x28], eax
	jmp	$_377

$_351:	test	rsi, rsi
	jz	$_352
	cmp	dword ptr [rsi+0x28], 4
	jz	$_352
	mov	rsi, qword ptr [rsi]
	jmp	$_351

$_352:	test	rsi, rsi
	jz	$_355
	test	ecx, ecx
	jz	$_355
	mov	rsi, qword ptr [rsi]
$_353:	test	rsi, rsi
	jz	$_354
	cmp	dword ptr [rsi+0x28], 4
	jz	$_354
	mov	rsi, qword ptr [rsi]
	jmp	$_353

$_354:	dec	ecx
	jmp	$_352

$_355:	test	rsi, rsi
	jnz	$_356
	mov	ecx, 1011
	call	asmerr@PLT
	jmp	$_379

$_356:	cmp	dword ptr [rsi+0x14], 0
	jnz	$_357
	inc	dword ptr [ModuleInfo+0x1B0+rip]
	mov	eax, dword ptr [ModuleInfo+0x1B0+rip]
	mov	dword ptr [rsi+0x14], eax
$_357:	mov	ecx, 1
	cmp	dword ptr [rbp-0x8], 445
	jz	$_358
	mov	ecx, 2
$_358:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	mov	dword ptr [rbp-0x81C], 0
	cmp	ecx, 2
	jne	$_371
	cmp	byte ptr [rbx], 40
	jne	$_371
	cmp	byte ptr [rbx+0x18], 0
	jz	$_359
	cmp	byte ptr [rbx+0x30], 58
	jnz	$_359
	add	dword ptr [rbp+0x28], 2
	add	rbx, 48
$_359:	mov	rax, qword ptr [rbx+0x28]
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	mov	ecx, 1
$_360:	cmp	byte ptr [rbx], 0
	jz	$_363
	cmp	byte ptr [rbx], 40
	jnz	$_361
	inc	ecx
	jmp	$_362

$_361:	cmp	byte ptr [rbx], 41
	jnz	$_362
	dec	ecx
	jz	$_363
$_362:	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	jmp	$_360

$_363:	cmp	byte ptr [rbx], 41
	jne	$_377
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	cmp	byte ptr [rbx-0x30], 40
	je	$_370
	cmp	byte ptr [rbx-0x30], 58
	je	$_370
	mov	rcx, qword ptr [rbx-0x8]
	sub	rcx, rax
	je	$_370
	cmp	ecx, 2016
	ja	$_377
	mov	qword ptr [rbp-0x850], rsi
	mov	qword ptr [rbp-0x840], rcx
	mov	r8d, ecx
	mov	rdx, rax
	mov	rcx, rdi
	call	tmemcpy@PLT
	mov	rcx, qword ptr [rbp-0x840]
	add	rcx, rax
	mov	byte ptr [rcx], 0
	dec	rcx
$_364:	cmp	rcx, rax
	jbe	$_365
	cmp	byte ptr [rcx], 32
	ja	$_365
	mov	byte ptr [rcx], 0
	dec	rcx
	jmp	$_364

$_365:	mov	rsi, qword ptr [rsi+0x8]
$_366:	test	rsi, rsi
	jz	$_368
	cmp	qword ptr [rsi+0x20], 0
	jz	$_367
	mov	rdx, qword ptr [rsi+0x20]
	mov	rcx, rdi
	call	tstrcmp@PLT
	test	eax, eax
	jnz	$_367
	mov	ecx, dword ptr [rsi+0x18]
	jmp	$_368

$_367:	mov	rsi, qword ptr [rsi+0x8]
	jmp	$_366

$_368:	mov	rax, rsi
	mov	rsi, qword ptr [rbp-0x850]
	test	rax, rax
	jz	$_369
	mov	edx, dword ptr [rsi+0x18]
	mov	dword ptr [rsi+0x18], ecx
	mov	dword ptr [rbp-0x81C], edx
	jmp	$_370

$_369:	cmp	qword ptr [rsi+0x20], 0
	jz	$_370
	mov	r8, rdi
	mov	rdx, qword ptr [rsi+0x20]
	lea	rcx, [DS0050+rip]
	call	AddLineQueueX@PLT
	mov	eax, dword ptr [rsi+0x1C]
	test	eax, eax
	jz	$_370
	mov	edx, dword ptr [rsi+0x18]
	mov	dword ptr [rsi+0x18], eax
	mov	dword ptr [rbp-0x81C], edx
$_370:	mov	ecx, 2
	jmp	$_372

$_371:	cmp	ecx, 2
	jnz	$_372
	cmp	dword ptr [rsi+0x1C], 0
	jz	$_372
	mov	eax, dword ptr [rsi+0x1C]
	mov	edx, dword ptr [rsi+0x18]
	mov	dword ptr [rsi+0x18], eax
	mov	dword ptr [rbp-0x81C], edx
$_372:	mov	dword ptr [rsp+0x28], 1
	mov	rax, qword ptr [rbp-0x828]
	mov	qword ptr [rsp+0x20], rax
	mov	r9d, ecx
	mov	r8, qword ptr [rbp+0x30]
	lea	rdx, [rbp+0x28]
	mov	rcx, rsi
	call	HllContinueIf@PLT
	cmp	dword ptr [rbp-0x81C], 0
	jz	$_373
	mov	eax, dword ptr [rbp-0x81C]
	mov	dword ptr [rsi+0x18], eax
$_373:	jmp	$_377

$_374:	cmp	byte ptr [rbx+0x18], 40
	jnz	$_375
	cmp	byte ptr [rbx+0x48], 58
	jnz	$_375
	mov	rax, qword ptr [rbx+0x38]
	mov	al, byte ptr [rax]
	cmp	al, 48
	jc	$_375
	cmp	al, 57
	ja	$_375
	sub	al, 48
	movzx	ecx, al
$_375:	jmp	$_351

$_376:	cmp	eax, 447
	je	$_310
	cmp	eax, 444
	je	$_313
	cmp	eax, 445
	je	$_351
	cmp	eax, 446
	jz	$_374
$_377:	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	cmp	byte ptr [rbx], 0
	jz	$_378
	cmp	dword ptr [rbp-0x4], 0
	jnz	$_378
	mov	rdx, qword ptr [rbx+0x10]
	mov	ecx, 2008
	call	asmerr@PLT
	mov	dword ptr [rbp-0x4], -1
$_378:	mov	eax, dword ptr [rbp-0x4]
$_379:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

SwitchDirective:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	dword ptr [rbp-0x4], 0
	imul	eax, dword ptr [rbp+0x10], 24
	add	rax, qword ptr [rbp+0x18]
	mov	eax, dword ptr [rax+0x4]
	jmp	$_383

$_380:	mov	rdx, qword ptr [rbp+0x18]
	mov	ecx, dword ptr [rbp+0x10]
	call	$_308
	mov	dword ptr [rbp-0x4], eax
	jmp	$_384

$_381:	mov	rdx, qword ptr [rbp+0x18]
	mov	ecx, dword ptr [rbp+0x10]
	call	$_290
	mov	dword ptr [rbp-0x4], eax
	jmp	$_384

$_382:	mov	rdx, qword ptr [rbp+0x18]
	mov	ecx, dword ptr [rbp+0x10]
	call	$_245
	mov	dword ptr [rbp-0x4], eax
	jmp	$_384

$_383:	cmp	eax, 444
	jz	$_380
	cmp	eax, 446
	jz	$_380
	cmp	eax, 447
	jz	$_380
	cmp	eax, 445
	jz	$_380
	cmp	eax, 448
	jz	$_381
	cmp	eax, 443
	jz	$_382
$_384:	cmp	byte ptr [ModuleInfo+0x1DB+rip], 0
	jz	$_385
	call	GetCurrOffset@PLT
	xor	r8d, r8d
	mov	edx, eax
	mov	ecx, 4
	call	LstWrite@PLT
$_385:	cmp	qword ptr [ModuleInfo+0xC8+rip], 0
	jz	$_386
	call	RunLineQueue@PLT
$_386:	mov	eax, dword ptr [rbp-0x4]
	leave
	ret


.SECTION .data
	.ALIGN	16

DS0000:
	.asciz " jmp @C%04X"

DS0001:
	.ascii " cmp %s, %s\n"
	.ascii " jb @C%04X\n"
	.ascii " cmp %s, %s\n"
	.ascii " jbe @C%04X\n"
	.asciz "@C%04X%s"

DS0002:
	.asciz ":"

DS0003:
	.ascii " cmp %s, %s\n"
	.asciz " je @C%04X"

DS0004:
	.asciz "%s%s"

DS0005:
	.asciz " .case %s"

DS0006:
	.ascii " cmp %s,%d\n"
	.ascii " jl  %s\n"
	.ascii " cmp %s,%d\n"
	.asciz " jg  %s"

DS0007:
	.asciz "push %r"

DS0008:
	.asciz " movsx %r, byte ptr %s"

DS0009:
	.asciz " movsx %r, %s"

DS000A:
	.asciz "al"

DS000B:
	.asciz " mov al, %s"

DS000C:
	.asciz " cbw"

DS000D:
	.asciz " mov %r, word ptr %s"

DS000E:
	.asciz " mov %r,%s"

DS000F:
	.asciz " movsx %r, word ptr %s"

DS0010:
	.asciz " mov %r, dword ptr %s"

DS0011:
	.asciz " mov %r, %s"

DS0012:
	.asciz " movsxd %r, dword ptr %s"

DS0013:
	.asciz " movsxd %r, %s"

DS0014:
	.asciz " mov %r, qword ptr %s"

DS0015:
	.asciz " %r eax, %r ptr [r11+%r*%d-(%d*%d)+(%s-%s)]"

DS0016:
	.asciz " ALIGN %d"

DS0017:
	.asciz " ALIGN 8"

DS0018:
	.asciz "MIN%s equ %d"

DS0019:
	.ascii ".data\n"
	.ascii "ALIGN 4\n"
	.asciz "DT%s label dword"

DS001A:
	.asciz " push ax"

DS001B:
	.asciz " mov ax, %s"

DS001C:
	.asciz " xchg ax, bx"

DS001D:
	.ascii " push bx\n"
	.asciz " push ax"

DS001E:
	.asciz " mov bx, %s"

DS001F:
	.asciz " push bx"

DS0020:
	.asciz " mov bx, ax"

DS0021:
	.asciz " sub bx, %d"

DS0022:
	.asciz " add bx, bx"

DS0023:
	.ascii " mov bx, cs:[bx+%s]\n"
	.ascii " xchg ax, bx\n"
	.asciz " jmp ax"

DS0024:
	.ascii " mov ax, cs:[bx+%s]\n"
	.ascii " mov bx, sp\n"
	.ascii " mov ss:[bx+4], ax\n"
	.ascii " pop ax\n"
	.ascii " pop bx\n"
	.asciz " retn"

DS0025:
	.asciz " movzx eax, byte ptr [eax+IT%s-(%d)]"

DS0026:
	.asciz " movzx eax, word ptr [eax*2+IT%s-(%d*2)]"

DS0027:
	.asciz " jmp [eax*4+%s]"

DS0028:
	.asciz " mov eax, [eax*4+%s]"

DS0029:
	.asciz " jmp [eax*4+%s-(%d*4)]"

DS002A:
	.asciz " mov eax, [eax*4+%s-(%d*4)]"

DS002B:
	.ascii " xchg eax, [esp]\n"
	.asciz " retn"

DS002C:
	.asciz " push %s"

DS002D:
	.asciz " movzx %s, byte ptr [%s+IT%s-(%d)]"

DS002E:
	.asciz " movzx %s, word ptr [%s*2+IT%s-(%d*2)]"

DS002F:
	.asciz " jmp [%s*4+%s]"

DS0030:
	.ascii " mov %s, [%s*4+%s]\n"
	.ascii " xchg %s, [esp]\n"
	.asciz " retn"

DS0031:
	.asciz " jmp [%s*4+%s-(%d*4)]"

DS0032:
	.asciz "register r11 overwritten by .SWITCH"

DS0033:
	.asciz " push rax"

DS0034:
	.asciz " movsxd rax, %r"

DS0035:
	.asciz " lea r11, %s"

DS0036:
	.ascii " sub r11, rax\n"
	.ascii " pop rax\n"
	.asciz " jmp r11"

DS0037:
	.asciz " movzx eax, byte ptr [r11+%r-(%d)+(IT%s-%s)]"

DS0038:
	.asciz " movzx eax, word ptr [r11+%r*2-(%d*2)+(IT%s-%s)]"

DS0039:
	.ascii " push r11\n"
	.asciz " lea r11, %s"

DS003A:
	.ascii " sub r11, rax\n"
	.ascii " mov rax, [rsp+8]\n"
	.ascii " mov [rsp+8], r11\n"
	.ascii " pop r11\n"
	.asciz " retn"

DS003B:
	.asciz "ALIGN %r"

DS003C:
	.asciz " %r %s-@C%04X"

DS003D:
	.asciz " %r @C%04X"

DS003E:
	.asciz " %r 0"

DS003F:
	.asciz " %r %s"

DS0040:
	.asciz "IT%s label %r"

DS0041:
	.asciz " %r %d"

DS0042:
	.asciz ".code"

DS0043:
	.asciz " jmp %s"

DS0044:
	.asciz " mov ax, %r"

DS0045:
	.ascii " xchg ax, bx\n"
	.ascii " add bx, bx\n"
	.ascii " mov bx, cs:[bx+%s]\n"
	.ascii " xchg ax, bx\n"
	.asciz " jmp ax"

DS0046:
	.ascii " push ax\n"
	.ascii " push bx\n"
	.asciz " push ax"

DS0047:
	.asciz " mov bx, %r"

DS0048:
	.ascii " add bx, bx\n"
	.ascii " mov ax, cs:[bx+%s]\n"
	.ascii " mov bx, sp\n"
	.ascii " mov ss:[bx+4], ax\n"
	.ascii " pop ax\n"
	.ascii " pop bx\n"
	.asciz " retn"

DS0049:
	.asciz " jmp [%r*4+DT%s-(MIN%s*4)]"

DS004A:
	.asciz " jmp [%r*4+%s-(MIN%s*4)]"

DS004B:
	.asciz "MIN%s"

DS004C:
	.asciz " movsxd %r, %r"

DS004D:
	.ascii " lea r11, %s\n"
	.ascii " sub r11, [%r*8+r11-(MIN%s*8)+(%s-%s)]\n"
	.asciz " jmp r11"

DS004E:
	.ascii " push %r\n"
	.ascii " lea  %r, %s\n"
	.ascii " sub  %r, [%r+%r*8-(MIN%s*8)+(%s-%s)]\n"
	.ascii " xchg %r, [rsp]\n"
	.asciz " retn"

DS004F:
	.asciz "%s:"

DS0050:
	.asciz " mov %s, %s"


.att_syntax prefix
