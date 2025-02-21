
.intel_syntax noprefix

.global get_register
.global InvokeDirective

.extern ExpandHllProc
.extern GetResWName
.extern AssignPointer
.extern CreateFloat
.extern atofloat
.extern quad_resize
.extern get_fasttype
.extern sym_ReservedStack
.extern CurrProc
.extern Mangle
.extern LstWrite
.extern GetGroup
.extern GetCurrOffset
.extern GetSymOfssize
.extern GetOfssizeAssume
.extern GetStdAssume
.extern search_assume
.extern RunLineQueue
.extern AddLineQueueX
.extern AddLineQueue
.extern EvalOperand
.extern SizeFromRegister
.extern SizeFromMemtype
.extern SpecialTable
.extern LclDup
.extern tstrcat
.extern tstrcpy
.extern tstrlen
.extern tmemcpy
.extern tsprintf
.extern asmerr
.extern stackreg
.extern Options
.extern ModuleInfo
.extern Parse_Pass
.extern SymFind


.SECTION .text
	.ALIGN	16

$_001:	mov	dword ptr [simd_scratch+rip], 0
	mov	dword ptr [wreg_scratch+rip], 0
	ret

get_register:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	lea	rcx, [SpecialTable+rip]
	imul	eax, dword ptr [rbp+0x10], 12
	mov	edx, dword ptr [rbp+0x18]
	test	byte ptr [rcx+rax], 0x10
	jz	$_002
	mov	edx, 16
$_002:	movzx	ecx, byte ptr [rcx+rax+0xA]
	mov	eax, dword ptr [rbp+0x10]
	cmp	ecx, 15
	ja	$_012
	jmp	$_011

$_003:	cmp	ecx, 4
	jnc	$_004
	lea	rax, [rcx+0x1]
	jmp	$_012

$_004:	lea	rax, [rcx+0x53]
	jmp	$_012

$_005:	cmp	ecx, 8
	jnc	$_006
	lea	rax, [rcx+0x9]
	jmp	$_012

$_006:	lea	rax, [rcx+0x5B]
	jmp	$_012

$_007:	cmp	ecx, 8
	jnc	$_008
	lea	rax, [rcx+0x11]
	jmp	$_012

$_008:	lea	rax, [rcx+0x63]
	jmp	$_012

$_009:	cmp	ecx, 8
	jnc	$_010
	lea	rax, [rcx+0x73]
	jmp	$_012

$_010:	lea	rax, [rcx+0x73]
	jmp	$_012

	jmp	$_012

$_011:	cmp	rdx, 1
	jz	$_003
	cmp	rdx, 2
	jz	$_005
	cmp	rdx, 4
	jz	$_007
	cmp	rdx, 8
	jz	$_009
$_012:	leave
	ret

$_013:
	mov	rdx, qword ptr [rdx]
	xchg	rdi, rdx
	mov	ecx, 31
	repne scasb
	movzx	eax, byte ptr [rdi]
	mov	rdi, rdx
	ret

$_014:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 184
	mov	dword ptr [rbp-0x74], 0
	mov	dword ptr [rbp-0x78], 0
	mov	dword ptr [rbp-0x7C], 0
	mov	dword ptr [rbp-0x80], 0
	mov	byte ptr [rbp-0x85], 0
	mov	rbx, rcx
	mov	esi, edx
	mov	rcx, rbx
	call	GetSymOfssize@PLT
	mov	ecx, eax
	mov	dword ptr [rbp-0x84], ecx
	mov	eax, 2
	shl	eax, cl
	mov	dword ptr [rbp-0x70], eax
	mov	rdx, qword ptr [rbx+0x68]
	mov	rdi, qword ptr [rdx+0x8]
$_015:	test	rdi, rdi
	jz	$_023
	test	byte ptr [rdi+0x17], 0x01
	jnz	$_016
	cmp	byte ptr [rdi+0x19], -62
	jnz	$_018
$_016:	dec	esi
	cmp	byte ptr [rdi+0x19], -62
	jnz	$_017
	inc	dword ptr [rbp-0x7C]
$_017:	jmp	$_022

$_018:	test	byte ptr [rdi+0x3B], 0x04
	jz	$_019
	dec	dword ptr [rbp+0x30]
	inc	byte ptr [rbp-0x85]
	jmp	$_022

$_019:	inc	dword ptr [rbp-0x74]
	mov	eax, dword ptr [rdi+0x50]
	mov	edx, dword ptr [rbp-0x70]
	dec	edx
	add	eax, edx
	not	edx
	and	eax, edx
	add	dword ptr [rbp-0x80], eax
	mov	dl, byte ptr [rdi+0x19]
	cmp	dl, -60
	jnz	$_020
	mov	rdx, qword ptr [rdi+0x20]
	mov	dl, byte ptr [rdx+0x19]
$_020:	test	dl, 0x20
	jnz	$_021
	cmp	dl, 31
	jnz	$_022
$_021:	inc	dword ptr [rbp-0x78]
$_022:	mov	rdi, qword ptr [rdi+0x78]
	jmp	$_015

$_023:
	cmp	byte ptr [rbp-0x85], 0
	je	$_038
	imul	edi, dword ptr [rbp+0x38], 24
	add	rdi, qword ptr [rbp+0x40]
	xor	ecx, ecx
$_024:	cmp	ecx, dword ptr [rbp+0x30]
	jg	$_026
	cmp	byte ptr [rdi], 0
	jz	$_026
	inc	dword ptr [rbp+0x38]
	cmp	byte ptr [rdi], 44
	jnz	$_025
	inc	ecx
$_025:	add	rdi, 24
	jmp	$_024

$_026:	jmp	$_037

$_027:	movzx	eax, byte ptr [rdi]
	jmp	$_032

$_028:	mov	eax, dword ptr [rbp+0x38]
	mov	dword ptr [rbp-0x6C], eax
	mov	byte ptr [rsp+0x20], 1
	lea	r9, [rbp-0x68]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x40]
	lea	rcx, [rbp-0x6C]
	call	EvalOperand@PLT
	cmp	eax, -1
	jz	$_033
	cmp	byte ptr [rbp-0x28], -64
	jz	$_029
	test	byte ptr [rbp-0x28], 0x20
	jz	$_029
	inc	dword ptr [simd_scratch+rip]
$_029:	jmp	$_033

$_030:	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rdi+0x4], 12
	test	byte ptr [r11+rax], 0x10
	jz	$_033
$_031:	inc	dword ptr [simd_scratch+rip]
	jmp	$_033

$_032:	cmp	eax, 8
	jz	$_028
	cmp	eax, 6
	jz	$_028
	cmp	eax, 91
	jz	$_028
	cmp	eax, 2
	jz	$_030
	cmp	eax, 11
	jz	$_031
$_033:	jmp	$_035

$_034:	inc	dword ptr [rbp+0x38]
	add	rdi, 24
	cmp	byte ptr [rdi-0x18], 44
	jz	$_036
$_035:	cmp	byte ptr [rdi], 0
	jnz	$_034
$_036:	inc	dword ptr [wreg_scratch+rip]
$_037:	cmp	byte ptr [rdi], 0
	jne	$_027
	mov	eax, dword ptr [simd_scratch+rip]
	sub	dword ptr [wreg_scratch+rip], eax
$_038:	movzx	edx, byte ptr [rbx+0x1A]
	mov	ecx, dword ptr [rbp-0x84]
	call	get_fasttype@PLT
	mov	rdi, rax
	mov	rcx, qword ptr [rbp+0x48]
	mov	eax, dword ptr [simd_scratch+rip]
	add	eax, dword ptr [wreg_scratch+rip]
	mul	dword ptr [rbp-0x70]
	add	eax, dword ptr [rbp-0x80]
	mov	edx, eax
	test	byte ptr [rdi+0xF], 0x10
	je	$_048
	xor	eax, eax
	mov	dword ptr [rcx], eax
	mov	ecx, dword ptr [rbp-0x70]
	movzx	edx, byte ptr [rdi+0xD]
	movzx	eax, byte ptr [rbx+0x1F]
	cmp	dl, byte ptr [rdi+0xC]
	jbe	$_039
	add	ecx, ecx
$_039:	cmp	eax, ecx
	jbe	$_040
	mov	ecx, eax
$_040:	mov	byte ptr [rbx+0x1F], cl
	mov	eax, dword ptr [rbp+0x30]
	add	eax, dword ptr [simd_scratch+rip]
	add	eax, dword ptr [wreg_scratch+rip]
	sub	eax, dword ptr [rbp-0x7C]
	cmp	al, dl
	jnc	$_041
	mov	al, dl
$_041:	mov	edx, eax
	cmp	ecx, 8
	jnz	$_042
	test	eax, 0x1
	jz	$_042
	inc	eax
$_042:	test	byte ptr [rbx+0x16], 0x10
	jz	$_043
	cmp	dl, byte ptr [rdi+0xD]
	jnz	$_043
	xor	eax, eax
$_043:	mul	ecx
	test	byte ptr [ModuleInfo+0x1E5+rip], 0x02
	jz	$_046
	mov	rdx, qword ptr [CurrProc+rip]
	test	eax, eax
	jz	$_044
	test	rdx, rdx
	jz	$_044
	or	byte ptr [rdx+0x3B], 0x10
$_044:	mov	rdx, qword ptr [sym_ReservedStack+rip]
	cmp	eax, dword ptr [rdx+0x28]
	jle	$_045
	mov	dword ptr [rdx+0x28], eax
$_045:	jmp	$_047

$_046:	test	eax, eax
	jz	$_047
	mov	rcx, qword ptr [rbp+0x48]
	mov	dword ptr [rcx], eax
	mov	edx, eax
	lea	rcx, [DS0000+rip]
	call	AddLineQueueX@PLT
$_047:	xor	eax, eax
	jmp	$_054

$_048:	test	byte ptr [rdi+0xF], 0x20
	jz	$_052
	movzx	edi, byte ptr [rbx+0x1E]
	movzx	esi, byte ptr [rbx+0x1D]
	add	edi, dword ptr [simd_scratch+rip]
	add	edi, dword ptr [rbp-0x78]
	add	esi, dword ptr [rbp-0x74]
	sub	esi, dword ptr [rbp-0x78]
	add	esi, dword ptr [wreg_scratch+rip]
	xor	eax, eax
	cmp	esi, 6
	jbe	$_049
	lea	eax, [rsi-0x6]
$_049:	cmp	edi, 8
	jbe	$_050
	lea	eax, [rax+rdi-0x8]
	mov	edi, 8
$_050:	mul	dword ptr [rbp-0x70]
	mov	dword ptr [rcx], eax
	test	eax, 0xF
	jz	$_051
	test	byte ptr [ModuleInfo+0x1E5+rip], 0x02
	jz	$_051
	add	eax, 8
	mov	dword ptr [rcx], eax
	lea	rcx, [DS0001+rip]
	call	AddLineQueue@PLT
$_051:	mov	eax, edi
	jmp	$_054

$_052:	mov	eax, dword ptr [rbp-0x84]
	shr	eax, 1
	test	byte ptr [rdi+0xF], 0x02
	jz	$_053
	test	byte ptr [rbx+0x16], 0x10
	jnz	$_053
	xor	edx, edx
$_053:	mov	dword ptr [rcx], edx
$_054:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_055:
	mov	qword ptr [rsp+0x18], r8
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	edx, r8d
	test	edx, edx
	jz	$_056
	call	GetSymOfssize@PLT
	lea	rdx, [stackreg+rip]
	mov	edx, dword ptr [rdx+rax*4]
	mov	r8d, dword ptr [rbp+0x20]
	lea	rcx, [DS0002+rip]
	call	AddLineQueueX@PLT
$_056:	leave
	ret

$_057:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 200
	mov	dword ptr [rbp-0x8], 0
	mov	dword ptr [rbp-0xC], 0
	mov	dword ptr [rbp-0x1C], 0
	mov	dword ptr [rbp-0x4C], 0
	mov	byte ptr [rbp-0x65], 0
	mov	byte ptr [rbp-0x67], 0
	mov	byte ptr [rbp-0x69], 0
	mov	byte ptr [rbp-0x7A], 0
	mov	rbx, rcx
	mov	rsi, r8
	mov	rdi, qword ptr [rbp+0x48]
	movzx	ecx, byte ptr [rbx+0x1B]
	mov	byte ptr [rbp-0x66], cl
	mov	eax, 2
	shl	eax, cl
	mov	dword ptr [rbp-0x30], eax
	movzx	edx, byte ptr [rbx+0x1A]
	call	get_fasttype@PLT
	mov	qword ptr [rbp-0x40], rax
	mov	rdx, rax
	xor	eax, eax
	test	byte ptr [rdx+0xF], 0x10
	setne	al
	mov	byte ptr [rbp-0x67], al
	test	byte ptr [rdx+0xF], 0x08
	setne	al
	add	eax, eax
	cmp	byte ptr [rbp-0x66], 0
	setne	cl
	shl	eax, cl
	mov	dword ptr [rbp-0x48], eax
	mov	al, byte ptr [rdx+0xE]
	mov	dword ptr [rbp-0x44], eax
	mov	eax, dword ptr [rdx+0x8]
	mov	dword ptr [rbp-0x50], eax
	mov	al, byte ptr [rsi+0x19]
	cmp	al, -60
	jnz	$_058
	mov	rax, qword ptr [rsi+0x20]
	mov	al, byte ptr [rax+0x19]
$_058:	mov	byte ptr [rbp-0x68], al
	mov	rcx, qword ptr [rbp+0x50]
	cmp	byte ptr [rcx], 0
	jz	$_059
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_060
	test	byte ptr [rbx+0x16], 0x10
	jz	$_060
$_059:	jmp	$_357

$_060:	mov	rdx, qword ptr [rbx+0x68]
	test	byte ptr [rdx+0x40], 0x01
	jz	$_061
	test	byte ptr [rbx+0x16], 0x10
	jz	$_061
	test	byte ptr [rbx+0x15], 0xFFFFFF80
	jz	$_061
	cmp	dword ptr [rbp+0x30], 0
	jnz	$_061
	jmp	$_357

$_061:	cmp	byte ptr [rbp-0x68], -62
	jnz	$_062
	mov	rcx, qword ptr [rbp+0x50]
	call	LclDup@PLT
	mov	qword ptr [rsi+0x8], rax
	jmp	$_357

$_062:	mov	cl, byte ptr [rbp-0x66]
	mov	eax, dword ptr [ModuleInfo+0x1C0+rip]
	and	eax, 0xF0
	mov	dword ptr [rbp-0x2C], eax
	movzx	edx, byte ptr [rbx+0x1F]
	mov	dword ptr [rbp-0x34], edx
	cmp	byte ptr [rbp-0x67], 0
	jz	$_064
	mov	eax, dword ptr [rbp-0x30]
	mov	ecx, dword ptr [rbp+0x30]
	cmp	al, dl
	jnc	$_063
	mov	al, dl
$_063:	mul	ecx
	mov	dword ptr [rbp-0x4C], eax
	mov	byte ptr [rsi+0x4B], al
$_064:	mov	eax, dword ptr [rbp-0x30]
	cmp	eax, 8
	jnz	$_065
	cmp	dword ptr [rbp+0x40], 0
	jnz	$_065
	cmp	dword ptr [rdi+0x38], 249
	jz	$_065
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_065
	mov	eax, 4
$_065:	mov	dword ptr [rbp-0x4], eax
	mov	cl, byte ptr [rdi+0x40]
	cmp	cl, -16
	jnz	$_066
	mov	cl, -64
$_066:	cmp	dword ptr [rbp+0x40], 0
	jnz	$_067
	cmp	dword ptr [rdi+0x38], 249
	jnz	$_068
$_067:	jmp	$_080

$_068:	cmp	dword ptr [rdi+0x3C], 2
	jnz	$_075
	test	byte ptr [rdi+0x43], 0x01
	jz	$_073
	cmp	cl, -64
	jz	$_070
	mov	r8, qword ptr [rdi+0x60]
	movzx	edx, byte ptr [rbp-0x66]
	movzx	ecx, cl
	call	SizeFromMemtype@PLT
	test	eax, eax
	jz	$_069
	mov	dword ptr [rbp-0x4], eax
$_069:	jmp	$_072

$_070:	cmp	byte ptr [rbp-0x68], -61
	jz	$_071
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_072
$_071:	mov	eax, dword ptr [rbp-0x30]
	mov	dword ptr [rbp-0x4], eax
$_072:	jmp	$_074

$_073:	cmp	cl, -64
	jz	$_074
	mov	r8, qword ptr [rdi+0x60]
	movzx	edx, byte ptr [rbp-0x66]
	movzx	ecx, cl
	call	SizeFromMemtype@PLT
	test	eax, eax
	jz	$_074
	mov	dword ptr [rbp-0x4], eax
$_074:	jmp	$_080

$_075:	cmp	dword ptr [rdi+0x3C], 1
	jnz	$_080
	xor	eax, eax
	cmp	cl, -64
	jz	$_077
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_076
	cmp	byte ptr [rbp-0x68], -64
	jnz	$_076
	mov	byte ptr [rbp-0x68], cl
$_076:	mov	r8, qword ptr [rdi+0x60]
	movzx	edx, byte ptr [rbp-0x66]
	movzx	ecx, cl
	call	SizeFromMemtype@PLT
	jmp	$_079

$_077:	cmp	byte ptr [rbp-0x68], -61
	jz	$_078
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_079
$_078:	mov	eax, dword ptr [rbp-0x30]
$_079:	test	eax, eax
	jz	$_080
	mov	dword ptr [rbp-0x4], eax
$_080:	cmp	qword ptr [rdi+0x18], 0
	je	$_088
	mov	rax, qword ptr [rdi+0x18]
	mov	ecx, dword ptr [rax+0x4]
	lea	rdx, [SpecialTable+rip]
	imul	eax, ecx, 12
	add	rdx, rax
	mov	eax, dword ptr [rdx+0x4]
	and	eax, 0x7F
	mov	dword ptr [rbp-0xC], eax
	mov	eax, ecx
	movzx	ecx, byte ptr [rdx+0xA]
	mov	edx, dword ptr [rdx]
	mov	dword ptr [rbp-0x10], ecx
	cmp	dword ptr [rdi+0x3C], 2
	jnz	$_081
	test	byte ptr [rdi+0x43], 0x01
	jnz	$_081
	mov	dword ptr [rbp-0x8], eax
$_081:	test	edx, 0x70
	jz	$_082
	inc	byte ptr [rbp-0x65]
	add	ecx, 16
$_082:	test	edx, 0xF
	jnz	$_083
	cmp	ecx, 32
	jnc	$_088
	test	edx, 0x70
	jz	$_088
$_083:	mov	dword ptr [rbp-0x60], eax
	mov	eax, 1
	shl	eax, cl
	and	eax, dword ptr [rbp-0x50]
	mov	rcx, qword ptr [rbp+0x58]
	test	eax, eax
	jz	$_085
	test	dword ptr [rcx], eax
	jz	$_084
	mov	byte ptr [rbp-0x7A], 1
$_084:	jmp	$_087

$_085:	test	byte ptr [rcx], 0x01
	jz	$_087
	test	edx, 0x80
	jnz	$_086
	cmp	dword ptr [rbp-0x60], 5
	jnz	$_087
$_086:	mov	byte ptr [rbp-0x7A], 1
$_087:	test	edx, 0xF
	jz	$_088
	cmp	dword ptr [rdi+0x3C], 2
	jnz	$_088
	test	byte ptr [rdi+0x43], 0x01
	jnz	$_088
	mov	eax, dword ptr [rbp-0xC]
	mov	dword ptr [rbp-0x4], eax
$_088:	cmp	dword ptr [rdi+0x3C], 1
	jnz	$_092
	cmp	qword ptr [rdi+0x20], 0
	jz	$_092
	mov	rax, qword ptr [rdi+0x20]
	mov	ecx, dword ptr [rax+0x4]
	lea	rdx, [SpecialTable+rip]
	imul	eax, ecx, 12
	mov	dword ptr [rbp-0x60], ecx
	movzx	ecx, byte ptr [rdx+rax+0xA]
	mov	edx, dword ptr [rdx+rax]
	test	edx, 0xF
	jz	$_092
	mov	eax, 1
	shl	eax, cl
	and	eax, dword ptr [rbp-0x50]
	mov	rcx, qword ptr [rbp+0x58]
	test	eax, eax
	jz	$_090
	test	dword ptr [rcx], eax
	jz	$_089
	mov	byte ptr [rbp-0x7A], 1
$_089:	jmp	$_092

$_090:	test	byte ptr [rcx], 0x01
	jz	$_092
	test	edx, 0x80
	jnz	$_091
	cmp	dword ptr [rbp-0x60], 5
	jnz	$_092
$_091:	mov	byte ptr [rbp-0x7A], 1
$_092:	cmp	byte ptr [rbp-0x7A], 0
	jz	$_093
	mov	ecx, 2133
	call	asmerr@PLT
	inc	eax
	mov	rcx, qword ptr [rbp+0x58]
	mov	dword ptr [rcx], eax
$_093:	mov	eax, dword ptr [rbp-0x4]
	mov	byte ptr [rbp-0x7B], 1
	test	byte ptr [rsi+0x3B], 0x04
	jnz	$_094
	mov	r8, qword ptr [rsi+0x20]
	movzx	edx, byte ptr [rbp-0x66]
	movzx	ecx, byte ptr [rsi+0x19]
	call	SizeFromMemtype@PLT
	mov	byte ptr [rbp-0x7B], 0
