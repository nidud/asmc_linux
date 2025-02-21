

.intel_syntax noprefix

.global pe_create_PE_header
.global bin_init

.extern SortSegments
.extern _atoow
.extern CreateVariable
.extern CreateIntSegment
.extern Mangle
.extern RunLineQueue
.extern AddLineQueueX
.extern LstNL
.extern LstPrintf
.extern SymTables
.extern LclAlloc
.extern tqsort
.extern tstrcmp
.extern tstrncpy
.extern tstrcpy
.extern tstrchr
.extern tstrlen
.extern tmemset
.extern tmemicmp
.extern tmemcmp
.extern tmemcpy
.extern ConvertSectionName
.extern asmerr
.extern Options
.extern ModuleInfo
.extern Parse_Pass
.extern WriteError
.extern SymFind
.extern ftell
.extern fseek
.extern fwrite
.extern time


.SECTION .text
	.ALIGN	16

$_001:	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	rsi, rcx
	mov	rbx, rdx
	mov	rdi, qword ptr [rsi+0x68]
	cmp	dword ptr [rdi+0x48], 5
	jnz	$_002
	mov	eax, dword ptr [rdi+0x58]
	shl	eax, 4
	mov	dword ptr [rdi+0xC], eax
	jmp	$_018

	jmp	$_003

$_002:	cmp	byte ptr [rdi+0x6C], 0
	jz	$_003
	jmp	$_018

$_003:	mov	edx, 1
	mov	al, byte ptr [rdi+0x6A]
	cmp	byte ptr [rbx+0x1], al
	jbe	$_004
	mov	cl, byte ptr [rbx+0x1]
	jmp	$_005

$_004:	mov	cl, byte ptr [rdi+0x6A]
$_005:	shl	edx, cl
	mov	dword ptr [rbp-0x4], edx
	mov	ecx, edx
	neg	ecx
	dec	edx
	add	edx, dword ptr [rbx+0x4]
	and	edx, ecx
	sub	edx, dword ptr [rbx+0x4]
	add	dword ptr [rbx+0x4], edx
	mov	dword ptr [rbp-0x8], edx
	mov	rax, qword ptr [rdi]
	mov	qword ptr [rbp-0x10], rax
	test	rax, rax
	jnz	$_006
	mov	eax, dword ptr [rbx+0x4]
	sub	eax, dword ptr [rbx+0x8]
	mov	dword ptr [rbp-0x14], eax
	jmp	$_010

$_006:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jz	$_007
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jnz	$_008
$_007:	mov	eax, dword ptr [rbx+0x1C]
	mov	dword ptr [rbp-0x14], eax
	jmp	$_010

$_008:	cmp	dword ptr [rax+0x50], 0
	jnz	$_009
	mov	ecx, dword ptr [rbx+0x4]
	sub	ecx, dword ptr [rbx+0x8]
	mov	dword ptr [rax+0x28], ecx
	mov	dword ptr [rbp-0x14], 0
	jmp	$_010

$_009:	mov	ecx, dword ptr [rax+0x50]
	add	ecx, dword ptr [rbp-0x8]
	mov	dword ptr [rbp-0x14], ecx
$_010:	cmp	byte ptr [rbx], 0
	jnz	$_012
	mov	rax, qword ptr [rbp-0x10]
	test	rax, rax
	jz	$_012
	cmp	rax, qword ptr [ModuleInfo+0x200+rip]
	jz	$_011
	mov	dword ptr [rdi+0x8], 0
	jmp	$_012

$_011:	mov	edx, 36
	mov	rcx, qword ptr [rsi+0x8]
	call	tstrchr@PLT
	test	rax, rax
	jz	$_012
	mov	dword ptr [rdi+0x8], 0
$_012:	mov	eax, dword ptr [rbx+0x4]
	mov	dword ptr [rdi+0x38], eax
	mov	eax, dword ptr [rbp-0x14]
	mov	dword ptr [rdi+0xC], eax
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 0
	jnz	$_015
	mov	eax, dword ptr [rsi+0x50]
	sub	eax, dword ptr [rdi+0x8]
	add	dword ptr [rbx+0x4], eax
	cmp	byte ptr [rbx], 0
	jz	$_013
	mov	eax, dword ptr [rdi+0x8]
	mov	dword ptr [rbx+0x18], eax
$_013:	cmp	dword ptr [rbx+0xC], -1
	jnz	$_014
	mov	eax, dword ptr [rbp-0x14]
	mov	dword ptr [rbx+0xC], eax
	mov	qword ptr [rbx+0x10], rsi
$_014:	jmp	$_016

$_015:	mov	eax, dword ptr [rsi+0x50]
	sub	eax, dword ptr [rdi+0x8]
	add	dword ptr [rbx+0x1C], eax
	cmp	dword ptr [rdi+0x48], 3
	jz	$_016
	add	dword ptr [rbx+0x4], eax
$_016:	mov	eax, dword ptr [rsi+0x50]
	add	dword ptr [rbp-0x14], eax
	mov	rcx, qword ptr [rbp-0x10]
	test	rcx, rcx
	jz	$_017
	mov	eax, dword ptr [rbp-0x14]
	mov	dword ptr [rcx+0x50], eax
	cmp	dword ptr [rcx+0x50], 65536
	jbe	$_017
	cmp	byte ptr [rcx+0x38], 0
	jnz	$_017
	mov	rdx, qword ptr [rcx+0x8]
	mov	ecx, 8003
	call	asmerr@PLT
$_017:	mov	byte ptr [rbx], 0
$_018:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_019:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	dword ptr [rbp-0x4], 0
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_020:	test	rsi, rsi
	je	$_034
	mov	rdi, qword ptr [rsi+0x68]
	cmp	dword ptr [rdi+0x48], 5
	jnz	$_021
	jmp	$_033

$_021:	mov	rbx, qword ptr [rdi+0x28]
$_022:	test	rbx, rbx
	je	$_033
	jmp	$_031

$_023:	mov	rcx, qword ptr [rbx+0x30]
	test	rcx, rcx
	jz	$_024
	mov	rcx, qword ptr [rcx+0x30]
	test	rcx, rcx
	jz	$_024
	cmp	qword ptr [rcx+0x68], 0
	jz	$_024
	mov	rax, qword ptr [rcx+0x68]
	cmp	dword ptr [rax+0x48], 5
	je	$_032
$_024:	inc	dword ptr [rbp-0x4]
	cmp	qword ptr [rbp+0x28], 0
	jz	$_030
	mov	eax, dword ptr [rbx+0x14]
	mov	ecx, dword ptr [rdi+0xC]
	and	ecx, 0x0F
	add	ecx, eax
	mov	eax, dword ptr [rdi+0xC]
	shr	eax, 4
	cmp	qword ptr [rdi], 0
	jz	$_025
	mov	rdx, qword ptr [rdi]
	mov	edx, dword ptr [rdx+0x28]
	and	edx, 0x0F
	add	ecx, edx
	mov	rdx, qword ptr [rdi]
	mov	edx, dword ptr [rdx+0x28]
	shr	edx, 4
	add	eax, edx
$_025:	cmp	byte ptr [rbx+0x18], 9
	jnz	$_026
	add	ecx, 2
	jmp	$_027

$_026:	cmp	byte ptr [rbx+0x18], 10
	jnz	$_027
	add	ecx, 4
$_027:	jmp	$_029

$_028:	sub	ecx, 16
	inc	eax
$_029:	cmp	ecx, 65536
	jnc	$_028
	mov	rdx, qword ptr [rbp+0x28]
	mov	word ptr [rdx], cx
	mov	word ptr [rdx+0x2], ax
	add	qword ptr [rbp+0x28], 4
$_030:	jmp	$_032

$_031:	cmp	byte ptr [rbx+0x18], 10
	je	$_023
	cmp	byte ptr [rbx+0x18], 9
	je	$_023
	cmp	byte ptr [rbx+0x18], 8
	je	$_023
$_032:	mov	rbx, qword ptr [rbx+0x8]
	jmp	$_022

$_033:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_020

$_034:
	mov	eax, dword ptr [rbp-0x4]
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_035:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	dword ptr [rbp-0x4], 1
	mov	rsi, qword ptr [SymTables+0x20+rip]
	xor	eax, eax
	xor	ebx, ebx
$_036:	test	rsi, rsi
	jz	$_046
	mov	rdi, qword ptr [rsi+0x68]
	cmp	dword ptr [rdi+0x48], 5
	jz	$_037
	cmp	byte ptr [rdi+0x6C], 0
	jz	$_038
$_037:	jmp	$_045

$_038:	cmp	dword ptr [rbp+0x28], 0
	jnz	$_041
	cmp	dword ptr [rdi+0x18], 0
	jnz	$_041
	mov	rcx, qword ptr [rsi+0x70]
$_039:	test	rcx, rcx
	jz	$_040
	mov	rdx, qword ptr [rcx+0x68]
	cmp	dword ptr [rdx+0x18], 0
	jnz	$_040
	mov	rcx, qword ptr [rcx+0x70]
	jmp	$_039

$_040:	test	rcx, rcx
	jz	$_046
$_041:	mov	ecx, dword ptr [rsi+0x50]
	sub	ecx, dword ptr [rdi+0x8]
	add	ecx, dword ptr [rdi+0x38]
	cmp	dword ptr [rbp-0x4], 0
	jnz	$_042
	add	ebx, dword ptr [rdi+0x8]
$_042:	cmp	dword ptr [rbp+0x28], 0
	jz	$_043
	add	ecx, ebx
$_043:	cmp	eax, ecx
	jnc	$_044
	mov	eax, ecx
$_044:	mov	dword ptr [rbp-0x4], 0
$_045:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_036

$_046:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_047:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 88
	mov	rsi, rcx
	mov	rdi, qword ptr [rsi+0x68]
	cmp	dword ptr [rdi+0x48], 5
	jnz	$_048
	xor	eax, eax
	jmp	$_096

$_048:	mov	rbx, qword ptr [rdi+0x28]
$_049:	test	rbx, rbx
	je	$_095
	mov	eax, dword ptr [rbx+0x14]
	sub	eax, dword ptr [rdi+0x8]
	add	rax, qword ptr [rdi+0x10]
	mov	rcx, qword ptr [rbx+0x30]
	mov	qword ptr [rbp-0x18], rax
	test	rcx, rcx
	je	$_067
	cmp	qword ptr [rcx+0x30], 0
	jnz	$_050
	test	byte ptr [rcx+0x14], 0x40
	je	$_067
$_050:	test	byte ptr [rcx+0x14], 0x40
	jz	$_051
	mov	rsi, qword ptr [rbx+0x20]
	mov	dword ptr [rbp-0x1C], 0
	jmp	$_052

$_051:	mov	rsi, qword ptr [rcx+0x30]
	mov	eax, dword ptr [rcx+0x28]
	mov	dword ptr [rbp-0x1C], eax
$_052:	mov	qword ptr [rbp-0x28], rsi
	mov	rsi, qword ptr [rsi+0x68]
	mov	al, byte ptr [rbx+0x18]
	jmp	$_065

$_053:	mov	eax, dword ptr [rbx+0x10]
	add	eax, dword ptr [rbp-0x1C]
	add	eax, dword ptr [rsi+0xC]
	mov	rdx, qword ptr [rbp+0x30]
	sub	eax, dword ptr [rdx+0x18]
	mov	dword ptr [rbp-0x4], eax
	jmp	$_066

$_054:	mov	eax, dword ptr [rbx+0x10]
	add	eax, dword ptr [rbp-0x1C]
	sub	eax, dword ptr [rsi+0x8]
	mov	dword ptr [rbp-0x4], eax
	mov	rcx, qword ptr [rbp-0x28]
	mov	edx, 36
	mov	rcx, qword ptr [rcx+0x8]
	call	tstrchr@PLT
	test	rax, rax
	jz	$_057
	mov	rcx, qword ptr [rbp-0x28]
	sub	rax, qword ptr [rcx+0x8]
	mov	rdx, qword ptr [SymTables+0x20+rip]
$_055:	test	rdx, rdx
	jz	$_057
	cmp	dword ptr [rdx+0x10], eax
	jnz	$_056
	push	rsi
	push	rdi
	mov	rcx, qword ptr [rbp-0x28]
	mov	rdi, qword ptr [rdx+0x8]
	mov	rsi, qword ptr [rcx+0x8]
	mov	ecx, eax
	repe cmpsb
	pop	rdi
	pop	rsi
	jnz	$_056
	mov	eax, dword ptr [rbx+0x10]
	add	eax, dword ptr [rbp-0x1C]
	add	eax, dword ptr [rsi+0xC]
	mov	rcx, qword ptr [rdx+0x68]
	sub	eax, dword ptr [rcx+0xC]
	mov	dword ptr [rbp-0x4], eax
	jmp	$_057

$_056:	mov	rdx, qword ptr [rdx+0x70]
	jmp	$_055

$_057:	jmp	$_066

$_058:	mov	eax, dword ptr [rsi+0xC]
	add	eax, dword ptr [rbp-0x1C]
	mov	dword ptr [rbp-0x4], eax
	jmp	$_066

$_059:	cmp	qword ptr [rsi], 0
	jz	$_063
	cmp	byte ptr [rbx+0x20], 0
	jz	$_063
	mov	rcx, qword ptr [rsi]
	mov	eax, dword ptr [rcx+0x28]
	and	eax, 0x0F
	add	eax, dword ptr [rsi+0xC]
	add	eax, dword ptr [rbx+0x10]
	add	eax, dword ptr [rbp-0x1C]
	mov	dword ptr [rbp-0x4], eax
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jz	$_060
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jnz	$_062
$_060:	mov	rcx, qword ptr [rbp+0x30]
	cmp	byte ptr [rdi+0x68], 2
	jnz	$_061
	mov	eax, dword ptr [rbp-0x4]
	add	rax, qword ptr [rcx+0x20]
	mov	qword ptr [rbp-0x10], rax
$_061:	mov	eax, dword ptr [rcx+0x20]
	add	dword ptr [rbp-0x4], eax
$_062:	jmp	$_064

