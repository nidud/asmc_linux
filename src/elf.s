
.intel_syntax noprefix

.global elf_init

.extern GetSegIdx
.extern Mangle
.extern SymTables
.extern LclAlloc
.extern tstrcmp
.extern tstrcat
.extern tstrcpy
.extern tstrlen
.extern tmemset
.extern tmemcmp
.extern tmemcpy
.extern asmerr
.extern ModuleInfo
.extern WriteError
.extern fseek
.extern fwrite


.SECTION .text
	.ALIGN	16

$_001:	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, qword ptr [rcx+0x8]
	lea	rdi, [cst+rip]
	xor	ebx, ebx
$_002:	cmp	ebx, 4
	jnc	$_005
	movzx	r8d, byte ptr [rdi]
	mov	rdx, qword ptr [rdi+0x8]
	mov	rcx, rsi
	call	tmemcmp@PLT
	test	rax, rax
	jnz	$_004
	movzx	edx, byte ptr [rdi]
	cmp	byte ptr [rsi+rdx], 0
	jnz	$_003
	mov	rax, qword ptr [rdi+0x10]
	jmp	$_006

	jmp	$_004

$_003:	test	byte ptr [rdi+0x1], 0x01
	jz	$_004
	cmp	byte ptr [rsi+rdx], 36
	jnz	$_004
	add	rsi, rdx
	mov	rdx, qword ptr [rdi+0x10]
	mov	rcx, qword ptr [rbp+0x30]
	call	tstrcpy@PLT
	mov	rdx, rsi
	mov	rcx, rax
	call	tstrcat@PLT
	jmp	$_006

$_004:	inc	ebx
	add	rdi, 24
	jmp	$_002

$_005:	mov	rax, rsi
$_006:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_007:
	sub	rsp, 8
	xor	eax, eax
	mov	rcx, qword ptr [SymTables+0x20+rip]
$_008:	test	rcx, rcx
	jz	$_010
	mov	rdx, qword ptr [rcx+0x68]
	cmp	qword ptr [rdx+0x28], 0
	jz	$_009
	inc	eax
$_009:	mov	rcx, qword ptr [rcx+0x70]
	jmp	$_008

$_010:
	add	rsp, 8
	ret

$_011:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 312
	mov	dword ptr [rbp-0x8], 1
	mov	rbx, rcx
	imul	esi, dword ptr [rbp+0x30], 16
	mov	dword ptr [rbx+0x28], esi
	mov	ecx, esi
	call	LclAlloc@PLT
	mov	qword ptr [rbx+0x30], rax
	mov	rdi, rax
	mov	ecx, esi
	xor	eax, eax
	mov	rdx, rdi
	rep stosb
	lea	rdi, [rdx+0x10]
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rdi], eax
	mov	rcx, qword ptr [rbx+0x8]
	call	tstrlen@PLT
	inc	rax
	add	dword ptr [rbp-0x8], eax
	mov	byte ptr [rdi+0xC], 4
	mov	word ptr [rdi+0xE], -15
	add	rdi, 16
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_012:	test	rsi, rsi
	jz	$_013
	mov	byte ptr [rdi+0xC], 3
	mov	rcx, qword ptr [rsi+0x30]
	call	GetSegIdx@PLT
	mov	word ptr [rdi+0xE], ax
	add	rdi, 16
	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_012

$_013:
	mov	rsi, qword ptr [rbp+0x38]
$_014:	test	rsi, rsi
	jz	$_020
	lea	rdx, [rbp-0x110]
	mov	rcx, qword ptr [rsi+0x8]
	call	Mangle@PLT
	lea	rbx, [rax+0x1]
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rdi], eax
	mov	rcx, qword ptr [rsi+0x8]
	mov	rdx, qword ptr [rcx+0x30]
	test	rdx, rdx
	jz	$_015
	mov	rax, qword ptr [rdx+0x68]
$_015:	test	rdx, rdx
	jz	$_016
	cmp	dword ptr [rax+0x48], 1
	jz	$_016
	mov	byte ptr [rdi+0xC], 1
	jmp	$_017

$_016:	mov	byte ptr [rdi+0xC], 2
$_017:	mov	eax, dword ptr [rcx+0x28]
	mov	dword ptr [rdi+0x4], eax
	test	rdx, rdx
	jz	$_018
	mov	rcx, rdx
	call	GetSegIdx@PLT
	mov	word ptr [rdi+0xE], ax
	jmp	$_019

$_018:
	mov	word ptr [rdi+0xE], -15
$_019:	add	dword ptr [rbp-0x8], ebx
	add	rdi, 16
	mov	rsi, qword ptr [rsi]
	jmp	$_014

$_020:
	mov	rsi, qword ptr [SymTables+0x10+rip]
$_021:	test	rsi, rsi
	jz	$_028
	test	byte ptr [rsi+0x3B], 0x01
	jnz	$_022
	test	byte ptr [rsi+0x3B], 0x02
	jnz	$_027
$_022:	lea	rdx, [rbp-0x110]
	mov	rcx, rsi
	call	Mangle@PLT
	lea	rbx, [rax+0x1]
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rdi], eax
	test	byte ptr [rsi+0x3B], 0x01
	jz	$_023
	mov	byte ptr [rdi+0xC], 21
	mov	eax, dword ptr [rsi+0x50]
	mov	dword ptr [rdi+0x4], eax
	mov	word ptr [rdi+0xE], -14
	jmp	$_026

$_023:	mov	rax, rsi
	test	byte ptr [rax+0x3B], 0x01
	jnz	$_024
	cmp	qword ptr [rax+0x58], 0
	jz	$_024
	mov	byte ptr [rdi+0xC], 32
	jmp	$_025

$_024:	mov	byte ptr [rdi+0xC], 16
$_025:	mov	eax, dword ptr [rsi+0x28]
	mov	dword ptr [rdi+0x4], eax
	mov	word ptr [rdi+0xE], 0
$_026:	add	dword ptr [rbp-0x8], ebx
	add	rdi, 16
$_027:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_021

$_028:
	mov	rsi, qword ptr [ModuleInfo+0x10+rip]
$_029:	test	rsi, rsi
	je	$_037
	mov	rbx, qword ptr [rsi+0x8]
	lea	rdx, [rbp-0x110]
	mov	rcx, rbx
	call	Mangle@PLT
	mov	dword ptr [rbp-0x4], eax
	mov	rbx, qword ptr [rbx+0x30]
	test	rbx, rbx
	jz	$_030
	mov	rcx, qword ptr [rbx+0x68]
$_030:	test	rbx, rbx
	jz	$_031
	cmp	dword ptr [rcx+0x48], 1
	jz	$_031
	mov	byte ptr [rdi+0xC], 17
	jmp	$_032