$_094:	mov	dword ptr [rbp-0x14], eax
	cmp	dword ptr [rdi+0x3C], 3
	jz	$_095
	cmp	byte ptr [rbp-0x68], -64
	jz	$_096
	test	byte ptr [rbp-0x68], 0x20
	jz	$_096
$_095:	inc	byte ptr [rbp-0x65]
$_096:	mov	rcx, rbx
	xor	ebx, ebx
	test	byte ptr [rsi+0x17], 0x01
	jz	$_097
	movzx	ebx, byte ptr [rsi+0x48]
	mov	dword ptr [rbp-0x18], ebx
	jmp	$_108

$_097:	test	byte ptr [rsi+0x3B], 0x04
	je	$_108
	cmp	byte ptr [rbp-0x68], -64
	jnz	$_098
	mov	al, byte ptr [rdi+0x40]
	mov	byte ptr [rbp-0x68], al
	and	al, 0xFFFFFFE0
	cmp	al, 32
	jnz	$_098
	inc	byte ptr [rbp-0x65]
$_098:	mov	rdx, qword ptr [rbp-0x40]
	test	byte ptr [rdx+0xF], 0x10
	jz	$_103
	mov	eax, dword ptr [rbp+0x30]
	cmp	byte ptr [rbp-0x65], 0
	jz	$_101
	cmp	al, byte ptr [rdx+0xD]
	jnc	$_100
	lea	ebx, [rax+0x28]
	cmp	al, 7
	jbe	$_099
	add	ebx, 92
$_099:	cmp	al, byte ptr [rdx+0xC]
	jnc	$_100
	movzx	ecx, byte ptr [rbp-0x66]
	shl	ecx, 3
	add	ecx, eax
	add	rcx, qword ptr [rdx]
	movzx	eax, byte ptr [rcx+0x8]
	mov	dword ptr [rbp-0x1C], eax
$_100:	jmp	$_102

$_101:	cmp	al, byte ptr [rdx+0xC]
	jnc	$_102
	movzx	ecx, byte ptr [rbp-0x66]
	shl	ecx, 3
	add	ecx, eax
	add	rcx, qword ptr [rdx]
	movzx	ebx, byte ptr [rcx+0x8]
$_102:	jmp	$_106

$_103:	cmp	byte ptr [rbp-0x65], 0
	jz	$_105
	cmp	dword ptr [simd_scratch+rip], 0
	jz	$_104
	movzx	eax, byte ptr [rcx+0x1E]
	dec	dword ptr [simd_scratch+rip]
	mov	ecx, dword ptr [simd_scratch+rip]
	add	ecx, eax
	cmp	cl, byte ptr [rdx+0xD]
	jnc	$_104
	lea	ebx, [rcx+0x28]
$_104:	jmp	$_106

$_105:	cmp	dword ptr [wreg_scratch+rip], 0
	jz	$_106
	movzx	eax, byte ptr [rcx+0x1D]
	dec	dword ptr [wreg_scratch+rip]
	mov	ecx, dword ptr [wreg_scratch+rip]
	add	ecx, eax
	cmp	cl, byte ptr [rdx+0xC]
	jnc	$_106
	mov	eax, ecx
	movzx	ecx, byte ptr [rbp-0x66]
	shl	ecx, 3
	add	ecx, eax
	add	rcx, qword ptr [rdx]
	movzx	ebx, byte ptr [rcx+0x8]
$_106:	test	ebx, ebx
	jz	$_108
	mov	ecx, ebx
	call	SizeFromRegister@PLT
	cmp	eax, 16
	jnc	$_107
	mov	edx, dword ptr [rbp-0x30]
	cmp	eax, dword ptr [rbp-0x14]
	jle	$_107
	shr	edx, 1
	cmp	edx, dword ptr [rbp-0x14]
	jl	$_107
	mov	ecx, ebx
	call	get_register
	mov	ebx, eax
$_107:	mov	dword ptr [rbp-0x18], ebx
$_108:	test	ebx, ebx
	jz	$_114
	lea	rdx, [SpecialTable+rip]
	imul	eax, ebx, 12
	movzx	ecx, byte ptr [rdx+rax+0xA]
	cmp	dword ptr [rbp-0x1C], 0
	jnz	$_109
	cmp	dword ptr [rbp-0x8], 0
	jz	$_109
	cmp	ecx, dword ptr [rbp-0x10]
	jz	$_113
$_109:	test	byte ptr [rdx+rax], 0x70
	jz	$_110
	add	ecx, 16
$_110:	xor	eax, eax
	cmp	ecx, 32
	jnc	$_111
	inc	eax
	shl	eax, cl
$_111:	mov	ecx, dword ptr [rbp-0x1C]
	test	ecx, ecx
	jz	$_112
	imul	ecx, ecx, 12
	movzx	ecx, byte ptr [rdx+rcx+0xA]
	mov	edx, 1
	shl	edx, cl
	or	eax, edx
$_112:	mov	rcx, qword ptr [rbp+0x58]
	or	dword ptr [rcx], eax
$_113:	jmp	$_117

$_114:	cmp	byte ptr [rbp-0x67], 0
	jnz	$_115
	mov	rdx, qword ptr [rbp-0x40]
	movzx	eax, byte ptr [rsi+0x49]
	sub	al, byte ptr [rdx+0xC]
	mul	dword ptr [rbp-0x30]
	mov	byte ptr [rsi+0x4B], al
$_115:	mov	byte ptr [rbp-0x69], 1
	movzx	eax, byte ptr [rbp-0x66]
	lea	rdx, [stackreg+rip]
	mov	eax, dword ptr [rdx+rax*4]
	mov	dword ptr [rbp-0x28], eax
	mov	ebx, dword ptr [ModuleInfo+0x340+rip]
	mov	eax, ebx
	mov	edx, dword ptr [rbp-0x30]
	cmp	edx, dword ptr [rbp-0x14]
	jle	$_116
	shr	edx, 1
	cmp	edx, dword ptr [rbp-0x14]
	jl	$_116
	mov	ecx, ebx
	call	get_register
$_116:	mov	dword ptr [rbp-0x18], eax
$_117:	mov	eax, dword ptr [rbp-0x18]
	mov	dword ptr [rbp-0x24], eax
	mov	ecx, dword ptr [rbp-0x18]
	call	SizeFromRegister@PLT
	mov	dword ptr [rbp-0x20], eax
	cmp	byte ptr [rbp-0x66], 0
	jz	$_118
	mov	edx, 4
	mov	ecx, dword ptr [rbp-0x18]
	call	get_register
	mov	dword ptr [rbp-0x24], eax
$_118:	mov	eax, dword ptr [rbp-0x14]
	mov	ecx, dword ptr [rbp-0x30]
	mov	edx, ecx
	shr	edx, 1
	cmp	dword ptr [rbp+0x40], 0
	jnz	$_119
	cmp	eax, ecx
	jbe	$_239
$_119:	cmp	eax, ecx
	jz	$_120
	cmp	eax, edx
	jnz	$_124
$_120:	mov	esi, ebx
	cmp	eax, edx
	jnz	$_121
	mov	esi, dword ptr [rbp-0x24]
$_121:	mov	r8, qword ptr [rbp+0x50]
	mov	edx, esi
	lea	rcx, [DS0003+rip]
	call	AddLineQueueX@PLT
	cmp	byte ptr [rbp-0x69], 0
	jz	$_123
	cmp	byte ptr [rbp-0x67], 0
	jz	$_122
	mov	ebx, esi
$_122:	jmp	$_353

$_123:	jmp	$_357

$_124:	cmp	eax, ecx
	jc	$_356
	cmp	byte ptr [rbp-0x65], 0
	je	$_152
	cmp	eax, 8
	ja	$_132
	cmp	dword ptr [rdi+0x3C], 2
	jnz	$_128
	test	byte ptr [rdi+0x43], 0x01
	jnz	$_128
	mov	ecx, 643
	cmp	eax, 4
	jnz	$_125
	mov	ecx, 1081
$_125:	cmp	byte ptr [rbp-0x69], 0
	jz	$_126
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rsp+0x28], eax
	mov	eax, dword ptr [rbp-0x28]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, ecx
	mov	r8d, dword ptr [rbp-0x4]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS0004+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_126:	cmp	ebx, dword ptr [rbp-0x8]
	jz	$_127
	mov	r9d, dword ptr [rbp-0x8]
	mov	r8d, ebx
	mov	edx, ecx
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
$_127:	jmp	$_357

$_128:	mov	rdx, qword ptr [rbp+0x50]
	cmp	dword ptr [rdi+0x3C], 3
	jnz	$_131
	xor	eax, eax
	test	byte ptr [rdi+0x43], 0x20
	jz	$_129
	inc	eax
$_129:	mov	rcx, qword ptr [rdi+0x10]
	test	rcx, rcx
	jz	$_130
	mov	rdx, qword ptr [rcx+0x8]
$_130:	mov	byte ptr [rsp+0x20], 0
	mov	r9d, eax
	mov	r8d, 8
	mov	rcx, rdi
	call	atofloat@PLT
	mov	r8d, dword ptr [rdi]
	mov	edx, dword ptr [rdi+0x4]
	lea	rcx, [DS0006+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_131:	mov	r8, rdx
	lea	rcx, [DS0007+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_132:	cmp	dword ptr [rdi+0x3C], 3
	jne	$_139
	cmp	byte ptr [rbp-0x69], 0
	je	$_137
	cmp	byte ptr [rbp-0x66], 1
	jnz	$_133
	mov	eax, dword ptr [rdi]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, dword ptr [rdi+0x4]
	mov	r8d, dword ptr [rdi+0x8]
	mov	edx, dword ptr [rdi+0xC]
	lea	rcx, [DS0008+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_133:	cmp	byte ptr [rbp-0x67], 0
	jnz	$_134
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS0009+rip]
	call	AddLineQueueX@PLT
$_134:	cmp	byte ptr [rbp-0x66], 2
	jnz	$_135
	cmp	dword ptr [rdi+0x4], 0
	jnz	$_135
	cmp	dword ptr [rdi], 0
	jnz	$_135
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000A+rip]
	call	AddLineQueueX@PLT
	jmp	$_136

$_135:	mov	eax, dword ptr [rdi+0x4]
	mov	dword ptr [rsp+0x30], eax
	mov	eax, dword ptr [rbp-0x4C]
	mov	dword ptr [rsp+0x28], eax
	mov	eax, dword ptr [rbp-0x28]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, dword ptr [rdi]
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000B+rip]
	call	AddLineQueueX@PLT
$_136:	mov	eax, dword ptr [rdi+0xC]
	mov	dword ptr [rsp+0x30], eax
	mov	eax, dword ptr [rbp-0x4C]
	mov	dword ptr [rsp+0x28], eax
	mov	eax, dword ptr [rbp-0x28]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, dword ptr [rdi+0x8]
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000C+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_137:	cmp	dword ptr [rdi], 0
	jnz	$_138
	cmp	dword ptr [rdi+0x4], 0
	jnz	$_138
	cmp	dword ptr [rdi+0x8], 0
	jnz	$_138
	cmp	dword ptr [rdi+0xC], 0
	jnz	$_138
	mov	r9d, ebx
	mov	r8d, ebx
	mov	edx, 1033
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_138:	lea	rsi, [rbp-0x79]
	mov	r8, rsi
	mov	rdx, rdi
	mov	ecx, eax
	call	CreateFloat@PLT
	mov	r9, rsi
	mov	r8d, ebx
	mov	edx, 1061
	lea	rcx, [DS000D+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_139:	cmp	dword ptr [rbp-0x8], 0
	je	$_145
	cmp	byte ptr [rbp-0x69], 0
	jz	$_142
	mov	ecx, 1061
	cmp	eax, 16
	jbe	$_140
	mov	ecx, 1425
$_140:	cmp	byte ptr [rbp-0x67], 0
	jnz	$_141
	mov	r8d, eax
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000E+rip]
	call	AddLineQueueX@PLT
$_141:	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, dword ptr [rbp-0x4C]
	mov	r8d, dword ptr [rbp-0x28]
	mov	edx, ecx
	lea	rcx, [DS000F+rip]
	call	AddLineQueueX@PLT
	jmp	$_144

$_142:	cmp	ebx, dword ptr [rbp-0x8]
	jz	$_144
	mov	ecx, 1425
	cmp	dword ptr [rbp-0x8], 140
	jge	$_143
	cmp	eax, 16
	jnz	$_143
	mov	ecx, 1061
$_143:	mov	r9d, dword ptr [rbp-0x8]
	mov	r8d, ebx
	mov	edx, ecx
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
$_144:	jmp	$_357

$_145:	cmp	byte ptr [rbp-0x69], 0
	jne	$_151
	lea	r11, [SpecialTable+rip]
	imul	eax, ebx, 12
	mov	ecx, dword ptr [r11+rax]
	test	ecx, 0x70
	jnz	$_146
	jmp	$_356

$_146:	mov	edx, 1425
	mov	esi, 233
	test	ecx, 0x40
	jz	$_147
	mov	esi, 225
	jmp	$_149

$_147:	test	ecx, 0x20
	jz	$_148
	mov	esi, 224
	jmp	$_149

$_148:	cmp	ebx, 140
	jnc	$_149
	mov	edx, 1061
$_149:	mov	rax, qword ptr [rbp+0x50]
	mov	qword ptr [rsp+0x20], rax
	mov	r9d, esi
	mov	r8d, ebx
	lea	rcx, [DS0010+rip]
	call	AddLineQueueX@PLT
	cmp	dword ptr [rbp-0x1C], 0
	jz	$_150
	mov	r8, qword ptr [rbp+0x50]
	mov	edx, dword ptr [rbp-0x1C]
	lea	rcx, [DS0003+rip]
	call	AddLineQueueX@PLT
$_150:	jmp	$_357

$_151:	jmp	$_217

$_152:	cmp	dword ptr [rbp-0x8], 0
	je	$_179
	mov	rdx, qword ptr [rdi+0x18]
	cmp	byte ptr [rdx-0x18], 13
	jnz	$_153
	mov	ecx, dword ptr [rdx-0x2C]
	mov	eax, dword ptr [rdx+0x4]
	jmp	$_163

$_153:	cmp	byte ptr [rbp-0x69], 0
	jz	$_158
	cmp	byte ptr [rbp-0x67], 0
	jz	$_156
	mov	edx, 207
	cmp	ecx, 4
	jnz	$_154
	mov	edx, 210
	jmp	$_155

$_154:	cmp	ecx, 8
	jnz	$_155
	mov	edx, 214
$_155:	mov	eax, dword ptr [rbp-0x30]
	mov	dword ptr [rsp+0x38], eax
	mov	eax, dword ptr [rbp-0x4C]
	mov	dword ptr [rsp+0x30], eax
	mov	eax, dword ptr [rbp-0x28]
	mov	dword ptr [rsp+0x28], eax
	mov	dword ptr [rsp+0x20], edx
	mov	r9d, dword ptr [rbp-0x8]
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS0011+rip]
	call	AddLineQueueX@PLT
	jmp	$_157

$_156:	mov	edx, dword ptr [rbp-0x8]
	lea	rcx, [DS0012+rip]
	call	AddLineQueueX@PLT
$_157:	jmp	$_162

$_158:	cmp	ebx, dword ptr [rbp-0x8]
	jz	$_159
	mov	r8d, dword ptr [rbp-0x8]
	mov	edx, ebx
	lea	rcx, [DS0013+rip]
	call	AddLineQueueX@PLT
$_159:	mov	rdx, qword ptr [rbp-0x40]
	mov	eax, ebx
	call	$_013
	test	eax, eax
	jnz	$_160
	jmp	$_356

$_160:	cmp	dword ptr [rbp-0x30], 8
	jnz	$_161
	mov	edx, 4
	mov	ecx, eax
	call	get_register
$_161:	mov	r8d, eax
	mov	edx, eax
	lea	rcx, [DS0014+rip]
	call	AddLineQueueX@PLT
$_162:	jmp	$_357

$_163:	mov	dword ptr [rbp-0x60], ecx
	mov	dword ptr [rbp-0x5C], eax
	mov	esi, 2
	cmp	byte ptr [rdx+0x18], 13
	jnz	$_164
	mov	ecx, dword ptr [rdx+0x34]
	mov	eax, dword ptr [rdx+0x64]
	mov	dword ptr [rbp-0x58], ecx
	mov	dword ptr [rbp-0x54], eax
	mov	esi, 4
$_164:	cmp	byte ptr [rbp-0x69], 0
	jz	$_170
	cmp	byte ptr [rbp-0x67], 0
	jz	$_167
	mov	ebx, dword ptr [rbp-0x4C]
$_165:	test	esi, esi
	jz	$_166
	mov	r9d, dword ptr [rbp+rsi*4-0x64]
	mov	r8d, ebx
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS0015+rip]
	call	AddLineQueueX@PLT
	dec	esi
	add	ebx, dword ptr [rbp-0x30]
	jmp	$_165

$_166:	jmp	$_169

$_167:	xor	ebx, ebx
$_168:	cmp	ebx, esi
	jnc	$_169
	mov	edx, dword ptr [rbp+rbx*4-0x60]
	lea	rcx, [DS0012+0x8+rip]
	call	AddLineQueueX@PLT
	inc	ebx
	jmp	$_168

$_169:	jmp	$_178

$_170:	mov	rdx, qword ptr [rbp-0x40]
	mov	eax, ebx
	call	$_013
	test	eax, eax
	jnz	$_171
	jmp	$_356

$_171:	mov	edi, eax
	cmp	esi, 4
	jnz	$_176
	mov	rdx, qword ptr [rbp-0x40]
	mov	eax, edi
	call	$_013
	test	eax, eax
	jnz	$_172
	jmp	$_356

$_172:	mov	esi, eax
	mov	rdx, qword ptr [rbp-0x40]
	mov	eax, esi
	call	$_013
	test	eax, eax
	jnz	$_173
	jmp	$_356

$_173:	mov	ecx, eax
	cmp	eax, dword ptr [rbp-0x60]
	jz	$_174
	mov	r8d, dword ptr [rbp-0x60]
	mov	edx, ecx
	lea	rcx, [DS0013+rip]
	call	AddLineQueueX@PLT
$_174:	cmp	esi, dword ptr [rbp-0x5C]
	jz	$_175
	mov	r8d, dword ptr [rbp-0x5C]
	mov	edx, esi
	lea	rcx, [DS0013+rip]
	call	AddLineQueueX@PLT
$_175:	mov	eax, dword ptr [rbp-0x58]
	mov	dword ptr [rbp-0x60], eax
	mov	eax, dword ptr [rbp-0x54]
	mov	dword ptr [rbp-0x5C], eax
$_176:	cmp	edi, dword ptr [rbp-0x60]
	jz	$_177
	mov	r8d, dword ptr [rbp-0x60]
	mov	edx, edi
	lea	rcx, [DS0013+rip]
	call	AddLineQueueX@PLT
$_177:	cmp	ebx, dword ptr [rbp-0x5C]
	jz	$_178
	mov	r8d, dword ptr [rbp-0x5C]
	mov	edx, ebx
	lea	rcx, [DS0013+rip]
	call	AddLineQueueX@PLT
$_178:	jmp	$_357

$_179:	cmp	byte ptr [rbp-0x69], 0
	je	$_197
	cmp	dword ptr [rdi+0x3C], 0
	jne	$_197
	cmp	byte ptr [rbp-0x67], 0
	je	$_182
	cmp	dword ptr [rdi+0x4], 0
	jnz	$_180
	cmp	dword ptr [rdi], 0
	jnz	$_180
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000A+rip]
	call	AddLineQueueX@PLT
	jmp	$_181

$_180:	mov	eax, dword ptr [rdi+0x4]
	mov	dword ptr [rsp+0x30], eax
	mov	eax, dword ptr [rbp-0x4C]
	mov	dword ptr [rsp+0x28], eax
	mov	eax, dword ptr [rbp-0x28]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, dword ptr [rdi]
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000B+rip]
	call	AddLineQueueX@PLT
$_181:	mov	eax, dword ptr [rdi+0xC]
	mov	dword ptr [rsp+0x30], eax
	mov	eax, dword ptr [rbp-0x4C]
	mov	dword ptr [rsp+0x28], eax
	mov	eax, dword ptr [rbp-0x28]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, dword ptr [rdi+0x8]
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000C+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_182:	cmp	byte ptr [rbp-0x66], 0
	jnz	$_187
	jmp	$_185

$_183:	movzx	ecx, word ptr [rdi+0x6]
	movzx	edx, word ptr [rdi+0x4]
	mov	r8d, edx
	mov	edx, ecx
	lea	rcx, [DS0008+0x12+rip]
	call	AddLineQueueX@PLT