$_063:	mov	eax, dword ptr [rsi+0xC]
	and	eax, 0x0F
	add	eax, dword ptr [rbx+0x10]
	add	eax, dword ptr [rbp-0x1C]
	mov	dword ptr [rbp-0x4], eax
$_064:	jmp	$_066

$_065:	cmp	al, 12
	je	$_053
	cmp	al, 13
	je	$_054
	cmp	al, 1
	je	$_058
	cmp	al, 2
	je	$_058
	cmp	al, 3
	je	$_058
	jmp	$_059

$_066:	jmp	$_068

$_067:	mov	qword ptr [rbp-0x28], 0
	mov	dword ptr [rbp-0x4], 0
$_068:	mov	rcx, qword ptr [rbp-0x18]
	mov	eax, dword ptr [rbp-0x4]
	movzx	edx, byte ptr [rbx+0x18]
	jmp	$_089

$C005F: sub	eax, dword ptr [rbx+0x14]
	sub	eax, dword ptr [rdi+0xC]
	dec	eax
	add	byte ptr [rcx], al
	jmp	$_093

$C0061: sub	eax, dword ptr [rbx+0x14]
	sub	eax, dword ptr [rdi+0xC]
	sub	eax, 2
	add	word ptr [rcx], ax
	jmp	$_093

$C0062: cmp	byte ptr [rdi+0x68], 2
	jnz	$_069
	movzx	edx, byte ptr [rbx+0x1A]
	sub	edx, 4
	add	dword ptr [rbx+0x14], edx
$_069:	sub	eax, dword ptr [rbx+0x14]
	sub	eax, dword ptr [rdi+0xC]
	sub	eax, 4
	add	dword ptr [rcx], eax
	jmp	$_093

$C0064: mov	byte ptr [rcx], al
	jmp	$_093

$C0065: mov	word ptr [rcx], ax
	jmp	$_093
$C0066:
$C0067:
$C0068: mov	dword ptr [rcx], eax
	jmp	$_093

$C0069: cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jnz	$_070
	cmp	byte ptr [rdi+0x68], 2
	jz	$_071
$_070:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jnz	$_072
$_071:	mov	rax, qword ptr [rbp-0x10]
$_072:	mov	qword ptr [rcx], rax
	jmp	$_093

$C006D: mov	al, ah
	mov	byte ptr [rcx], al
	jmp	$_093

$C006E: mov	rax, qword ptr [rbx+0x30]
	test	rax, rax
	jz	$_073
	cmp	byte ptr [rax+0x18], 3
	jnz	$_073
	mov	rdx, qword ptr [rax+0x68]
	cmp	dword ptr [rdx+0x48], 5
	jnz	$_073
	mov	edx, dword ptr [rdx+0x58]
	mov	word ptr [rcx], dx
	jmp	$_093

$_073:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 1
	jnz	$_079
	cmp	byte ptr [rax+0x18], 4
	jnz	$_074
	mov	qword ptr [rbp-0x28], rax
	mov	rsi, qword ptr [rax+0x68]
	mov	edx, dword ptr [rax+0x28]
	shr	edx, 4
	mov	word ptr [rcx], dx
	jmp	$_078

$_074:	cmp	byte ptr [rax+0x18], 3
	jnz	$_076
	mov	qword ptr [rbp-0x28], rax
	mov	rsi, qword ptr [rax+0x68]
	mov	edx, dword ptr [rsi+0xC]
	cmp	qword ptr [rsi], 0
	jz	$_075
	mov	rax, qword ptr [rsi]
	add	edx, dword ptr [rax+0x28]
$_075:	shr	edx, 4
	mov	word ptr [rcx], dx
	jmp	$_078

$_076:	cmp	byte ptr [rbx+0x20], 1
	jnz	$_077
	mov	rax, qword ptr [rsi]
	mov	eax, dword ptr [rax+0x28]
	shr	eax, 4
	mov	word ptr [rcx], ax
	jmp	$_078

$_077:	mov	eax, dword ptr [rsi+0xC]
	shr	eax, 4
	mov	word ptr [rcx], ax
$_078:	jmp	$_093

$_079:	mov	eax, dword ptr [rbp-0x4]
$C0077: cmp	qword ptr [rbp-0x28], 0
	jz	$_080
	cmp	dword ptr [rsi+0x48], 5
	jnz	$_080
	mov	word ptr [rcx], ax
	mov	eax, dword ptr [rsi+0x58]
	mov	word ptr [rcx+0x2], ax
	jmp	$_093

$_080:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 1
	jnz	$_084
	mov	word ptr [rcx], ax
	add	rcx, 2
	cmp	byte ptr [rbx+0x20], 1
	jnz	$_081
	mov	rax, qword ptr [rsi]
	mov	eax, dword ptr [rax+0x28]
	shr	eax, 4
	mov	word ptr [rcx], ax
	jmp	$_083

$_081:	mov	eax, dword ptr [rsi+0xC]
	cmp	qword ptr [rsi], 0
	jz	$_082
	mov	rdx, qword ptr [rsi]
	add	eax, dword ptr [rdx+0x28]
$_082:	shr	eax, 4
	mov	word ptr [rcx], ax
$_083:	jmp	$_093

$_084:	mov	eax, dword ptr [rbp-0x4]
$C007D: cmp	qword ptr [rbp-0x28], 0
	jz	$_085
	cmp	dword ptr [rsi+0x48], 5
	jnz	$_085
	mov	dword ptr [rcx], eax
	mov	eax, dword ptr [rsi+0x58]
	mov	word ptr [rcx+0x4], ax
	jmp	$_093

$_085:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 1
	jnz	$C0083
	mov	dword ptr [rcx], eax
	cmp	byte ptr [rbx+0x20], 1
	jnz	$_086
	mov	rax, qword ptr [rsi]
	mov	eax, dword ptr [rax+0x28]
	shr	eax, 4
	mov	word ptr [rcx+0x4], ax
	jmp	$_088

$_086:	mov	eax, dword ptr [rsi+0xC]
	cmp	qword ptr [rsi], 0
	jz	$_087
	mov	rdx, qword ptr [rsi]
	add	eax, dword ptr [rdx+0x28]
$_087:	shr	eax, 4
	mov	word ptr [rcx+0x4], ax
$_088:	jmp	$_093

$C0083: mov	rcx, qword ptr [ModuleInfo+0x1A8+rip]
	lea	rdx, [rcx+0xA]
	mov	rcx, qword ptr [rbp+0x28]
	mov	eax, dword ptr [rbx+0x14]
	mov	dword ptr [rsp+0x20], eax
	mov	r9, qword ptr [rcx+0x8]
	movzx	r8d, byte ptr [rbx+0x18]
	mov	ecx, 3019
	call	asmerr@PLT
	jmp	$_093

$_089:	cmp	edx, 1
	jl	$C0083
	cmp	edx, 13
	jg	$C0083
	push	rax
	lea	r11, [$C0083+rip]
	movzx	eax, word ptr [r11+rdx*2-(1*2)+($C0084-$C0083)]
	sub	r11, rax
	pop	rax
	jmp	r11
	.ALIGN 2
$C0084:
	.word $C0083-$C005F
	.word $C0083-$C0061
	.word $C0083-$C0062
	.word $C0083-$C0064
	.word $C0083-$C0065
	.word $C0083-$C0066
	.word $C0083-$C0069
	.word $C0083-$C006E
	.word $C0083-$C0077
	.word $C0083-$C007D
	.word $C0083-$C006D
	.word $C0083-$C0067
	.word $C0083-$C0068
$_093:
	mov	rbx, qword ptr [rbx+0x8]
	jmp	$_049

$_095:	xor	eax, eax
$_096:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_097:
	sub	rsp, 40
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_098
	lea	rcx, [DS0000+rip]
	call	SymFind@PLT
	test	rax, rax
	jnz	$_098
	or	byte ptr [ModuleInfo+0x170+rip], 0x01
$_098:	test	byte ptr [ModuleInfo+0x170+rip], 0x01
	jz	$_099
	lea	r9, [DS0002+rip]
	lea	r8, [DS0003+rip]
	lea	rdx, [DS0002+rip]
	lea	rcx, [DS0001+rip]
	call	AddLineQueueX@PLT
	call	RunLineQueue@PLT
	lea	rcx, [DS0000+rip]
	call	SymFind@PLT
	test	rax, rax
	jz	$_099
	cmp	byte ptr [rax+0x18], 3
	jnz	$_099
	mov	rcx, qword ptr [rax+0x68]
	mov	dword ptr [rcx+0x48], 6
$_099:	add	rsp, 40
	ret

set_file_flags:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	lea	rcx, [DS0004+rip]
	call	SymFind@PLT
	test	rax, rax
	jz	$_101
	mov	rcx, qword ptr [rax+0x68]
	mov	rdx, qword ptr [rcx+0x10]
	movzx	eax, word ptr [rdx+0x16]
	cmp	qword ptr [rbp+0x18], 0
	jz	$_100
	mov	rcx, qword ptr [rbp+0x18]
	mov	eax, dword ptr [rcx]
	mov	word ptr [rdx+0x16], ax
$_100:	mov	rcx, qword ptr [rbp+0x10]
	mov	dword ptr [rcx+0x28], eax
$_101:	leave
	ret

pe_create_PE_header:
	push	rsi
	push	rdi
	push	rbx
	sub	rsp, 48
	cmp	dword ptr [Parse_Pass+rip], 0
	jne	$_109
	cmp	byte ptr [ModuleInfo+0x1B5+rip], 7
	jz	$_102
	mov	ecx, 3002
	call	asmerr@PLT
$_102:	movzx	eax, byte ptr [Options+0xCE+rip]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_103
	mov	ebx, 264
	lea	rdi, [pe64def+rip]
	mov	word ptr [rdi+0x5C], ax
	jmp	$_104

$_103:	mov	ebx, 248
	lea	rdi, [pe32def+rip]
	mov	word ptr [rdi+0x5C], ax
$_104:	cmp	byte ptr [Options+0xCF+rip], 0
	jz	$_105
	or	byte ptr [rdi+0x17], 0x20
$_105:	lea	rcx, [DS0004+rip]
	call	SymFind@PLT
	test	rax, rax
	jnz	$_106
	mov	dword ptr [rsp+0x20], 1
	movzx	r9d, byte ptr [ModuleInfo+0x1CD+rip]
	mov	r8d, 2
	lea	rdx, [DS0005+rip]
	lea	rcx, [DS0004+rip]
	call	CreateIntSegment@PLT
	mov	dword ptr [rax+0x50], ebx
	mov	rsi, qword ptr [rax+0x68]
	mov	rcx, qword ptr [ModuleInfo+0x200+rip]
	mov	qword ptr [rsi], rcx
	mov	byte ptr [rsi+0x72], 2
	mov	byte ptr [rsi+0x69], 64
	mov	byte ptr [rsi+0x6B], 1
	mov	dword ptr [rsi+0x18], ebx
	jmp	$_108

$_106:	cmp	dword ptr [rax+0x50], ebx
	jge	$_107
	mov	dword ptr [rax+0x50], ebx
$_107:	mov	rsi, qword ptr [rax+0x68]
	mov	byte ptr [rsi+0x6F], 1
	mov	dword ptr [rsi+0x8], 0
$_108:	mov	dword ptr [rsi+0x48], 6
	mov	ecx, ebx
	call	LclAlloc@PLT
	mov	qword ptr [rsi+0x10], rax
	mov	r8d, ebx
	mov	rdx, rdi
	mov	rcx, rax
	call	tmemcpy@PLT
	mov	rbx, rax
	lea	rcx, [rbx+0x8]
	movzx	ebx, word ptr [rdi+0x16]
	mov	rdi, rcx
	call	time@PLT
	mov	edx, ebx
	lea	rcx, [DS0006+rip]
	call	CreateVariable@PLT
	test	rax, rax
	jz	$_109
	or	byte ptr [rax+0x14], 0x20
	lea	rcx, [set_file_flags+rip]
	mov	qword ptr [rax+0x58], rcx
$_109:	add	rsp, 48
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
	sub	rsp, 72
	mov	dword ptr [rbp-0xC], 0
	cmp	dword ptr [Parse_Pass+rip], 0
	jne	$_129
	lea	rcx, [DS0007+rip]
	call	SymFind@PLT
	test	rax, rax
	jz	$_111
	mov	rdi, rax
	mov	rsi, qword ptr [rdi+0x68]
	jmp	$_112

$_111:	mov	dword ptr [rbp-0xC], 1
	mov	dword ptr [rsp+0x20], 1
	movzx	r9d, byte ptr [ModuleInfo+0x1CD+rip]
	mov	r8d, 2
	lea	rdx, [DS0005+rip]
	lea	rcx, [DS0007+rip]
	call	CreateIntSegment@PLT
	mov	rdi, rax
	mov	rsi, qword ptr [rdi+0x68]
	mov	rax, qword ptr [ModuleInfo+0x200+rip]
	mov	qword ptr [rsi], rax
	mov	byte ptr [rsi+0x72], 2
$_112:	mov	dword ptr [rsi+0x48], 6
	cmp	dword ptr [rbp-0xC], 0
	jnz	$_113
	jmp	$_129

$_113:	mov	qword ptr [rbp-0x8], rdi
	mov	rdi, qword ptr [SymTables+0x20+rip]
$_114:	test	rdi, rdi
	je	$_123
	mov	rsi, qword ptr [rdi+0x68]
	mov	dword ptr [rsi+0x4C], 10
	cmp	dword ptr [rsi+0x48], 2
	jnz	$_118
	cmp	byte ptr [rsi+0x6B], 0
	jnz	$_115
	cmp	byte ptr [rsi+0x69], 64
	jnz	$_116
$_115:	mov	dword ptr [rsi+0x48], 7
	jmp	$_117

$_116:	cmp	qword ptr [rsi+0x50], 0
	jz	$_117
	mov	rcx, qword ptr [rsi+0x50]
	lea	rdx, [DS0008+rip]
	mov	rcx, qword ptr [rcx+0x8]
	call	tstrcmp@PLT
	test	eax, eax
	jnz	$_117
	mov	dword ptr [rsi+0x48], 7