$_031:	mov	byte ptr [rdi+0xC], 18
$_032:	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rdi], eax
	mov	rcx, qword ptr [rsi+0x8]
	mov	eax, dword ptr [rcx+0x28]
	mov	dword ptr [rdi+0x4], eax
	cmp	byte ptr [rcx+0x18], 1
	jnz	$_035
	test	rbx, rbx
	jz	$_033
	mov	rcx, rbx
	call	GetSegIdx@PLT
	mov	word ptr [rdi+0xE], ax
	jmp	$_034

$_033:
	mov	word ptr [rdi+0xE], -15
$_034:	jmp	$_036

$_035:
	mov	word ptr [rdi+0xE], 0
$_036:	mov	eax, dword ptr [rbp-0x4]
	add	dword ptr [rbp-0x8], eax
	inc	dword ptr [rbp-0x8]
	add	rdi, 16
	mov	rsi, qword ptr [rsi]
	jmp	$_029

$_037:
	mov	eax, dword ptr [rbp-0x8]
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_038:
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 296
	mov	dword ptr [rbp-0x8], 1
	mov	rbx, rcx
	imul	esi, dword ptr [rbp+0x30], 24
	mov	dword ptr [rbx+0x28], esi
	mov	ecx, esi
	call	LclAlloc@PLT
	mov	qword ptr [rbx+0x30], rax
	mov	rdi, rax
	mov	rcx, rsi
	xor	eax, eax
	mov	rdx, rdi
	rep stosb
	lea	rdi, [rdx+0x18]
	mov	dword ptr [rdi], 1
	mov	rcx, qword ptr [rbx+0x8]
	call	tstrlen@PLT
	inc	rax
	add	dword ptr [rbp-0x8], eax
	mov	byte ptr [rdi+0x4], 4
	mov	word ptr [rdi+0x6], -15
	add	rdi, 24
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_039:	test	rsi, rsi
	jz	$_040
	mov	byte ptr [rdi+0x4], 3
	mov	rcx, qword ptr [rsi+0x30]
	call	GetSegIdx@PLT
	mov	word ptr [rdi+0x6], ax
	add	rdi, 24
	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_039

$_040:
	mov	rsi, qword ptr [rbp+0x38]
$_041:	test	rsi, rsi
	jz	$_047
	lea	rdx, [rbp-0x108]
	mov	rcx, qword ptr [rsi+0x8]
	call	Mangle@PLT
	lea	rbx, [rax+0x1]
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rdi], eax
	mov	rcx, qword ptr [rsi+0x8]
	mov	rdx, qword ptr [rcx+0x30]
	test	rdx, rdx
	jz	$_042
	mov	rax, qword ptr [rdx+0x68]
$_042:	test	rdx, rdx
	jz	$_043
	cmp	dword ptr [rax+0x48], 1
	jz	$_043
	mov	byte ptr [rdi+0x4], 1
	jmp	$_044

$_043:	mov	byte ptr [rdi+0x4], 2
$_044:	mov	eax, dword ptr [rcx+0x28]
	mov	dword ptr [rdi+0x8], eax
	test	edx, edx
	jz	$_045
	mov	rcx, rdx
	call	GetSegIdx@PLT
	mov	word ptr [rdi+0x6], ax
	jmp	$_046

$_045:
	mov	word ptr [rdi+0x6], -15
$_046:	add	dword ptr [rbp-0x8], ebx
	add	rdi, 24
	mov	rsi, qword ptr [rsi]
	jmp	$_041

$_047:
	mov	rsi, qword ptr [SymTables+0x10+rip]
$_048:	test	rsi, rsi
	jz	$_055
	test	byte ptr [rsi+0x3B], 0x01
	jnz	$_049
	test	byte ptr [rsi+0x3B], 0x02
	jnz	$_054
$_049:	lea	rdx, [rbp-0x108]
	mov	rcx, rsi
	call	Mangle@PLT
	lea	rbx, [rax+0x1]
	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rdi], eax
	test	byte ptr [rsi+0x3B], 0x01
	jz	$_050
	mov	byte ptr [rdi+0x4], 21
	mov	eax, dword ptr [rsi+0x50]
	mov	dword ptr [rdi+0x8], eax
	mov	word ptr [rdi+0x6], -14
	jmp	$_053

$_050:	mov	rax, rsi
	test	byte ptr [rax+0x3B], 0x01
	jnz	$_051
	cmp	qword ptr [rax+0x58], 0
	jz	$_051
	mov	byte ptr [rdi+0x4], 32
	jmp	$_052

$_051:	mov	byte ptr [rdi+0x4], 16
$_052:	mov	eax, dword ptr [rsi+0x28]
	mov	dword ptr [rdi+0x8], eax
	mov	word ptr [rdi+0x6], 0
$_053:	add	dword ptr [rbp-0x8], ebx
	add	rdi, 24
$_054:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_048

$_055:
	mov	rsi, qword ptr [ModuleInfo+0x10+rip]
$_056:	test	rsi, rsi
	je	$_064
	mov	rbx, qword ptr [rsi+0x8]
	lea	rdx, [rbp-0x108]
	mov	rcx, rbx
	call	Mangle@PLT
	mov	dword ptr [rbp-0x4], eax
	mov	rdx, qword ptr [rbx+0x30]
	test	rdx, rdx
	jz	$_057
	mov	rcx, qword ptr [rdx+0x68]
$_057:	test	rdx, rdx
	jz	$_058
	cmp	dword ptr [rcx+0x48], 1
	jz	$_058
	mov	byte ptr [rdi+0x4], 17
	jmp	$_059

$_058:	mov	byte ptr [rdi+0x4], 18
$_059:	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rdi], eax
	mov	eax, dword ptr [rbx+0x28]
	mov	dword ptr [rdi+0x8], eax
	cmp	byte ptr [rbx+0x18], 1
	jnz	$_062
	test	rdx, rdx
	jz	$_060
	mov	rcx, rdx
	call	GetSegIdx@PLT
	mov	word ptr [rdi+0x6], ax
	jmp	$_061

$_060:
	mov	word ptr [rdi+0x6], -15
$_061:	jmp	$_063

$_062:
	mov	word ptr [rdi+0x6], 0
$_063:	mov	eax, dword ptr [rbp-0x4]
	add	dword ptr [rbp-0x8], eax
	inc	dword ptr [rbp-0x8]
	add	rdi, 24
	mov	rsi, qword ptr [rsi]
	jmp	$_056

$_064:
	mov	eax, dword ptr [rbp-0x8]
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
	sub	rsp, 56
	mov	qword ptr [rbp-0x18], 0
	mov	qword ptr [rbp-0x10], 0
	mov	rbx, rcx
	mov	dword ptr [rbx], 2
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_066:	test	rsi, rsi
	jz	$_067
	mov	eax, dword ptr [rbx]
	mov	dword ptr [rsi+0x60], eax
	inc	dword ptr [rbx]
	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_066