$_184:	movzx	ecx, word ptr [rdi+0x2]
	movzx	edx, word ptr [rdi]
	mov	r8d, edx
	mov	edx, ecx
	lea	rcx, [DS0008+0x12+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

	jmp	$_186

$_185:	cmp	eax, 8
	jz	$_183
	cmp	eax, 4
	jz	$_184
$_186:	jmp	$_356

$_187:	cmp	byte ptr [rbp-0x66], 1
	jnz	$_192
	jmp	$_190

$_188:	mov	r8d, dword ptr [rdi+0x8]
	mov	edx, dword ptr [rdi+0xC]
	lea	rcx, [DS0008+0x12+rip]
	call	AddLineQueueX@PLT
$_189:	mov	r8d, dword ptr [rdi]
	mov	edx, dword ptr [rdi+0x4]
	lea	rcx, [DS0008+0x12+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

	jmp	$_191

$_190:	cmp	eax, 16
	jz	$_188
	cmp	eax, 8
	jz	$_189
$_191:	jmp	$_356

$_192:	cmp	eax, 16
	jne	$_356
	cmp	dword ptr [rdi+0xC], 0
	jnz	$_193
	mov	edx, dword ptr [rdi+0x8]
	lea	rcx, [DS0008+0x1B+rip]
	call	AddLineQueueX@PLT
	jmp	$_194

$_193:	mov	rax, qword ptr [rbp+0x58]
	or	byte ptr [rax], 0x01
	mov	r8, qword ptr [rdi+0x8]
	mov	edx, ebx
	lea	rcx, [DS0016+rip]
	call	AddLineQueueX@PLT
	mov	edx, ebx
	lea	rcx, [DS0012+0x8+rip]
	call	AddLineQueueX@PLT
$_194:	cmp	dword ptr [rdi+0x4], 0
	jnz	$_195
	mov	edx, dword ptr [rdi]
	lea	rcx, [DS0008+0x1B+rip]
	call	AddLineQueueX@PLT
	jmp	$_196

$_195:	mov	rax, qword ptr [rbp+0x58]
	or	byte ptr [rax], 0x01
	mov	r8, qword ptr [rdi]
	mov	edx, ebx
	lea	rcx, [DS0016+rip]
	call	AddLineQueueX@PLT
	mov	edx, ebx
	lea	rcx, [DS0012+0x8+rip]
	call	AddLineQueueX@PLT
$_196:	jmp	$_357

$_197:	cmp	byte ptr [rbp-0x69], 0
	jne	$_217
	test	byte ptr [rsi+0x17], 0x02
	jnz	$_198
	jmp	$_220

$_198:	mov	dword ptr [rbp-0x60], ebx
	mov	ebx, 207
	cmp	ecx, 4
	jnz	$_199
	mov	ebx, 210
	jmp	$_200

$_199:	cmp	ecx, 8
	jnz	$_200
	mov	ebx, 214
$_200:	mov	edx, 1
$_201:	cmp	ecx, eax
	jnc	$_202
	inc	edx
	add	ecx, dword ptr [rbp-0x30]
	jmp	$_201

$_202:	mov	dword ptr [rbp-0x64], edx
	xor	esi, esi
$_203:	cmp	esi, dword ptr [rbp-0x64]
	jge	$_216
	mov	eax, dword ptr [rbp-0x30]
	mul	esi
	cmp	dword ptr [rdi+0x3C], 0
	jne	$_214
	mov	ecx, eax
	cmp	dword ptr [rbp-0x30], 2
	jnz	$_204
	movzx	eax, word ptr [rdi+rax]
	jmp	$_206

$_204:	cmp	dword ptr [rbp-0x30], 8
	jnz	$_205
	mov	edx, dword ptr [rdi+rax+0x4]
$_205:	mov	eax, dword ptr [rdi+rax]
$_206:	test	eax, eax
	jnz	$_210
	test	edx, edx
	jnz	$_210
	mov	eax, dword ptr [rdi]
	or	eax, dword ptr [rdi+0x4]
	or	eax, dword ptr [rdi+0x8]
	or	eax, dword ptr [rdi+0xC]
	test	eax, eax
	jz	$_207
	test	byte ptr [rdi+0x43], 0x20
	jz	$_207
	cmp	dword ptr [rbp-0x30], 8
	jnz	$_207
	mov	edx, dword ptr [rbp-0x60]
	lea	rcx, [DS0017+rip]
	call	AddLineQueueX@PLT
	jmp	$_209

$_207:	mov	ecx, dword ptr [rbp-0x60]
	cmp	dword ptr [rbp-0x30], 8
	jnz	$_208
	mov	edx, 4
	call	get_register
	mov	ecx, eax
$_208:	mov	r8d, ecx
	mov	edx, ecx
	lea	rcx, [DS0014+rip]
	call	AddLineQueueX@PLT
$_209:	jmp	$_213

$_210:	cmp	dword ptr [rbp-0x30], 8
	jge	$_211
	mov	r8d, eax
	mov	edx, dword ptr [rbp-0x60]
	lea	rcx, [DS0018+rip]
	call	AddLineQueueX@PLT
	jmp	$_213

$_211:	test	edx, edx
	jnz	$_212
	mov	dword ptr [rbp-0x5C], eax
	mov	edx, 4
	mov	ecx, dword ptr [rbp-0x60]
	call	get_register
	mov	ecx, eax
	mov	r8d, dword ptr [rbp-0x5C]
	mov	edx, ecx
	lea	rcx, [DS0018+rip]
	call	AddLineQueueX@PLT
	jmp	$_213

$_212:	mov	r8, qword ptr [rdi+rcx]
	mov	edx, dword ptr [rbp-0x60]
	lea	rcx, [DS0016+rip]
	call	AddLineQueueX@PLT
$_213:	jmp	$_215

$_214:	mov	dword ptr [rsp+0x20], eax
	mov	r9, qword ptr [rbp+0x50]
	mov	r8d, ebx
	mov	edx, dword ptr [rbp-0x60]
	lea	rcx, [DS0019+rip]
	call	AddLineQueueX@PLT
$_215:	mov	rdx, qword ptr [rbp-0x40]
	mov	eax, dword ptr [rbp-0x60]
	call	$_013
	mov	dword ptr [rbp-0x60], eax
	inc	esi
	jmp	$_203

$_216:	jmp	$_357

$_217:	mov	esi, 1
$_218:	cmp	ecx, eax
	jnc	$_219
	add	esi, esi
	add	ecx, ecx
	jmp	$_218

$_219:	cmp	ecx, dword ptr [rbp-0x34]
	jg	$_220
	cmp	ecx, dword ptr [rbp-0x44]
	jle	$_222
$_220:	mov	r8, qword ptr [rbp+0x50]
	mov	edx, ebx
	lea	rcx, [DS0003+rip]
	call	AddLineQueueX@PLT
	cmp	byte ptr [rbp-0x69], 0
	jz	$_221
	jmp	$_353

$_221:	jmp	$_357

$_222:	cmp	dword ptr [rdi+0x3C], 0
	jne	$_231
$_223:	test	esi, esi
	je	$_230
	cmp	dword ptr [rbp-0x30], 8
	jnz	$_226
	mov	rax, qword ptr [rbp+0x58]
	or	byte ptr [rax], 0x01
	mov	r8, qword ptr [rdi+rsi*8-0x8]
	mov	edx, ebx
	lea	rcx, [DS0016+rip]
	call	AddLineQueueX@PLT
	cmp	byte ptr [rbp-0x67], 0
	jz	$_224
	lea	ecx, [rsi*8-0x8]
	add	ecx, dword ptr [rbp-0x4C]
	mov	r9d, ebx
	mov	r8d, ecx
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS0015+rip]
	call	AddLineQueueX@PLT
	jmp	$_225

$_224:	mov	edx, ebx
	lea	rcx, [DS0012+0x8+rip]
	call	AddLineQueueX@PLT
$_225:	jmp	$_229

$_226:	cmp	dword ptr [rbp-0x30], 4
	jnz	$_227
	mov	eax, dword ptr [rdi+rsi*4-0x4]
	jmp	$_228

$_227:	movzx	eax, word ptr [rdi+rsi*2-0x2]
$_228:	mov	edx, eax
	lea	rcx, [DS0008+0x1B+rip]
	call	AddLineQueueX@PLT
$_229:	dec	esi
	jmp	$_223

$_230:	jmp	$_357

$_231:	mov	ebx, 210
	jmp	$_236

$_232:	mov	ebx, 214
	jmp	$_237

$_233:	mov	ebx, 233
	jmp	$_237

$_234:	mov	ebx, 224
	jmp	$_237

$_235:	mov	ebx, 225
	jmp	$_237

$_236:	cmp	ecx, 8
	jz	$_232
	cmp	ecx, 16
	jz	$_233
	cmp	ecx, 32
	jz	$_234
	cmp	ecx, 64
	jz	$_235
$_237:	cmp	byte ptr [rbp-0x67], 0
	jnz	$_238
	mov	r8d, ecx
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000E+rip]
	call	AddLineQueueX@PLT
$_238:	mov	rax, qword ptr [rbp+0x50]
	mov	qword ptr [rsp+0x20], rax
	mov	r9d, ebx
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS001A+rip]
	call	AddLineQueueX@PLT
	mov	rax, qword ptr [rbp+0x58]
	or	byte ptr [rax], 0x01
	jmp	$_357

$_239:	cmp	byte ptr [rbp-0x65], 0
	je	$_289
	mov	dl, byte ptr [rbp-0x68]
	mov	ecx, dword ptr [rbp-0x14]
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_241
	cmp	dl, 35
	jz	$_241
	cmp	dl, 39
	jz	$_241
	mov	dl, 35
	cmp	dword ptr [rbp-0xC], 16
	jz	$_240
	cmp	dword ptr [rdi+0x3C], 3
	jnz	$_241
$_240:	mov	dl, 39
$_241:	cmp	ecx, 8
	ja	$_242
	cmp	byte ptr [rbp-0x66], 2
	jnc	$_243
	cmp	ecx, 4
	jbe	$_243
$_242:	jmp	$_356

$_243:	cmp	ecx, dword ptr [rbp-0x30]
	jge	$_244
	mov	ecx, dword ptr [rbp-0x30]
$_244:	cmp	dword ptr [rdi+0x3C], 2
	jne	$_263
	test	byte ptr [rdi+0x43], 0x01
	jne	$_263
	cmp	byte ptr [rbp-0x69], 0
	jnz	$_246
	cmp	ebx, dword ptr [rbp-0x8]
	jnz	$_246
	cmp	dword ptr [rbp-0x1C], 0
	jz	$_245
	mov	r8d, ebx
	mov	edx, dword ptr [rbp-0x1C]
	lea	rcx, [DS001B+rip]
	call	AddLineQueueX@PLT
$_245:	jmp	$_357

$_246:	mov	byte ptr [rbp-0x68], dl
	cmp	byte ptr [rbp-0x69], 0
	jz	$_247
	cmp	byte ptr [rbp-0x67], 0
	jnz	$_247
	mov	r8d, ecx
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000E+rip]
	call	AddLineQueueX@PLT
$_247:	mov	dl, byte ptr [rbp-0x68]
	mov	ecx, 1061
	cmp	dl, 35
	jz	$_248
	cmp	dl, 33
	jnz	$_249
$_248:	mov	ecx, 1081
	jmp	$_250

$_249:	cmp	dl, 39
	jnz	$_250
	mov	ecx, 643
$_250:	cmp	dword ptr [rbp-0x8], 140
	jl	$_253
	mov	ecx, 1425
	cmp	dl, 35
	jz	$_251
	cmp	dl, 33
	jnz	$_252
$_251:	mov	ecx, 1437
	jmp	$_253

$_252:	cmp	dl, 39
	jnz	$_253
	mov	ecx, 1436
$_253:	cmp	ecx, 1437
	jz	$_254
	cmp	ecx, 1436
	jnz	$_257
$_254:	cmp	byte ptr [rbp-0x69], 0
	jz	$_255
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, dword ptr [rbp-0x4C]
	mov	r8d, dword ptr [rbp-0x28]
	mov	edx, ecx
	lea	rcx, [DS000F+rip]
	call	AddLineQueueX@PLT
	jmp	$_256

$_255:	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, ebx
	mov	r8d, ebx
	mov	edx, ecx
	lea	rcx, [DS001C+rip]
	call	AddLineQueueX@PLT
$_256:	jmp	$_357

$_257:	cmp	byte ptr [rbp-0x69], 0
	jz	$_259
	cmp	ecx, 1081
	jnz	$_258
	cmp	dword ptr [rbp-0x30], 8
	jnz	$_258
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_258
	mov	ecx, 1055
	mov	r9d, dword ptr [rbp-0x8]
	mov	r8d, dword ptr [rbp-0x8]
	mov	edx, ecx
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
	mov	ecx, 643
$_258:	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, dword ptr [rbp-0x4C]
	mov	r8d, dword ptr [rbp-0x28]
	mov	edx, ecx
	lea	rcx, [DS000F+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_259:	cmp	dword ptr [rbp-0x30], 8
	jnz	$_261
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_261
	cmp	ecx, 1081
	jnz	$_260
	mov	ecx, 1055
	jmp	$_261

$_260:	cmp	ecx, 643
	jnz	$_261
	mov	ecx, 1061
$_261:	mov	r9d, dword ptr [rbp-0x8]
	mov	r8d, ebx
	mov	edx, ecx
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
	cmp	dword ptr [rbp-0x1C], 0
	jz	$_262
	mov	r8d, ebx
	mov	edx, dword ptr [rbp-0x1C]
	lea	rcx, [DS001B+rip]
	call	AddLineQueueX@PLT
$_262:	jmp	$_357

$_263:	cmp	byte ptr [rbp-0x69], 0
	je	$_268
	cmp	byte ptr [rbp-0x67], 0
	je	$_268
	cmp	dword ptr [rdi+0x3C], 3
	jne	$_268
	xor	eax, eax
	mov	rdx, qword ptr [rbp+0x50]
	test	byte ptr [rdi+0x43], 0x20
	jz	$_264
	inc	eax
$_264:	mov	rcx, qword ptr [rdi+0x10]
	test	rcx, rcx
	jz	$_265
	mov	rdx, qword ptr [rcx+0x8]
$_265:	cmp	dword ptr [rbp-0x30], 8
	jnz	$_266
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_266
	cmp	dword ptr [rbp-0x14], 4
	jnz	$_266
	mov	dword ptr [rbp-0x14], 8
$_266:	mov	byte ptr [rsp+0x20], 0
	mov	r9d, eax
	mov	r8d, dword ptr [rbp-0x14]
	mov	rcx, rdi
	call	atofloat@PLT
	mov	r9d, dword ptr [rdi]
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS001D+rip]
	call	AddLineQueueX@PLT
	cmp	dword ptr [rbp-0x14], 8
	jnz	$_267
	mov	r9d, dword ptr [rdi+0x4]
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS000B+0x1E+rip]
	call	AddLineQueueX@PLT
$_267:	jmp	$_357

$_268:	cmp	dl, 33
	jnz	$_272
	mov	rdx, qword ptr [rbp+0x50]
	lea	rcx, [DS001E+rip]
	call	AddLineQueueX@PLT
	cmp	byte ptr [rbp-0x69], 0
	jz	$_270
	cmp	byte ptr [rbp-0x67], 0
	jz	$_269
	mov	ebx, 9
$_269:	jmp	$_353

	jmp	$_271

$_270:	mov	rdx, qword ptr [rbp+0x58]
	or	byte ptr [rdx], 0x01
	mov	edx, ebx
	lea	rcx, [DS001F+rip]
	call	AddLineQueueX@PLT
$_271:	jmp	$_357

$_272:	cmp	dl, 35
	jne	$_284
	cmp	byte ptr [rbp-0x69], 0
	je	$_281
	cmp	dword ptr [rbp-0x30], 4
	jg	$_277
	cmp	dword ptr [rdi+0x3C], 3
	jnz	$_275
	xor	eax, eax
	mov	rdx, qword ptr [rbp+0x50]
	test	byte ptr [rdi+0x43], 0x20
	jz	$_273
	inc	eax
$_273:	mov	rcx, qword ptr [rdi+0x10]
	test	rcx, rcx
	jz	$_274
	mov	rdx, qword ptr [rcx+0x8]
$_274:	mov	byte ptr [rsp+0x20], 0
	mov	r9d, eax
	mov	r8d, 4
	mov	rcx, rdi
	call	atofloat@PLT
	mov	edx, dword ptr [rdi]
	lea	rcx, [DS0020+rip]
	call	AddLineQueueX@PLT
	jmp	$_276

$_275:	mov	rdx, qword ptr [rbp+0x50]
	lea	rcx, [DS0021+rip]
	call	AddLineQueueX@PLT
$_276:	jmp	$_357