$_117:	jmp	$_122

$_118:	cmp	dword ptr [rsi+0x48], 0
	jnz	$_122
	mov	rbx, qword ptr [rdi+0x8]
	mov	r8d, 5
	lea	rdx, [DS0009+rip]
	mov	rcx, rbx
	call	tmemcmp@PLT
	test	eax, eax
	jnz	$_121
	cmp	byte ptr [rbx+0x5], 0
	jz	$_119
	cmp	byte ptr [rbx+0x5], 36
	jnz	$_120
$_119:	mov	dword ptr [rsi+0x48], 9
$_120:	jmp	$_122

$_121:	lea	rdx, [DS000A+rip]
	mov	rcx, rbx
	call	tstrcmp@PLT
	test	eax, eax
	jnz	$_122
	mov	dword ptr [rsi+0x48], 8
$_122:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_114

$_123:	mov	ebx, 1
	xor	esi, esi
$_124:	cmp	ebx, 7
	jnc	$_128
	lea	rcx, [flat_order+rip]
	mov	rdi, qword ptr [SymTables+0x20+rip]
$_125:	test	rdi, rdi
	jz	$_127
	mov	rdx, qword ptr [rdi+0x68]
	mov	eax, dword ptr [rcx+rbx*4]
	cmp	dword ptr [rdx+0x48], eax
	jnz	$_126
	cmp	dword ptr [rdi+0x50], 0
	jz	$_126
	inc	esi
	jmp	$_127

$_126:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_125

$_127:	inc	ebx
	jmp	$_124

$_128:	test	esi, esi
	jz	$_129
	mov	rdi, qword ptr [rbp-0x8]
	imul	ebx, esi, 40
	mov	dword ptr [rdi+0x50], ebx
	mov	rsi, qword ptr [rdi+0x68]
	lea	ecx, [rbx+0x28]
	call	LclAlloc@PLT
	mov	qword ptr [rsi+0x10], rax
$_129:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

compare_exp:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rdx, qword ptr [rdx]
	mov	rcx, qword ptr [rcx]
	call	tstrcmp@PLT
	leave
	ret

$_130:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 120
	mov	rdi, qword ptr [SymTables+0x40+rip]
	xor	ebx, ebx
$_131:	test	rdi, rdi
	jz	$_133
	mov	rdx, qword ptr [rdi+0x68]
	test	byte ptr [rdx+0x40], 0x04
	jz	$_132
	inc	ebx
$_132:	mov	rdi, qword ptr [rdi+0x78]
	jmp	$_131

$_133:
	test	ebx, ebx
	je	$_150
	lea	rdi, [rbp-0x4]
	call	time@PLT
	lea	rsi, [ModuleInfo+0x230+rip]
	mov	qword ptr [rsp+0x50], rsi
	mov	qword ptr [rsp+0x48], rsi
	mov	qword ptr [rsp+0x40], rsi
	mov	dword ptr [rsp+0x38], ebx
	mov	dword ptr [rsp+0x30], ebx
	mov	dword ptr [rsp+0x28], 1
	mov	qword ptr [rsp+0x20], rsi
	mov	r9d, dword ptr [rbp-0x4]
	lea	r8, [DS000D+rip]
	lea	rdx, [DS000C+rip]
	lea	rcx, [DS000B+rip]
	call	AddLineQueueX@PLT
	mov	qword ptr [rbp-0x10], rsi
	mov	dword ptr [rbp-0x8], ebx
	imul	ecx, ebx, 16
	mov	eax, ecx
	add	eax, 15
	and	eax, 0xFFFFFFF0
	sub	rsp, rax
	lea	rax, [rsp+0x60]
	mov	qword ptr [rbp-0x18], rax
	mov	rdi, qword ptr [SymTables+0x40+rip]
	mov	rsi, rax
	xor	ebx, ebx
$_134:	test	rdi, rdi
	jz	$_136
	mov	rdx, qword ptr [rdi+0x68]
	test	byte ptr [rdx+0x40], 0x04
	jz	$_135
	mov	rax, qword ptr [rdi+0x8]
	mov	qword ptr [rsi], rax
	mov	dword ptr [rsi+0x8], ebx
	inc	ebx
	add	rsi, 16
$_135:	mov	rdi, qword ptr [rdi+0x78]
	jmp	$_134

$_136:	lea	r9, [compare_exp+rip]
	mov	r8d, 16
	mov	edx, dword ptr [rbp-0x8]
	mov	rcx, qword ptr [rbp-0x18]
	call	tqsort@PLT
	mov	rdx, qword ptr [rbp-0x10]
	lea	rcx, [DS000E+rip]
	call	AddLineQueueX@PLT
	mov	rdi, qword ptr [SymTables+0x40+rip]
$_137:	test	rdi, rdi
	jz	$_139
	mov	rdx, qword ptr [rdi+0x68]
	test	byte ptr [rdx+0x40], 0x04
	jz	$_138
	mov	rdx, qword ptr [rdi+0x8]
	lea	rcx, [DS000F+rip]
	call	AddLineQueueX@PLT
$_138:	mov	rdi, qword ptr [rdi+0x78]
	jmp	$_137

$_139:	mov	rdx, qword ptr [rbp-0x10]
	lea	rcx, [DS0010+rip]
	call	AddLineQueueX@PLT
	mov	rsi, qword ptr [rbp-0x18]
	xor	ebx, ebx
$_140:	cmp	ebx, dword ptr [rbp-0x8]
	jge	$_141
	mov	rdx, qword ptr [rsi]
	lea	rcx, [DS0011+rip]
	call	AddLineQueueX@PLT
	inc	ebx
	add	rsi, 16
	jmp	$_140

$_141:	mov	rdx, qword ptr [rbp-0x10]
	lea	rcx, [DS0012+rip]
	call	AddLineQueueX@PLT
	mov	rsi, qword ptr [rbp-0x18]
	xor	ebx, ebx
$_142:	cmp	ebx, dword ptr [rbp-0x8]
	jge	$_143
	mov	edx, dword ptr [rsi+0x8]
	lea	rcx, [DS0013+rip]
	call	AddLineQueueX@PLT
	inc	ebx
	add	rsi, 16
	jmp	$_142

$_143:	mov	rbx, qword ptr [ModuleInfo+0x98+rip]
	mov	rcx, rbx
	call	tstrlen@PLT
	add	rbx, rax
$_144:	cmp	rbx, qword ptr [ModuleInfo+0x98+rip]
	jbe	$_145
	cmp	byte ptr [rbx], 47
	jz	$_145
	cmp	byte ptr [rbx], 92
	jz	$_145
	cmp	byte ptr [rbx], 58
	jz	$_145
	dec	rbx
	jmp	$_144

$_145:	mov	r8, rbx
	mov	rdx, qword ptr [rbp-0x10]
	lea	rcx, [DS0014+rip]
	call	AddLineQueueX@PLT
	mov	rdi, qword ptr [SymTables+0x40+rip]
$_146:	test	rdi, rdi
	jz	$_149
	mov	rdx, qword ptr [rdi+0x68]
	test	byte ptr [rdx+0x40], 0x04
	jz	$_148
	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	mov	rcx, rdi
	call	Mangle@PLT
	mov	rcx, qword ptr [ModuleInfo+0x188+rip]
	cmp	byte ptr [Options+0x90+rip], 0
	jz	$_147
	mov	rcx, qword ptr [rdi+0x8]
$_147:	mov	r8, rcx
	mov	rdx, qword ptr [rdi+0x8]
	lea	rcx, [DS0015+rip]
	call	AddLineQueueX@PLT
$_148:	mov	rdi, qword ptr [rdi+0x78]
	jmp	$_146

$_149:	lea	rdx, [DS000C+rip]
	lea	rcx, [DS0016+rip]
	call	AddLineQueueX@PLT
	call	RunLineQueue@PLT
$_150:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_151:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 376
	mov	dword ptr [rbp-0x4], 0
	mov	dword ptr [rbp-0x8], 214
	lea	rax, [DS0017+rip]
	mov	qword ptr [rbp-0x10], rax
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jz	$_152
	mov	dword ptr [rbp-0x8], 210
	lea	rax, [DS0018+rip]
	mov	qword ptr [rbp-0x10], rax
$_152:	mov	rbx, qword ptr [ModuleInfo+0x60+rip]
$_153:	test	rbx, rbx
	je	$_169
	cmp	dword ptr [rbx+0x8], 0
	je	$_168
	cmp	dword ptr [rbp-0x4], 0
	jnz	$_154
	mov	dword ptr [rbp-0x4], 1
	lea	rcx, [DS0019+rip]
	call	AddLineQueueX@PLT
$_154:	lea	rdx, [rbx+0xC]
	lea	rcx, [rbp-0x110]
	call	tstrcpy@PLT
	mov	rsi, rax
	jmp	$_156

$_155:	mov	byte ptr [rax], 95
$_156:	mov	edx, 46
	mov	rcx, rsi
	call	tstrchr@PLT
	test	rax, rax
	jnz	$_155
	jmp	$_158

$_157:	mov	byte ptr [rax], 95
$_158:	mov	edx, 45
	mov	rcx, rsi
	call	tstrchr@PLT
	test	rax, rax
	jnz	$_157
	lea	rcx, [DS001A+rip]
	lea	rdx, [DS000D+rip]
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rsp+0x58], eax
	mov	qword ptr [rsp+0x50], rsi
	mov	qword ptr [rsp+0x48], rdx
	mov	rax, qword ptr [rbp-0x10]
	mov	qword ptr [rsp+0x40], rax
	mov	qword ptr [rsp+0x38], rcx
	mov	qword ptr [rsp+0x30], rcx
	mov	qword ptr [rsp+0x28], rsi
	mov	qword ptr [rsp+0x20], rsi
	mov	r9, rsi
	mov	r8, rdx
	mov	rdx, rcx
	lea	rcx, [DS001B+rip]
	call	AddLineQueueX@PLT
	mov	rdi, qword ptr [SymTables+0x10+rip]
$_159:	test	rdi, rdi
	jz	$_161
	test	byte ptr [rdi+0x14], 0x08
	jz	$_160
	cmp	qword ptr [rdi+0x50], rbx
	jnz	$_160
	mov	rdx, qword ptr [rdi+0x8]
	lea	rcx, [DS001C+rip]
	call	AddLineQueueX@PLT
$_160:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_159

$_161:	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rsp+0x30], eax
	mov	qword ptr [rsp+0x28], rsi
	lea	rax, [DS000D+rip]
	mov	qword ptr [rsp+0x20], rax
	mov	r9, qword ptr [rbp-0x10]
	lea	r8, [DS001A+rip]
	lea	rdx, [DS001A+rip]
	lea	rcx, [DS001D+rip]
	call	AddLineQueueX@PLT
	mov	rdi, qword ptr [SymTables+0x10+rip]
$_162:	test	rdi, rdi
	jz	$_164
	test	byte ptr [rdi+0x14], 0x08
	jz	$_163
	cmp	qword ptr [rdi+0x50], rbx
	jnz	$_163
	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	mov	rcx, rdi
	call	Mangle@PLT
	mov	r9, qword ptr [rdi+0x8]
	mov	r8, qword ptr [ModuleInfo+0x188+rip]
	mov	rdx, qword ptr [ModuleInfo+0x68+rip]
	lea	rcx, [DS001E+rip]
	call	AddLineQueueX@PLT
$_163:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_162

$_164:	lea	r9, [DS000D+rip]
	lea	r8, [DS001A+rip]
	lea	rdx, [DS001A+rip]
	lea	rcx, [DS001F+rip]
	call	AddLineQueueX@PLT
	mov	rdi, qword ptr [SymTables+0x10+rip]
$_165:	test	rdi, rdi
	jz	$_167
	test	byte ptr [rdi+0x14], 0x08
	jz	$_166
	cmp	qword ptr [rdi+0x50], rbx
	jnz	$_166
	mov	r8, qword ptr [rdi+0x8]
	mov	rdx, qword ptr [rdi+0x8]
	lea	rcx, [DS0020+rip]
	call	AddLineQueueX@PLT
$_166:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_165

$_167:	lea	r9, [DS001A+rip]
	lea	r8, [rbx+0xC]
	mov	rdx, rsi
	lea	rcx, [DS0021+rip]
	call	AddLineQueueX@PLT
$_168:	mov	rbx, qword ptr [rbx]
	jmp	$_153

$_169:
	cmp	qword ptr [ModuleInfo+0xC8+rip], 0
	jz	$_170
	lea	r9, [DS001A+rip]
	lea	r8, [DS000D+rip]
	lea	rdx, [DS001A+rip]
	lea	rcx, [DS0022+rip]
	call	AddLineQueueX@PLT
	call	RunLineQueue@PLT
$_170:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_171:
	mov	eax, 4294967295
	jmp	$_173

$_172:	shr	ecx, 1
	inc	eax
$_173:	test	ecx, ecx
	jnz	$_172
	ret

$_174:
	mov	rcx, qword ptr [rcx+0x68]
	mov	eax, 3221225536
	jmp	$_181

$_175:	mov	eax, 1610612768
	jmp	$_183

$_176:	mov	eax, 3221225600
	jmp	$_183

$_177:	mov	eax, 3221225600
	jmp	$_183

$_178:	mov	eax, 1073741888
	jmp	$_183

$_179:	mov	rdx, qword ptr [rcx+0x50]
	mov	rdx, qword ptr [rdx+0x8]
	cmp	dword ptr [rdx], 1397641027
	jnz	$_180
	cmp	word ptr [rdx+0x4], 84
	jnz	$_180
	mov	eax, 1073741888
$_180:	jmp	$_183

$_181:	cmp	dword ptr [rcx+0x48], 1
	jz	$_175
	cmp	dword ptr [rcx+0x48], 3
	jz	$_176
	cmp	byte ptr [rcx+0x72], 5
	jnz	$_182
	cmp	dword ptr [rcx+0x18], 0
	jz	$_177