$_067:
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_068:	test	rsi, rsi
	je	$_075
	mov	rcx, qword ptr [rsi+0x68]
	cmp	dword ptr [rcx+0x40], 0
	jz	$_074
	mov	rdi, qword ptr [rcx+0x28]
$_069:	test	rdi, rdi
	jz	$_074
	mov	rcx, qword ptr [rdi+0x30]
	test	byte ptr [rcx+0x14], 0x40
	jz	$_070
	mov	rax, qword ptr [rdi+0x20]
	mov	qword ptr [rdi+0x30], rax
	jmp	$_073

$_070:	cmp	byte ptr [rcx+0x18], 1
	jnz	$_073
	test	dword ptr [rcx+0x14], 0x4080
	jnz	$_073
	or	byte ptr [rcx+0x15], 0x40
	mov	ecx, 16
	call	LclAlloc@PLT
	mov	qword ptr [rax], 0
	mov	rcx, qword ptr [rdi+0x30]
	mov	qword ptr [rax+0x8], rcx
	cmp	qword ptr [rbp-0x10], 0
	jz	$_071
	mov	rdx, qword ptr [rbp-0x10]
	mov	qword ptr [rdx], rax
	mov	qword ptr [rbp-0x10], rax
	jmp	$_072

$_071:	mov	qword ptr [rbp-0x18], rax
	mov	qword ptr [rbp-0x10], rax
$_072:	mov	eax, dword ptr [rbx]
	mov	dword ptr [rcx+0x60], eax
	inc	dword ptr [rbx]
$_073:	mov	rdi, qword ptr [rdi+0x8]
	jmp	$_069

$_074:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_068

$_075:
	mov	eax, dword ptr [rbx]
	mov	dword ptr [rbx+0x4], eax
	mov	rcx, qword ptr [SymTables+0x10+rip]
$_076:	test	rcx, rcx
	jz	$_079
	test	byte ptr [rcx+0x3B], 0x01
	jnz	$_077
	test	byte ptr [rcx+0x3B], 0x02
	jz	$_077
	jmp	$_078

$_077:	mov	eax, dword ptr [rbx]
	mov	dword ptr [rcx+0x60], eax
	inc	dword ptr [rbx]
$_078:	mov	rcx, qword ptr [rcx+0x70]
	jmp	$_076

$_079:
	mov	rcx, qword ptr [ModuleInfo+0x10+rip]
$_080:	test	rcx, rcx
	jz	$_081
	mov	rdx, qword ptr [rcx+0x8]
	mov	eax, dword ptr [rbx]
	mov	dword ptr [rdx+0x60], eax
	inc	dword ptr [rbx]
	mov	rcx, qword ptr [rcx]
	jmp	$_080

$_081:
	mov	eax, dword ptr [rbx]
	mov	dword ptr [rbp-0x4], eax
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_082
	mov	r8, qword ptr [rbp-0x18]
	mov	edx, dword ptr [rbp-0x4]
	mov	rcx, rbx
	call	$_038
	mov	dword ptr [rbp-0x8], eax
	jmp	$_083

$_082:	mov	r8, qword ptr [rbp-0x18]
	mov	edx, dword ptr [rbp-0x4]
	mov	rcx, rbx
	call	$_011
	mov	dword ptr [rbp-0x8], eax
$_083:	mov	eax, dword ptr [rbp-0x8]
	mov	dword ptr [rbx+0x38], eax
	mov	ecx, dword ptr [rbp-0x8]
	call	LclAlloc@PLT
	mov	qword ptr [rbx+0x40], rax
	lea	rdi, [rax+0x1]
	mov	rsi, qword ptr [rbx+0x8]
	jmp	$_085

$_084:	movsb
$_085:	cmp	byte ptr [rsi], 0
	jnz	$_084
	movsb
	mov	rsi, qword ptr [rbp-0x18]
$_086:	test	rsi, rsi
	jz	$_087
	mov	rdx, rdi
	mov	rcx, qword ptr [rsi+0x8]
	call	Mangle@PLT
	lea	rdi, [rdi+rax+0x1]
	mov	rsi, qword ptr [rsi]
	jmp	$_086

$_087:
	mov	rsi, qword ptr [SymTables+0x10+rip]
$_088:	test	rsi, rsi
	jz	$_091
	test	byte ptr [rsi+0x3B], 0x01
	jnz	$_089
	test	byte ptr [rsi+0x3B], 0x02
	jz	$_089
	jmp	$_090

$_089:	mov	rdx, rdi
	mov	rcx, rsi
	call	Mangle@PLT
	lea	rdi, [rdi+rax+0x1]
$_090:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_088

$_091:
	mov	rsi, qword ptr [ModuleInfo+0x10+rip]
$_092:	test	rsi, rsi
	jz	$_093
	mov	rcx, qword ptr [rsi+0x8]
	mov	rdx, rdi
	call	Mangle@PLT
	lea	rdi, [rdi+rax+0x1]
	mov	rsi, qword ptr [rsi]
	jmp	$_092

$_093:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_094:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 296
	mov	dword ptr [rbp-0x4], 1
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_095:	test	rsi, rsi
	jz	$_100
	mov	rbx, qword ptr [rsi+0x68]
	cmp	qword ptr [rbx+0x60], 0
	jz	$_096
	mov	rdi, qword ptr [rbx+0x60]
	jmp	$_097

$_096:	lea	rdx, [rbp-0xFC]
	mov	rcx, rsi
	call	$_001
	mov	rdi, rax
$_097:	mov	rcx, rdi
	call	tstrlen@PLT
	add	dword ptr [rbp-0x4], eax
	inc	dword ptr [rbp-0x4]
	cmp	qword ptr [rbx+0x28], 0
	jz	$_099
	mov	rcx, rdi
	call	tstrlen@PLT
	add	dword ptr [rbp-0x4], eax
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_098
	add	dword ptr [rbp-0x4], 6
	jmp	$_099

$_098:	add	dword ptr [rbp-0x4], 5
$_099:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_095

$_100:
	lea	rdi, [internal_segparms+rip]
	xor	ebx, ebx
$_101:	cmp	ebx, 3
	jnc	$_102
	mov	rcx, qword ptr [rdi]
	call	tstrlen@PLT
	inc	eax
	add	dword ptr [rbp-0x4], eax
	inc	ebx
	add	rdi, 16
	jmp	$_101