$_277:	mov	ecx, 713
	mov	dword ptr [rbp-0x60], 17
	test	byte ptr [rsi+0x3B], 0x04
	je	$_279
	mov	dword ptr [rbp-0x60], 115
	cmp	dword ptr [rdi+0x3C], 3
	jz	$_279
	mov	ecx, 1055
	mov	esi, 40
	mov	r9, qword ptr [rbp+0x50]
	mov	r8d, esi
	mov	edx, ecx
	lea	rcx, [DS0022+rip]
	call	AddLineQueueX@PLT
	mov	rax, qword ptr [rbp+0x58]
	or	byte ptr [rax+0x2], 0x01
	cmp	byte ptr [rbp-0x67], 0
	jz	$_278
	mov	ecx, 643
	mov	dword ptr [rsp+0x20], esi
	mov	r9d, dword ptr [rbp-0x4C]
	mov	r8d, dword ptr [rbp-0x28]
	mov	edx, ecx
	lea	rcx, [DS000F+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_278:	mov	ecx, 1059
	mov	r9d, esi
	mov	r8d, ebx
	mov	edx, ecx
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
	jmp	$_353

$_279:	mov	r9, qword ptr [rbp+0x50]
	mov	r8d, dword ptr [rbp-0x60]
	mov	edx, ecx
	lea	rcx, [DS0022+rip]
	call	AddLineQueueX@PLT
	cmp	byte ptr [rbp-0x67], 0
	jz	$_280
	mov	ebx, dword ptr [rbp-0x60]
$_280:	jmp	$_353

$_281:	mov	ecx, 1081
	test	byte ptr [rsi+0x3B], 0x04
	jz	$_282
	cmp	dword ptr [rbp-0x30], 8
	jnz	$_282
	mov	ecx, 1055
	cmp	dword ptr [rdi+0x3C], 3
	jnz	$_282
	mov	ecx, 643
$_282:	mov	r9, qword ptr [rbp+0x50]
	mov	r8d, ebx
	mov	edx, ecx
	lea	rcx, [DS0022+rip]
	call	AddLineQueueX@PLT
	cmp	dword ptr [rbp-0x1C], 0
	jz	$_283
	mov	r8d, ebx
	mov	edx, dword ptr [rbp-0x1C]
	lea	rcx, [DS001B+rip]
	call	AddLineQueueX@PLT
$_283:	jmp	$_357

$_284:	mov	rcx, qword ptr [rbp+0x50]
	cmp	byte ptr [rbp-0x69], 0
	jz	$_287
	cmp	dword ptr [rbp-0x30], 8
	jnz	$_285
	mov	ebx, 115
	mov	r8, rcx
	mov	edx, ebx
	lea	rcx, [DS0023+rip]
	call	AddLineQueueX@PLT
	jmp	$_353

$_285:	cmp	dword ptr [rdi+0x3C], 3
	jnz	$_286
	mov	r8d, dword ptr [rdi]
	mov	edx, dword ptr [rdi+0x4]
	lea	rcx, [DS0008+0x12+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_286:	mov	r8, rcx
	mov	rdx, rcx
	lea	rcx, [DS0024+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_287:	mov	r8, rcx
	mov	edx, ebx
	lea	rcx, [DS0025+rip]
	call	AddLineQueueX@PLT
	cmp	dword ptr [rbp-0x1C], 0
	jz	$_288
	mov	r8d, ebx
	mov	edx, dword ptr [rbp-0x1C]
	lea	rcx, [DS001B+rip]
	call	AddLineQueueX@PLT
$_288:	jmp	$_357

$_289:	cmp	dword ptr [rdi+0x3C], 0
	jz	$_290
	cmp	dword ptr [rdi+0x3C], 1
	jne	$_309
	test	byte ptr [rdi+0x43], 0x01
	jne	$_309
	cmp	byte ptr [rdi+0x40], -64
	jne	$_309
	cmp	dword ptr [rdi+0x38], 249
	je	$_309
$_290:	cmp	ecx, 8
	jnz	$_294
	cmp	eax, 8
	jnz	$_294
	mov	rax, qword ptr [rdi]
	cmp	rax, 2147483647
	jg	$_291
	cmp	rax, -2147483648
	jge	$_294
$_291:	mov	rdx, qword ptr [rbp+0x50]
	cmp	byte ptr [rbp-0x69], 0
	jz	$_292
	cmp	byte ptr [rbp-0x67], 0
	jz	$_292
	mov	qword ptr [rsp+0x30], rdx
	mov	eax, dword ptr [rbp-0x4C]
	mov	dword ptr [rsp+0x28], eax
	mov	eax, dword ptr [rbp-0x28]
	mov	dword ptr [rsp+0x20], eax
	mov	r9, rdx
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS0026+rip]
	call	AddLineQueueX@PLT
	jmp	$_293

$_292:	mov	r8, rdx
	mov	edx, ebx
	lea	rcx, [DS0023+rip]
	call	AddLineQueueX@PLT
	cmp	byte ptr [rbp-0x69], 0
	jz	$_293
	jmp	$_353

$_293:	jmp	$_357

$_294:	mov	rax, qword ptr [rdi+0x50]
	cmp	byte ptr [rsi+0x19], -61
	jnz	$_295
	cmp	dword ptr [rdi+0x3C], 1
	jnz	$_295
	cmp	byte ptr [rax+0x18], 0
	jz	$_295
	jmp	$_356

$_295:	mov	rdx, qword ptr [rbp+0x50]
	cmp	byte ptr [rbp-0x69], 0
	jnz	$_298
	cmp	word ptr [rdx], 48
	jz	$_296
	cmp	dword ptr [rdi], 0
	jnz	$_297
	cmp	dword ptr [rdi+0x4], 0
	jnz	$_297
$_296:	mov	r8d, dword ptr [rbp-0x24]
	mov	edx, dword ptr [rbp-0x24]
	lea	rcx, [DS0014+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_297:	jmp	$_301

$_298:	cmp	byte ptr [rbp-0x67], 0
	jnz	$_301
	cmp	dword ptr [rbp-0x2C], 16
	jge	$_299
	mov	r9d, ebx
	mov	r8, rdx
	mov	edx, ebx
	lea	rcx, [DS0027+rip]
	call	AddLineQueueX@PLT
	mov	rax, qword ptr [rbp+0x58]
	or	byte ptr [rax], 0x01
	jmp	$_300

$_299:	lea	rcx, [DS0021+rip]
	call	AddLineQueueX@PLT
$_300:	jmp	$_357

$_301:	cmp	byte ptr [rbp-0x69], 0
	jz	$_306
	mov	eax, dword ptr [rbp-0x14]
	mov	ecx, 214
	cmp	eax, 1
	jnz	$_302
	mov	ecx, 205
	jmp	$_305

$_302:	cmp	eax, 2
	jnz	$_303
	mov	ecx, 207
	jmp	$_305

$_303:	cmp	eax, 4
	jnz	$_305
	cmp	dword ptr [rdi], 0
	jnz	$_304
	test	byte ptr [rsi+0x3B], 0x04
	jnz	$_305
$_304:	mov	ecx, 210
$_305:	mov	qword ptr [rsp+0x20], rdx
	mov	r9d, dword ptr [rbp-0x4C]
	mov	r8d, dword ptr [rbp-0x28]
	mov	edx, ecx
	lea	rcx, [DS0028+rip]
	call	AddLineQueueX@PLT
	jmp	$_308

$_306:	cmp	dword ptr [rdi+0x4], 0
	jnz	$_307
	mov	ebx, dword ptr [rbp-0x24]
$_307:	mov	r8, rdx
	mov	edx, ebx
	lea	rcx, [DS0023+rip]
	call	AddLineQueueX@PLT
$_308:	jmp	$_357

$_309:	cmp	dword ptr [rbp-0x8], 0
	je	$_328
	mov	edx, dword ptr [rbp-0xC]
	cmp	edx, eax
	jnc	$_310
	cmp	byte ptr [rbp-0x68], -61
	jnz	$_310
	jmp	$_356

$_310:	cmp	edx, dword ptr [rbp-0x20]
	jle	$_312
	mov	edx, dword ptr [rbp-0x20]
	mov	ecx, dword ptr [rbp-0x8]
	call	get_register
	mov	dword ptr [rbp-0x8], eax
	cmp	eax, dword ptr [rbp-0x18]
	jnz	$_311
	cmp	byte ptr [rbp-0x69], 0
	jnz	$_311
	jmp	$_357

$_311:	mov	eax, dword ptr [rbp-0x20]
	mov	dword ptr [rbp-0xC], eax
	mov	dword ptr [rbp-0x4], eax
	mov	edx, eax
$_312:	cmp	byte ptr [rbp-0x69], 0
	je	$_317
	cmp	byte ptr [rbp-0x67], 0
	jz	$_315
	cmp	byte ptr [rbp-0x7B], 0
	jz	$_314
	cmp	dword ptr [rbp-0x48], edx
	jle	$_314
	cmp	dword ptr [rbp-0x2C], 48
	jl	$_314
	mov	esi, 750
	movzx	eax, byte ptr [rdi+0x40]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_313
	mov	esi, 749
$_313:	mov	r9d, dword ptr [rbp-0x8]
	mov	r8d, dword ptr [rbp-0x18]
	mov	edx, esi
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
	mov	eax, dword ptr [rbp-0x18]
	mov	dword ptr [rbp-0x8], eax
	mov	rax, qword ptr [rbp+0x58]
	or	byte ptr [rax], 0x01
$_314:	mov	r9d, dword ptr [rbp-0x8]
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS0015+rip]
	call	AddLineQueueX@PLT
	jmp	$_316

$_315:	mov	edx, dword ptr [rbp-0x30]
	mov	ecx, dword ptr [rbp-0x8]
	call	get_register
	mov	rdx, rax
	lea	rcx, [DS0027+0xC+rip]
	call	AddLineQueueX@PLT
$_316:	jmp	$_357

$_317:	mov	esi, 713
	cmp	dword ptr [rbp-0x48], edx
	jle	$_321
	mov	edx, dword ptr [rbp-0x48]
	mov	ecx, dword ptr [rbp-0x18]
	call	get_register
	mov	ebx, eax
	cmp	dword ptr [rbp-0x2C], 48
	jl	$_319
	mov	esi, 750
	movzx	eax, byte ptr [rdi+0x40]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_318
	mov	esi, 749
$_318:	jmp	$_320

$_319:	jmp	$_325

$_320:	jmp	$_326

$_321:	cmp	dword ptr [rbp-0x20], edx
	jle	$_326
	cmp	dword ptr [rbp-0x2C], 48
	jl	$_325
	mov	esi, 750
	movzx	eax, byte ptr [rdi+0x40]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_322
	mov	esi, 749
$_322:	cmp	edx, 4
	jnz	$_324
	cmp	esi, 750
	jnz	$_323
	mov	esi, 713
	mov	edx, 4
	mov	ecx, dword ptr [rbp-0x18]
	call	get_register
	mov	ebx, eax
	jmp	$_324

$_323:	mov	esi, 1234
$_324:	jmp	$_326

$_325:	imul	eax, ebx, 12
	lea	rdx, [SpecialTable+rip]
	movzx	ecx, byte ptr [rdx+rax+0xA]
	lea	ebx, [rcx+0x1]
	add	ecx, 5
	mov	edx, ecx
	lea	rcx, [DS0029+rip]
	call	AddLineQueueX@PLT
$_326:	cmp	ebx, dword ptr [rbp-0x8]
	jz	$_327
	mov	r9d, dword ptr [rbp-0x8]
	mov	r8d, ebx
	mov	edx, esi
	lea	rcx, [DS0005+rip]
	call	AddLineQueueX@PLT
$_327:	jmp	$_357

$_328:	mov	esi, eax
	bsf	eax, eax
	bsr	esi, esi
	cmp	eax, esi
	jne	$_342
	mov	eax, dword ptr [rbp-0x20]
	cmp	dword ptr [rbp-0x4], eax
	jle	$_329
	mov	dword ptr [rbp-0x4], eax
$_329:	mov	eax, dword ptr [rbp-0x4]
	cmp	eax, ecx
	jnz	$_330
	cmp	byte ptr [rbp-0x69], 0
	jz	$_330
	cmp	byte ptr [rbp-0x67], 0
	jnz	$_330
	mov	rdx, qword ptr [rbp+0x50]
	lea	rcx, [DS0021+rip]
	call	AddLineQueueX@PLT
	jmp	$_357

$_330:	mov	esi, 713
	mov	edx, dword ptr [rbp-0x20]
	cmp	byte ptr [rbp-0x69], 0
	jnz	$_331
	cmp	dword ptr [rbp-0x48], edx
	jle	$_331
	mov	edx, dword ptr [rbp-0x48]
	mov	ecx, dword ptr [rbp-0x18]
	call	get_register
	mov	dword ptr [rbp-0x18], eax
	mov	eax, dword ptr [rbp-0x48]
	mov	dword ptr [rbp-0x20], eax
	mov	eax, dword ptr [rbp-0x4]
$_331:	mov	ecx, 205
	cmp	eax, 2
	jnz	$_332
	mov	ecx, 207
	jmp	$_334

$_332:	cmp	eax, 4
	jnz	$_333
	mov	ecx, 210
	jmp	$_334

$_333:	cmp	eax, 8
	jnz	$_334
	mov	ecx, 214
$_334:	cmp	eax, dword ptr [rbp-0x20]
	jge	$_339
	cmp	dword ptr [rbp-0x2C], 48
	jl	$_338
	mov	esi, 750
	movzx	eax, byte ptr [rdi+0x40]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_335
	mov	esi, 749
$_335:	cmp	dword ptr [rbp-0x4], 4
	jnz	$_337
	cmp	esi, 750
	jnz	$_336
	mov	edx, 4
	mov	ecx, dword ptr [rbp-0x18]
	call	get_register
	mov	dword ptr [rbp-0x18], eax
	mov	esi, 713
	mov	ecx, 210
	jmp	$_337

$_336:	mov	esi, 1234
$_337:	jmp	$_339

$_338:	imul	eax, ebx, 12
	lea	rdx, [SpecialTable+rip]
	movzx	ecx, byte ptr [rdx+rax+0xA]
	lea	eax, [rcx+0x1]
	mov	dword ptr [rbp-0x18], eax
	add	ecx, 5
	mov	edx, ecx
	lea	rcx, [DS0029+rip]
	call	AddLineQueueX@PLT
	mov	ecx, 205
$_339:	mov	rax, qword ptr [rbp+0x50]
	mov	qword ptr [rsp+0x20], rax
	mov	r9d, ecx
	mov	r8d, dword ptr [rbp-0x18]
	mov	edx, esi
	lea	rcx, [DS0010+rip]
	call	AddLineQueueX@PLT
	cmp	byte ptr [rbp-0x69], 0
	jz	$_341
	cmp	byte ptr [rbp-0x67], 0
	jz	$_340
	mov	ebx, dword ptr [rbp-0x18]
$_340:	jmp	$_353

$_341:	jmp	$_357

$_342:	mov	ecx, dword ptr [rbp-0x4]
	mov	edi, 210
	mov	esi, 1
	jmp	$_348

$_343:	inc	esi
$_344:	inc	esi
$_345:	jmp	$_349

$_346:	mov	edi, 207
	jmp	$_349

$_347:	jmp	$_356

	jmp	$_349

$_348:	cmp	ecx, 7
	jz	$_343
	cmp	ecx, 6
	jz	$_344
	cmp	ecx, 5
	jz	$_345
	cmp	ecx, 3
	jz	$_346
	jmp	$_347

$_349:	sub	ecx, esi
	mov	edx, ecx
	mov	ecx, ebx
	call	get_register
	mov	ecx, eax
	mov	edx, 713
	cmp	edi, 207
	jnz	$_350
	mov	edx, 750
	mov	ecx, ebx
$_350:	mov	dword ptr [rsp+0x28], esi
	mov	rax, qword ptr [rbp+0x50]
	mov	qword ptr [rsp+0x20], rax
	mov	r9d, edi
	mov	r8d, ecx
	lea	rcx, [DS002A+rip]
	call	AddLineQueueX@PLT
	cmp	esi, 1
	jbe	$_351
	sub	esi, 2
	mov	edx, 2
	mov	ecx, ebx
	call	get_register
	mov	ecx, eax
	mov	dword ptr [rsp+0x20], esi
	mov	r9, qword ptr [rbp+0x50]
	mov	r8d, ecx
	mov	edx, ebx
	lea	rcx, [DS002B+rip]
	call	AddLineQueueX@PLT
$_351:	test	esi, esi
	jz	$_352
	mov	edx, 1
	mov	ecx, ebx
	call	get_register
	mov	ecx, eax
	mov	r9, qword ptr [rbp+0x50]
	mov	r8d, ecx
	mov	edx, ebx
	lea	rcx, [DS002C+rip]
	call	AddLineQueueX@PLT
$_352:	cmp	byte ptr [rbp-0x69], 0
	jz	$_355
$_353:	mov	rax, qword ptr [rbp+0x58]
	or	byte ptr [rax], 0x01
	cmp	byte ptr [rbp-0x67], 0
	jz	$_354
	mov	r9d, ebx
	mov	r8d, dword ptr [rbp-0x4C]
	mov	edx, dword ptr [rbp-0x28]
	lea	rcx, [DS0015+rip]
	call	AddLineQueueX@PLT
	jmp	$_355

$_354:	mov	edx, ebx
	lea	rcx, [DS0027+0xC+rip]
	call	AddLineQueueX@PLT
$_355:	jmp	$_357

$_356:	mov	edx, dword ptr [rbp+0x30]
	inc	edx
	mov	ecx, 2114
	call	asmerr@PLT
$_357:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_358:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	esi, 0
	mov	rdi, rcx
	mov	rax, qword ptr [rdi+0x50]
	mov	rdx, qword ptr [rdi+0x30]
	test	rdx, rdx
	jz	$_361
	cmp	byte ptr [rdx], 2
	jnz	$_359
	mov	esi, dword ptr [rdx+0x4]
	jmp	$_360

$_359:	mov	rdx, qword ptr [rdx+0x8]
	mov	rcx, rdi
	call	tstrcpy@PLT
$_360:	jmp	$_371

$_361:	test	rax, rax
	je	$_369
	cmp	qword ptr [rax+0x30], 0
	je	$_369
	mov	rbx, qword ptr [rax+0x30]
	mov	rcx, qword ptr [rbx+0x68]
	cmp	dword ptr [rcx+0x48], 2
	jz	$_362
	cmp	dword ptr [rcx+0x48], 3
	jnz	$_363
$_362:	mov	r8d, 1
	mov	edx, 3
	mov	rcx, rbx
	call	search_assume@PLT
	jmp	$_364

$_363:	mov	r8d, 1
	mov	edx, 1
	mov	rcx, rbx
	call	search_assume@PLT
$_364:	cmp	eax, -2
	jz	$_365
	lea	rsi, [rax+0x19]
	jmp	$_368

$_365:	mov	rcx, qword ptr [rdi+0x50]
	call	GetGroup@PLT
	test	rax, rax
	jnz	$_366
	mov	rax, rbx
$_366:	test	rax, rax
	jz	$_367
	mov	rdx, qword ptr [rax+0x8]
	mov	rcx, qword ptr [rbp+0x30]
	call	tstrcpy@PLT
	jmp	$_368

$_367:	lea	rdx, [DS002D+rip]
	mov	rcx, qword ptr [rbp+0x30]
	call	tstrcpy@PLT
	mov	rdx, qword ptr [rbp+0x38]
	mov	rcx, rax
	call	tstrcat@PLT
$_368:	jmp	$_371

$_369:	test	rax, rax
	jz	$_370
	cmp	byte ptr [rax+0x18], 5
	jnz	$_370
	mov	esi, 27
	jmp	$_371

$_370:	lea	rdx, [DS002D+rip]
	mov	rcx, qword ptr [rbp+0x30]
	call	tstrcpy@PLT
	mov	rdx, qword ptr [rbp+0x38]
	mov	rcx, rax
	call	tstrcat@PLT
$_371:	mov	rax, rsi
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_372:
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rdi, rcx
	imul	ebx, edx, 24
	add	rbx, qword ptr [rbp+0x38]
	xor	eax, eax
	mov	byte ptr [rdi], al
$_373:	cmp	byte ptr [rbx], 44
	jz	$_376
	cmp	byte ptr [rbx], 0
	jz	$_376
	cmp	byte ptr [rbx+0x18], 5
	jnz	$_374
	cmp	dword ptr [rbx+0x1C], 270
	jnz	$_374
	add	rbx, 24
	jmp	$_375

$_374:	mov	rsi, qword ptr [rbx+0x10]
	mov	rcx, qword ptr [rbx+0x28]
	sub	rcx, rsi
	rep movsb
$_375:	add	rbx, 24
	jmp	$_373

$_376:
	stosb
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_377:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 2344
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	xor	ecx, ecx
$_378:	cmp	ecx, dword ptr [rbp+0x48]
	jg	$_381
	cmp	byte ptr [rbx], 0
	jnz	$_379
	mov	rax, -1
	jmp	$_645

$_379:	cmp	byte ptr [rbx], 44
	jnz	$_380
	inc	ecx
$_380:	add	rbx, 24
	inc	dword ptr [rbp+0x28]
	jmp	$_378

$_381:	mov	dword ptr [rbp-0x4], ecx
	mov	rdi, qword ptr [rbp+0x40]
	test	rdi, rdi
	jnz	$_382
	xor	eax, eax
	jmp	$_645

$_382:	mov	eax, dword ptr [rbp+0x48]
	inc	eax
	mov	dword ptr [rbp-0x8D4], eax
	mov	eax, dword ptr [ModuleInfo+0x1C0+rip]
	and	eax, 0xF0
	mov	dword ptr [rbp-0x8D0], eax
	mov	rsi, qword ptr [rbp+0x38]
	mov	dword ptr [rbp-0x8C], 17
	mov	dword ptr [rbp-0x1C], 0
	mov	eax, dword ptr [rdi+0x50]
	mov	dword ptr [rbp-0x8], eax
	cmp	byte ptr [rbx], 7
	jnz	$_383
	cmp	dword ptr [rbx+0x4], 273
	jnz	$_383
	mov	dword ptr [rbp-0x1C], 1
	cmp	byte ptr [rdi+0x19], -62
	jz	$_383
	add	rbx, 24
	inc	dword ptr [rbp+0x28]
$_383:	mov	rdx, rbx
$_384:	cmp	byte ptr [rdx], 44
	jz	$_385
	cmp	byte ptr [rdx], 0
	jz	$_385
	add	rdx, 24
	jmp	$_384

$_385:	mov	rsi, qword ptr [rbx+0x10]
	mov	rcx, qword ptr [rdx+0x10]
	sub	rcx, rsi
	lea	rdi, [rbp-0x88C]
	rep movsb
	mov	byte ptr [rdi], 0
	mov	rdi, qword ptr [rbp+0x40]
	cmp	byte ptr [rdi+0x19], -62
	jnz	$_386
	cmp	dword ptr [rbp-0x1C], 0
	jz	$_386
	add	rbx, 24
	inc	dword ptr [rbp+0x28]
$_386:	mov	eax, dword ptr [rbp+0x28]
	mov	dword ptr [rbp-0x14], eax
	mov	rsi, qword ptr [rbp+0x38]
	movzx	eax, byte ptr [rsi+0x1B]
	cmp	byte ptr [rsi+0x18], 7
	jz	$_387
	mov	rcx, rsi
	call	GetSymOfssize@PLT
$_387:	mov	byte ptr [rbp-0x8D5], al
	mov	ecx, eax
	mov	eax, 2
	shl	eax, cl
	add	eax, 2
	mov	dword ptr [rbp-0x18], eax
	movzx	edx, byte ptr [rsi+0x1A]
	movzx	ecx, byte ptr [rbp-0x8D5]
	call	get_fasttype@PLT
	cmp	qword ptr [rax], 0
	setne	al
	mov	byte ptr [rbp-0x8D6], al
	cmp	dword ptr [rbp-0x1C], 0
	je	$_418
	movzx	eax, byte ptr [ModuleInfo+0x1F1+rip]
	mov	dword ptr [rsp+0x20], eax
	lea	r9, [rbp-0x88]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp-0x14]
	call	EvalOperand@PLT
	cmp	eax, -1
	jnz	$_388
	jmp	$_645

$_388:	imul	ebx, dword ptr [rbp-0x14], 24
	add	rbx, qword ptr [rbp+0x30]
	mov	eax, dword ptr [rbp-0x18]
	cmp	dword ptr [rbp-0x8], eax
	jle	$_389
	cmp	dword ptr [rbp-0x18], 4
	jle	$_389
	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
	xor	eax, eax
	jmp	$_645

$_389:	cmp	byte ptr [rbp-0x8D6], 0
	jz	$_390
	mov	rax, qword ptr [rbp+0x50]
	mov	qword ptr [rsp+0x30], rax
	lea	rax, [rbp-0x88C]
	mov	qword ptr [rsp+0x28], rax
	lea	rax, [rbp-0x88]
	mov	qword ptr [rsp+0x20], rax
	mov	r9d, dword ptr [rbp-0x1C]
	mov	r8, qword ptr [rbp+0x40]
	mov	edx, dword ptr [rbp+0x48]
	mov	rcx, qword ptr [rbp+0x38]
	call	$_057
	xor	eax, eax
	jmp	$_645

$_390:	cmp	dword ptr [rbp-0x4C], 2
	jz	$_391
	test	byte ptr [rbp-0x45], 0x01
	je	$_396
$_391:	cmp	byte ptr [rdi+0x1C], 0
	jnz	$_392
	mov	eax, dword ptr [rbp-0x18]
	cmp	dword ptr [rbp-0x8], eax
	jz	$_392
	test	byte ptr [rdi+0x3B], 0x04
	jz	$_395
	cmp	byte ptr [rbp-0x48], -126
	jnz	$_395
$_392:	mov	rcx, qword ptr [rbp-0x38]
	test	rcx, rcx
	jz	$_393
	cmp	byte ptr [rcx+0x18], 5
	jnz	$_393
	lea	rcx, [DS002E+rip]
	call	AddLineQueue@PLT
	jmp	$_395

$_393:	cmp	qword ptr [rbp-0x58], 0
	jz	$_394
	mov	rcx, qword ptr [rbp-0x58]
	mov	rdx, qword ptr [rcx+0x8]
	lea	rcx, [DS0021+rip]
	call	AddLineQueueX@PLT
	jmp	$_395

$_394:	lea	rcx, [DS002F+rip]
	call	AddLineQueue@PLT
$_395:	lea	r8, [rbp-0x88C]
	mov	edx, dword ptr [ModuleInfo+0x340+rip]
	lea	rcx, [DS0003+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	mov	edx, dword ptr [ModuleInfo+0x340+rip]
	lea	rcx, [DS0027+0xC+rip]
	call	AddLineQueueX@PLT
	jmp	$_415

$_396:	mov	cl, byte ptr [rdi+0x38]
	mov	eax, 2
	shl	eax, cl
	cmp	byte ptr [rdi+0x1C], 0
	jnz	$_397
	cmp	dword ptr [rbp-0x8], eax
	jg	$_397
	test	byte ptr [rdi+0x3B], 0x04
	je	$_402
	cmp	byte ptr [rbp-0x48], -126
	jne	$_402
$_397:	lea	r8, [rbp-0x88C]
	lea	rdx, [rbp-0x8CC]
	lea	rcx, [rbp-0x88]
	call	$_358
	test	eax, eax
	jz	$_400
	mov	dword ptr [rbp-0x8DC], eax
	mov	al, byte ptr [ModuleInfo+0x1CC+rip]
	cmp	byte ptr [rbp-0x8D5], al
	jnz	$_398
	cmp	byte ptr [rdi+0x38], 0
	jnz	$_399
	cmp	byte ptr [ModuleInfo+0x1CE+rip], 2
	jbe	$_399
$_398:	lea	rcx, [DS0030+rip]
	call	AddLineQueue@PLT
$_399:	mov	edx, dword ptr [rbp-0x8DC]
	lea	rcx, [DS0027+0xC+rip]
	call	AddLineQueueX@PLT
	jmp	$_401

$_400:	lea	rdx, [rbp-0x8CC]
	lea	rcx, [DS0021+rip]
	call	AddLineQueueX@PLT
$_401:	test	byte ptr [rdi+0x3B], 0x04
	jz	$_402
	movzx	eax, byte ptr [ModuleInfo+0x1CE+rip]
	add	dword ptr [size_vararg+rip], eax
$_402:	cmp	dword ptr [rbp-0x8D0], 16
	jnc	$_403
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0031+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	jmp	$_415

$_403:	mov	rcx, qword ptr [rbp-0x38]
	cmp	byte ptr [rbp-0x46], -2
	jnz	$_405
	test	rcx, rcx
	jz	$_405
	call	GetSymOfssize@PLT
	test	byte ptr [rdi+0x3B], 0x04
	jz	$_404
	mov	byte ptr [rbp-0x46], al
	jmp	$_405

$_404:	mov	cl, al
	mov	eax, 2
	shl	eax, cl
	cmp	al, byte ptr [ModuleInfo+0x1CE+rip]
	jz	$_405
	mov	byte ptr [rbp-0x46], cl
$_405:	cmp	byte ptr [rbp-0x46], 0
	jnz	$_406
	cmp	byte ptr [ModuleInfo+0x1CE+rip], 4
	jz	$_407
$_406:	cmp	byte ptr [rdi+0x38], 1
	jnz	$_408
	cmp	byte ptr [ModuleInfo+0x1CE+rip], 2
	jnz	$_408
$_407:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0032+rip]
	call	AddLineQueueX@PLT
	jmp	$_415

$_408:	cmp	byte ptr [ModuleInfo+0x1CE+rip], 2
	jbe	$_410
	cmp	byte ptr [rdi+0x38], 0
	jnz	$_410
	cmp	byte ptr [rdi+0x1C], 0
	jnz	$_409
	cmp	byte ptr [rbp-0x8D5], 0
	jnz	$_410
$_409:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0033+rip]
	call	AddLineQueueX@PLT
	jmp	$_415