$_182:	cmp	byte ptr [rcx+0x6B], 0
	jnz	$_178
	cmp	qword ptr [rcx+0x50], 0
	jnz	$_179
$_183:	cmp	byte ptr [rcx+0x69], 0
	jz	$_184
	and	eax, 0x1FFFFFF
	mov	dl, byte ptr [rcx+0x69]
	and	edx, 0xFE
	shl	edx, 24
	or	eax, edx
$_184:	ret

$_185:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 88
	mov	dword ptr [rbp-0x4], 0
	mov	dword ptr [rbp-0x8], 0
	mov	dword ptr [rbp-0x10], -1
	mov	rdi, qword ptr [SymTables+0x20+rip]
$_186:	test	rdi, rdi
	jz	$_193
	mov	rsi, qword ptr [rdi+0x68]
	cmp	dword ptr [rsi+0x48], 6
	jz	$_192
	mov	rbx, qword ptr [rsi+0x28]
$_187:	test	rbx, rbx
	jz	$_192
	jmp	$_190

$_188:	mov	eax, dword ptr [rbx+0x14]
	and	eax, 0xFFFFF000
	add	eax, dword ptr [rsi+0xC]
	cmp	eax, dword ptr [rbp-0x10]
	jz	$_189
	mov	dword ptr [rbp-0x10], eax
	inc	dword ptr [rbp-0x8]
	test	byte ptr [rbp-0x4], 0x01
	jz	$_189
	inc	dword ptr [rbp-0x4]
$_189:	inc	dword ptr [rbp-0x4]
	jmp	$_191

$_190:	cmp	byte ptr [rbx+0x18], 5
	jz	$_188
	cmp	byte ptr [rbx+0x18], 6
	jz	$_188
	cmp	byte ptr [rbx+0x18], 7
	jz	$_188
$_191:	mov	rbx, qword ptr [rbx+0x8]
	jmp	$_187

$_192:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_186

$_193:
	imul	ecx, dword ptr [rbp-0x8], 8
	imul	eax, dword ptr [rbp-0x4], 2
	add	ecx, eax
	mov	rdi, qword ptr [rbp+0x28]
	mov	rsi, qword ptr [rdi+0x68]
	mov	dword ptr [rdi+0x50], ecx
	call	LclAlloc@PLT
	mov	qword ptr [rsi+0x10], rax
	mov	qword ptr [rbp-0x30], rax
	mov	dword ptr [rax], -1
	add	rax, 8
	mov	qword ptr [rbp-0x38], rax
	mov	rdi, qword ptr [SymTables+0x20+rip]
$_194:	test	rdi, rdi
	je	$_206
	mov	rsi, qword ptr [rdi+0x68]
	cmp	dword ptr [rsi+0x48], 6
	je	$_205
	mov	rbx, qword ptr [rsi+0x28]
$_195:	test	rbx, rbx
	je	$_205
	xor	ecx, ecx
	mov	al, byte ptr [rbx+0x18]
	jmp	$_199

$_196:	mov	ecx, 2
	jmp	$_200

$_197:	mov	ecx, 3
	jmp	$_200

$_198:	mov	ecx, 10
	jmp	$_200

$_199:	cmp	al, 5
	jz	$_196
	cmp	al, 6
	jz	$_197
	cmp	al, 7
	jz	$_198
$_200:	test	ecx, ecx
	jz	$_204
	mov	dword ptr [rbp-0xC], ecx
	mov	eax, dword ptr [rbx+0x14]
	and	eax, 0xFFFFF000
	add	eax, dword ptr [rsi+0xC]
	mov	rdx, qword ptr [rbp-0x30]
	mov	rcx, qword ptr [rbp-0x38]
	cmp	eax, dword ptr [rdx]
	jz	$_203
	cmp	dword ptr [rdx], -1
	jz	$_202
	test	byte ptr [rdx+0x4], 0x02
	jz	$_201
	mov	word ptr [rcx], 0
	add	rcx, 2
	add	dword ptr [rdx+0x4], 2
$_201:	mov	rdx, rcx
	add	rcx, 8
$_202:	mov	dword ptr [rdx], eax
	mov	dword ptr [rdx+0x4], 8
$_203:	add	dword ptr [rdx+0x4], 2
	mov	qword ptr [rbp-0x30], rdx
	mov	eax, dword ptr [rbx+0x14]
	and	eax, 0xFFF
	mov	edx, dword ptr [rbp-0xC]
	shl	edx, 12
	or	eax, edx
	mov	word ptr [rcx], ax
	add	rcx, 2
	mov	qword ptr [rbp-0x38], rcx
$_204:	mov	rbx, qword ptr [rbx+0x8]
	jmp	$_195

$_205:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_194

$_206:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_207:
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 184
	mov	rbx, rcx
	mov	rsi, rdx
	jmp	$_233

$_208:	lodsb
	dec	dword ptr [rbp+0x38]
	cmp	al, 45
	jz	$_209
	cmp	al, 47
	jne	$_233
$_209:	lodsd
	sub	dword ptr [rbp+0x38], 4
	or	eax, 0x20202020
	jmp	$_232

$_210:	lodsb
	dec	dword ptr [rbp+0x38]
	cmp	al, 58
	jnz	$_213
	mov	eax, dword ptr [rsi]
	mov	ecx, 10
	cmp	al, 48
	jnz	$_211
	cmp	ah, 120
	jnz	$_211
	lodsw
	sub	dword ptr [rbp+0x38], 2
	mov	ecx, 16
$_211:	mov	r9d, dword ptr [rbp+0x38]
	mov	r8d, ecx
	lea	rdx, [rbp-0x10]
	mov	rcx, rsi
	call	_atoow@PLT
	mov	eax, dword ptr [rbp-0x10]
	mov	ecx, eax
	or	ecx, dword ptr [rbp-0xC]
	mov	edx, dword ptr [rbp-0x8]
	or	edx, dword ptr [rbp-0x4]
	test	ecx, ecx
	jz	$_213
	test	edx, edx
	jnz	$_213
	test	eax, 0xFFF
	jnz	$_213
	mov	edx, dword ptr [rbp-0xC]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_212
	mov	dword ptr [rbx+0x30], eax
	mov	dword ptr [rbx+0x34], edx
	jmp	$_213

$_212:	test	edx, edx
	jnz	$_213
	cmp	eax, 4294963200
	ja	$_213
	mov	dword ptr [rbx+0x34], eax
$_213:	jmp	$_233

$_214:	lodsw
	dec	dword ptr [rbp+0x38]
	or	al, 0x20
	cmp	al, 121
	jnz	$_217
	cmp	ah, 58
	jnz	$_217
	lea	rdi, [rbp-0x90]
$_215:	cmp	dword ptr [rbp+0x38], 0
	jle	$_216
	lodsb
	test	al, al
	jz	$_216
	cmp	al, 32
	jz	$_216
	stosb
	dec	dword ptr [rbp+0x38]
	jmp	$_215

$_216:	xor	eax, eax
	stosb
	lea	rcx, [rbp-0x90]
	call	SymFind@PLT
	test	rax, rax
	jz	$_217
	mov	qword ptr [ModuleInfo+0xE0+rip], rax
$_217:	jmp	$_233

$_218:	lodsb
	dec	dword ptr [rbp+0x38]
	or	al, 0x20
	cmp	al, 100
	jnz	$_220
	lodsb
	dec	dword ptr [rbp+0x38]
	cmp	al, 58
	jnz	$_219
	and	word ptr [rbx+0x16], 0xFFFE
	jmp	$_220

$_219:	or	byte ptr [rbx+0x16], 0x01
$_220:	jmp	$_233

$_221:	mov	r8d, 13
	lea	rdx, [DS0023+rip]
	mov	rcx, rsi
	call	tmemicmp@PLT
	test	eax, eax
	jnz	$_223
	sub	dword ptr [rbp+0x38], 13
	add	rsi, 13
	mov	r8d, 3
	lea	rdx, [DS0024+rip]
	mov	rcx, rsi
	call	tmemicmp@PLT
	test	eax, eax
	jnz	$_222
	sub	dword ptr [rbp+0x38], 3
	add	rsi, 3
	and	word ptr [rbx+0x16], 0xFFDF
	jmp	$_223

$_222:	or	byte ptr [rbx+0x16], 0x20
$_223:	jmp	$_233

$_224:	mov	dword ptr [rbp-0x94], 0
	mov	r8d, 6
	lea	rdx, [DS0025+rip]
	mov	rcx, rsi
	call	tmemicmp@PLT
	test	eax, eax
	jne	$_227
	sub	dword ptr [rbp+0x38], 6
	add	rsi, 6
	mov	r8d, 7
	lea	rdx, [DS0026+rip]
	mov	rcx, rsi
	call	tmemicmp@PLT
	test	eax, eax
	jnz	$_225
	sub	dword ptr [rbp+0x38], 7
	add	rsi, 7
	mov	dword ptr [rbp-0x94], 2
	jmp	$_227

$_225:	mov	r8d, 7
	lea	rdx, [DS0027+rip]
	mov	rcx, rsi
	call	tmemicmp@PLT
	test	eax, eax
	jnz	$_226
	sub	dword ptr [rbp+0x38], 7
	add	rsi, 7
	mov	dword ptr [rbp-0x94], 3
	jmp	$_227

$_226:	mov	r8d, 6
	lea	rdx, [DS0028+rip]
	mov	rcx, rsi
	call	tmemicmp@PLT
	test	eax, eax
	jnz	$_227
	sub	dword ptr [rbp+0x38], 6
	add	rsi, 6
	mov	dword ptr [rbp-0x94], 1
$_227:	cmp	dword ptr [rbp-0x94], 0
	jz	$_229
	mov	eax, dword ptr [rbp-0x94]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_228
	mov	word ptr [rbx+0x5C], ax
	jmp	$_229

$_228:	mov	word ptr [rbx+0x5C], ax
$_229:	jmp	$_233

$_230:	and	eax, 0xFFFFFF
	cmp	eax, 7105636
	jnz	$_231
	or	byte ptr [rbx+0x17], 0x20
$_231:	jmp	$_233

$_232:	cmp	eax, 1702060386
	je	$_210
	cmp	eax, 1920233061
	je	$_214
	cmp	eax, 1702390118
	je	$_218
	cmp	eax, 1735549292
	je	$_221
	cmp	eax, 1935832435
	je	$_224
	jmp	$_230

$_233:
	cmp	dword ptr [rbp+0x38], 3
	jg	$_208
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_234:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 440
	mov	dword ptr [rbp-0x14], 0
	mov	dword ptr [rbp-0x18], 0
	mov	dword ptr [rbp-0x1C], 0
	mov	dword ptr [rbp-0x20], 0
	mov	dword ptr [rbp-0x24], 0
	mov	dword ptr [rbp-0x28], 0
	mov	qword ptr [rbp-0x48], 0
	lea	rcx, [DS0000+rip]
	call	SymFind@PLT
	mov	qword ptr [rbp-0x30], rax
	mov	rsi, qword ptr [rax+0x68]
	lea	rcx, [DS0004+rip]
	call	SymFind@PLT
	mov	qword ptr [rbp-0x38], rax
	lea	rcx, [DS0007+rip]
	call	SymFind@PLT
	mov	qword ptr [rbp-0x40], rax
	mov	rax, qword ptr [ModuleInfo+0x200+rip]
	mov	qword ptr [rsi], rax
	mov	rax, qword ptr [rbp-0x38]
	mov	rsi, qword ptr [rax+0x68]
	mov	rcx, qword ptr [rsi+0x10]
	mov	qword ptr [rbp-0x50], rcx
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_235
	mov	ax, word ptr [rcx+0x16]
	mov	word ptr [rbp-0xE], ax
	jmp	$_236

$_235:	mov	ax, word ptr [rcx+0x16]
	mov	word ptr [rbp-0xE], ax
$_236:	mov	rdi, qword ptr [ModuleInfo+0x50+rip]
$_237:	test	rdi, rdi
	jz	$_238
	lea	rcx, [rdi+0x8]
	call	tstrlen@PLT
	mov	r8d, eax
	lea	rdx, [rdi+0x8]
	mov	rcx, qword ptr [rbp-0x50]
	call	$_207
	mov	rdi, qword ptr [rdi]
	jmp	$_237

$_238:
	mov	rdi, qword ptr [SymTables+0x20+rip]
$_239:	test	rdi, rdi
	jz	$_241
	mov	rsi, qword ptr [rdi+0x68]
	cmp	byte ptr [rsi+0x6C], 0
	jz	$_240
	lea	rdx, [DS0029+rip]
	mov	rcx, qword ptr [rdi+0x8]
	call	tstrcmp@PLT
	test	rax, rax
	jnz	$_240
	mov	r8d, dword ptr [rsi+0x18]
	mov	rdx, qword ptr [rsi+0x10]
	mov	rcx, qword ptr [rbp-0x50]
	call	$_207
$_240:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_239

$_241:
	test	eax, 0x1
	jnz	$_242
	mov	dword ptr [rsp+0x20], 1
	movzx	r9d, byte ptr [ModuleInfo+0x1CD+rip]
	mov	r8d, 2
	lea	rdx, [DS002A+rip]
	lea	rcx, [DS000A+rip]
	call	CreateIntSegment@PLT
	mov	qword ptr [rbp-0x48], rax
	test	rax, rax
	jz	$_242
	mov	rsi, qword ptr [rax+0x68]
	mov	dword ptr [rax+0x50], 8
	mov	rax, qword ptr [ModuleInfo+0x200+rip]
	mov	qword ptr [rsi], rax
	mov	byte ptr [rsi+0x72], 2
	mov	dword ptr [rsi+0x48], 8
	mov	byte ptr [rsi+0x69], 66
	mov	dword ptr [rsi+0x18], 8
	mov	rdx, qword ptr [rbp-0x40]
	mov	rsi, qword ptr [rdx+0x68]
	mov	edi, dword ptr [rdx+0x50]
	add	dword ptr [rdx+0x50], 40
	add	rdi, qword ptr [rsi+0x10]
	mov	ecx, 40
	xor	eax, eax
	rep stosb