$_102:
	mov	rbx, qword ptr [rbp+0x28]
	mov	eax, dword ptr [rbp-0x4]
	mov	dword ptr [rbx+0x18], eax
	mov	ecx, dword ptr [rbp-0x4]
	call	LclAlloc@PLT
	mov	qword ptr [rbx+0x20], rax
	mov	rdi, rax
	mov	byte ptr [rdi], 0
	inc	rdi
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_103:	test	rsi, rsi
	jz	$_106
	mov	rcx, qword ptr [rsi+0x68]
	cmp	qword ptr [rcx+0x60], 0
	jz	$_104
	mov	rax, qword ptr [rcx+0x60]
	jmp	$_105

$_104:	lea	rdx, [rbp-0xFC]
	mov	rcx, rsi
	call	$_001
$_105:	mov	rdx, rax
	mov	rcx, rdi
	call	tstrcpy@PLT
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdi, [rdi+rax+0x1]
	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_103

$_106:
	xor	esi, esi
$_107:	cmp	esi, 3
	jnc	$_108
	imul	ecx, esi, 16
	lea	rdx, [internal_segparms+rip]
	mov	rdx, qword ptr [rdx+rcx]
	mov	rcx, rdi
	call	tstrcpy@PLT
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdi, [rdi+rax+0x1]
	inc	esi
	jmp	$_107

$_108:
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_109:	test	rsi, rsi
	je	$_115
	mov	rcx, qword ptr [rsi+0x68]
	cmp	qword ptr [rcx+0x28], 0
	jz	$_114
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_110
	lea	rdx, [DS000B+rip]
	mov	rcx, rdi
	call	tstrcpy@PLT
	jmp	$_111

$_110:	lea	rdx, [DS000C+rip]
	mov	rcx, rdi
	call	tstrcpy@PLT
$_111:	mov	rcx, rdi
	call	tstrlen@PLT
	add	rdi, rax
	mov	rcx, qword ptr [rsi+0x68]
	cmp	qword ptr [rcx+0x60], 0
	jz	$_112
	mov	rax, qword ptr [rcx+0x60]
	jmp	$_113

$_112:	lea	rdx, [rbp-0xFC]
	mov	rcx, rsi
	call	$_001
$_113:	mov	rdx, rax
	mov	rcx, rdi
	call	tstrcpy@PLT
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdi, [rdi+rax+0x1]
$_114:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_109

$_115:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_116:
	mov	rcx, qword ptr [rax+0x68]
	xor	eax, eax
	mov	rcx, qword ptr [rcx+0x28]
$_117:	test	rcx, rcx
	jz	$_118
	mov	rcx, qword ptr [rcx+0x8]
	inc	eax
	jmp	$_117

$_118:
	ret

$_119:
	mov	rcx, qword ptr [rax+0x68]
	cmp	byte ptr [rcx+0x6A], -1
	jnz	$_120
	xor	eax, eax
	jmp	$_121

$_120:	mov	cl, byte ptr [rcx+0x6A]
	mov	eax, 1
	shl	eax, cl
$_121:	ret

$_122:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 72
	add	dword ptr [rbp+0x30], 15
	and	dword ptr [rbp+0x30], 0xFFFFFFF0
	mov	rcx, qword ptr [rbp+0x28]
	call	$_094
	mov	r8d, 40
	xor	edx, edx
	lea	rcx, [rbp-0x28]
	call	tmemset@PLT
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 40
	mov	esi, 1
	lea	rdi, [rbp-0x28]
	call	fwrite@PLT
	cmp	rax, 40
	jz	$_123
	call	WriteError@PLT
$_123:	mov	rbx, qword ptr [rbp+0x28]
	mov	rdi, qword ptr [rbx+0x20]
	inc	rdi
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_124:	test	rsi, rsi
	je	$_133
	mov	r8d, 40
	xor	edx, edx
	lea	rcx, [rbp-0x28]
	call	tmemset@PLT
	mov	rax, rdi
	sub	rax, qword ptr [rbx+0x20]
	mov	dword ptr [rbp-0x28], eax
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdi, [rdi+rax+0x1]
	mov	rcx, qword ptr [rsi+0x68]
	cmp	byte ptr [rcx+0x6C], 0
	jz	$_125
	mov	dword ptr [rbp-0x24], 7
	jmp	$_130

$_125:	cmp	dword ptr [rcx+0x48], 3
	jz	$_126
	mov	dword ptr [rbp-0x24], 1
	jmp	$_127

$_126:	mov	dword ptr [rbp-0x24], 8
$_127:	cmp	dword ptr [rcx+0x48], 1
	jnz	$_128
	mov	dword ptr [rbp-0x20], 6
	jmp	$_130

$_128:	cmp	byte ptr [rcx+0x6B], 1
	jnz	$_129
	mov	dword ptr [rbp-0x20], 2
	jmp	$_130

$_129:	mov	dword ptr [rbp-0x20], 3
	cmp	qword ptr [rcx+0x50], 0
	jz	$_130
	mov	rcx, qword ptr [rcx+0x50]
	lea	rdx, [DS0007+rip]
	mov	rcx, qword ptr [rcx+0x8]
	call	tstrcmp@PLT
	test	rax, rax
	jnz	$_130
	mov	dword ptr [rbp-0x20], 2
$_130:	mov	eax, dword ptr [rbp+0x30]
	mov	dword ptr [rbp-0x18], eax
	mov	rcx, qword ptr [rsi+0x68]
	mov	dword ptr [rcx+0x38], eax
	mov	eax, dword ptr [rsi+0x50]
	mov	dword ptr [rbp-0x14], eax
	mov	rax, rsi
	call	$_119
	mov	dword ptr [rbp-0x8], eax
	push	rsi
	push	rdi
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 40
	mov	esi, 1
	lea	rdi, [rbp-0x28]
	call	fwrite@PLT
	pop	rdi
	pop	rsi
	cmp	eax, 40
	jz	$_131
	call	WriteError@PLT
$_131:	mov	rax, rsi
	call	$_116
	mov	rcx, qword ptr [rsi+0x68]
	mov	dword ptr [rcx+0x40], eax
	cmp	dword ptr [rbp-0x24], 8
	jz	$_132
	mov	eax, dword ptr [rbp-0x14]
	add	dword ptr [rbp+0x30], eax
	add	dword ptr [rbp+0x30], 15
	and	dword ptr [rbp+0x30], 0xFFFFFFF0
$_132:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_124

$_133:
	mov	rcx, rbx
	call	$_065
	mov	r8d, 40
	xor	edx, edx
	lea	rcx, [rbp-0x28]
	call	tmemset@PLT
	xor	esi, esi