$_410:	cmp	byte ptr [ModuleInfo+0x1CE+rip], 2
	jnz	$_411
	cmp	byte ptr [rbp-0x46], 1
	jnz	$_411
	test	byte ptr [rdi+0x3B], 0x04
	jnz	$_411
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0033+rip]
	call	AddLineQueueX@PLT
	jmp	$_415

$_411:	test	byte ptr [rsi+0x16], 0x10
	jz	$_412
	test	byte ptr [rdi+0x3B], 0x04
	jnz	$_415
$_412:	cmp	byte ptr [rdi+0x38], 2
	jnz	$_413
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0034+rip]
	call	AddLineQueueX@PLT
	lea	rcx, [DS0035+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	jmp	$_414

$_413:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0036+rip]
	call	AddLineQueueX@PLT
$_414:	test	byte ptr [rdi+0x3B], 0x04
	jz	$_415
	cmp	byte ptr [ModuleInfo+0x1CE+rip], 2
	jnz	$_415
	cmp	byte ptr [rbp-0x46], 0
	jbe	$_415
	movzx	eax, byte ptr [ModuleInfo+0x1CE+rip]
	add	dword ptr [size_vararg+rip], eax
$_415:	test	byte ptr [rdi+0x3B], 0x04
	jz	$_417
	movzx	eax, byte ptr [ModuleInfo+0x1CE+rip]
	cmp	byte ptr [rdi+0x1C], 0
	jz	$_416
	add	eax, eax
$_416:	add	dword ptr [size_vararg+rip], eax
$_417:	xor	eax, eax
	jmp	$_645

$_418:	cmp	byte ptr [rbx], 2
	jne	$_426
	cmp	byte ptr [rbx+0x18], 13
	jne	$_426
	cmp	byte ptr [rbx+0x30], 2
	jne	$_426
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbx+0x4], 12
	test	byte ptr [r11+rax+0x3], 0x0C
	jz	$_421
	mov	dword ptr [rbp-0x8E0], 2
	mov	al, byte ptr [ModuleInfo+0x1CC+rip]
	cmp	byte ptr [rbp-0x8D5], al
	jnz	$_419
	cmp	byte ptr [rdi+0x38], 0
	jnz	$_420
	cmp	byte ptr [ModuleInfo+0x1CE+rip], 2
	jbe	$_420
$_419:	lea	rcx, [DS0030+rip]
	call	AddLineQueue@PLT
$_420:	jmp	$_422

$_421:	mov	ecx, dword ptr [rbx+0x4]
	call	SizeFromRegister@PLT
	mov	dword ptr [rbp-0x8E0], eax
$_422:	mov	ecx, dword ptr [rbx+0x34]
	call	SizeFromRegister@PLT
	mov	dword ptr [rbp-0xC], eax
	cmp	dword ptr [rbp-0x8E0], 8
	jz	$_423
	cmp	byte ptr [rbp-0x8D6], 0
	jnz	$_423
	mov	edx, dword ptr [rbx+0x4]
	lea	rcx, [DS0027+0xC+rip]
	call	AddLineQueueX@PLT
$_423:	mov	eax, dword ptr [rbp-0xC]
	add	eax, dword ptr [rbp-0x8E0]
	test	byte ptr [rdi+0x3B], 0x04
	jz	$_424
	cmp	al, byte ptr [ModuleInfo+0x1CE+rip]
	jz	$_424
	mov	eax, dword ptr [rbp-0x8E0]
	add	dword ptr [size_vararg+rip], eax
	jmp	$_425

$_424:	mov	eax, dword ptr [rbp-0x8E0]
	add	dword ptr [rbp-0xC], eax
$_425:	mov	rdx, qword ptr [rbx+0x38]
	lea	rcx, [rbp-0x88C]
	call	tstrcpy@PLT
	mov	dword ptr [rbp-0x4C], 2
	and	byte ptr [rbp-0x45], 0xFFFFFFFE
	mov	qword ptr [rbp-0x38], 0
	lea	rax, [rbx+0x30]
	mov	qword ptr [rbp-0x70], rax
	jmp	$_449

$_426:	cmp	byte ptr [rdi+0x19], -62
	jnz	$_427
	mov	dword ptr [rbp-0x4C], 0
	mov	byte ptr [rbp-0x48], -62
	mov	qword ptr [rbp-0x38], 0
	mov	qword ptr [rbp-0x30], 0
	mov	qword ptr [rbp-0x70], 0
	jmp	$_428

$_427:	movzx	eax, byte ptr [ModuleInfo+0x1F1+rip]
	mov	dword ptr [rsp+0x20], eax
	lea	r9, [rbp-0x88]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp-0x14]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_645
	imul	ebx, dword ptr [rbp-0x14], 24
	add	rbx, qword ptr [rbp+0x30]
$_428:	cmp	dword ptr [rbp-0x4C], 2
	jnz	$_430
	test	byte ptr [rbp-0x45], 0x01
	jnz	$_430
	mov	rcx, qword ptr [rbp-0x70]
	mov	ecx, dword ptr [rcx+0x4]
	call	SizeFromRegister@PLT
	mov	dword ptr [rbp-0xC], eax
	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	cmp	dword ptr [rbp-0x14], eax
	jge	$_429
	cmp	byte ptr [rbx], 44
	jz	$_429
	or	byte ptr [rbp-0x45], 0x01
$_429:	jmp	$_449

$_430:	cmp	dword ptr [rbp-0x4C], 0
	jz	$_431
	cmp	byte ptr [rbp-0x48], -64
	jnz	$_435
$_431:	mov	eax, dword ptr [rbp-0x8]
	mov	rcx, qword ptr [rbp-0x38]
	cmp	dword ptr [rbp-0x4C], 1
	jnz	$_432
	cmp	dword ptr [rbp-0x50], 249
	jnz	$_432
	test	rcx, rcx
	jz	$_432
	call	GetSymOfssize@PLT
	mov	ecx, eax
	mov	eax, 2
	shl	eax, cl
$_432:	mov	dword ptr [rbp-0xC], eax
	cmp	dword ptr [rbp-0x8], 0
	jnz	$_434
	test	byte ptr [rdi+0x3B], 0x04
	jnz	$_433
	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
$_433:	mov	rcx, qword ptr [rbp-0x30]
	test	rcx, rcx
	jz	$_434
	cmp	byte ptr [rcx+0x19], -60
	jnz	$_434
	mov	r8, qword ptr [rcx+0x20]
	movzx	edx, byte ptr [rbp-0x46]
	movzx	ecx, byte ptr [rcx+0x19]
	call	SizeFromMemtype@PLT
	mov	dword ptr [rbp-0xC], eax
$_434:	jmp	$_449

$_435:	cmp	byte ptr [rbp-0x48], -60
	je	$_447
	cmp	dword ptr [rbp-0x4C], 1
	jnz	$_437
	test	byte ptr [rbp-0x45], 0x01
	jnz	$_437
	cmp	qword ptr [rbp-0x38], 0
	jz	$_437
	cmp	dword ptr [rbp-0x50], -2
	jnz	$_437
	cmp	byte ptr [rbp-0x48], -127
	jz	$_436
	cmp	byte ptr [rbp-0x48], -126
	jnz	$_437
$_436:	jmp	$_396

$_437:	cmp	dword ptr [rbp-0x4C], 1
	jnz	$_444
	cmp	byte ptr [rbp-0x48], -61
	jnz	$_444
	cmp	qword ptr [rbp-0x38], 0
	jz	$_444
	mov	rcx, qword ptr [rbp-0x38]
	cmp	byte ptr [rcx+0x18], 2
	jnz	$_441
	movzx	edx, byte ptr [rbp-0x46]
	cmp	edx, 254
	jnz	$_438
	mov	dl, byte ptr [rcx+0x38]
$_438:	cmp	byte ptr [rcx+0x1C], 0
	jz	$_439
	mov	ecx, 130
	jmp	$_440

$_439:	mov	ecx, 129
$_440:	xor	r8d, r8d
	movzx	ecx, cl
	call	SizeFromMemtype@PLT
	jmp	$_443

$_441:	mov	rdx, qword ptr [rbp-0x30]
	test	rdx, rdx
	jz	$_442
	mov	rcx, rdx
$_442:	mov	eax, dword ptr [rcx+0x50]
	test	byte ptr [rcx+0x15], 0x02
	jz	$_443
	mov	ecx, dword ptr [rcx+0x58]
	xor	edx, edx
	div	ecx
$_443:	jmp	$_446

$_444:	cmp	byte ptr [rbp-0x46], -2
	jnz	$_445
	mov	al, byte ptr [ModuleInfo+0x1CC+rip]
	mov	byte ptr [rbp-0x46], al
$_445:	mov	r8, qword ptr [rbp-0x28]
	movzx	edx, byte ptr [rbp-0x46]
	movzx	ecx, byte ptr [rbp-0x48]
	call	SizeFromMemtype@PLT
$_446:	mov	dword ptr [rbp-0xC], eax
	jmp	$_449

$_447:	mov	rcx, qword ptr [rbp-0x38]
	test	rcx, rcx
	jnz	$_448
	mov	rcx, qword ptr [rbp-0x30]
$_448:	mov	rcx, qword ptr [rcx+0x20]
	mov	eax, dword ptr [rcx+0x50]
	mov	dword ptr [rbp-0xC], eax
$_449:	movzx	eax, byte ptr [ModuleInfo+0x1CE+rip]
	mov	dword ptr [rbp-0x10], eax
	test	byte ptr [rdi+0x3B], 0x04
	jz	$_450
	mov	eax, dword ptr [rbp-0xC]
	mov	dword ptr [rbp-0x8], eax
$_450:	cmp	dword ptr [rbp-0xC], 16
	jnz	$_451
	cmp	byte ptr [rbp-0x48], 47
	jnz	$_451
	cmp	dword ptr [rbp-0x10], 4
	jnz	$_451
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rbp-0xC], eax
$_451:	cmp	byte ptr [rbp-0x8D6], 0
	jz	$_452
	mov	rax, qword ptr [rbp+0x50]
	mov	qword ptr [rsp+0x30], rax
	lea	rax, [rbp-0x88C]
	mov	qword ptr [rsp+0x28], rax
	lea	rax, [rbp-0x88]
	mov	qword ptr [rsp+0x20], rax
	mov	r9d, dword ptr [rbp-0x1C]
	mov	r8, qword ptr [rbp+0x40]
	mov	edx, dword ptr [rbp+0x48]
	mov	rcx, qword ptr [rbp+0x38]
	call	$_057
	xor	eax, eax
	jmp	$_645

$_452:	mov	eax, dword ptr [rbp-0x8]
	cmp	dword ptr [rbp-0xC], eax
	jg	$_453
	mov	eax, dword ptr [rbp-0x8]
	cmp	dword ptr [rbp-0xC], eax
	jge	$_454
	cmp	byte ptr [rdi+0x19], -61
	jnz	$_454
$_453:	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
	xor	eax, eax
	jmp	$_645

$_454:	cmp	dword ptr [rbp-0x10], 8
	jnz	$_455
	mov	dword ptr [rbp-0x8C], 115
$_455:	cmp	dword ptr [rbp-0x4C], 1
	jnz	$_456
	cmp	dword ptr [rbp-0x50], 249
	jnz	$_457
$_456:	cmp	dword ptr [rbp-0x4C], 2
	jne	$_516
	test	byte ptr [rbp-0x45], 0x01
	je	$_516
$_457:	mov	rcx, qword ptr [rbp+0x50]
	mov	rdx, qword ptr [rbp-0x70]
	mov	rax, qword ptr [rbp-0x68]
	cmp	byte ptr [rcx], 0
	jz	$_460
	test	rdx, rdx
	jz	$_458
	cmp	dword ptr [rdx+0x4], 17
	jz	$_459
	cmp	dword ptr [rdx+0x4], 115
	jz	$_459
$_458:	test	rax, rax
	jz	$_460
	cmp	dword ptr [rax+0x4], 17
	jz	$_459
	cmp	dword ptr [rax+0x4], 115
	jnz	$_460
$_459:	mov	byte ptr [rcx], 0
	mov	ecx, 2133
	call	asmerr@PLT
$_460:	test	byte ptr [rdi+0x3B], 0x04
	jz	$_462
	mov	eax, dword ptr [rbp-0x10]
	cmp	dword ptr [rbp-0xC], eax
	jle	$_461
	mov	eax, dword ptr [rbp-0xC]
$_461:	add	dword ptr [size_vararg+rip], eax
$_462:	mov	eax, dword ptr [rbp-0x10]
	cmp	dword ptr [rbp-0xC], eax
	jle	$_471
	mov	dword ptr [rbp-0x8E4], 207
	cmp	dword ptr [rbp-0x8D0], 48
	jc	$_463
	mov	dword ptr [rbp-0x10], 4
	mov	dword ptr [rbp-0x8E4], 210
$_463:	test	byte ptr [rbp-0x45], 0x02
	jz	$_464
	mov	r8, qword ptr [rbp+0x30]
	mov	edx, dword ptr [rbp+0x28]
	lea	rcx, [rbp-0x88C]
	call	$_372
	and	byte ptr [rbp-0x45], 0xFFFFFFFD
$_464:	jmp	$_470

$_465:	test	byte ptr [rbp-0xC], 0x02
	jz	$_468
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jbe	$_467
	cmp	dword ptr [rbp-0x10], 4
	jnz	$_466
	add	dword ptr [size_vararg+rip], 2
$_466:	movzx	ecx, byte ptr [ModuleInfo+0x1CC+rip]
	lea	rdx, [stackreg+rip]
	mov	edx, dword ptr [rdx+rcx*4]
	lea	rcx, [DS0037+rip]
	call	AddLineQueueX@PLT
$_467:	sub	dword ptr [rbp-0xC], 2
	mov	r8d, dword ptr [rbp-0xC]
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0038+rip]
	call	AddLineQueueX@PLT
	jmp	$_470

$_468:	movzx	ecx, byte ptr [ModuleInfo+0x1CC+rip]
	lea	rdx, [ModuleInfo+rip]
	mov	ecx, dword ptr [rdx+rcx*4+0x224]
	mov	edx, dword ptr [rbp-0xC]
	mov	eax, dword ptr [rbp-0x10]
	sub	edx, eax
	sub	dword ptr [rbp-0xC], eax
	cmp	qword ptr [CurrProc+rip], 0
	jz	$_469
	cmp	ecx, 21
	jnz	$_469
	mov	edx, eax
$_469:	mov	r9d, edx
	lea	r8, [rbp-0x88C]
	mov	edx, dword ptr [rbp-0x8E4]
	lea	rcx, [DS0039+rip]
	call	AddLineQueueX@PLT
$_470:	cmp	dword ptr [rbp-0xC], 0
	jg	$_465
	jmp	$_515

$_471:	mov	eax, dword ptr [rbp-0x10]
	cmp	dword ptr [rbp-0xC], eax
	jge	$_503
	cmp	dword ptr [rbp-0x8], 4
	jle	$_472
	cmp	dword ptr [rbp-0x10], 8
	jge	$_472
	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
$_472:	movzx	eax, byte ptr [rbp-0x48]
	and	al, 0xFFFFFFC0
	cmp	dword ptr [rbp-0xC], 4
	jge	$_473
	cmp	dword ptr [rbp-0x8], 2
	jle	$_473
	cmp	al, 64
	jnz	$_473
	cmp	dword ptr [rbp-0x8D0], 48
	jc	$_473
	mov	r8d, dword ptr [rbp-0x8C]
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS003A+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 1
	jmp	$_502

$_473:	jmp	$_501

$_474:	cmp	dword ptr [rbp-0x8], 1
	jnz	$_475
	test	byte ptr [rdi+0x3B], 0x04
	jnz	$_475
	mov	r8d, dword ptr [ModuleInfo+0x340+rip]
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS003B+rip]
	call	AddLineQueueX@PLT
	jmp	$_484

$_475:	cmp	dword ptr [rbp-0x10], 2
	jne	$_482
	cmp	byte ptr [rbp-0x48], 0
	jnz	$_480
	cmp	dword ptr [rbp-0x8], 4
	jnz	$_478
	cmp	dword ptr [rbp-0x8D0], 16
	jnc	$_477
	mov	rcx, qword ptr [rbp+0x50]
	test	byte ptr [rcx], 0x04
	jnz	$_476
	lea	rcx, [DS003C+rip]
	call	AddLineQueue@PLT
$_476:	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x06
	lea	rcx, [DS0031+0x13+rip]
	call	AddLineQueue@PLT
	jmp	$_478

$_477:	lea	rcx, [DS003D+rip]
	call	AddLineQueue@PLT
$_478:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS003E+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	test	byte ptr [rcx], 0x02
	jnz	$_479
	or	byte ptr [rcx], 0x02
	lea	rcx, [DS003F+rip]
	call	AddLineQueue@PLT
$_479:	jmp	$_481

$_480:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS003E+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 0
	lea	rcx, [DS0040+rip]
	call	AddLineQueue@PLT
	cmp	dword ptr [rbp-0x8], 4
	jnz	$_481
	lea	rcx, [DS0041+rip]
	call	AddLineQueue@PLT
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x08
$_481:	lea	rcx, [DS0031+0x13+rip]
	call	AddLineQueue@PLT
	jmp	$_484

$_482:	mov	ecx, 749
	cmp	byte ptr [rbp-0x48], 0
	jnz	$_483
	mov	ecx, 750
$_483:	mov	r9d, dword ptr [rbp-0x8C]
	lea	r8, [rbp-0x88C]
	mov	edx, ecx
	lea	rcx, [DS0042+rip]
	call	AddLineQueueX@PLT
$_484:	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	jmp	$_502

$_485:	cmp	byte ptr [rbp-0x48], 1
	jne	$_492
	cmp	byte ptr [ModuleInfo+0x337+rip], 0
	jnz	$_486
	cmp	dword ptr [rbp-0x8], 2
	jnz	$_492
$_486:	cmp	dword ptr [rbp-0x10], 8
	jnz	$_487
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0043+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 1
	jmp	$_491

$_487:	test	byte ptr [rdi+0x3B], 0x04
	jnz	$_488
	cmp	dword ptr [rbp-0x8], 2
	jz	$_489
$_488:	lea	rcx, [DS0044+rip]
	call	AddLineQueue@PLT
	jmp	$_490

$_489:	movzx	ecx, byte ptr [ModuleInfo+0x1CC+rip]
	lea	rdx, [stackreg+rip]
	mov	edx, dword ptr [rdx+rcx*4]
	lea	rcx, [DS0037+rip]
	call	AddLineQueueX@PLT
$_490:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0021+rip]
	call	AddLineQueueX@PLT
$_491:	jmp	$_494

$_492:	mov	ecx, 749
	cmp	byte ptr [rbp-0x48], 1
	jnz	$_493
	mov	ecx, 750