$_242:	lea	rcx, [flat_order+rip]
	xor	ebx, ebx
$_243:	cmp	ebx, 7
	jnc	$_247
	mov	rdi, qword ptr [SymTables+0x20+rip]
$_244:	test	rdi, rdi
	jz	$_246
	mov	rsi, qword ptr [rdi+0x68]
	mov	eax, dword ptr [rcx+rbx*4]
	cmp	dword ptr [rsi+0x48], eax
	jnz	$_245
	mov	dword ptr [rsi+0x4C], ebx
$_245:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_244

$_246:	inc	ebx
	jmp	$_243

$_247:
	mov	ecx, 2
	call	SortSegments@PLT
	mov	rax, qword ptr [rbp-0x50]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_248
	mov	eax, dword ptr [rax+0x3C]
	jmp	$_249

$_248:	mov	eax, dword ptr [rax+0x3C]
$_249:	mov	ecx, eax
	call	$_171
	mov	dword ptr [rbp-0x8], eax
	mov	rax, qword ptr [rbp-0x50]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_250
	mov	eax, dword ptr [rax+0x38]
	jmp	$_251

$_250:	mov	eax, dword ptr [rax+0x38]
$_251:	mov	dword ptr [rbp-0xC], eax
	mov	rdi, qword ptr [SymTables+0x20+rip]
	mov	ebx, 4294967295
$_252:	test	rdi, rdi
	jz	$_256
	mov	rsi, qword ptr [rdi+0x68]
	mov	rdx, qword ptr [rbp+0x28]
	cmp	dword ptr [rsi+0x4C], 10
	jz	$_253
	cmp	dword ptr [rsi+0x4C], ebx
	jz	$_254
$_253:	mov	ebx, dword ptr [rsi+0x4C]
	mov	eax, dword ptr [rbp-0x8]
	mov	byte ptr [rdx+0x1], al
	mov	eax, dword ptr [rbp-0xC]
	jmp	$_255

$_254:	mov	eax, 1
	mov	cl, byte ptr [rsi+0x6A]
	shl	eax, cl
	mov	byte ptr [rdx+0x1], 0
$_255:	dec	eax
	mov	ecx, eax
	not	ecx
	add	eax, dword ptr [rdx+0x1C]
	and	eax, ecx
	mov	dword ptr [rdx+0x1C], eax
	mov	rcx, rdi
	call	$_001
	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_252

$_256:
	mov	rbx, qword ptr [rbp+0x28]
	mov	rcx, qword ptr [rbp-0x48]
	test	rcx, rcx
	jz	$_258
	call	$_185
	mov	rcx, qword ptr [rbp-0x48]
	mov	eax, dword ptr [rcx+0x50]
	cmp	eax, 8
	jle	$_257
	mov	rsi, qword ptr [rcx+0x68]
	add	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rbx+0x1C], eax
	jmp	$_258

$_257:	mov	rdx, qword ptr [rbp-0x40]
	sub	dword ptr [rdx+0x50], 40
	sub	dword ptr [rbx+0x1C], 8
$_258:	mov	eax, dword ptr [rbx+0x1C]
	mov	dword ptr [rbp-0x28], eax
	mov	rax, qword ptr [rbp-0x30]
	mov	rcx, qword ptr [rbp-0x38]
	cmp	dword ptr [rax+0x50], 64
	jl	$_259
	mov	rsi, qword ptr [rax+0x68]
	mov	rdx, qword ptr [rsi+0x10]
	mov	rsi, qword ptr [rcx+0x68]
	mov	eax, dword ptr [rsi+0x38]
	mov	dword ptr [rdx+0x3C], eax
$_259:	mov	rsi, qword ptr [rcx+0x68]
	mov	rdx, qword ptr [rsi+0x10]
	lea	rcx, [rdx+0x4]
	mov	qword ptr [rbp-0x58], rcx
	mov	rdi, qword ptr [rbp-0x40]
	mov	eax, dword ptr [rdi+0x50]
	mov	ecx, 40
	cdq
	div	ecx
	mov	rcx, qword ptr [rbp-0x58]
	mov	word ptr [rcx+0x2], ax
	mov	rax, qword ptr [rbp-0x50]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_260
	mov	eax, dword ptr [rax+0x3C]
	jmp	$_261

$_260:	mov	eax, dword ptr [rax+0x3C]
$_261:	mov	dword ptr [rbx+0x28], eax
	mov	rsi, qword ptr [rdi+0x68]
	mov	rax, qword ptr [rsi+0x10]
	mov	qword ptr [rbp-0x60], rax
	mov	rdi, qword ptr [SymTables+0x20+rip]
	mov	ebx, 4294967295
$_262:	test	rdi, rdi
	je	$_275
	mov	rsi, qword ptr [rdi+0x68]
	cmp	dword ptr [rsi+0x48], 6
	je	$_274
	cmp	dword ptr [rdi+0x50], 0
	je	$_274
	cmp	byte ptr [rsi+0x6C], 0
	jz	$_263
	jmp	$_274

$_263:	cmp	dword ptr [rsi+0x4C], ebx
	jz	$_266
	mov	ebx, dword ptr [rsi+0x4C]
	mov	rax, qword ptr [rsi+0x60]
	test	rax, rax
	jnz	$_264
	lea	r8, [rbp-0x168]
	xor	edx, edx
	mov	rcx, rdi
	call	ConvertSectionName@PLT
$_264:	mov	qword ptr [rbp-0x70], rax
	mov	rcx, qword ptr [rbp-0x60]
	mov	r8d, 8
	mov	rdx, qword ptr [rbp-0x70]

.ALIGN	8
	call	tstrncpy@PLT
	mov	rcx, qword ptr [rbp-0x60]
	cmp	dword ptr [rsi+0x48], 3
	jz	$_265
	mov	eax, dword ptr [rsi+0x38]
	mov	dword ptr [rcx+0x14], eax
$_265:	mov	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rcx+0xC], eax
	cmp	dword ptr [rbp-0x24], 0
	jnz	$_266
	mov	eax, dword ptr [rsi+0x38]
	mov	dword ptr [rbp-0x24], eax
$_266:	mov	rcx, rdi
	call	$_174
	mov	rcx, qword ptr [rbp-0x60]
	or	dword ptr [rcx+0x24], eax
	mov	eax, dword ptr [rdi+0x50]
	cmp	dword ptr [rsi+0x48], 3
	jz	$_267
	add	dword ptr [rcx+0x10], eax
$_267:	mov	edx, dword ptr [rsi+0xC]
	sub	edx, dword ptr [rcx+0xC]
	add	eax, edx
	mov	dword ptr [rcx+0x8], eax
	mov	rdx, qword ptr [rdi+0x70]
	test	rdx, rdx
	jz	$_268
	mov	rdx, qword ptr [rdx+0x68]
$_268:	test	rdx, rdx
	jz	$_269
	cmp	dword ptr [rdx+0x4C], ebx
	jz	$_273
$_269:	mov	rax, qword ptr [rbp+0x28]
	mov	eax, dword ptr [rax+0x28]
	dec	eax
	add	dword ptr [rcx+0x10], eax
	not	eax
	and	dword ptr [rcx+0x10], eax
	test	byte ptr [rcx+0x27], 0x20
	jz	$_271
	cmp	dword ptr [rbp-0x14], 0
	jnz	$_270
	mov	eax, dword ptr [rcx+0xC]
	mov	dword ptr [rbp-0x14], eax
$_270:	mov	eax, dword ptr [rcx+0x10]
	add	dword ptr [rbp-0x1C], eax
$_271:	test	byte ptr [rcx+0x24], 0x40
	jz	$_273
	cmp	dword ptr [rbp-0x18], 0
	jnz	$_272
	mov	eax, dword ptr [rcx+0xC]
	mov	dword ptr [rbp-0x18], eax
$_272:	mov	eax, dword ptr [rcx+0x10]
	add	dword ptr [rbp-0x20], eax
$_273:	test	rdx, rdx
	jz	$_274
	cmp	dword ptr [rdx+0x4C], ebx
	jz	$_274
	add	qword ptr [rbp-0x60], 40
$_274:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_262

$_275:
	cmp	qword ptr [ModuleInfo+0xE0+rip], 0
	jz	$_278
	mov	rax, qword ptr [ModuleInfo+0xE0+rip]
	mov	rdx, qword ptr [rax+0x30]
	mov	rsi, qword ptr [rdx+0x68]
	mov	ecx, dword ptr [rsi+0xC]
	add	ecx, dword ptr [rax+0x28]
	mov	rax, qword ptr [rbp-0x50]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_276
	mov	dword ptr [rax+0x28], ecx
	jmp	$_277

$_276:	mov	dword ptr [rax+0x28], ecx
$_277:	jmp	$_279

$_278:	mov	ecx, 8009
	call	asmerr@PLT
$_279:	mov	rcx, qword ptr [rbp-0x50]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_280
	mov	eax, dword ptr [rcx+0x38]
	dec	eax
	mov	edx, eax
	not	edx
	add	eax, dword ptr [rbp-0x28]
	and	eax, edx
	mov	dword ptr [rbp-0x28], eax
	mov	eax, dword ptr [rbp-0x1C]
	mov	dword ptr [rcx+0x1C], eax
	mov	eax, dword ptr [rbp-0x14]
	mov	dword ptr [rcx+0x2C], eax
	mov	eax, dword ptr [rbp-0x28]
	mov	dword ptr [rcx+0x50], eax
	mov	eax, dword ptr [rbp-0x24]
	mov	dword ptr [rcx+0x54], eax
	lea	rax, [rcx+0x88]
	mov	qword ptr [rbp-0x68], rax
	jmp	$_281

$_280:	mov	eax, dword ptr [rcx+0x38]
	dec	eax
	mov	edx, eax
	not	edx
	add	eax, dword ptr [rbp-0x28]
	and	eax, edx
	mov	dword ptr [rbp-0x28], eax
	mov	eax, dword ptr [rbp-0x1C]
	mov	dword ptr [rcx+0x1C], eax
	mov	eax, dword ptr [rbp-0x20]
	mov	dword ptr [rcx+0x20], eax
	mov	eax, dword ptr [rbp-0x14]
	mov	dword ptr [rcx+0x2C], eax
	mov	eax, dword ptr [rbp-0x18]
	mov	dword ptr [rcx+0x30], eax
	mov	eax, dword ptr [rbp-0x28]
	mov	dword ptr [rcx+0x50], eax
	mov	eax, dword ptr [rbp-0x24]
	mov	dword ptr [rcx+0x54], eax
	lea	rax, [rcx+0x78]
	mov	qword ptr [rbp-0x68], rax
$_281:	lea	rcx, [DS000C+rip]
	call	SymFind@PLT
	test	rax, rax
	jz	$_282
	mov	rsi, qword ptr [rax+0x68]
	mov	rcx, qword ptr [rbp-0x68]
	mov	eax, dword ptr [rax+0x50]
	mov	dword ptr [rcx+0x4], eax
	mov	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rcx], eax
$_282:	lea	rcx, [DS002B+rip]
	call	SymFind@PLT
	test	rax, rax
	jz	$_283
	mov	rdi, rax
	lea	rcx, [DS002C+rip]
	call	SymFind@PLT
	mov	qword ptr [rbp-0x170], rax
	lea	rcx, [DS002D+rip]
	call	SymFind@PLT
	mov	qword ptr [rbp-0x178], rax
	mov	rcx, qword ptr [rbp-0x170]
	mov	rsi, qword ptr [rcx+0x68]
	mov	eax, dword ptr [rsi+0xC]
	add	eax, dword ptr [rcx+0x50]
	mov	rsi, qword ptr [rdi+0x68]
	sub	eax, dword ptr [rsi+0xC]
	mov	rdx, qword ptr [rbp-0x68]
	mov	dword ptr [rdx+0xC], eax
	mov	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rdx+0x8], eax
	mov	rcx, qword ptr [rbp-0x178]
	mov	rsi, qword ptr [rcx+0x68]
	mov	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rdx+0x60], eax
	mov	eax, dword ptr [rcx+0x50]
	mov	dword ptr [rdx+0x64], eax
$_283:	lea	rcx, [DS0009+rip]
	call	SymFind@PLT
	test	rax, rax
	jz	$_284
	mov	rsi, qword ptr [rax+0x68]
	mov	rdx, qword ptr [rbp-0x68]
	mov	eax, dword ptr [rax+0x50]
	mov	dword ptr [rdx+0x14], eax
	mov	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rdx+0x10], eax
$_284:	lea	rcx, [DS000A+rip]
	call	SymFind@PLT
	test	rax, rax
	jz	$_285
	mov	rsi, qword ptr [rax+0x68]
	mov	rdx, qword ptr [rbp-0x68]
	mov	eax, dword ptr [rax+0x50]
	mov	dword ptr [rdx+0x2C], eax
	mov	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rdx+0x28], eax
$_285:	lea	rcx, [DS002E+rip]
	call	SymFind@PLT
	test	rax, rax
	jz	$_286
	mov	rsi, qword ptr [rax+0x68]
	mov	rdx, qword ptr [rbp-0x68]
	mov	eax, dword ptr [rax+0x50]
	mov	dword ptr [rdx+0x4C], eax
	mov	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rdx+0x48], eax
$_286:	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_291
	lea	rcx, [DS002F+rip]
	call	SymFind@PLT
	test	rax, rax
	jz	$_287
	mov	rsi, qword ptr [rax+0x68]
	mov	rdx, qword ptr [rbp-0x68]
	mov	eax, dword ptr [rax+0x50]
	mov	dword ptr [rdx+0x1C], eax
	mov	eax, dword ptr [rsi+0xC]
	mov	dword ptr [rdx+0x18], eax
$_287:	mov	rcx, qword ptr [rbp-0x50]
	mov	rax, qword ptr [rcx+0x30]
	cmp	eax, -1
	jnz	$_290
	movabs	rax, 0x140000000
	test	byte ptr [rbp-0xD], 0x20
	jz	$_288
	movabs	rax, 0x180000000
	jmp	$_289