$_134:	cmp	esi, 3
	jnc	$_138
	mov	rax, rdi
	sub	rax, qword ptr [rbx+0x20]
	mov	dword ptr [rbp-0x28], eax
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdi, [rdi+rax+0x1]
	imul	ecx, esi, 16
	lea	rdx, [internal_segparms+rip]
	mov	eax, dword ptr [rdx+rcx+0x8]
	mov	dword ptr [rbp-0x24], eax
	mov	eax, dword ptr [rbp+0x30]
	mov	dword ptr [rbp-0x18], eax
	imul	ecx, esi, 16
	mov	eax, dword ptr [rbp+0x30]
	mov	dword ptr [rbx+rcx+0x1C], eax
	mov	eax, dword ptr [rbx+rcx+0x18]
	mov	dword ptr [rbp-0x14], eax
	cmp	esi, 1
	jnz	$_135
	mov	eax, dword ptr [ModuleInfo+0x8+rip]
	add	eax, 3
	mov	dword ptr [rbp-0x10], eax
	mov	eax, dword ptr [rbx+0x4]
	mov	dword ptr [rbp-0xC], eax
	mov	dword ptr [rbp-0x8], 4
	mov	dword ptr [rbp-0x4], 16
	jmp	$_136

$_135:	mov	dword ptr [rbp-0x10], 0
	mov	dword ptr [rbp-0xC], 0
	mov	dword ptr [rbp-0x8], 1
	mov	dword ptr [rbp-0x4], 0
$_136:	push	rsi
	push	rdi
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 40
	mov	esi, 1
	lea	rdi, [rbp-0x28]
	call	fwrite@PLT
	pop	rdi
	pop	rsi
	cmp	eax, 40
	jz	$_137
	call	WriteError@PLT
$_137:	mov	eax, dword ptr [rbp-0x14]
	add	dword ptr [rbp+0x30], eax
	add	dword ptr [rbp+0x30], 15
	and	dword ptr [rbp+0x30], 0xFFFFFFF0
	inc	esi
	jmp	$_134

$_138:
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_139:	test	rsi, rsi
	je	$_142
	mov	rcx, qword ptr [rsi+0x68]
	cmp	qword ptr [rcx+0x28], 0
	je	$_141
	mov	r8d, 40
	xor	edx, edx
	lea	rcx, [rbp-0x28]
	call	tmemset@PLT
	mov	rax, rdi
	sub	rax, qword ptr [rbx+0x20]
	mov	dword ptr [rbp-0x28], eax
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdi, [rdi+rax+0x1]
	mov	dword ptr [rbp-0x24], 9
	mov	eax, dword ptr [rbp+0x30]
	mov	dword ptr [rbp-0x18], eax
	mov	rcx, qword ptr [rsi+0x68]
	mov	dword ptr [rcx+0xC], eax
	mov	eax, 8
	mul	dword ptr [rcx+0x40]
	mov	dword ptr [rbp-0x14], eax
	mov	eax, dword ptr [ModuleInfo+0x8+rip]
	add	eax, 2
	mov	dword ptr [rbp-0x10], eax
	mov	rcx, qword ptr [rsi+0x30]
	call	GetSegIdx@PLT
	mov	dword ptr [rbp-0xC], eax
	mov	dword ptr [rbp-0x8], 4
	mov	dword ptr [rbp-0x4], 8
	push	rsi
	push	rdi
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 40
	mov	esi, 1
	lea	rdi, [rbp-0x28]
	call	fwrite@PLT
	pop	rdi
	pop	rsi
	cmp	eax, 40
	jz	$_140
	call	WriteError@PLT
$_140:	mov	eax, dword ptr [rbp-0x14]
	add	dword ptr [rbp+0x30], eax
	add	dword ptr [rbp+0x30], 15
	and	dword ptr [rbp+0x30], 0xFFFFFFF0
$_141:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_139

$_142:
	xor	eax, eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_143:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 104
	add	dword ptr [rbp+0x30], 15
	and	dword ptr [rbp+0x30], 0xFFFFFFF0
	mov	rcx, qword ptr [rbp+0x28]
	call	$_094
	mov	r8d, 64
	xor	edx, edx
	lea	rcx, [rbp-0x40]
	call	tmemset@PLT
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 64
	mov	esi, 1
	lea	rdi, [rbp-0x40]
	call	fwrite@PLT
	cmp	rax, 64
	jz	$_144
	call	WriteError@PLT
$_144:	mov	rbx, qword ptr [rbp+0x28]
	mov	rdi, qword ptr [rbx+0x20]
	inc	rdi
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_145:	test	rsi, rsi
	je	$_154
	mov	r8d, 64
	xor	edx, edx
	lea	rcx, [rbp-0x40]
	call	tmemset@PLT
	mov	rax, rdi
	sub	rax, qword ptr [rbx+0x20]
	mov	dword ptr [rbp-0x40], eax
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdi, [rdi+rax+0x1]
	mov	rcx, qword ptr [rsi+0x68]
	cmp	byte ptr [rcx+0x6C], 1
	jnz	$_146
	mov	dword ptr [rbp-0x3C], 7
	jmp	$_151

$_146:	cmp	dword ptr [rcx+0x48], 3
	jz	$_147
	mov	dword ptr [rbp-0x3C], 1
	jmp	$_148

$_147:	mov	dword ptr [rbp-0x3C], 8
$_148:	cmp	dword ptr [rcx+0x48], 1
	jnz	$_149
	mov	dword ptr [rbp-0x38], 6
	jmp	$_151

$_149:	cmp	byte ptr [rcx+0x6B], 1
	jnz	$_150
	mov	dword ptr [rbp-0x38], 2
	jmp	$_151

$_150:	mov	dword ptr [rbp-0x38], 3
	cmp	qword ptr [rcx+0x50], 0
	jz	$_151
	mov	rcx, qword ptr [rcx+0x50]
	lea	rdx, [DS0007+rip]
	mov	rcx, qword ptr [rcx+0x8]
	call	tstrcmp@PLT
	test	rax, rax
	jnz	$_151
	mov	dword ptr [rbp-0x38], 2
$_151:	mov	eax, dword ptr [rbp+0x30]
	mov	dword ptr [rbp-0x28], eax
	mov	rcx, qword ptr [rsi+0x68]
	mov	dword ptr [rcx+0x38], eax
	mov	eax, dword ptr [rsi+0x50]
	mov	dword ptr [rbp-0x20], eax
	mov	rax, rsi
	call	$_119
	mov	dword ptr [rbp-0x10], eax
	push	rsi
	push	rdi
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 64
	mov	esi, 1
	lea	rdi, [rbp-0x40]
	call	fwrite@PLT
	pop	rdi
	pop	rsi
	cmp	eax, 64
	jz	$_152
	call	WriteError@PLT