$_493:	mov	r9d, dword ptr [rbp-0x8C]
	lea	r8, [rbp-0x88C]
	mov	edx, ecx
	lea	rcx, [DS0042+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
$_494:	jmp	$_502

$_495:	cmp	dword ptr [rbp-0x10], 8
	jnz	$_496
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0045+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	jmp	$_502

$_496:	cmp	dword ptr [rbp-0xC], 3
	jnz	$_499
	cmp	dword ptr [rbp-0x10], 2
	jle	$_497
	mov	r9d, dword ptr [rbp-0x8C]
	lea	r8, [rbp-0x88C]
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0046+rip]
	call	AddLineQueueX@PLT
	jmp	$_498

$_497:	lea	r8, [rbp-0x88C]
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0047+rip]
	call	AddLineQueueX@PLT
$_498:	jmp	$_500

$_499:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0021+rip]
	call	AddLineQueueX@PLT
$_500:	jmp	$_502

$_501:	cmp	byte ptr [rbp-0x48], 0
	je	$_474
	cmp	byte ptr [rbp-0x48], 64
	je	$_474
	cmp	byte ptr [rbp-0x48], 1
	je	$_485
	cmp	byte ptr [rbp-0x48], 65
	je	$_485
	cmp	byte ptr [rbp-0x48], 3
	je	$_495
	cmp	byte ptr [rbp-0x48], 67
	je	$_495
	jmp	$_496

$_502:	jmp	$_515

$_503:	cmp	dword ptr [rbp-0x8], 8
	jnz	$_507
	cmp	dword ptr [rbp-0xC], 4
	jnz	$_507
	cmp	byte ptr [ModuleInfo+0x337+rip], 1
	jnz	$_504
	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
	jmp	$_506

$_504:	movzx	eax, byte ptr [rbp-0x48]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_505
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0048+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 1
	jmp	$_506

$_505:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0049+rip]
	call	AddLineQueueX@PLT
$_506:	jmp	$_515

$_507:	movzx	eax, byte ptr [rbp-0x48]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_511
	mov	eax, dword ptr [rbp-0xC]
	cmp	dword ptr [rbp-0x8], eax
	jle	$_511
	cmp	dword ptr [rbp-0x8], 2
	jle	$_508
	cmp	dword ptr [rbp-0x8D0], 48
	jc	$_508
	mov	r8d, dword ptr [rbp-0x8C]
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS003A+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 1
	jmp	$_510

$_508:	cmp	dword ptr [rbp-0x10], 2
	jnz	$_509
	cmp	dword ptr [rbp-0x8], 2
	jle	$_509
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS004A+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 9
	jmp	$_510

$_509:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0049+0x8+rip]
	call	AddLineQueueX@PLT
$_510:	jmp	$_515

$_511:	cmp	dword ptr [rbp-0x10], 2
	jnz	$_514
	cmp	dword ptr [rbp-0x8], 2
	jle	$_514
	cmp	dword ptr [rbp-0x8D0], 16
	jnc	$_513
	mov	rcx, qword ptr [rbp+0x50]
	test	byte ptr [rcx], 0x04
	jnz	$_512
	lea	rcx, [DS003C+rip]
	call	AddLineQueue@PLT
$_512:	lea	rcx, [DS004A+0x1A+rip]
	call	AddLineQueue@PLT
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x07
	jmp	$_514

$_513:	lea	rcx, [DS0044+rip]
	call	AddLineQueue@PLT
$_514:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0049+0x8+rip]
	call	AddLineQueueX@PLT
$_515:	jmp	$_644

$_516:	cmp	dword ptr [rbp-0x4C], 2
	jne	$_585
	mov	rcx, qword ptr [rbp-0x70]
	mov	eax, dword ptr [rcx+0x4]
	mov	dword ptr [rbp-0x8DC], eax
	lea	r11, [SpecialTable+rip]
	imul	eax, eax, 12
	mov	eax, dword ptr [r11+rax]
	mov	dword ptr [rbp-0x8E8], eax
	test	byte ptr [rdi+0x3B], 0x04
	jz	$_517
	mov	eax, dword ptr [rbp-0x10]
	cmp	dword ptr [rbp-0x8], eax
	jge	$_517
	mov	eax, dword ptr [rbp-0x10]
	mov	dword ptr [rbp-0x8], eax
$_517:	test	dword ptr [rbp-0x8E8], 0x32008070
	jz	$_518
	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
	jmp	$_645

$_518:	mov	rcx, qword ptr [rbp+0x50]
	test	byte ptr [rcx], 0x01
	jz	$_520
	cmp	dword ptr [rbp-0x8DC], 5
	jz	$_519
	test	dword ptr [rbp-0x8E8], 0x80
	jz	$_520
$_519:	and	byte ptr [rcx], 0xFFFFFFFE
	mov	ecx, 2133
	call	asmerr@PLT
	jmp	$_522

$_520:	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbp-0x8DC], 12
	test	byte ptr [rcx], 0x08
	jz	$_522
	cmp	dword ptr [rbp-0x8DC], 7
	jz	$_521
	cmp	byte ptr [r11+rax+0xA], 2
	jnz	$_522
$_521:	and	byte ptr [rcx], 0xFFFFFFF7
	mov	ecx, 2133
	call	asmerr@PLT
$_522:	mov	edx, 2
	mov	cl, byte ptr [rbp-0x8D5]
	shl	edx, cl
	mov	eax, dword ptr [rbp-0x8]
	cmp	dword ptr [rbp-0xC], eax
	jnz	$_523
	cmp	dword ptr [rbp-0xC], edx
	jge	$_583
$_523:	cmp	dword ptr [rbp-0x8], 4
	jle	$_528
	cmp	dword ptr [rbp-0x10], 8
	jge	$_528
	cmp	dword ptr [rbp-0x8], 8
	jnz	$_524
	cmp	byte ptr [ModuleInfo+0x337+rip], 1
	jnz	$_525
$_524:	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
	jmp	$_528

$_525:	movzx	eax, byte ptr [rbp-0x48]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_527
	cmp	dword ptr [rbp-0x8DC], 17
	jz	$_526
	mov	edx, dword ptr [rbp-0x8DC]
	lea	rcx, [DS004B+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 1
	mov	dword ptr [rbp-0x8DC], 17
$_526:	lea	rcx, [DS004C+rip]
	call	AddLineQueueX@PLT
	jmp	$_528

$_527:	lea	rcx, [DS003D+rip]
	call	AddLineQueueX@PLT
$_528:	cmp	dword ptr [rbp-0xC], 2
	jg	$_552
	cmp	dword ptr [rbp-0x8], 4
	jz	$_529
	cmp	dword ptr [rbp-0x10], 4
	jne	$_552
$_529:	cmp	dword ptr [rbp-0x8D0], 48
	jc	$_534
	mov	eax, dword ptr [rbp-0x8]
	cmp	dword ptr [rbp-0xC], eax
	jnz	$_534
	cmp	dword ptr [rbp-0xC], 2
	jnz	$_530
	sub	dword ptr [rbp-0x8DC], 9
	add	dword ptr [rbp-0x8DC], 17
	jmp	$_533

$_530:	cmp	dword ptr [rbp-0x8DC], 5
	jge	$_531
	sub	dword ptr [rbp-0x8DC], 1
	add	dword ptr [rbp-0x8DC], 17
	jmp	$_532

$_531:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS003E+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	mov	dword ptr [rbp-0x8DC], 17
$_532:	mov	dword ptr [rbp-0xC], 2
$_533:	jmp	$_551

$_534:	movzx	eax, byte ptr [rbp-0x48]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jne	$_540
	cmp	dword ptr [rbp-0x10], 4
	jge	$_540
	cmp	dword ptr [rbp-0x8D0], 48
	jc	$_535
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS004D+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 1
	mov	dword ptr [rbp-0x8DC], 17
	jmp	$_539

$_535:	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 9
	cmp	dword ptr [rbp-0xC], 1
	jnz	$_537
	cmp	dword ptr [rbp-0x8DC], 1
	jz	$_536
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS003E+rip]
	call	AddLineQueueX@PLT
$_536:	lea	rcx, [DS0040+rip]
	call	AddLineQueue@PLT
	jmp	$_538

$_537:	cmp	dword ptr [rbp-0x8DC], 9
	jz	$_538
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS001E+rip]
	call	AddLineQueueX@PLT
$_538:	lea	rcx, [DS0041+rip]
	call	AddLineQueue@PLT
	mov	dword ptr [rbp-0x8DC], 9
$_539:	mov	dword ptr [rbp-0xC], 2
	jmp	$_551

$_540:	cmp	dword ptr [rbp-0x8D0], 16
	jc	$_547
	cmp	dword ptr [rbp-0x10], 4
	jnz	$_545
	cmp	dword ptr [rbp-0xC], 1
	jnz	$_541
	jmp	$_544

$_541:	cmp	dword ptr [rbp-0x8], 2
	jg	$_542
	movzx	ecx, byte ptr [ModuleInfo+0x1CC+rip]
	lea	rdx, [stackreg+rip]
	mov	edx, dword ptr [rdx+rcx*4]
	lea	rcx, [DS0037+rip]
	call	AddLineQueueX@PLT
	jmp	$_544

$_542:	movzx	eax, byte ptr [rbp-0x48]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_543
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS004D+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 1
	mov	dword ptr [rbp-0x8DC], 17
	jmp	$_544

$_543:	lea	rcx, [DS0044+rip]
	call	AddLineQueue@PLT
$_544:	jmp	$_546

$_545:	lea	rcx, [DS0044+rip]
	call	AddLineQueue@PLT
$_546:	jmp	$_551

$_547:	mov	rcx, qword ptr [rbp+0x50]
	test	byte ptr [rcx], 0x04
	jnz	$_550
	cmp	dword ptr [rbp-0x8DC], 5
	jz	$_548
	test	dword ptr [rbp-0x8E8], 0x80
	jz	$_549
$_548:	mov	ecx, 2133
	call	asmerr@PLT
$_549:	lea	rcx, [DS003C+rip]
	call	AddLineQueue@PLT
$_550:	lea	rcx, [DS004A+0x1A+rip]
	call	AddLineQueue@PLT
	mov	rcx, qword ptr [rbp+0x50]
	mov	byte ptr [rcx], 7
$_551:	jmp	$_567

$_552:	cmp	dword ptr [rbp-0x10], 8
	jne	$_567
	mov	eax, dword ptr [rbp-0x8]
	cmp	dword ptr [rbp-0xC], eax
	jnz	$_553
	cmp	dword ptr [rbp-0x8], 8
	jl	$_554
$_553:	cmp	dword ptr [rbp-0xC], 4
	jne	$_567
	cmp	dword ptr [rbp-0x8], 8
	jne	$_567
$_554:	mov	ecx, dword ptr [rbp-0x8DC]
	call	SizeFromRegister@PLT
	mov	ecx, dword ptr [rbp-0x8DC]
	jmp	$_565

$_555:	cmp	ecx, 1
	jc	$_556
	cmp	ecx, 8
	ja	$_556
	add	ecx, 114
	jmp	$_558

$_556:	cmp	ecx, 87
	jc	$_557
	cmp	ecx, 90
	ja	$_557
	add	ecx, 32
	jmp	$_558

$_557:	cmp	ecx, 91
	jc	$_558
	cmp	ecx, 98
	ja	$_558
	add	ecx, 32
$_558:	jmp	$_566

$_559:	cmp	ecx, 9
	jc	$_560
	cmp	ecx, 16
	ja	$_560
	add	ecx, 106
	jmp	$_561

$_560:	cmp	ecx, 99
	jc	$_561
	cmp	ecx, 106
	ja	$_561
	add	ecx, 24
$_561:	jmp	$_566

$_562:	cmp	ecx, 17
	jc	$_563
	cmp	ecx, 24
	ja	$_563
	add	ecx, 98
	jmp	$_564

$_563:	cmp	ecx, 107
	jc	$_564
	cmp	ecx, 114
	ja	$_564
	add	ecx, 16
$_564:	jmp	$_566

$_565:	cmp	eax, 1
	jz	$_555
	cmp	eax, 2
	jz	$_559
	cmp	eax, 4
	jz	$_562
$_566:	mov	dword ptr [rbp-0x8DC], ecx
$_567:	cmp	dword ptr [rbp-0xC], 1
	jne	$_583
	mov	eax, dword ptr [rbp-0x8DC]
	cmp	eax, 5
	jc	$_568
	cmp	eax, 8
	jbe	$_569
$_568:	cmp	dword ptr [rbp-0x8], 1
	je	$_575
$_569:	cmp	dword ptr [rbp-0x8], 1
	jz	$_571
	cmp	dword ptr [rbp-0x8D0], 48
	jc	$_571
	mov	eax, 3
	mov	ecx, 750
	movzx	eax, byte ptr [rbp-0x48]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_570
	mov	ecx, 749
	mov	eax, 1
$_570:	mov	rdx, qword ptr [rbp+0x50]
	mov	byte ptr [rdx], al
	lea	r9, [rbp-0x88C]
	mov	r8d, dword ptr [ModuleInfo+0x340+rip]
	mov	edx, ecx
	lea	rcx, [DS0022+rip]
	call	AddLineQueueX@PLT
	jmp	$_574

$_571:	cmp	eax, 1
	jz	$_572
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS003E+rip]
	call	AddLineQueueX@PLT
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	and	byte ptr [rcx], 0xFFFFFFFB
$_572:	cmp	dword ptr [rbp-0x8], 1
	jz	$_574
	mov	rcx, qword ptr [rbp+0x50]
	movzx	eax, byte ptr [rbp-0x48]
	and	al, 0xFFFFFFC0
	cmp	al, 64
	jnz	$_573
	and	byte ptr [rcx], 0xFFFFFFF9
	lea	rcx, [DS0040+rip]
	call	AddLineQueue@PLT
	jmp	$_574

$_573:	test	byte ptr [rcx], 0x02
	jnz	$_574
	or	byte ptr [rcx], 0x02
	lea	rcx, [DS003F+rip]
	call	AddLineQueue@PLT
$_574:	mov	eax, dword ptr [ModuleInfo+0x340+rip]
	mov	dword ptr [rbp-0x8DC], eax
	jmp	$_583

$_575:	cmp	dword ptr [rbp-0x8D0], 48
	jc	$_577
	cmp	dword ptr [rbp-0x8], 4
	jz	$_576
	cmp	dword ptr [rbp-0x10], 4
	jnz	$_577
$_576:	sub	eax, 1
	add	eax, 17
	jmp	$_582

$_577:	cmp	dword ptr [rbp-0x10], 8
	jnz	$_581
	cmp	dword ptr [rbp-0x8D0], 112
	jc	$_581
	cmp	eax, 1
	jc	$_578
	cmp	eax, 4
	ja	$_578
	sub	eax, 1
	add	eax, 115
	jmp	$_580

$_578:	cmp	eax, 87
	jc	$_579
	cmp	eax, 90
	ja	$_579
	sub	eax, 87
	add	eax, 119
	jmp	$_580

$_579:	sub	eax, 91
	add	eax, 123
$_580:	jmp	$_582

$_581:	cmp	dword ptr [rbp-0x10], 8
	jge	$_582
	sub	eax, 1
	add	eax, 9
$_582:	mov	dword ptr [rbp-0x8DC], eax
$_583:	mov	edx, dword ptr [rbp-0x8DC]
	lea	rcx, [DS0046+0x3A+rip]
	call	AddLineQueueX@PLT
	mov	eax, dword ptr [rbp-0x10]
	cmp	dword ptr [rbp-0x8], eax
	jge	$_584
	mov	eax, dword ptr [rbp-0x10]
	mov	dword ptr [rbp-0x8], eax
$_584:	jmp	$_643

$_585:	cmp	dword ptr [rbp-0x8], 0
	je	$_596
	mov	eax, dword ptr [rbp-0x88]
	mov	edx, dword ptr [rbp-0x84]
	cmp	dword ptr [rbp-0x4C], 3
	jnz	$_586
	mov	ecx, 4
	jmp	$_595

$_586:	test	edx, edx
	jnz	$_587
	cmp	eax, 255
	jbe	$_588
$_587:	cmp	edx, -1
	jnz	$_589
	cmp	eax, 4294967041
	jl	$_589
$_588:	mov	ecx, 1
	jmp	$_595

$_589:	test	edx, edx
	jnz	$_590
	cmp	eax, 65535
	jbe	$_591
$_590:	cmp	edx, -1
	jnz	$_592
	cmp	eax, 4294901761
	jl	$_592
$_591:	mov	ecx, 2
	jmp	$_595

$_592:	test	edx, edx
	jz	$_593
	cmp	edx, -1
	jnz	$_594
$_593:	mov	ecx, 4
	jmp	$_595

$_594:	mov	ecx, 8
$_595:	cmp	dword ptr [rbp-0x8], ecx
	jge	$_596
	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
$_596:	mov	eax, 2
	mov	cl, byte ptr [rbp-0x8D5]
	shl	eax, cl
	mov	dword ptr [rbp-0xC], eax
	cmp	dword ptr [rbp-0x8], eax
	jge	$_601
	cmp	dword ptr [rbp-0x8], 0
	jnz	$_600
	test	byte ptr [rdi+0x3B], 0x04
	jz	$_600
	cmp	eax, 2
	jnz	$_598
	cmp	dword ptr [rbp-0x88], 65535
	jg	$_597
	cmp	dword ptr [rbp-0x88], -65535
	jge	$_598
$_597:	mov	dword ptr [rbp-0x8], 4
	jmp	$_599

$_598:	mov	dword ptr [rbp-0x8], eax
$_599:	jmp	$_601

$_600:	mov	dword ptr [rbp-0x8], eax
$_601:	cmp	dword ptr [rbp-0x8D0], 16
	jnc	$_616
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	jmp	$_614

$_602:	cmp	dword ptr [rbp-0x88], 0
	jnz	$_603
	cmp	dword ptr [rbp-0x4C], 1
	jnz	$_604
$_603:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS001E+rip]
	call	AddLineQueueX@PLT
	jmp	$_606

$_604:	test	byte ptr [rcx], 0x04
	jnz	$_605
	lea	rcx, [DS003C+rip]
	call	AddLineQueue@PLT
$_605:	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x06
$_606:	jmp	$_615

$_607:	cmp	dword ptr [rbp-0x88], 65535
	ja	$_608
	lea	rcx, [DS003C+rip]
	call	AddLineQueue@PLT
	jmp	$_609

$_608:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS004E+rip]
	call	AddLineQueueX@PLT
$_609:	lea	rcx, [DS004A+0x1A+rip]
	call	AddLineQueue@PLT
	cmp	dword ptr [rbp-0x88], 0
	jnz	$_610
	cmp	dword ptr [rbp-0x4C], 1
	jnz	$_611
$_610:	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS004F+rip]
	call	AddLineQueueX@PLT
	jmp	$_612

$_611:	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x06
$_612:	jmp	$_615

$_613:	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
	jmp	$_615

$_614:	cmp	dword ptr [rbp-0x8], 2
	je	$_602
	cmp	dword ptr [rbp-0x8], 4
	je	$_607
	jmp	$_613

$_615:	lea	rcx, [DS004A+0x1A+rip]
	call	AddLineQueue@PLT
	jmp	$_643

$_616:	mov	ebx, 708
	mov	esi, 4294967294
	mov	eax, dword ptr [rbp-0x10]
	cmp	dword ptr [rbp-0x8], eax
	je	$_641
	jmp	$_640

$_617:	mov	ebx, 710
	jmp	$_641

$_618:	cmp	byte ptr [rbp-0x8D5], 0
	jnz	$_619
	mov	ebx, 710
	jmp	$_620

$_619:	cmp	byte ptr [rbp-0x8D5], 1
	jnz	$_620
	cmp	byte ptr [ModuleInfo+0x1CE+rip], 2
	jnz	$_620
	mov	ebx, 672
$_620:	lea	r8, [rbp-0x88C]
	mov	edx, ebx
	lea	rcx, [DS0050+rip]
	call	AddLineQueueX@PLT
$_621:	cmp	dword ptr [rbp-0x8D0], 48
	jc	$_622
	mov	ebx, 672
	jmp	$_623

$_622:	mov	ebx, 710
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0051+rip]
	call	AddLineQueueX@PLT
	mov	esi, 245
$_623:	jmp	$_641

$_624:	cmp	byte ptr [rbp-0x8D5], 0
	jz	$_625
	cmp	byte ptr [Options+0xC6+rip], 1
	jz	$_625
	cmp	dword ptr [rbp-0x4C], 3
	jz	$_626
$_625:	jmp	$_641

$_626:	mov	edx, 10
	lea	rcx, [rbp-0x88]
	call	quad_resize@PLT
	mov	edx, dword ptr [rbp-0x80]
	lea	rcx, [DS0052+rip]
	call	AddLineQueueX@PLT
	cmp	dword ptr [rbp-0x8D0], 112
	jc	$_627
	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	mov	rdx, qword ptr [rbp-0x88]
	lea	rcx, [DS0053+rip]
	call	AddLineQueueX@PLT
	jmp	$_628

$_627:	mov	ebx, 672
	mov	r8, qword ptr [rbp-0x88]
	mov	rdx, qword ptr [rbp-0x88]
	lea	rcx, [DS0054+rip]
	call	AddLineQueueX@PLT
$_628:	jmp	$_643