$_288:	test	byte ptr [rcx+0x16], 0x20
	jnz	$_289
	mov	eax, 4194304
$_289:	mov	qword ptr [rcx+0x30], rax
$_290:	mov	rcx, qword ptr [rbp+0x28]
	mov	qword ptr [rcx+0x20], rax
	jmp	$_296

$_291:	mov	rcx, qword ptr [rbp-0x50]
	cmp	dword ptr [rcx+0x34], -1
	jnz	$_293
	mov	eax, 4194304
	test	byte ptr [rbp-0xD], 0x20
	jz	$_292
	mov	eax, 268435456
$_292:	mov	dword ptr [rcx+0x34], eax
$_293:	mov	rcx, qword ptr [rbp+0x28]
	mov	rax, qword ptr [rbp-0x50]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_294
	mov	rax, qword ptr [rax+0x30]
	jmp	$_295

$_294:	mov	eax, dword ptr [rax+0x34]
$_295:	mov	dword ptr [rcx+0x20], eax
$_296:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

pe_enddirhook:
	sub	rsp, 8
	call	$_097
	call	$_130
	cmp	qword ptr [ModuleInfo+0x60+rip], 0
	jz	$_297
	call	$_151
$_297:	call	$_110
	xor	eax, eax
	add	rsp, 8
	ret

bin_write_module:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 184
	mov	qword ptr [rbp-0x38], 0
	xor	eax, eax
	push	rdi
	push	rcx
	lea	rdi, [rbp-0x70]
	mov	ecx, 48
	rep stosb
	pop	rcx
	pop	rdi
	mov	byte ptr [rbp-0x70], 1
	mov	rdi, qword ptr [SymTables+0x20+rip]
$_298:	test	rdi, rdi
	jz	$_300
	mov	rsi, qword ptr [rdi+0x68]
	mov	dword ptr [rsi+0xC], 0
	cmp	byte ptr [rsi+0x72], 5
	jnz	$_299
	mov	dword ptr [rsi+0x48], 4
$_299:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_298

$_300:
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 1
	jnz	$_301
	xor	ecx, ecx
	call	$_019
	mov	word ptr [rbp-0x2A], ax
	shl	eax, 2
	movzx	edx, word ptr [ModuleInfo+0x1E4+rip]
	add	eax, edx
	movzx	edx, word ptr [ModuleInfo+0x1E6+rip]
	dec	edx
	add	eax, edx
	mov	ecx, edx
	not	ecx
	and	eax, ecx
	jmp	$_302

$_301:	xor	eax, eax
$_302:	mov	dword ptr [rbp-0x68], eax
	mov	dword ptr [rbp-0x6C], eax
	test	eax, eax
	jz	$_303
	mov	ecx, eax
	call	LclAlloc@PLT
	mov	qword ptr [rbp-0x40], rax
$_303:	mov	dword ptr [rbp-0x64], -1
	mov	dword ptr [rbp-0x54], 0
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jz	$_304
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jnz	$_306
$_304:	cmp	byte ptr [ModuleInfo+0x1B5+rip], 0
	jnz	$_305
	mov	ecx, 2013
	call	asmerr@PLT
	jmp	$_358

$_305:	lea	rcx, [rbp-0x70]
	call	$_234
	jmp	$_315

$_306:	cmp	byte ptr [ModuleInfo+0x1BA+rip], 1
	jnz	$_312
	xor	ebx, ebx
$_307:	cmp	ebx, 6
	jnc	$_311
	mov	rdi, qword ptr [SymTables+0x20+rip]
$_308:	test	rdi, rdi
	jz	$_310
	mov	rsi, qword ptr [rdi+0x68]
	lea	rcx, [dosseg_order+rip]
	mov	eax, dword ptr [rcx+rbx*4]
	cmp	dword ptr [rsi+0x48], eax
	jnz	$_309
	lea	rdx, [rbp-0x70]
	mov	rcx, rdi
	call	$_001
$_309:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_308

$_310:	inc	ebx
	jmp	$_307

$_311:	xor	ecx, ecx
	call	SortSegments@PLT
	jmp	$_315

$_312:	cmp	byte ptr [ModuleInfo+0x1BA+rip], 2
	jnz	$_313
	mov	ecx, 1
	call	SortSegments@PLT
$_313:	mov	rdi, qword ptr [SymTables+0x20+rip]
$_314:	test	rdi, rdi
	jz	$_315
	lea	rdx, [rbp-0x70]
	mov	rcx, rdi
	call	$_001
	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_314

$_315:	mov	rdi, qword ptr [SymTables+0x20+rip]
$_316:	test	rdi, rdi
	jz	$_318
	lea	rdx, [rbp-0x70]
	mov	rcx, rdi
	call	$_047
	mov	rsi, qword ptr [rdi+0x68]
	cmp	qword ptr [rbp-0x38], 0
	jnz	$_317
	cmp	byte ptr [rsi+0x72], 5
	jnz	$_317
	mov	qword ptr [rbp-0x38], rdi
$_317:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_316

$_318:	cmp	dword ptr [ModuleInfo+rip], 0
	jz	$_319
	mov	rax, -1
	jmp	$_358

$_319:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 0
	jnz	$_321
	cmp	qword ptr [ModuleInfo+0xE0+rip], 0
	jz	$_321
	mov	rax, qword ptr [ModuleInfo+0xE0+rip]
	cmp	dword ptr [rbp-0x64], -1
	jz	$_320
	mov	rax, qword ptr [rax+0x30]
	cmp	qword ptr [rbp-0x60], rax
	jz	$_321
$_320:	mov	ecx, 3003
	call	asmerr@PLT
	jmp	$_358

$_321:	xor	ecx, ecx
	call	$_035
	mov	dword ptr [rbp-0x10], eax
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 1
	jne	$_334
	mov	rdi, qword ptr [rbp-0x40]
	mov	word ptr [rdi], 23117
	mov	ecx, 512
	mov	eax, dword ptr [rbp-0x10]
	cdq
	div	ecx
	mov	word ptr [rdi+0x2], dx
	test	edx, edx
	jz	$_322
	inc	eax
$_322:	mov	word ptr [rdi+0x4], ax
	mov	ax, word ptr [rbp-0x2A]
	mov	word ptr [rdi+0x6], ax
	mov	eax, dword ptr [rbp-0x68]
	shr	eax, 4
	mov	word ptr [rdi+0x8], ax
	mov	ecx, 1
	call	$_035
	sub	eax, dword ptr [rbp-0x10]
	mov	dword ptr [rbp-0x1C], eax
	mov	edx, eax
	shr	eax, 4
	and	edx, 0x0F
	jz	$_323
	inc	eax
$_323:	mov	word ptr [rdi+0xA], ax
	cmp	ax, word ptr [ModuleInfo+0x1E8+rip]
	jnc	$_324
	mov	ax, word ptr [ModuleInfo+0x1E8+rip]
	mov	word ptr [rdi+0xA], ax
$_324:	mov	ax, word ptr [ModuleInfo+0x1EA+rip]
	mov	word ptr [rdi+0xC], ax
	cmp	ax, word ptr [rdi+0xA]
	jnc	$_325
	mov	ax, word ptr [rdi+0xA]
	mov	word ptr [rdi+0xC], ax
$_325:	cmp	qword ptr [rbp-0x38], 0
	jz	$_328
	mov	rcx, qword ptr [rbp-0x38]
	mov	rsi, qword ptr [rcx+0x68]
	mov	eax, dword ptr [rsi+0xC]
	cmp	qword ptr [rsi], 0
	jz	$_326
	mov	rdx, qword ptr [rsi]
	add	eax, dword ptr [rdx+0x28]
$_326:	xor	edx, edx
	test	eax, 0xF
	jz	$_327
	inc	edx
$_327:	shr	eax, 4
	add	eax, edx
	mov	word ptr [rdi+0xE], ax
	mov	eax, dword ptr [rcx+0x50]
	mov	word ptr [rdi+0x10], ax
	jmp	$_329

$_328:	mov	ecx, 8010
	call	asmerr@PLT
$_329:
	mov	word ptr [rdi+0x12], 0
	cmp	qword ptr [ModuleInfo+0xE0+rip], 0
	jz	$_332
	mov	rcx, qword ptr [ModuleInfo+0xE0+rip]
	mov	rdx, qword ptr [rcx+0x30]
	mov	rsi, qword ptr [rdx+0x68]
	cmp	qword ptr [rsi], 0
	jz	$_330
	mov	rax, qword ptr [rsi]
	mov	eax, dword ptr [rax+0x28]
	mov	edx, eax
	shr	edx, 4
	and	eax, 0x0F
	add	eax, dword ptr [rsi+0xC]
	add	eax, dword ptr [rcx+0x28]
	mov	word ptr [rdi+0x14], ax
	mov	word ptr [rdi+0x16], dx
	jmp	$_331

$_330:	mov	eax, dword ptr [rsi+0xC]
	mov	edx, eax
	shr	edx, 4
	and	eax, 0x0F
	add	eax, dword ptr [rcx+0x28]
	mov	word ptr [rdi+0x14], ax
	mov	word ptr [rdi+0x16], dx
$_331:	jmp	$_333

$_332:	mov	ecx, 8009
	call	asmerr@PLT
$_333:	mov	ax, word ptr [ModuleInfo+0x1E4+rip]
	mov	word ptr [rdi+0x18], ax
	add	rax, qword ptr [rbp-0x40]
	mov	rcx, rax
	call	$_019
$_334:	cmp	qword ptr [ModuleInfo+0x80+rip], 0
	jz	$_335
	mov	edx, 2
	xor	esi, esi
	mov	rdi, qword ptr [ModuleInfo+0x80+rip]
	call	fseek@PLT
	call	LstNL@PLT
	call	LstNL@PLT
	lea	rcx, [DS0030+rip]
	call	LstPrintf@PLT
	call	LstNL@PLT
	call	LstNL@PLT
	lea	rcx, [DS0031+rip]
	call	LstPrintf@PLT
	call	LstNL@PLT
	lea	rcx, [DS0032+rip]
	call	LstPrintf@PLT
	call	LstNL@PLT
$_335:	cmp	dword ptr [rbp-0x68], 0
	jz	$_337
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, dword ptr [rbp-0x68]
	mov	esi, 1
	mov	rdi, qword ptr [rbp-0x40]
	call	fwrite@PLT
	cmp	eax, dword ptr [rbp-0x68]
	jz	$_336
	call	WriteError@PLT
$_336:	mov	qword ptr [rsp+0x28], 0
	mov	eax, dword ptr [rbp-0x68]
	mov	dword ptr [rsp+0x20], eax
	xor	r9d, r9d
	xor	r8d, r8d
	lea	rdx, [DS0034+rip]
	lea	rcx, [DS0033+rip]
	call	LstPrintf@PLT
	call	LstNL@PLT
$_337:	mov	rdi, qword ptr [SymTables+0x20+rip]
	mov	dword ptr [rbp-0x18], 1
$_338:	test	rdi, rdi
	je	$_351
	mov	rsi, qword ptr [rdi+0x68]
	cmp	dword ptr [rsi+0x48], 5
	je	$_350
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jz	$_339
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jnz	$_342
$_339:	cmp	dword ptr [rsi+0x48], 3
	jz	$_340
	cmp	byte ptr [rsi+0x6C], 0
	jz	$_342
$_340:	xor	eax, eax
	cmp	byte ptr [rsi+0x6C], 0
	jz	$_341
	jmp	$_350

$_341:	jmp	$_343

$_342:	mov	eax, dword ptr [rdi+0x50]
	cmp	dword ptr [rbp-0x18], 0
	jz	$_343
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 0
	jnz	$_343
	sub	eax, dword ptr [rsi+0x8]
$_343:	mov	dword ptr [rbp-0xC], eax
	cmp	dword ptr [rbp-0x18], 0
	jnz	$_344
	mov	eax, dword ptr [rdi+0x50]
$_344:	mov	dword ptr [rbp-0x30], eax
	cmp	dword ptr [rsi+0x18], 0
	jnz	$_347
	mov	rdx, qword ptr [rdi+0x70]
$_345:	test	rdx, rdx
	jz	$_346
	mov	rcx, qword ptr [rdx+0x68]
	cmp	dword ptr [rcx+0x18], 0
	jnz	$_346
	mov	rdx, qword ptr [rdx+0x70]
	jmp	$_345

$_346:	test	rdx, rdx
	jnz	$_347
	mov	dword ptr [rbp-0xC], edx
$_347:	mov	ecx, dword ptr [rsi+0xC]
	cmp	dword ptr [rbp-0x18], 0
	jz	$_348
	add	ecx, dword ptr [rsi+0x8]
$_348:	mov	eax, dword ptr [rbp-0x30]
	mov	dword ptr [rsp+0x28], eax
	mov	eax, dword ptr [rbp-0xC]
	mov	dword ptr [rsp+0x20], eax
	mov	r9d, ecx
	mov	r8d, dword ptr [rsi+0x38]
	mov	rdx, qword ptr [rdi+0x8]
	lea	rcx, [DS0033+rip]
	call	LstPrintf@PLT
	call	LstNL@PLT
	cmp	dword ptr [rbp-0xC], 0
	jz	$_349
	cmp	qword ptr [rsi+0x10], 0
	jz	$_349
	mov	qword ptr [rbp-0x78], rdi
	mov	qword ptr [rbp-0x80], rsi
	xor	edx, edx
	mov	esi, dword ptr [rsi+0x38]
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fseek@PLT
	mov	rdi, qword ptr [rbp-0x80]
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, dword ptr [rbp-0xC]
	mov	esi, 1
	mov	rdi, qword ptr [rdi+0x10]
	call	fwrite@PLT
	mov	rsi, qword ptr [rbp-0x80]
	mov	rdi, qword ptr [rbp-0x78]
	cmp	eax, dword ptr [rbp-0xC]
	jz	$_349
	call	WriteError@PLT
$_349:	mov	dword ptr [rbp-0x18], 0
$_350:	mov	rdi, qword ptr [rdi+0x70]
	jmp	$_338