$_152:	mov	rax, rsi
	call	$_116
	mov	rcx, qword ptr [rsi+0x68]
	mov	dword ptr [rcx+0x40], eax
	cmp	dword ptr [rbp-0x3C], 8
	jz	$_153
	mov	eax, dword ptr [rbp-0x20]
	add	dword ptr [rbp+0x30], eax
	add	dword ptr [rbp+0x30], 15
	and	dword ptr [rbp+0x30], 0xFFFFFFF0
$_153:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_145

$_154:
	mov	rcx, rbx
	call	$_065
	mov	r8d, 64
	xor	edx, edx
	lea	rcx, [rbp-0x40]
	call	tmemset@PLT
	xor	esi, esi
$_155:	cmp	esi, 3
	jnc	$_159
	mov	rax, rdi
	sub	rax, qword ptr [rbx+0x20]
	mov	dword ptr [rbp-0x40], eax
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdi, [rdi+rax+0x1]
	imul	ecx, esi, 16
	lea	rdx, [internal_segparms+rip]
	mov	eax, dword ptr [rdx+rcx+0x8]
	mov	dword ptr [rbp-0x3C], eax
	mov	eax, dword ptr [rbp+0x30]
	mov	dword ptr [rbp-0x28], eax
	imul	ecx, esi, 16
	mov	dword ptr [rbx+rcx+0x1C], eax
	mov	eax, dword ptr [rbx+rcx+0x18]
	mov	dword ptr [rbp-0x20], eax
	cmp	esi, 1
	jnz	$_156
	mov	eax, dword ptr [ModuleInfo+0x8+rip]
	add	eax, 3
	mov	dword ptr [rbp-0x18], eax
	mov	eax, dword ptr [rbx+0x4]
	mov	dword ptr [rbp-0x14], eax
	mov	dword ptr [rbp-0x10], 4
	mov	dword ptr [rbp-0x8], 24
	jmp	$_157

$_156:	mov	dword ptr [rbp-0x18], 0
	mov	dword ptr [rbp-0x14], 0
	mov	dword ptr [rbp-0x10], 1
	mov	dword ptr [rbp-0x8], 0
$_157:	push	rsi
	push	rdi
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 64
	mov	esi, 1
	lea	rdi, [rbp-0x40]
	call	fwrite@PLT
	pop	rdi
	pop	rsi
	cmp	eax, 64
	jz	$_158
	call	WriteError@PLT
$_158:	mov	eax, dword ptr [rbp-0x20]
	add	dword ptr [rbp+0x30], eax
	add	dword ptr [rbp+0x30], 15
	and	dword ptr [rbp+0x30], 0xFFFFFFF0
	inc	esi
	jmp	$_155

$_159:
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_160:	test	rsi, rsi
	je	$_163
	mov	rcx, qword ptr [rsi+0x68]
	cmp	qword ptr [rcx+0x28], 0
	je	$_162
	mov	r8d, 64
	xor	edx, edx
	lea	rcx, [rbp-0x40]
	call	tmemset@PLT
	mov	rax, rdi
	sub	rax, qword ptr [rbx+0x20]
	mov	dword ptr [rbp-0x40], eax
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdi, [rdi+rax+0x1]
	mov	dword ptr [rbp-0x3C], 4
	mov	eax, dword ptr [rbp+0x30]
	mov	dword ptr [rbp-0x28], eax
	mov	rcx, qword ptr [rsi+0x68]
	mov	dword ptr [rcx+0xC], eax
	mov	eax, 24
	mul	dword ptr [rcx+0x40]
	mov	dword ptr [rbp-0x20], eax
	mov	eax, dword ptr [ModuleInfo+0x8+rip]
	add	eax, 2
	mov	dword ptr [rbp-0x18], eax
	mov	rcx, qword ptr [rsi+0x30]
	call	GetSegIdx@PLT
	mov	dword ptr [rbp-0x14], eax
	mov	dword ptr [rbp-0x10], 4
	mov	dword ptr [rbp-0x8], 24
	push	rsi
	push	rdi
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 64
	mov	esi, 1
	lea	rdi, [rbp-0x40]
	call	fwrite@PLT
	pop	rdi
	pop	rsi
	cmp	eax, 64
	jz	$_161
	call	WriteError@PLT
$_161:	mov	eax, dword ptr [rbp-0x20]
	add	dword ptr [rbp+0x30], eax
	add	dword ptr [rbp+0x30], 15
	and	dword ptr [rbp+0x30], 0xFFFFFFF0
$_162:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_160

$_163:
	xor	eax, eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_164:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 72
	mov	rbx, rcx
	mov	rcx, qword ptr [rdx+0x68]
	mov	rsi, qword ptr [rcx+0x28]
$_165:	test	rsi, rsi
	je	$_180
	mov	eax, dword ptr [rsi+0x14]
	mov	dword ptr [rbp-0x10], eax
	jmp	$_177

$_166:	mov	byte ptr [rbp-0x1], 2
	mov	rcx, qword ptr [rsi+0x30]
	cmp	byte ptr [ModuleInfo+0x352+rip], 0
	jz	$_167
	cmp	byte ptr [rcx+0x18], 2
	jnz	$_167
	test	byte ptr [rcx+0x15], 0x08
	jz	$_167
	mov	byte ptr [rbp-0x1], 4
$_167:	jmp	$_178

$_168:	mov	byte ptr [rbp-0x1], 1
	jmp	$_178

$_169:	mov	byte ptr [rbp-0x1], 8
	jmp	$_178

$_170:	mov	dword ptr [rbx+0x10], 1
	mov	byte ptr [rbp-0x1], 20
	jmp	$_178

$_171:	mov	dword ptr [rbx+0x10], 1
	mov	byte ptr [rbp-0x1], 21
	jmp	$_178

$_172:	mov	dword ptr [rbx+0x10], 1
	mov	byte ptr [rbp-0x1], 22
	jmp	$_178

$_173:	mov	dword ptr [rbx+0x10], 1
	mov	byte ptr [rbp-0x1], 23
	jmp	$_178

$_174:	mov	byte ptr [rbp-0x1], 0
	mov	rcx, qword ptr [rbp+0x30]
	cmp	byte ptr [rsi+0x18], 14
	jnc	$_175
	mov	rdx, qword ptr [ModuleInfo+0x1A8+rip]
	mov	eax, dword ptr [rsi+0x14]
	mov	dword ptr [rsp+0x20], eax
	mov	r9, qword ptr [rcx+0x8]
	movzx	r8d, byte ptr [rsi+0x18]
	movsx	edx, byte ptr [rdx+0xA]
	mov	ecx, 3019
	call	asmerr@PLT
	jmp	$_176

$_175:	mov	r9d, dword ptr [rsi+0x14]
	mov	r8, qword ptr [rcx+0x8]
	movzx	edx, byte ptr [rsi+0x18]
	mov	ecx, 3014
	call	asmerr@PLT
$_176:	jmp	$_178