$_629:	cmp	byte ptr [rbp-0x8D5], 0
	je	$_641
	cmp	byte ptr [Options+0xC6+rip], 1
	je	$_641
	cmp	byte ptr [rbp-0x8D5], 1
	jnz	$_630
	mov	ebx, 672
	mov	rax, qword ptr [rbp-0x88]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x88]
	mov	r8, qword ptr [rbp-0x80]
	mov	rdx, qword ptr [rbp-0x80]
	lea	rcx, [DS0055+rip]
	call	AddLineQueueX@PLT
	jmp	$_643

$_630:	cmp	dword ptr [rbp-0x7C], 0
	jz	$_631
	cmp	dword ptr [rbp-0x7C], -1
	jnz	$_632
$_631:	mov	rdx, qword ptr [rbp-0x80]
	lea	rcx, [DS0056+rip]
	call	AddLineQueueX@PLT
	jmp	$_633

$_632:	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	mov	rdx, qword ptr [rbp-0x80]
	lea	rcx, [DS0053+rip]
	call	AddLineQueueX@PLT
$_633:	cmp	dword ptr [rbp-0x84], 0
	jz	$_634
	cmp	dword ptr [rbp-0x84], -1
	jnz	$_635
$_634:	mov	rdx, qword ptr [rbp-0x88]
	lea	rcx, [DS0056+rip]
	call	AddLineQueueX@PLT
	jmp	$_636

$_635:	mov	rcx, qword ptr [rbp+0x50]
	or	byte ptr [rcx], 0x01
	mov	rdx, qword ptr [rbp-0x88]
	lea	rcx, [DS0053+rip]
	call	AddLineQueueX@PLT
$_636:	jmp	$_643

$_637:	cmp	byte ptr [rbp-0x8D5], 2
	jz	$_641
	cmp	dword ptr [rbp-0x4C], 0
	jz	$_638
	cmp	dword ptr [rbp-0x4C], 3
	jnz	$_639
$_638:	mov	ebx, 672
	mov	esi, 244
	lea	rdx, [rbp-0x88C]
	lea	rcx, [DS0057+rip]
	call	AddLineQueueX@PLT
	jmp	$_641

$_639:	mov	edx, dword ptr [rbp-0x8D4]
	mov	ecx, 2114
	call	asmerr@PLT
	jmp	$_641

$_640:	cmp	dword ptr [rbp-0x8], 2
	je	$_617
	cmp	dword ptr [rbp-0x8], 6
	je	$_618
	cmp	dword ptr [rbp-0x8], 4
	je	$_621
	cmp	dword ptr [rbp-0x8], 10
	je	$_624
	cmp	dword ptr [rbp-0x8], 16
	je	$_629
	cmp	dword ptr [rbp-0x8], 8
	jz	$_637
	jmp	$_639

$_641:	cmp	esi, -2
	jz	$_642
	lea	r9, [rbp-0x88C]
	mov	r8d, esi
	mov	edx, ebx
	lea	rcx, [DS0058+rip]
	call	AddLineQueueX@PLT
	jmp	$_643

$_642:	lea	r8, [rbp-0x88C]
	mov	edx, ebx
	lea	rcx, [DS0059+rip]
	call	AddLineQueueX@PLT
$_643:	test	byte ptr [rdi+0x3B], 0x04
	jz	$_644
	mov	eax, dword ptr [rbp-0x8]
	add	dword ptr [size_vararg+rip], eax
$_644:	xor	eax, eax
$_645:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

InvokeDirective:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 2888
	mov	dword ptr [rbp-0x48], 0
	mov	qword ptr [rbp-0x8C8], 0
	mov	qword ptr [rbp-0x8D8], 0
	inc	dword ptr [rbp+0x28]
	mov	eax, dword ptr [rbp+0x28]
	mov	dword ptr [rbp-0x3C], eax
	cmp	byte ptr [Options+0xC6+rip], 0
	jnz	$_648
$_646:	mov	r8, qword ptr [rbp+0x30]
	mov	edx, dword ptr [rbp+0x28]
	lea	rcx, [rbp-0x8C0]
	call	ExpandHllProc@PLT
	cmp	eax, -1
	je	$_758
	cmp	byte ptr [rbp-0x8C0], 0
	jz	$_648
	lea	rcx, [rbp-0x8C0]
	call	AddLineQueue@PLT
	call	RunLineQueue@PLT
	mov	rbx, qword ptr [rbp+0x30]
	cmp	dword ptr [rbx+0x4], 543
	jnz	$_647
	cmp	byte ptr [rbx+0x18], 2
	jnz	$_647
	cmp	dword ptr [ModuleInfo+0x220+rip], 2
	jnz	$_647
	xor	eax, eax
	jmp	$_758

$_647:	jmp	$_646

$_648:	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	cmp	byte ptr [rbx], 8
	jnz	$_649
	cmp	byte ptr [rbx+0x18], 44
	je	$_657
	cmp	byte ptr [rbx+0x18], 0
	je	$_657
$_649:	mov	byte ptr [rsp+0x20], 0
	lea	r9, [rbp-0xC0]
	mov	r8d, dword ptr [ModuleInfo+0x220+rip]
	mov	rdx, qword ptr [rbp+0x30]
	lea	rcx, [rbp+0x28]
	call	EvalOperand@PLT
	cmp	eax, -1
	je	$_758
	mov	rsi, qword ptr [rbp-0x60]
	test	rsi, rsi
	jz	$_651
	cmp	byte ptr [rsi+0x18], 7
	jnz	$_651
	mov	qword ptr [rbp-0x8], rsi
	mov	qword ptr [rbp-0x10], rsi
	cmp	byte ptr [rsi+0x19], -128
	jnz	$_650
	jmp	$_664

$_650:	cmp	byte ptr [rsi+0x19], -61
	jnz	$_651
	jmp	$_665

$_651:	cmp	dword ptr [rbp-0x84], 2
	jnz	$_654
	mov	rbx, qword ptr [rbp-0xA8]
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbx+0x4], 12
	test	byte ptr [r11+rax], 0x0E
	jz	$_652
	lea	r11, [SpecialTable+rip]
	imul	eax, dword ptr [rbx+0x4], 12
	movzx	ecx, byte ptr [r11+rax+0xA]
	call	GetStdAssume@PLT
	mov	qword ptr [rbp-0x8], rax
	jmp	$_653

$_652:	mov	qword ptr [rbp-0x8], 0
$_653:	jmp	$_656

$_654:	mov	rax, qword ptr [rbp-0x68]
	test	rax, rax
	jnz	$_655
	mov	rax, qword ptr [rbp-0x70]
$_655:	mov	qword ptr [rbp-0x8], rax
$_656:	jmp	$_658

$_657:	mov	qword ptr [rbp-0xA8], 0
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	mov	rcx, qword ptr [rbx+0x8]
	call	SymFind@PLT
	mov	qword ptr [rbp-0x8], rax
	inc	dword ptr [rbp+0x28]
$_658:	mov	rsi, qword ptr [rbp-0x8]
	test	rsi, rsi
	jnz	$_659
	mov	ecx, 2190
	call	asmerr@PLT
	jmp	$_758

$_659:	mov	rdx, qword ptr [rsi+0x20]
	mov	rcx, qword ptr [rsi+0x40]
	test	byte ptr [rsi+0x15], 0x08
	jz	$_660
	jmp	$_668

$_660:	cmp	byte ptr [rsi+0x19], -61
	jnz	$_661
	test	rcx, rcx
	jz	$_661
	test	byte ptr [rcx+0x15], 0x08
	jz	$_661
	mov	qword ptr [rbp-0x8], rcx
	jmp	$_668

$_661:	cmp	byte ptr [rsi+0x19], -61
	jnz	$_662
	test	rcx, rcx
	jz	$_662
	cmp	byte ptr [rcx+0x19], -128
	jnz	$_662
	mov	qword ptr [rbp-0x10], rcx
	jmp	$_664

	jmp	$_668

$_662:	cmp	byte ptr [rsi+0x19], -60
	jnz	$_667
	cmp	byte ptr [rdx+0x19], -61
	jz	$_663
	cmp	byte ptr [rdx+0x19], -128
	jnz	$_667
$_663:	mov	qword ptr [rbp-0x10], rdx
	cmp	byte ptr [rdx+0x19], -128
	jz	$_664
	jmp	$_665

$_664:	mov	rsi, qword ptr [rbp-0x10]
	cmp	byte ptr [rsi+0x19], -128
	jz	$_665
	mov	ecx, 2190
	call	asmerr@PLT
	jmp	$_758

$_665:	mov	rsi, qword ptr [rbp-0x10]
	mov	rax, qword ptr [rsi+0x40]
	mov	qword ptr [rbp-0x8], rax
	test	rax, rax
	jnz	$_666
	mov	ecx, 2190
	call	asmerr@PLT
	jmp	$_758

$_666:	jmp	$_668

$_667:	mov	ecx, 2190
	call	asmerr@PLT
	jmp	$_758

$_668:	mov	rsi, qword ptr [rbp-0x8]
	mov	qword ptr [rbp-0x10], rsi
	mov	rcx, rsi
	mov	rax, qword ptr [rcx+0x68]
	mov	qword ptr [rbp-0x50], rax
	cmp	byte ptr [Options+0xC6+rip], 0
	jne	$_679
	imul	ebx, dword ptr [rbp-0x3C], 24
	add	rbx, qword ptr [rbp+0x30]
	mov	rcx, qword ptr [rsi+0x40]
	cmp	byte ptr [rsi+0x18], 2
	jnz	$_670
	test	rcx, rcx
	jz	$_670
	cmp	byte ptr [rcx+0x18], 9
	jnz	$_670
	mov	rax, qword ptr [rcx+0x58]
	test	rax, rax
	jz	$_669
	mov	qword ptr [rbp-0x8C8], rcx
	mov	qword ptr [rax], rcx
	mov	rdx, qword ptr [rcx+0x8]
	lea	rcx, [rbp-0x8C0]
	call	tstrcpy@PLT
$_669:	jmp	$_679

$_670:	cmp	byte ptr [rbx], 91
	jne	$_679
	cmp	byte ptr [rbx+0x48], 46
	jne	$_679
	cmp	qword ptr [rbp-0x68], 0
	je	$_679
	mov	rdi, qword ptr [rbp-0x68]
	test	byte ptr [rdi+0x15], 0xFFFFFF80
	je	$_678
	mov	rcx, qword ptr [rbx+0x68]
	call	SymFind@PLT
	mov	qword ptr [rbp-0x8D0], rax
	test	rax, rax
	je	$_674
	test	byte ptr [rax+0x16], 0x04
	je	$_674
	test	byte ptr [rdi+0x16], 0x08
	jz	$_671
	mov	rax, qword ptr [rdi+0x30]
	mov	qword ptr [rbp-0x8C8], rax
	mov	rdx, qword ptr [rax+0x8]
	lea	rcx, [rbp-0x8C0]
	call	tstrcpy@PLT
	jmp	$_672

$_671:	mov	rcx, qword ptr [rax+0x30]
	mov	rdx, qword ptr [rcx+0x8]
	lea	rcx, [rbp-0x8C0]
	call	tstrcpy@PLT
	lea	rdx, [DS005A+rip]
	mov	rcx, rax
	call	tstrcat@PLT
	mov	rdx, qword ptr [rdi+0x8]
	mov	rcx, rax
	call	tstrcat@PLT
	mov	rcx, rax
	call	SymFind@PLT
	mov	qword ptr [rbp-0x8C8], rax
$_672:	mov	rax, qword ptr [rbp-0x8C8]
	test	rax, rax
	jz	$_673
	cmp	byte ptr [rax+0x18], 10
	jnz	$_673
	mov	rcx, qword ptr [rax+0x28]
	call	SymFind@PLT
	mov	qword ptr [rbp-0x8C8], rax
$_673:	test	rax, rax
	jz	$_674
	cmp	byte ptr [rax+0x18], 9
	jz	$_674
	mov	qword ptr [rbp-0x8C8], 0
$_674:	test	byte ptr [rdi+0x16], 0x40
	jz	$_678
	and	dword ptr [rdi+0x14], 0xFFBFFFFF
	mov	ecx, dword ptr [ModuleInfo+0x220+rip]
	dec	ecx
	imul	edx, ecx, 24
	add	rdx, qword ptr [rbp+0x30]
	jmp	$_676

$_675:	cmp	byte ptr [rdx], 44
	jz	$_677
	sub	rdx, 24
	dec	ecx
$_676:	cmp	rdx, rbx
	ja	$_675
$_677:	cmp	byte ptr [rdx], 44
	jnz	$_678
	lea	rax, [rdx+0x18]
	mov	qword ptr [rbp-0x8D8], rax
	mov	byte ptr [rdx], 0
	mov	dword ptr [ModuleInfo+0x220+rip], ecx
$_678:	or	byte ptr [rsi+0x15], 0xFFFFFF80
	cmp	qword ptr [rbp-0x8C8], 0
	jz	$_679
	or	byte ptr [rsi+0x16], 0x10
	test	byte ptr [rax+0x16], 0x20
	jz	$_679
	or	byte ptr [rsi+0x16], 0x20
$_679:	mov	rdx, qword ptr [rbp-0x50]
	mov	rcx, qword ptr [rdx+0x8]
	mov	dword ptr [rbp-0x2C], 0
$_680:	test	rcx, rcx
	jz	$_681
	mov	rcx, qword ptr [rcx+0x78]
	inc	dword ptr [rbp-0x2C]
	jmp	$_680

$_681:	mov	eax, dword ptr [rbp+0x28]
	mov	dword ptr [rbp-0x44], eax
	test	byte ptr [rsi+0x16], 0x20
	jz	$_683
	inc	dword ptr [rbp+0x28]
	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
$_682:	cmp	byte ptr [rbx], 0
	jz	$_683
	cmp	byte ptr [rbx], 44
	jz	$_683
	inc	dword ptr [rbp+0x28]
	add	rbx, 24
	jmp	$_682

$_683:	movzx	eax, byte ptr [rsi+0x1B]
	cmp	byte ptr [rsi+0x18], 7
	jz	$_684
	mov	rcx, rsi
	call	GetSymOfssize@PLT
$_684:	movzx	edx, byte ptr [rsi+0x1A]
	mov	ecx, eax
	call	get_fasttype@PLT
	mov	al, byte ptr [rax+0xF]
	mov	byte ptr [rbp-0x8D9], al
	test	al, 0x31
	jz	$_685
	call	$_001
	lea	rax, [rbp-0x30]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp+0x30]
	mov	r8d, dword ptr [rbp+0x28]
	mov	edx, dword ptr [rbp-0x2C]
	mov	rcx, rsi
	call	$_014
	mov	dword ptr [rbp-0x40], eax
$_685:	mov	rdx, qword ptr [rbp-0x50]
	mov	rdi, qword ptr [rdx+0x8]
	mov	eax, dword ptr [rbp+0x28]
	mov	dword ptr [rbp-0x38], eax
	test	byte ptr [rdx+0x40], 0x01
	jnz	$_687
	lea	rax, [rbp-0x48]
	mov	qword ptr [rsp+0x28], rax
	mov	eax, dword ptr [rbp-0x2C]
	mov	dword ptr [rsp+0x20], eax
	xor	r9d, r9d
	mov	r8, qword ptr [rbp-0x10]
	mov	rdx, qword ptr [rbp+0x30]
	mov	ecx, dword ptr [rbp+0x28]
	call	$_377
	cmp	eax, -1
	jz	$_686
	mov	ecx, 2136
	call	asmerr@PLT
	jmp	$_758

$_686:	jmp	$_693

$_687:	mov	eax, dword ptr [ModuleInfo+0x220+rip]
	sub	eax, dword ptr [rbp+0x28]
	shr	eax, 1
	mov	dword ptr [rbp-0x8E0], eax
	dec	dword ptr [rbp-0x2C]
	mov	dword ptr [size_vararg+rip], 0
	jmp	$_689

$_688:	mov	rdi, qword ptr [rdi+0x78]
$_689:	test	rdi, rdi
	jz	$_690
	test	byte ptr [rdi+0x3B], 0x04
	jz	$_688
$_690:	mov	eax, dword ptr [rbp-0x2C]
	cmp	dword ptr [rbp-0x8E0], eax
	jl	$_691
	lea	rax, [rbp-0x48]
	mov	qword ptr [rsp+0x28], rax
	mov	eax, dword ptr [rbp-0x8E0]
	mov	dword ptr [rsp+0x20], eax
	mov	r9, rdi
	mov	r8, qword ptr [rbp-0x10]
	mov	rdx, qword ptr [rbp+0x30]
	mov	ecx, dword ptr [rbp+0x28]
	call	$_377
	dec	dword ptr [rbp-0x8E0]
	jmp	$_690

$_691:	mov	rdx, qword ptr [rbp-0x50]
	mov	rdi, qword ptr [rdx+0x8]
$_692:	test	rdi, rdi
	jz	$_693
	test	byte ptr [rdi+0x3B], 0x04
	jz	$_693
	mov	rdi, qword ptr [rdi+0x78]
	jmp	$_692

$_693:	test	byte ptr [rbp-0x8D9], 0x04
	jne	$_705
	mov	dword ptr [rbp-0x8E4], 0
$_694:	test	rdi, rdi
	je	$_701
	cmp	dword ptr [rbp-0x2C], 0
	je	$_701
	dec	dword ptr [rbp-0x2C]
	lea	rax, [rbp-0x48]
	mov	qword ptr [rsp+0x28], rax
	mov	eax, dword ptr [rbp-0x2C]
	mov	dword ptr [rsp+0x20], eax
	mov	r9, rdi
	mov	r8, qword ptr [rbp-0x10]
	mov	rdx, qword ptr [rbp+0x30]
	mov	ecx, dword ptr [rbp+0x28]
	call	$_377
	cmp	eax, -1
	jnz	$_695
	cmp	qword ptr [rbp-0x8C8], 0
	jnz	$_695
	mov	edx, dword ptr [rbp-0x2C]
	mov	ecx, 2033
	call	asmerr@PLT
$_695:	movzx	eax, byte ptr [ModuleInfo+0x1CC+rip]
	lea	rcx, [ModuleInfo+rip]
	mov	eax, dword ptr [rcx+rax*4+0x224]
	cmp	qword ptr [CurrProc+rip], 0
	jz	$_700
	cmp	eax, 21
	jnz	$_700
	call	RunLineQueue@PLT
	mov	eax, dword ptr [rdi+0x50]
	cmp	eax, 4
	jnc	$_696
	mov	eax, 4
$_696:	cmp	eax, 4
	jbe	$_697
	mov	eax, 8
$_697:	add	dword ptr [rbp-0x8E4], eax
	mov	rcx, qword ptr [CurrProc+rip]
	mov	rdx, qword ptr [rcx+0x68]
	mov	rdx, qword ptr [rdx+0x8]
$_698:	test	rdx, rdx
	jz	$_700
	cmp	byte ptr [rdx+0x18], 10
	jz	$_699
	add	dword ptr [rdx+0x28], eax
$_699:	mov	rdx, qword ptr [rdx+0x78]
	jmp	$_698

$_700:	mov	rdi, qword ptr [rdi+0x78]
	jmp	$_694

$_701:	cmp	dword ptr [rbp-0x8E4], 0
	jz	$_704
	mov	rcx, qword ptr [CurrProc+rip]
	mov	rax, qword ptr [rcx+0x68]
	mov	rdx, qword ptr [rax+0x8]
$_702:	test	rdx, rdx
	jz	$_704
	cmp	byte ptr [rdx+0x18], 10
	jz	$_703
	mov	eax, dword ptr [rbp-0x8E4]
	sub	dword ptr [rdx+0x28], eax
$_703:	mov	rdx, qword ptr [rdx+0x78]
	jmp	$_702

$_704:	jmp	$_708

$_705:	mov	dword ptr [rbp-0x2C], 0
$_706:	test	rdi, rdi
	jz	$_708
	test	byte ptr [rdi+0x3B], 0x04
	jnz	$_708
	lea	rax, [rbp-0x48]
	mov	qword ptr [rsp+0x28], rax
	mov	eax, dword ptr [rbp-0x2C]
	mov	dword ptr [rsp+0x20], eax
	mov	r9, rdi
	mov	r8, qword ptr [rbp-0x10]
	mov	rdx, qword ptr [rbp+0x30]
	mov	ecx, dword ptr [rbp+0x28]
	call	$_377
	cmp	eax, -1
	jnz	$_707
	cmp	qword ptr [rbp-0x8C8], 0
	jnz	$_707
	mov	edx, dword ptr [rbp-0x2C]
	mov	ecx, 2033
	call	asmerr@PLT
$_707:	mov	rdi, qword ptr [rdi+0x78]
	inc	dword ptr [rbp-0x2C]
	jmp	$_706

$_708:	mov	eax, dword ptr [rbp-0x44]
	mov	dword ptr [rbp+0x28], eax
	mov	rdx, qword ptr [rbp-0x50]
	mov	rcx, qword ptr [rbp-0x10]
	cmp	qword ptr [rbp-0x8C8], 0
	jnz	$_710
	cmp	byte ptr [rcx+0x1A], 2
	jnz	$_710
	test	byte ptr [rdx+0x40], 0x01
	jz	$_710
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_710
	cmp	dword ptr [rbp-0x40], 0
	jz	$_709
	mov	edx, dword ptr [rbp-0x40]
	lea	rcx, [DS005B+rip]
	call	AddLineQueueX@PLT
	jmp	$_710

$_709:	lea	rcx, [DS005C+rip]
	call	AddLineQueue@PLT