$_351:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jz	$_352
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jnz	$_353
$_352:	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	ftell@PLT
	mov	dword ptr [rbp-0xC], eax
	mov	eax, dword ptr [rbp-0x48]
	dec	eax
	test	dword ptr [rbp-0xC], eax
	jz	$_353
	lea	ecx, [rax+0x1]
	and	eax, dword ptr [rbp-0xC]
	sub	ecx, eax
	mov	dword ptr [rbp-0xC], ecx
	mov	eax, ecx
	add	eax, 15
	and	eax, 0xFFFFFFF0
	sub	rsp, rax
	lea	rax, [rsp+0x30]
	mov	r8d, dword ptr [rbp-0xC]
	xor	edx, edx
	mov	rcx, rax
	call	tmemset@PLT
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, dword ptr [rbp-0xC]
	mov	esi, 1
	mov	rdi, rax
	call	fwrite@PLT
$_353:	lea	rcx, [DS0032+rip]
	call	LstPrintf@PLT
	call	LstNL@PLT
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 1
	jnz	$_354
	mov	eax, dword ptr [rbp-0x10]
	sub	eax, dword ptr [rbp-0x68]
	add	dword ptr [rbp-0x1C], eax
	jmp	$_357

$_354:	cmp	byte ptr [ModuleInfo+0x1B8+rip], 2
	jz	$_355
	cmp	byte ptr [ModuleInfo+0x1B8+rip], 3
	jnz	$_356
$_355:	mov	eax, dword ptr [rbp-0x54]
	mov	dword ptr [rbp-0x1C], eax
	jmp	$_357

$_356:	mov	ecx, 1
	call	$_035
	mov	dword ptr [rbp-0x1C], eax
$_357:	mov	r9d, dword ptr [rbp-0x1C]
	mov	r8d, dword ptr [rbp-0x10]
	lea	rdx, [DS0036+rip]
	lea	rcx, [DS0035+rip]
	call	LstPrintf@PLT
	call	LstNL@PLT
	xor	eax, eax
$_358:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

bin_check_external:
	sub	rsp, 40
	mov	rdx, qword ptr [SymTables+0x10+rip]
$_359:	test	rdx, rdx
	jz	$_362
	test	byte ptr [rdx+0x3B], 0x02
	jz	$_360
	test	byte ptr [rdx+0x14], 0x01
	jz	$_361
$_360:	test	byte ptr [rdx+0x16], 0x10
	jnz	$_361
	mov	rdx, qword ptr [rdx+0x8]
	mov	ecx, 2014
	call	asmerr@PLT
	jmp	$_363

$_361:	mov	rdx, qword ptr [rdx+0x70]
	jmp	$_359

$_362:	xor	eax, eax
$_363:	add	rsp, 40
	ret

bin_init:
	push	rsi
	push	rdi
	push	rbx
	lea	rax, [bin_write_module+rip]
	mov	qword ptr [ModuleInfo+0x158+rip], rax
	lea	rax, [bin_check_external+rip]
	mov	qword ptr [ModuleInfo+0x168+rip], rax
	mov	al, byte ptr [ModuleInfo+0x1B8+rip]
	jmp	$_366

$_364:	lea	rdi, [ModuleInfo+0x1E4+rip]
	lea	rsi, [mzdata+rip]
	mov	ecx, 8
	rep movsb
	jmp	$_367

$_365:	lea	rax, [pe_enddirhook+rip]
	mov	qword ptr [ModuleInfo+0x160+rip], rax
	jmp	$_367

$_366:	cmp	al, 1
	jz	$_364
	cmp	al, 2
	jz	$_365
	cmp	al, 3
	jz	$_365
$_367:	pop	rbx
	pop	rdi
	pop	rsi
	ret


.SECTION .data
	.ALIGN	16

mzdata:
	.byte  0x1E, 0x00, 0x10, 0x00, 0x00, 0x00, 0xFF, 0xFF

dosseg_order:
	.byte  0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
	.byte  0x04, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00

flat_order:
	.byte  0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte  0x07, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
	.byte  0x03, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00
	.byte  0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

pe32def:
	.byte  0x50, 0x45, 0x00, 0x00, 0x4C, 0x01, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0xE0, 0x00, 0x0F, 0x01
	.byte  0x0B, 0x01, 0x05, 0x01, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF
	.byte  0x00, 0x10, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00
	.byte  0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x00
	.byte  0x00, 0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00
	.zero  128 * 1

pe64def:
	.byte  0x50, 0x45, 0x00, 0x00, 0x64, 0x86, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0xF0, 0x00, 0x2F, 0x01
	.byte  0x0B, 0x02, 0x05, 0x01, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x10, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00
	.byte  0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00
	.zero  128 * 1

DS0000:
	.byte  0x2E, 0x68, 0x64, 0x72, 0x24, 0x31, 0x00

DS0001:
	.byte  0x6F, 0x70, 0x74, 0x69, 0x6F, 0x6E, 0x20, 0x64
	.byte  0x6F, 0x74, 0x6E, 0x61, 0x6D, 0x65, 0x0A, 0x49
	.byte  0x4D, 0x41, 0x47, 0x45, 0x5F, 0x44, 0x4F, 0x53
	.byte  0x5F, 0x48, 0x45, 0x41, 0x44, 0x45, 0x52, 0x20
	.byte  0x53, 0x54, 0x52, 0x55, 0x43, 0x0A, 0x65, 0x5F
	.byte  0x6D, 0x61, 0x67, 0x69, 0x63, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x64, 0x77
	.byte  0x20, 0x3F, 0x0A, 0x65, 0x5F, 0x63, 0x62, 0x6C
	.byte  0x70, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x64, 0x77, 0x20, 0x3F, 0x0A
	.byte  0x65, 0x5F, 0x63, 0x70, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x64, 0x77, 0x20, 0x3F, 0x0A, 0x65, 0x5F, 0x63
	.byte  0x72, 0x6C, 0x63, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x64, 0x77, 0x20
	.byte  0x3F, 0x0A, 0x65, 0x5F, 0x63, 0x70, 0x61, 0x72
	.byte  0x68, 0x64, 0x72, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x64, 0x77, 0x20, 0x3F, 0x0A, 0x65
	.byte  0x5F, 0x6D, 0x69, 0x6E, 0x61, 0x6C, 0x6C, 0x6F
	.byte  0x63, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x64
	.byte  0x77, 0x20, 0x3F, 0x0A, 0x65, 0x5F, 0x6D, 0x61
	.byte  0x78, 0x61, 0x6C, 0x6C, 0x6F, 0x63, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x64, 0x77, 0x20, 0x3F
	.byte  0x0A, 0x65, 0x5F, 0x73, 0x73, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x64, 0x77, 0x20, 0x3F, 0x0A, 0x65, 0x5F
	.byte  0x73, 0x70, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x64, 0x77
	.byte  0x20, 0x3F, 0x0A, 0x65, 0x5F, 0x63, 0x73, 0x75
	.byte  0x6D, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x64, 0x77, 0x20, 0x3F, 0x0A
	.byte  0x65, 0x5F, 0x69, 0x70, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x64, 0x77, 0x20, 0x3F, 0x0A, 0x65, 0x5F, 0x63
	.byte  0x73, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x64, 0x77, 0x20
	.byte  0x3F, 0x0A, 0x65, 0x5F, 0x6C, 0x66, 0x61, 0x72
	.byte  0x6C, 0x63, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x64, 0x77, 0x20, 0x3F, 0x0A, 0x65
	.byte  0x5F, 0x6F, 0x76, 0x6E, 0x6F, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x64
	.byte  0x77, 0x20, 0x3F, 0x0A, 0x65, 0x5F, 0x72, 0x65
	.byte  0x73, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x64, 0x77, 0x20, 0x34
	.byte  0x20, 0x64, 0x75, 0x70, 0x28, 0x3F, 0x29, 0x0A
	.byte  0x65, 0x5F, 0x6F, 0x65, 0x6D, 0x69, 0x64, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x64, 0x77, 0x20, 0x3F, 0x0A, 0x65, 0x5F, 0x6F
	.byte  0x65, 0x6D, 0x69, 0x6E, 0x66, 0x6F, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x64, 0x77, 0x20
	.byte  0x3F, 0x0A, 0x65, 0x5F, 0x72, 0x65, 0x73, 0x32
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x64, 0x77, 0x20, 0x31, 0x30, 0x20
	.byte  0x64, 0x75, 0x70, 0x28, 0x3F, 0x29, 0x0A, 0x65
	.byte  0x5F, 0x6C, 0x66, 0x61, 0x6E, 0x65, 0x77, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x64
	.byte  0x64, 0x20, 0x3F, 0x0A, 0x49, 0x4D, 0x41, 0x47
	.byte  0x45, 0x5F, 0x44, 0x4F, 0x53, 0x5F, 0x48, 0x45
	.byte  0x41, 0x44, 0x45, 0x52, 0x20, 0x45, 0x4E, 0x44
	.byte  0x53, 0x0A, 0x25, 0x73, 0x31, 0x20, 0x73, 0x65
	.byte  0x67, 0x6D, 0x65, 0x6E, 0x74, 0x20, 0x55, 0x53
	.byte  0x45, 0x31, 0x36, 0x20, 0x77, 0x6F, 0x72, 0x64
	.byte  0x20, 0x25, 0x73, 0x0A, 0x49, 0x4D, 0x41, 0x47
	.byte  0x45, 0x5F, 0x44, 0x4F, 0x53, 0x5F, 0x48, 0x45
	.byte  0x41, 0x44, 0x45, 0x52, 0x20, 0x7B, 0x20, 0x30
	.byte  0x78, 0x35, 0x41, 0x34, 0x44, 0x2C, 0x20, 0x30
	.byte  0x78, 0x36, 0x38, 0x2C, 0x20, 0x31, 0x2C, 0x20
	.byte  0x30, 0x2C, 0x20, 0x34, 0x2C, 0x20, 0x30, 0x2C
	.byte  0x20, 0x2D, 0x31, 0x2C, 0x20, 0x30, 0x2C, 0x20
	.byte  0x30, 0x78, 0x42, 0x38, 0x2C, 0x20, 0x30, 0x2C
	.byte  0x20, 0x30, 0x2C, 0x20, 0x30, 0x2C, 0x20, 0x30
	.byte  0x78, 0x34, 0x30, 0x20, 0x7D, 0x0A, 0x70, 0x75
	.byte  0x73, 0x68, 0x20, 0x63, 0x73, 0x0A, 0x70, 0x6F
	.byte  0x70, 0x20, 0x64, 0x73, 0x0A, 0x6D, 0x6F, 0x76
	.byte  0x20, 0x64, 0x78, 0x2C, 0x40, 0x46, 0x2D, 0x34
	.byte  0x30, 0x68, 0x0A, 0x6D, 0x6F, 0x76, 0x20, 0x61
	.byte  0x68, 0x2C, 0x39, 0x0A, 0x69, 0x6E, 0x74, 0x20
	.byte  0x32, 0x31, 0x68, 0x0A, 0x6D, 0x6F, 0x76, 0x20
	.byte  0x61, 0x78, 0x2C, 0x34, 0x43, 0x30, 0x31, 0x68
	.byte  0x0A, 0x69, 0x6E, 0x74, 0x20, 0x32, 0x31, 0x68
	.byte  0x0A, 0x40, 0x40, 0x3A, 0x0A, 0x64, 0x62, 0x20
	.byte  0x27, 0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73
	.byte  0x20, 0x61, 0x20, 0x50, 0x45, 0x20, 0x65, 0x78
	.byte  0x65, 0x63, 0x75, 0x74, 0x61, 0x62, 0x6C, 0x65
	.byte  0x27, 0x2C, 0x30, 0x44, 0x68, 0x2C, 0x30, 0x41
	.byte  0x68, 0x2C, 0x27, 0x24, 0x27, 0x0A, 0x25, 0x73
	.byte  0x31, 0x20, 0x65, 0x6E, 0x64, 0x73, 0x00

DS0002:
	.byte  0x2E, 0x68, 0x64, 0x72, 0x24, 0x00

DS0003:
	.byte  0x72, 0x65, 0x61, 0x64, 0x20, 0x70, 0x75, 0x62
	.byte  0x6C, 0x69, 0x63, 0x20, 0x27, 0x48, 0x44, 0x52
	.byte  0x27, 0x00

DS0004:
	.byte  0x2E, 0x68, 0x64, 0x72, 0x24, 0x32, 0x00

DS0005:
	.byte  0x48, 0x44, 0x52, 0x00

DS0006:
	.byte  0x40, 0x70, 0x65, 0x5F, 0x66, 0x69, 0x6C, 0x65
	.byte  0x5F, 0x66, 0x6C, 0x61, 0x67, 0x73, 0x00

DS0007:
	.byte  0x2E, 0x68, 0x64, 0x72, 0x24, 0x33, 0x00

DS0008:
	.byte  0x43, 0x4F, 0x4E, 0x53, 0x54, 0x00

DS0009:
	.byte  0x2E, 0x72, 0x73, 0x72, 0x63, 0x00

DS000A:
	.byte  0x2E, 0x72, 0x65, 0x6C, 0x6F, 0x63, 0x00