$_177:	cmp	byte ptr [rsi+0x18], 3
	je	$_166
	cmp	byte ptr [rsi+0x18], 6
	je	$_168
	cmp	byte ptr [rsi+0x18], 12
	je	$_169
	cmp	byte ptr [rsi+0x18], 5
	je	$_170
	cmp	byte ptr [rsi+0x18], 2
	je	$_171
	cmp	byte ptr [rsi+0x18], 4
	je	$_172
	cmp	byte ptr [rsi+0x18], 1
	je	$_173
	jmp	$_174

$_178:	mov	rcx, qword ptr [rsi+0x30]
	movzx	edx, byte ptr [rbp-0x1]
	mov	eax, dword ptr [rcx+0x60]
	shl	eax, 8
	add	eax, edx
	mov	dword ptr [rbp-0xC], eax
	mov	rbx, rsi
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 8
	mov	esi, 1
	lea	rdi, [rbp-0x10]
	call	fwrite@PLT
	cmp	eax, 8
	jz	$_179
	call	WriteError@PLT
$_179:	mov	rsi, rbx
	mov	rbx, qword ptr [rbp+0x28]
	mov	rsi, qword ptr [rsi+0x8]
	jmp	$_165

$_180:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_181:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 88
	mov	rdx, rcx
	mov	rcx, qword ptr [rdx+0x68]
	mov	rsi, qword ptr [rcx+0x28]
$_182:	test	rsi, rsi
	je	$_198
	mov	rcx, qword ptr [rsi+0x30]
	mov	edi, dword ptr [rcx+0x60]
	mov	eax, dword ptr [rsi+0x14]
	mov	qword ptr [rbp-0x18], rax
	mov	edx, dword ptr [rsi+0x10]
	movzx	rax, byte ptr [rsi+0x1A]
	sub	rax, rdx
	neg	rax
	mov	qword ptr [rbp-0x8], rax
	movzx	eax, byte ptr [rsi+0x18]
	jmp	$_195

$_183:	mov	ebx, 2
	cmp	byte ptr [ModuleInfo+0x352+rip], 0
	jz	$_184
	cmp	byte ptr [rcx+0x18], 2
	jnz	$_184
	test	byte ptr [rcx+0x15], 0x08
	jz	$_184
	mov	ebx, 4
$_184:	jmp	$_196

$_185:	mov	ebx, 1
	jmp	$_196

$_186:	mov	ebx, 8
	jmp	$_196

$_187:	mov	ebx, 10
	jmp	$_196

$_188:	mov	ebx, 12
	jmp	$_196

$_189:	mov	ebx, 13
	jmp	$_196

$_190:	mov	ebx, 14
	jmp	$_196

$_191:	mov	ebx, 15
	jmp	$_196

$_192:	mov	rcx, qword ptr [rbp+0x28]
	mov	ebx, 0
	cmp	byte ptr [rsi+0x18], 14
	jnc	$_193
	mov	rdx, qword ptr [ModuleInfo+0x1A8+rip]
	mov	eax, dword ptr [rsi+0x14]
	mov	dword ptr [rsp+0x20], eax
	mov	r9, qword ptr [rcx+0x8]
	movzx	r8d, byte ptr [rsi+0x18]
	lea	rdx, [rdx+0xA]
	mov	ecx, 3019
	call	asmerr@PLT
	jmp	$_194

$_193:	mov	r9d, dword ptr [rsi+0x14]
	mov	r8, qword ptr [rcx+0x8]
	movzx	edx, byte ptr [rsi+0x18]
	mov	ecx, 3014
	call	asmerr@PLT
$_194:	jmp	$_196

$_195:	cmp	eax, 3
	je	$_183
	cmp	eax, 7
	je	$_185
	cmp	eax, 12
	je	$_186
	cmp	eax, 6
	je	$_187
	cmp	eax, 5
	je	$_188
	cmp	eax, 2
	je	$_189
	cmp	eax, 4
	je	$_190
	cmp	eax, 1
	je	$_191
	jmp	$_192

$_196:	mov	dword ptr [rbp-0x10], ebx
	mov	dword ptr [rbp-0xC], edi
	mov	qword ptr [rbp-0x20], rsi
	mov	qword ptr [rbp-0x28], rdi
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 24
	mov	esi, 1
	lea	rdi, [rbp-0x18]
	call	fwrite@PLT
	cmp	rax, 24
	jz	$_197
	call	WriteError@PLT
$_197:	mov	rsi, qword ptr [rbp-0x20]
	mov	rdi, qword ptr [rbp-0x28]
	mov	rsi, qword ptr [rsi+0x8]
	jmp	$_182

$_198:
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_199:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 56
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_200:	test	rsi, rsi
	je	$_204
	mov	rdi, qword ptr [rsi+0x68]
	mov	ebx, dword ptr [rsi+0x50]
	sub	ebx, dword ptr [rdi+0x8]
	cmp	dword ptr [rdi+0x48], 3
	jz	$_203
	test	ebx, ebx
	jz	$_203
	mov	qword ptr [rbp-0x8], rsi
	cmp	qword ptr [rdi+0x10], 0
	jnz	$_201
	mov	edx, 1
	mov	esi, ebx
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fseek@PLT
	jmp	$_202

$_201:	mov	ecx, dword ptr [rdi+0x38]
	add	ecx, dword ptr [rdi+0x8]
	xor	edx, edx
	mov	esi, ecx
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fseek@PLT
	mov	rsi, qword ptr [rbp-0x8]
	mov	rdi, qword ptr [rsi+0x68]
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, ebx
	mov	esi, 1
	mov	rdi, qword ptr [rdi+0x10]
	call	fwrite@PLT
	cmp	rax, rbx
	jz	$_202
	call	WriteError@PLT
$_202:	mov	rsi, qword ptr [rbp-0x8]
$_203:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_200

$_204:
	mov	rbx, qword ptr [rbp+0x28]
	xor	esi, esi
$_205:	cmp	esi, 3
	jnc	$_207
	imul	edi, esi, 16
	cmp	qword ptr [rbx+rdi+0x20], 0
	jz	$_206
	mov	qword ptr [rbp-0x8], rsi
	mov	qword ptr [rbp-0x10], rdi
	xor	edx, edx
	mov	esi, dword ptr [rbx+rdi+0x1C]
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fseek@PLT
	mov	rdi, qword ptr [rbp-0x10]
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, dword ptr [rbx+rdi+0x18]
	mov	esi, 1
	mov	rdi, qword ptr [rbx+rdi+0x20]
	call	fwrite@PLT
	mov	rsi, qword ptr [rbp-0x8]
	mov	rdi, qword ptr [rbp-0x10]
	cmp	eax, dword ptr [rbx+rdi+0x18]
	jz	$_206
	call	WriteError@PLT