$_710:	mov	rcx, qword ptr [rbp-0x10]
	mov	rdx, qword ptr [rbp-0xA8]
	cmp	qword ptr [rbp-0xA8], 0
	jz	$_711
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_711
	test	byte ptr [rbp-0x48], 0x01
	jz	$_711
	cmp	byte ptr [rdx+0x1], 0
	jnz	$_711
	test	byte ptr [rcx+0x15], 0xFFFFFF80
	jnz	$_711
	mov	ecx, 7002
	call	asmerr@PLT
$_711:	mov	rax, qword ptr [ModuleInfo+0x188+rip]
	mov	qword ptr [rbp-0x20], rax
	lea	rdx, [DS005D+rip]
	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcpy@PLT
	add	qword ptr [rbp-0x20], 6
	cmp	qword ptr [rbp-0x8C8], 0
	jne	$_713
	cmp	byte ptr [rsi+0x18], 2
	jne	$_713
	cmp	qword ptr [rsi+0x50], 0
	je	$_713
	mov	rax, qword ptr [rbp-0x20]
	mov	qword ptr [rbp-0x8F0], rax
	mov	rdx, qword ptr [ModuleInfo+0x68+rip]
	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcpy@PLT
	mov	rcx, qword ptr [rbp-0x20]
	call	tstrlen@PLT
	add	qword ptr [rbp-0x20], rax
	mov	rdx, qword ptr [rbp-0x20]
	mov	rcx, rsi
	call	Mangle@PLT
	add	qword ptr [rbp-0x20], rax
	inc	dword ptr [rbp-0x3C]
	test	byte ptr [rsi+0x14], 0x08
	jnz	$_713
	or	byte ptr [rsi+0x14], 0x08
	mov	rcx, qword ptr [rsi+0x50]
	inc	dword ptr [rcx+0x8]
	cmp	byte ptr [rsi+0x1A], 0
	jz	$_712
	mov	al, byte ptr [ModuleInfo+0x1B6+rip]
	cmp	byte ptr [rsi+0x1A], al
	jz	$_712
	movzx	eax, byte ptr [rsi+0x1A]
	add	eax, 276
	mov	r8, qword ptr [rbp-0x8F0]
	mov	edx, eax
	lea	rcx, [DS005E+rip]
	call	AddLineQueueX@PLT
	jmp	$_713

$_712:	mov	rdx, qword ptr [rbp-0x8F0]
	lea	rcx, [DS005F+rip]
	call	AddLineQueueX@PLT
$_713:	imul	ebx, dword ptr [rbp-0x3C], 24
	add	rbx, qword ptr [rbp+0x30]
	mov	rcx, qword ptr [rbp-0x68]
	cmp	qword ptr [rbp-0x8C8], 0
	jnz	$_714
	cmp	byte ptr [rbx], 91
	jne	$_748
	cmp	byte ptr [rbx+0x48], 46
	jne	$_748
	test	rcx, rcx
	je	$_748
	test	byte ptr [rcx+0x15], 0xFFFFFF80
	je	$_748
$_714:	cmp	qword ptr [rbp-0x8C8], 0
	je	$_731
	mov	dword ptr [rbp-0x8F4], 0
	mov	rcx, qword ptr [ModuleInfo+0x188+rip]
	inc	rcx
	mov	qword ptr [rbp-0x20], rcx
	lea	rdx, [rbp-0x8C0]
	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcpy@PLT
	lea	rdx, [DS0060+rip]
	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcat@PLT
	mov	rcx, qword ptr [rbp-0x20]
	call	tstrlen@PLT
	add	qword ptr [rbp-0x20], rax
	test	byte ptr [rbp-0x8D9], 0x31
	je	$_720
	mov	rdx, qword ptr [rbp-0x50]
	mov	rdi, qword ptr [rdx+0x8]
$_715:	test	rdi, rdi
	je	$_720
	mov	rax, qword ptr [rdi+0x8]
	cmp	byte ptr [rdi+0x19], -62
	jnz	$_716
	lea	rdx, [DS0060+0x2+rip]
	mov	qword ptr [rdi+0x8], rdx
	jmp	$_719

$_716:	cmp	byte ptr [rdi+0x18], 10
	jnz	$_717
	mov	rax, qword ptr [rdi+0x28]
	jmp	$_719

$_717:	test	byte ptr [rdi+0x17], 0x01
	jz	$_718
	movzx	ecx, byte ptr [rdi+0x48]
	lea	rdx, [rbp-0xB08]
	call	GetResWName@PLT
	mov	rcx, rax
	call	LclDup@PLT
	jmp	$_719

$_718:	movzx	eax, byte ptr [rdi+0x38]
	lea	rdx, [stackreg+rip]
	mov	edx, dword ptr [rdx+rax*4]
	movzx	ecx, byte ptr [rdi+0x4B]
	mov	r9d, ecx
	mov	r8d, edx
	lea	rdx, [DS0061+rip]
	lea	rcx, [rbp-0xB08]
	call	tsprintf@PLT
	lea	rcx, [rbp-0xB08]
	call	LclDup@PLT
$_719:	movzx	ecx, byte ptr [rdi+0x49]
	mov	qword ptr [rbp+rcx*8-0xAF8], rax
	mov	rdi, qword ptr [rdi+0x78]
	inc	dword ptr [rbp-0x8F4]
	jmp	$_715

$_720:	imul	ebx, dword ptr [rbp+0x28], 24
	add	rbx, qword ptr [rbp+0x30]
	mov	rdx, qword ptr [rbp-0x50]
	mov	rdi, qword ptr [rbp-0x10]
	cmp	dword ptr [rbp-0x8F4], 0
	jnz	$_723
	cmp	byte ptr [rbx], 0
	jz	$_722
	mov	rdx, qword ptr [rbx+0x28]
	test	byte ptr [rdi+0x16], 0x20
	jz	$_721
	mov	rdx, qword ptr [rbx+0x40]
$_721:	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcat@PLT
$_722:	jmp	$_730

$_723:	test	byte ptr [rdx+0x40], 0x01
	jz	$_725
	mov	rdx, qword ptr [rbx+0x28]
	cmp	dword ptr [rbx+0x1C], 273
	jnz	$_724
	test	byte ptr [rdi+0x15], 0xFFFFFF80
	jz	$_724
	mov	rdx, qword ptr [rbx+0x40]
$_724:	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcat@PLT
	jmp	$_730

$_725:	mov	esi, 1
	mov	rdx, qword ptr [rbp-0xAF8]
	test	byte ptr [rdi+0x16], 0x20
	jz	$_726
	mov	rdx, qword ptr [rbx+0x38]
	xor	esi, esi
$_726:	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcat@PLT
$_727:	cmp	esi, dword ptr [rbp-0x8F4]
	jge	$_729
	lea	rdx, [DS0062+rip]
	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcat@PLT
	cmp	qword ptr [rbp+rsi*8-0xAF8], 0
	jz	$_728
	mov	rdx, qword ptr [rbp+rsi*8-0xAF8]
	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcat@PLT
$_728:	inc	esi
	jmp	$_727

$_729:	mov	rsi, qword ptr [rbp-0x8]
$_730:	lea	rdx, [DS0058+0xA+rip]
	mov	rcx, qword ptr [rbp-0x20]
	call	tstrcat@PLT
$_731:	cmp	qword ptr [rbp-0x8D8], 0
	je	$_738
	mov	edi, 17
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_732
	mov	edi, 115
	cmp	byte ptr [rsi+0x1A], 2
	jnz	$_732
	mov	edi, 125
$_732:	mov	rbx, qword ptr [rbp-0x8D8]
	mov	rcx, qword ptr [rbx+0x8]
	call	SymFind@PLT
	mov	rcx, rax
	mov	rax, qword ptr [rbp-0x8C8]
	mov	qword ptr [rsp+0x28], rax
	movzx	eax, byte ptr [rsi+0x1A]
	mov	dword ptr [rsp+0x20], eax
	mov	r9, qword ptr [rbp-0x8D0]
	mov	r8, qword ptr [rbp-0x8D8]
	mov	edx, edi
	call	AssignPointer@PLT
	cmp	edi, 17
	jnz	$_737
	cmp	byte ptr [rsi+0x1A], 1
	jz	$_733
	cmp	byte ptr [rsi+0x1A], 3
	jnz	$_737
$_733:	test	rax, rax
	jz	$_736
	cmp	byte ptr [rax+0x19], -60
	jnz	$_734
	mov	rax, qword ptr [rax+0x20]
$_734:	cmp	byte ptr [rax+0x19], -61
	jnz	$_735
	mov	rax, qword ptr [rax+0x40]
$_735:	test	rax, rax
	jz	$_736
	test	byte ptr [rax+0x16], 0x02
	jnz	$_736
	xor	eax, eax
$_736:	test	rax, rax
	jz	$_737
	lea	rcx, [DS0063+rip]
	call	AddLineQueue@PLT
$_737:	jmp	$_748

$_738:	cmp	qword ptr [rbp-0x8C8], 0
	jne	$_748
	imul	ebx, dword ptr [rbp-0x38], 24
	add	rbx, qword ptr [rbp+0x30]
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 2
	jnz	$_741
	cmp	byte ptr [rsi+0x1A], 2
	jnz	$_739
	lea	rcx, [DS0064+rip]
	call	AddLineQueue@PLT
	jmp	$_740

$_739:	lea	rcx, [DS0065+rip]
	call	AddLineQueue@PLT
$_740:	jmp	$_748

$_741:	cmp	byte ptr [ModuleInfo+0x1CC+rip], 1
	jne	$_748
	mov	dword ptr [rbp-0xB0C], 17
	cmp	byte ptr [rsi+0x1A], 9
	jz	$_742
	cmp	byte ptr [rsi+0x1A], 10
	jnz	$_743
$_742:	jmp	$_747

$_743:	cmp	byte ptr [rsi+0x1A], 7
	jnz	$_744
	mov	dword ptr [rbp-0xB0C], 18
	jmp	$_747

$_744:	cmp	dword ptr [rbx+0x1C], 17
	jz	$_747
	cmp	byte ptr [rbx+0x18], 2
	jnz	$_745
	cmp	dword ptr [rbx+0x1C], 17
	jbe	$_745
	cmp	dword ptr [rbx+0x1C], 24
	ja	$_745
	mov	eax, dword ptr [rbx+0x1C]
	mov	dword ptr [rbp-0xB0C], eax
	jmp	$_747

$_745:	cmp	byte ptr [rbx+0x18], 7
	jnz	$_746
	cmp	dword ptr [rbx+0x1C], 273
	jnz	$_746
	mov	rdx, qword ptr [rbx+0x38]
	lea	rcx, [DS0066+rip]
	call	AddLineQueueX@PLT
	jmp	$_747

$_746:	mov	rdx, qword ptr [rbx+0x20]
	lea	rcx, [DS0067+rip]
	call	AddLineQueueX@PLT
$_747:	mov	edx, dword ptr [rbp-0xB0C]
	lea	rcx, [DS0068+rip]
	call	AddLineQueueX@PLT
$_748:	mov	rbx, qword ptr [rbp+0x30]
	imul	edx, dword ptr [rbp-0x38], 24
	imul	ecx, dword ptr [rbp-0x3C], 24
	cmp	qword ptr [rbp-0x8C8], 0
	jnz	$_749
	mov	rax, qword ptr [rbx+rdx+0x10]
	sub	rax, qword ptr [rbx+rcx+0x10]
	mov	dword ptr [rbp-0x34], eax
	mov	r8d, dword ptr [rbp-0x34]
	mov	rdx, qword ptr [rbx+rcx+0x10]
	mov	rcx, qword ptr [rbp-0x20]
	call	tmemcpy@PLT
	mov	edx, dword ptr [rbp-0x34]
	mov	byte ptr [rax+rdx], 0
$_749:	mov	rcx, qword ptr [ModuleInfo+0x188+rip]
	call	AddLineQueue@PLT
	mov	rdi, qword ptr [rbp-0x50]
	mov	rsi, qword ptr [rbp-0x8]
	cmp	byte ptr [rsi+0x1A], 1
	jz	$_750
	cmp	byte ptr [rsi+0x1A], 2
	jne	$_755
	test	byte ptr [rbp-0x8D9], 0x31
	jnz	$_755
$_750:	cmp	dword ptr [rdi+0x20], 0
	jnz	$_751
	test	byte ptr [rdi+0x40], 0x01
	jz	$_755
	cmp	dword ptr [size_vararg+rip], 0
	jz	$_755
$_751:	movzx	eax, byte ptr [ModuleInfo+0x1CC+rip]
	cmp	byte ptr [ModuleInfo+0x1CC+rip], 0
	jnz	$_752
	cmp	qword ptr [ModuleInfo+0x148+rip], 0
	jz	$_752
	mov	ecx, 2
	call	GetOfssizeAssume@PLT
$_752:	lea	rdx, [stackreg+rip]
	mov	eax, dword ptr [rdx+rax*4]
	test	byte ptr [rdi+0x40], 0x01
	jz	$_753
	mov	ecx, dword ptr [rdi+0x20]
	add	ecx, dword ptr [size_vararg+rip]
	mov	r8d, ecx
	mov	edx, eax
	lea	rcx, [DS0069+rip]
	call	AddLineQueueX@PLT
	jmp	$_754

$_753:	mov	r8d, dword ptr [rdi+0x20]
	mov	edx, eax
	lea	rcx, [DS0069+rip]
	call	AddLineQueueX@PLT
$_754:	jmp	$_756

$_755:	test	byte ptr [rbp-0x8D9], 0x31
	jz	$_756
	mov	r8d, dword ptr [rbp-0x30]
	mov	edx, dword ptr [rbp-0x2C]
	mov	rcx, qword ptr [rbp-0x10]
	call	$_055
$_756:	call	GetCurrOffset@PLT
	xor	r8d, r8d
	mov	edx, eax
	mov	ecx, 4
	call	LstWrite@PLT
	call	RunLineQueue@PLT
	mov	rcx, qword ptr [rbp-0x8C8]
	test	rcx, rcx
	jz	$_757
	cmp	qword ptr [rcx+0x58], 0
	jz	$_757
	mov	rdx, qword ptr [rcx+0x58]
	mov	qword ptr [rdx], rsi
$_757:	xor	eax, eax
$_758:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret


.SECTION .data
	.ALIGN	16

size_vararg:
	.int   0x00000000

simd_scratch:
	.int   0x00000000

wreg_scratch:
	.int   0x00000000

DS0000:
	.asciz " sub rsp, %d"

DS0001:
	.asciz " sub rsp, 8"

DS0002:
	.asciz " add %r, %d"

DS0003:
	.asciz " lea %r, %s"

DS0004:
	.ascii " sub %r, %u\n"
	.asciz " %r [%r], %r"

DS0005:
	.asciz " %r %r, %r"

DS0006:
	.ascii " push %u\n"
	.asciz " push %u"

DS0007:
	.ascii " push dword ptr %s[4]\n"
	.asciz " push dword ptr %s[0]"

DS0008:
	.ascii " push %u\n"
	.ascii " push %u\n"
	.ascii " push %u\n"
	.asciz " push %u"

DS0009:
	.asciz " sub %r, 16"

DS000A:
	.asciz " mov qword ptr [%r+%u], 0"

DS000B:
	.ascii " mov dword ptr [%r+%u][0], %u\n"
	.asciz " mov dword ptr [%r+%u][4], %u"

DS000C:
	.ascii " mov dword ptr [%r+%u][8], %u\n"
	.asciz " mov dword ptr [%r+%u][12], %u"

DS000D:
	.asciz " %r %r, xmmword ptr %s"

DS000E:
	.asciz " sub %r, %u"

DS000F:
	.asciz " %r [%r+%u], %r"

DS0010:
	.asciz " %r %r, %r ptr %s"

DS0011:
	.ascii " mov [%r+%u], %r\n"
	.asciz " mov %r ptr [%r+%u+%u], 0"

DS0012:
	.ascii " push 0\n"
	.asciz " push %r"

DS0013:
	.asciz " mov %r, %r"

DS0014:
	.asciz " xor %r, %r"

DS0015:
	.asciz " mov [%r+%u], %r"

DS0016:
	.asciz " mov %r, %lu"

DS0017:
	.asciz " mov %r, -1"

DS0018:
	.asciz " mov %r, %u"

DS0019:
	.asciz " mov %r, %r ptr %s[%u]"

DS001A:
	.asciz " mov [%r+%u], %r ptr %s"

DS001B:
	.asciz " movq %r, %r"

DS001C:
	.asciz " %r %r, %r, %r"

DS001D:
	.asciz " mov dword ptr [%r+%u], %u"

DS001E:
	.asciz " mov ax, %s"

DS001F:
	.asciz " movd %r, eax"

DS0020:
	.asciz " push %d"

DS0021:
	.asciz " push %s"

DS0022:
	.asciz " %r %r, %s"

DS0023:
	.asciz " mov %r, %s"

DS0024:
	.ascii " push dword ptr %s[4]\n"
	.asciz " push dword ptr %s"

DS0025:
	.asciz " movsd %r, %s"

DS0026:
	.ascii " mov dword ptr [%r+%u], low32(%s)\n"
	.asciz " mov dword ptr [%r+%u+4], high32(%s)"

DS0027:
	.ascii " mov %r, %s\n"
	.asciz " push %r"

DS0028:
	.asciz " mov %r ptr [%r+%u], %s"

DS0029:
	.asciz " mov %r, 0"

DS002A:
	.asciz " %r %r, %r ptr %s[%u]"

DS002B:
	.ascii " shl %r, 16\n"
	.asciz " mov %r, word ptr %s[%u]"

DS002C:
	.ascii " shl %r, 8\n"
	.asciz " mov %r, byte ptr %s"

DS002D:
	.asciz "seg "

DS002E:
	.asciz " push ss"

DS002F:
	.asciz " push ds"

DS0030:
	.asciz " db 66h"

DS0031:
	.ascii " mov ax, offset %s\n"
	.asciz " push ax"

DS0032:
	.asciz " pushd offset %s"

DS0033:
	.asciz " pushw offset %s"

DS0034:
	.asciz " lea rax, %s"

DS0035:
	.asciz " push rax"

DS0036:
	.asciz " push offset %s"

DS0037:
	.asciz " sub %r, 2"

DS0038:
	.asciz " push word ptr %s+%u"

DS0039:
	.asciz " push %r ptr %s+%u"

DS003A:
	.ascii " movsx eax, %s\n"
	.asciz " push %r"

DS003B:
	.ascii " mov al, %s\n"
	.asciz " push %r"

DS003C:
	.asciz " xor ax, ax"

DS003D:
	.asciz " push 0"

DS003E:
	.asciz " mov al, %s"

DS003F:
	.asciz " mov ah, 0"

DS0040:
	.asciz " cbw"

DS0041:
	.ascii " cwd\n"
	.asciz " push dx"

DS0042:
	.ascii " %r eax, %s\n"
	.asciz " push %r"

DS0043:
	.ascii " mov ax, %s\n"
	.asciz " push rax"

DS0044:
	.asciz " pushw 0"

DS0045:
	.ascii " mov eax, %s\n"
	.asciz " push rax"

DS0046:
	.ascii " mov al, byte ptr %s[2]\n"
	.ascii " shl eax, 16\n"
	.ascii " mov ax, word ptr %s\n"
	.asciz " push %r"

DS0047:
	.ascii " push word ptr %s[2]\n"
	.asciz " push word ptr %s"

DS0048:
	.ascii " mov eax,%s\n"
	.ascii " cdq\n"
	.ascii " push edx\n"
	.asciz " push eax"

DS0049:
	.ascii " push 0\n"
	.asciz " push %s"

DS004A:
	.ascii " mov ax, %s\n"
	.ascii " cwd\n"
	.ascii " push dx\n"
	.asciz " push ax"

DS004B:
	.asciz " mov eax,%r"

DS004C:
	.ascii " cdq\n"
	.asciz " push edx"

DS004D:
	.asciz " movsx eax, %s"

DS004E:
	.asciz " mov ax, highword (%s)"

DS004F:
	.asciz " mov ax, lowword (%s)"

DS0050:
	.asciz " %r (%s) shr 32t"

DS0051:
	.asciz " pushw highword (%s)"

DS0052:
	.asciz " push 0x%x"

DS0053:
	.ascii " mov rax, 0x%lx\n"
	.asciz " push rax"

DS0054:
	.ascii " pushd high32 (0x%lx)\n"
	.asciz " pushd low32 (0x%lx)"

DS0055:
	.ascii " pushd high32 (0x%lx)\n"
	.ascii " pushd low32 (0x%lx)\n"
	.ascii " pushd high32 (0x%lx)\n"
	.asciz " pushd low32 (0x%lx)"

DS0056:
	.asciz " push 0x%lx"

DS0057:
	.asciz " pushd high32 (%s)"

DS0058:
	.asciz " %r %r (%s)"

DS0059:
	.asciz " %r %s"

DS005A:
	.asciz "_"

DS005B:
	.asciz " mov eax, %d"

DS005C:
	.asciz " xor eax, eax"

DS005D:
	.asciz " call "

DS005E:
	.asciz " externdef %r %s: ptr proc"

DS005F:
	.asciz " externdef %s: ptr proc"

DS0060:
	.asciz "( "

DS0061:
	.asciz "[%r+%u]"

DS0062:
	.asciz ", "

DS0063:
	.ascii " mov [esp], eax\n"
	.asciz " mov eax, [eax]"

DS0064:
	.asciz " mov r10, [rdi]"

DS0065:
	.asciz " mov rax, [rcx]"

DS0066:
	.asciz " lea eax, %s"

DS0067:
	.asciz " mov eax, %s"

DS0068:
	.asciz " mov eax, [%r]"

DS0069:
	.asciz " add %r, %u"


.att_syntax prefix