DS000B:
	.byte  0x6F, 0x70, 0x74, 0x69, 0x6F, 0x6E, 0x20, 0x64
	.byte  0x6F, 0x74, 0x6E, 0x61, 0x6D, 0x65, 0x0A, 0x25
	.byte  0x73, 0x20, 0x73, 0x65, 0x67, 0x6D, 0x65, 0x6E
	.byte  0x74, 0x20, 0x64, 0x77, 0x6F, 0x72, 0x64, 0x20
	.byte  0x25, 0x73, 0x0A, 0x44, 0x44, 0x20, 0x30, 0x2C
	.byte  0x20, 0x30, 0x25, 0x78, 0x68, 0x2C, 0x20, 0x30
	.byte  0x2C, 0x20, 0x69, 0x6D, 0x61, 0x67, 0x65, 0x72
	.byte  0x65, 0x6C, 0x20, 0x40, 0x25, 0x73, 0x5F, 0x6E
	.byte  0x61, 0x6D, 0x65, 0x2C, 0x20, 0x25, 0x75, 0x2C
	.byte  0x20, 0x25, 0x75, 0x2C, 0x20, 0x25, 0x75, 0x2C
	.byte  0x20, 0x69, 0x6D, 0x61, 0x67, 0x65, 0x72, 0x65
	.byte  0x6C, 0x20, 0x40, 0x25, 0x73, 0x5F, 0x66, 0x75
	.byte  0x6E, 0x63, 0x2C, 0x20, 0x69, 0x6D, 0x61, 0x67
	.byte  0x65, 0x72, 0x65, 0x6C, 0x20, 0x40, 0x25, 0x73
	.byte  0x5F, 0x6E, 0x61, 0x6D, 0x65, 0x73, 0x2C, 0x20
	.byte  0x69, 0x6D, 0x61, 0x67, 0x65, 0x72, 0x65, 0x6C
	.byte  0x20, 0x40, 0x25, 0x73, 0x5F, 0x6E, 0x61, 0x6D
	.byte  0x65, 0x6F, 0x72, 0x64, 0x00

DS000C:
	.byte  0x2E, 0x65, 0x64, 0x61, 0x74, 0x61, 0x00

DS000D:
	.byte  0x46, 0x4C, 0x41, 0x54, 0x20, 0x72, 0x65, 0x61
	.byte  0x64, 0x20, 0x70, 0x75, 0x62, 0x6C, 0x69, 0x63
	.byte  0x20, 0x61, 0x6C, 0x69, 0x61, 0x73, 0x28, 0x27
	.byte  0x2E, 0x72, 0x64, 0x61, 0x74, 0x61, 0x27, 0x29
	.byte  0x20, 0x27, 0x44, 0x41, 0x54, 0x41, 0x27, 0x00

DS000E:
	.byte  0x40, 0x25, 0x73, 0x5F, 0x66, 0x75, 0x6E, 0x63
	.byte  0x20, 0x6C, 0x61, 0x62, 0x65, 0x6C, 0x20, 0x64
	.byte  0x77, 0x6F, 0x72, 0x64, 0x00

DS000F:
	.byte  0x64, 0x64, 0x20, 0x69, 0x6D, 0x61, 0x67, 0x65
	.byte  0x72, 0x65, 0x6C, 0x20, 0x25, 0x73, 0x00

DS0010:
	.byte  0x40, 0x25, 0x73, 0x5F, 0x6E, 0x61, 0x6D, 0x65
	.byte  0x73, 0x20, 0x6C, 0x61, 0x62, 0x65, 0x6C, 0x20
	.byte  0x64, 0x77, 0x6F, 0x72, 0x64, 0x00

DS0011:
	.byte  0x64, 0x64, 0x20, 0x69, 0x6D, 0x61, 0x67, 0x65
	.byte  0x72, 0x65, 0x6C, 0x20, 0x40, 0x25, 0x73, 0x00

DS0012:
	.byte  0x40, 0x25, 0x73, 0x5F, 0x6E, 0x61, 0x6D, 0x65
	.byte  0x6F, 0x72, 0x64, 0x20, 0x6C, 0x61, 0x62, 0x65
	.byte  0x6C, 0x20, 0x77, 0x6F, 0x72, 0x64, 0x00

DS0013:
	.byte  0x64, 0x77, 0x20, 0x25, 0x75, 0x00

DS0014:
	.byte  0x40, 0x25, 0x73, 0x5F, 0x6E, 0x61, 0x6D, 0x65
	.byte  0x20, 0x64, 0x62, 0x20, 0x27, 0x25, 0x73, 0x27
	.byte  0x2C, 0x30, 0x00

DS0015:
	.byte  0x40, 0x25, 0x73, 0x20, 0x64, 0x62, 0x20, 0x27
	.byte  0x25, 0x73, 0x27, 0x2C, 0x30, 0x00

DS0016:
	.byte  0x25, 0x73, 0x20, 0x65, 0x6E, 0x64, 0x73, 0x00

DS0017:
	.byte  0x41, 0x4C, 0x49, 0x47, 0x4E, 0x28, 0x38, 0x29
	.byte  0x00

DS0018:
	.byte  0x41, 0x4C, 0x49, 0x47, 0x4E, 0x28, 0x34, 0x29
	.byte  0x00

DS0019:
	.byte  0x40, 0x4C, 0x50, 0x50, 0x52, 0x4F, 0x43, 0x20
	.byte  0x74, 0x79, 0x70, 0x65, 0x64, 0x65, 0x66, 0x20
	.byte  0x70, 0x74, 0x72, 0x20, 0x70, 0x72, 0x6F, 0x63
	.byte  0x0A, 0x6F, 0x70, 0x74, 0x69, 0x6F, 0x6E, 0x20
	.byte  0x64, 0x6F, 0x74, 0x6E, 0x61, 0x6D, 0x65, 0x00

DS001A:
	.byte  0x2E, 0x69, 0x64, 0x61, 0x74, 0x61, 0x24, 0x00

DS001B:
	.byte  0x25, 0x73, 0x32, 0x20, 0x73, 0x65, 0x67, 0x6D
	.byte  0x65, 0x6E, 0x74, 0x20, 0x64, 0x77, 0x6F, 0x72
	.byte  0x64, 0x20, 0x25, 0x73, 0x0A, 0x64, 0x64, 0x20
	.byte  0x69, 0x6D, 0x61, 0x67, 0x65, 0x72, 0x65, 0x6C
	.byte  0x20, 0x40, 0x25, 0x73, 0x5F, 0x69, 0x6C, 0x74
	.byte  0x2C, 0x20, 0x30, 0x2C, 0x20, 0x30, 0x2C, 0x20
	.byte  0x69, 0x6D, 0x61, 0x67, 0x65, 0x72, 0x65, 0x6C
	.byte  0x20, 0x40, 0x25, 0x73, 0x5F, 0x6E, 0x61, 0x6D
	.byte  0x65, 0x2C, 0x20, 0x69, 0x6D, 0x61, 0x67, 0x65
	.byte  0x72, 0x65, 0x6C, 0x20, 0x40, 0x25, 0x73, 0x5F
	.byte  0x69, 0x61, 0x74, 0x0A, 0x25, 0x73, 0x32, 0x20
	.byte  0x65, 0x6E, 0x64, 0x73, 0x0A, 0x25, 0x73, 0x34
	.byte  0x20, 0x73, 0x65, 0x67, 0x6D, 0x65, 0x6E, 0x74
	.byte  0x20, 0x25, 0x73, 0x20, 0x25, 0x73, 0x0A, 0x40
	.byte  0x25, 0x73, 0x5F, 0x69, 0x6C, 0x74, 0x20, 0x6C
	.byte  0x61, 0x62, 0x65, 0x6C, 0x20, 0x25, 0x72, 0x00

DS001C:
	.byte  0x40, 0x4C, 0x50, 0x50, 0x52, 0x4F, 0x43, 0x20
	.byte  0x69, 0x6D, 0x61, 0x67, 0x65, 0x72, 0x65, 0x6C
	.byte  0x20, 0x40, 0x25, 0x73, 0x5F, 0x6E, 0x61, 0x6D
	.byte  0x65, 0x00

DS001D:
	.byte  0x40, 0x4C, 0x50, 0x50, 0x52, 0x4F, 0x43, 0x20
	.byte  0x30, 0x0A, 0x25, 0x73, 0x34, 0x20, 0x65, 0x6E
	.byte  0x64, 0x73, 0x0A, 0x25, 0x73, 0x35, 0x20, 0x73
	.byte  0x65, 0x67, 0x6D, 0x65, 0x6E, 0x74, 0x20, 0x25
	.byte  0x73, 0x20, 0x25, 0x73, 0x0A, 0x40, 0x25, 0x73
	.byte  0x5F, 0x69, 0x61, 0x74, 0x20, 0x6C, 0x61, 0x62
	.byte  0x65, 0x6C, 0x20, 0x25, 0x72, 0x00

DS001E:
	.byte  0x25, 0x73, 0x25, 0x73, 0x20, 0x40, 0x4C, 0x50
	.byte  0x50, 0x52, 0x4F, 0x43, 0x20, 0x69, 0x6D, 0x61
	.byte  0x67, 0x65, 0x72, 0x65, 0x6C, 0x20, 0x40, 0x25
	.byte  0x73, 0x5F, 0x6E, 0x61, 0x6D, 0x65, 0x00

DS001F:
	.byte  0x40, 0x4C, 0x50, 0x50, 0x52, 0x4F, 0x43, 0x20
	.byte  0x30, 0x0A, 0x25, 0x73, 0x35, 0x20, 0x65, 0x6E
	.byte  0x64, 0x73, 0x0A, 0x25, 0x73, 0x36, 0x20, 0x73
	.byte  0x65, 0x67, 0x6D, 0x65, 0x6E, 0x74, 0x20, 0x77
	.byte  0x6F, 0x72, 0x64, 0x20, 0x25, 0x73, 0x00

DS0020:
	.byte  0x40, 0x25, 0x73, 0x5F, 0x6E, 0x61, 0x6D, 0x65
	.byte  0x20, 0x64, 0x77, 0x20, 0x30, 0x0A, 0x64, 0x62
	.byte  0x20, 0x27, 0x25, 0x73, 0x27, 0x2C, 0x30, 0x0A
	.byte  0x65, 0x76, 0x65, 0x6E, 0x00

DS0021:
	.byte  0x40, 0x25, 0x73, 0x5F, 0x6E, 0x61, 0x6D, 0x65
	.byte  0x20, 0x64, 0x62, 0x20, 0x27, 0x25, 0x73, 0x27
	.byte  0x2C, 0x30, 0x0A, 0x65, 0x76, 0x65, 0x6E, 0x0A
	.byte  0x25, 0x73, 0x36, 0x20, 0x65, 0x6E, 0x64, 0x73
	.byte  0x00

DS0022:
	.byte  0x25, 0x73, 0x33, 0x20, 0x73, 0x65, 0x67, 0x6D
	.byte  0x65, 0x6E, 0x74, 0x20, 0x64, 0x77, 0x6F, 0x72
	.byte  0x64, 0x20, 0x25, 0x73, 0x0A, 0x44, 0x44, 0x20
	.byte  0x30, 0x2C, 0x20, 0x30, 0x2C, 0x20, 0x30, 0x2C
	.byte  0x20, 0x30, 0x2C, 0x20, 0x30, 0x0A, 0x25, 0x73
	.byte  0x33, 0x20, 0x65, 0x6E, 0x64, 0x73, 0x00

DS0023:
	.byte  0x65, 0x61, 0x64, 0x64, 0x72, 0x65, 0x73, 0x73
	.byte  0x61, 0x77, 0x61, 0x72, 0x65, 0x00

DS0024:
	.byte  0x3A, 0x6E, 0x6F, 0x00

DS0025:
	.byte  0x79, 0x73, 0x74, 0x65, 0x6D, 0x3A, 0x00

DS0026:
	.byte  0x77, 0x69, 0x6E, 0x64, 0x6F, 0x77, 0x73, 0x00

DS0027:
	.byte  0x63, 0x6F, 0x6E, 0x73, 0x6F, 0x6C, 0x65, 0x00

DS0028:
	.byte  0x6E, 0x61, 0x74, 0x69, 0x76, 0x65, 0x00

DS0029:
	.byte  0x2E, 0x64, 0x72, 0x65, 0x63, 0x74, 0x76, 0x65
	.byte  0x00

DS002A:
	.byte  0x52, 0x45, 0x4C, 0x4F, 0x43, 0x00

DS002B:
	.byte  0x2E, 0x69, 0x64, 0x61, 0x74, 0x61, 0x24, 0x32
	.byte  0x00

DS002C:
	.byte  0x2E, 0x69, 0x64, 0x61, 0x74, 0x61, 0x24, 0x33
	.byte  0x00

DS002D:
	.byte  0x2E, 0x69, 0x64, 0x61, 0x74, 0x61, 0x24, 0x35
	.byte  0x00

DS002E:
	.byte  0x2E, 0x74, 0x6C, 0x73, 0x00

DS002F:
	.byte  0x2E, 0x70, 0x64, 0x61, 0x74, 0x61, 0x00

DS0030:
	.byte  0x42, 0x69, 0x6E, 0x61, 0x72, 0x79, 0x20, 0x4D
	.byte  0x61, 0x70, 0x3A, 0x00

DS0031:
	.byte  0x53, 0x65, 0x67, 0x6D, 0x65, 0x6E, 0x74, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	.byte  0x20, 0x50, 0x6F, 0x73, 0x28, 0x66, 0x69, 0x6C
	.byte  0x65, 0x29, 0x20, 0x20, 0x20, 0x20, 0x20, 0x52
	.byte  0x56, 0x41, 0x20, 0x20, 0x53, 0x69, 0x7A, 0x65
	.byte  0x28, 0x66, 0x69, 0x6C, 0x29, 0x20, 0x53, 0x69
	.byte  0x7A, 0x65, 0x28, 0x6D, 0x65, 0x6D, 0x29, 0x00

DS0032:
	.byte  0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D
	.byte  0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D
	.byte  0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D
	.byte  0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D
	.byte  0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D
	.byte  0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D
	.byte  0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D
	.byte  0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x00

DS0033:
	.byte  0x25, 0x2D, 0x32, 0x34, 0x73, 0x20, 0x25, 0x38
	.byte  0x58, 0x20, 0x25, 0x38, 0x58, 0x20, 0x25, 0x39
	.byte  0x58, 0x20, 0x25, 0x39, 0x58, 0x00

DS0034:
	.byte  0x3C, 0x68, 0x65, 0x61, 0x64, 0x65, 0x72, 0x3E
	.byte  0x00

DS0035:
	.byte  0x25, 0x2D, 0x34, 0x32, 0x73, 0x20, 0x25, 0x39
	.byte  0x58, 0x20, 0x25, 0x39, 0x58, 0x00

DS0036:
	.byte  0x20, 0x00


.att_syntax prefix