$_206:	inc	esi
	jmp	$_205

$_207:
	mov	rsi, qword ptr [SymTables+0x20+rip]
$_208:	test	rsi, rsi
	jz	$_211
	mov	rdi, qword ptr [rsi+0x68]
	cmp	dword ptr [rdi+0x40], 0
	jz	$_210
	mov	qword ptr [rbp-0x8], rsi
	mov	qword ptr [rbp-0x10], rdi
	xor	edx, edx
	mov	esi, dword ptr [rdi+0xC]
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fseek@PLT
	mov	rsi, qword ptr [rbp-0x8]
	mov	rdi, qword ptr [rbp-0x10]
	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	jnz	$_209
	mov	rcx, rsi
	call	$_181
	jmp	$_210

$_209:	mov	rdx, rsi
	mov	rcx, rbx
	call	$_164
$_210:	mov	rsi, qword ptr [rsi+0x70]
	jmp	$_208

$_211:
	cmp	dword ptr [rbx+0x10], 0
	jz	$_212
	mov	ecx, 8013
	call	asmerr@PLT
$_212:	xor	eax, eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

elf_write_module:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 168
	mov	r8d, 136
	xor	edx, edx
	lea	rcx, [rbp-0x88]
	call	tmemset@PLT
	mov	rdi, qword ptr [ModuleInfo+0x90+rip]
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rdx, [rdi+rax]
	jmp	$_214

$_213:	cmp	byte ptr [rdx-0x1], 92
	jz	$_215
	cmp	byte ptr [rdx-0x1], 47
	jz	$_215
	dec	rdx
$_214:	cmp	rdx, rdi
	ja	$_213
$_215:	mov	qword ptr [rbp-0x80], rdx
	xor	edx, edx
	xor	esi, esi
	mov	rdi, qword ptr [ModuleInfo+0x78+rip]
	call	fseek@PLT
	jmp	$_220

$_216:	mov	r8d, 4
	lea	rdx, [DS000D+rip]
	lea	rcx, [rbp-0x40]
	call	tmemcpy@PLT
	mov	byte ptr [rbp-0x3C], 2
	mov	byte ptr [rbp-0x3B], 1
	mov	byte ptr [rbp-0x3A], 1
	mov	al, byte ptr [ModuleInfo+0x1E4+rip]
	mov	byte ptr [rbp-0x39], al
	mov	word ptr [rbp-0x30], 1
	mov	word ptr [rbp-0x2E], 62
	mov	dword ptr [rbp-0x2C], 1
	mov	dword ptr [rbp-0x18], 64
	mov	word ptr [rbp-0xC], 64
	mov	word ptr [rbp-0x6], 64
	call	$_007
	add	eax, dword ptr [ModuleInfo+0x8+rip]
	add	eax, 4
	mov	word ptr [rbp-0x4], ax
	mov	eax, dword ptr [ModuleInfo+0x8+rip]
	add	eax, 1
	mov	word ptr [rbp-0x2], ax
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 64
	mov	esi, 1
	lea	rdi, [rbp-0x40]
	call	fwrite@PLT
	cmp	rax, 64
	jz	$_217
	call	WriteError@PLT
$_217:	movzx	eax, word ptr [rbp-0x4]
	mul	word ptr [rbp-0x6]
	add	eax, 64
	mov	edx, eax
	lea	rcx, [rbp-0x88]
	call	$_143
	jmp	$_221

$_218:	mov	r8d, 4
	lea	rdx, [DS000D+rip]
	lea	rcx, [rbp-0x40]
	call	tmemcpy@PLT
	mov	byte ptr [rbp-0x3C], 1
	mov	byte ptr [rbp-0x3B], 1
	mov	byte ptr [rbp-0x3A], 1
	mov	al, byte ptr [ModuleInfo+0x1E4+rip]
	mov	byte ptr [rbp-0x39], al
	mov	word ptr [rbp-0x30], 1
	mov	word ptr [rbp-0x2E], 3
	mov	dword ptr [rbp-0x2C], 1
	mov	dword ptr [rbp-0x20], 52
	mov	word ptr [rbp-0x18], 52
	mov	word ptr [rbp-0x12], 40
	call	$_007
	add	eax, dword ptr [ModuleInfo+0x8+rip]
	add	eax, 4
	mov	word ptr [rbp-0x10], ax
	mov	eax, dword ptr [ModuleInfo+0x8+rip]
	add	eax, 1
	mov	word ptr [rbp-0xE], ax
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	mov	edx, 52
	mov	esi, 1
	lea	rdi, [rbp-0x40]
	call	fwrite@PLT
	cmp	rax, 52
	jz	$_219
	call	WriteError@PLT
$_219:	movzx	eax, word ptr [rbp-0x10]
	mul	word ptr [rbp-0x12]
	add	eax, 52
	mov	edx, eax
	lea	rcx, [rbp-0x88]
	call	$_122
	jmp	$_221

$_220:	cmp	byte ptr [ModuleInfo+0x1CD+rip], 2
	je	$_216
	jmp	$_218

$_221:
	lea	rcx, [rbp-0x88]
	call	$_199
	xor	eax, eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

elf_init:
	sub	rsp, 8
	mov	byte ptr [ModuleInfo+0x1E4+rip], 0
	lea	rax, [elf_write_module+rip]
	mov	qword ptr [ModuleInfo+0x158+rip], rax
	add	rsp, 8
	ret


.SECTION .data
	.ALIGN	16

internal_segparms:
	.quad  DS0000
	.quad  0x0000000000000003
	.quad  DS0001
	.quad  0x0000000000000002
	.quad  DS0002
	.quad  0x0000000000000003

cst:
	.byte  0x05, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.quad  DS0003
	.quad  DS0004
	.quad  0x0000000000000105
	.quad  DS0005
	.quad  DS0006
	.quad  0x0000000000000105
	.quad  DS0007
	.quad  DS0008
	.quad  0x0000000000000004
	.quad  DS0009
	.quad  DS000A

DS000B:
	.asciz ".rela"

DS000C:
	.asciz ".rel"

DS000D:
	.byte  0x7F, 'E', 'L', 'F', 0x00


.SECTION .rodata
	.ALIGN	16

DS0000:
	.asciz ".shstrtab"

DS0001:
	.asciz ".symtab"

DS0002:
	.asciz ".strtab"

DS0003:
	.asciz "_TEXT"

DS0004:
	.asciz ".text"

DS0005:
	.asciz "_DATA"

DS0006:
	.asciz ".data"

DS0007:
	.asciz "CONST"

DS0008:
	.asciz ".rodata"

DS0009:
	.asciz "_BSS"

DS000A:
	.asciz ".bss"


.att_syntax prefix
