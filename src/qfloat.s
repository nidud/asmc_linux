

.intel_syntax noprefix

.global __mulo
.global __divo
.global __shlo
.global __shro
.global __saro
.global __cvtq_ss
.global __cvtq_sd
.global __cvtq_ld
.global __cmpq
.global __addq
.global __subq
.global __mulq
.global __divq
.global __sqrtq
.global _fltscale
.global __div64_
.global __rem64_
.global _atoow
.global _atoqw
.global atofloat
.global quad_resize
.global _flttostr

.extern tstrlen
.extern tmemset
.extern asmerr
.extern Parse_Pass


.SECTION .text
	.ALIGN	16

__mulo:
	mov	rax, qword ptr [rcx]
	mov	r10, qword ptr [rcx+0x8]
	mov	r9, qword ptr [rdx+0x8]
	test	r10, r10
	jnz	$_002
	test	r9, r9
	jnz	$_002
	test	r8, r8
	jz	$_001
	mov	qword ptr [r8], r9
	mov	qword ptr [r8+0x8], r9
$_001:	mul	qword ptr [rdx]
	jmp	$_004

$_002:	push	rcx
	mov	r11, qword ptr [rdx]
	mul	r11
	push	rax
	xchg	r11, rdx
	mov	rax, r10
	mul	rdx
	add	r11, rax
	xchg	rdx, rcx
	mov	rax, qword ptr [rdx]
	mul	r9
	add	r11, rax
	adc	rcx, rdx
	mov	edx, 0
	adc	edx, 0
	test	r8, r8
	jz	$_003
	xchg	r9, rdx
	mov	rax, r10
	mul	rdx
	add	rax, rcx
	adc	rdx, r9
	mov	qword ptr [r8], rax
	mov	qword ptr [r8+0x8], rdx
$_003:	pop	rax
	mov	rdx, r11
	pop	rcx
$_004:	mov	qword ptr [rcx], rax
	mov	qword ptr [rcx+0x8], rdx
	mov	rax, rcx
	ret

__divo:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x18], r8
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rbx, qword ptr [rcx]
	mov	rcx, qword ptr [rcx+0x8]
	mov	r10, qword ptr [rdx]
	mov	r11, qword ptr [rdx+0x8]
	xor	eax, eax
	xor	edx, edx
	test	r10, r10
	jnz	$_005
	test	r11, r11
	jnz	$_005
	xor	rbx, rbx
	xor	rcx, rcx
	jmp	$_013

$_005:	cmp	r11, rcx
	jnz	$_006
	cmp	r10, rbx
$_006:	ja	$_013
	jnz	$_007
	xor	rbx, rbx
	xor	rcx, rcx
	inc	eax
	jmp	$_013

$_007:	mov	r8d, 4294967295
$_008:	inc	r8d
	shl	r10, 1
	rcl	r11, 1
	jc	$_009
	cmp	r11, rcx
	ja	$_009
	jc	$_008
	cmp	r10, rbx
	jc	$_008
	jz	$_008
$_009:	rcr	r11, 1
	rcr	r10, 1
	sub	rbx, r10
	sbb	rcx, r11
	cmc
	jc	$_012
$_010:	add	rax, rax
	adc	rdx, rdx
	dec	r8d
	jns	$_011
	add	rbx, r10
	adc	rcx, r11
	jmp	$_013

$_011:	shr	r11, 1
	rcr	r10, 1
	add	rbx, r10
	adc	rcx, r11
	jnc	$_010
$_012:	adc	rax, rax
	adc	rdx, rdx
	dec	r8d
	jns	$_009
$_013:	mov	r10, qword ptr [rbp+0x28]
	test	r10, r10
	jz	$_014
	mov	qword ptr [r10], rbx
	mov	qword ptr [r10+0x8], rcx
$_014:	mov	r10, rax
	mov	rax, qword ptr [rbp+0x18]
	mov	qword ptr [rax], r10
	mov	qword ptr [rax+0x8], rdx
	leave
	pop	rbx
	ret

__shlo:
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rbx, rcx
	mov	r10, rcx
	mov	ecx, edx
	mov	rax, qword ptr [r10]
	mov	rdx, qword ptr [r10+0x8]
	cmp	ecx, 128
	jnc	$_015
	cmp	ecx, 64
	jc	$_016
	cmp	r8d, 128
	jnc	$_016
$_015:	xor	eax, eax
	xor	edx, edx
	jmp	$_020

$_016:	cmp	r8d, 128
	jnz	$_019
	jmp	$_018

$_017:	mov	rdx, rax
	xor	eax, eax
	sub	ecx, 64
$_018:	cmp	ecx, 64
	jnc	$_017
	shld	rdx, rax, cl
	shl	rax, cl
	jmp	$_020

$_019:	shl	rax, cl
$_020:	mov	qword ptr [r10], rax
	mov	qword ptr [r10+0x8], rdx
	mov	rax, rbx
	leave
	pop	rbx
	ret

__shro:
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rbx, rcx
	mov	r10, rcx
	mov	ecx, edx
	mov	rax, qword ptr [r10]
	mov	rdx, qword ptr [r10+0x8]
	cmp	ecx, 128
	jnc	$_021
	cmp	ecx, 64
	jc	$_022
	cmp	r8d, 128
	jnc	$_022
$_021:	xor	edx, edx
	xor	eax, eax
	jmp	$_027

$_022:	cmp	r8d, 128
	jnz	$_025
	jmp	$_024

$_023:	mov	rax, rdx
	xor	edx, edx
	sub	ecx, 64
$_024:	cmp	ecx, 64
	ja	$_023
	shrd	rax, rdx, cl
	shr	rdx, cl
	jmp	$_027

$_025:	cmp	eax, -1
	jnz	$_026
	cmp	r8d, 32
	jnz	$_026
	and	eax, eax
$_026:	shr	rax, cl
$_027:	mov	qword ptr [r10], rax
	mov	qword ptr [r10+0x8], rdx
	mov	rax, rbx
	leave
	pop	rbx
	ret

__saro:
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rsi, rcx
	mov	ecx, edx
	mov	eax, dword ptr [rsi]
	mov	edx, dword ptr [rsi+0x4]
	mov	ebx, dword ptr [rsi+0x8]
	mov	edi, dword ptr [rsi+0xC]
	cmp	ecx, 64
	jc	$_028
	cmp	dword ptr [rbp+0x38], 64
	jg	$_028
	xor	eax, eax
	xor	edx, edx
	xor	ebx, ebx
	xor	edi, edi
	jmp	$_036

$_028:	cmp	ecx, 128
	jc	$_029
	cmp	dword ptr [rbp+0x38], 128
	jnz	$_029
	sar	edi, 31
	mov	ebx, edi
	mov	edx, edi
	mov	eax, edi
	jmp	$_036

$_029:	cmp	dword ptr [rbp+0x38], 128
	jnz	$_032
	jmp	$_031

$_030:	mov	eax, edx
	mov	edx, ebx
	mov	ebx, edi
	sar	edi, 31
	sub	ecx, 32
$_031:	cmp	ecx, 32
	ja	$_030
	shrd	eax, edx, cl
	shrd	edx, ebx, cl
	shrd	ebx, edi, cl
	sar	edi, cl
	jmp	$_036

$_032:	cmp	eax, -1
	jnz	$_033
	cmp	dword ptr [rbp+0x38], 32
	jnz	$_033
	xor	edx, edx
$_033:	cmp	dword ptr [rbp+0x38], 32
	jnz	$_034
	sar	eax, cl
	jmp	$_036

$_034:	cmp	ecx, 32
	jnc	$_035
	shrd	eax, edx, cl
	sar	edx, cl
	jmp	$_036

$_035:	mov	eax, edx
	sar	edx, 31
	and	cl, 0x1F
	sar	eax, cl
$_036:	mov	dword ptr [rsi], eax
	mov	dword ptr [rsi+0x4], edx
	mov	dword ptr [rsi+0x8], ebx
	mov	dword ptr [rsi+0xC], edi
	mov	rax, rsi
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_037:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rsi, rdx
	mov	rdi, rcx
	mov	eax, dword ptr [rsi+0xA]
	mov	cx, word ptr [rsi+0xE]
	shr	eax, 1
	test	ecx, 0x7FFF
	jz	$_038
	or	eax, 0x80000000
$_038:	mov	edx, eax
	shl	edx, 12
	mov	edx, 4292870144
	jnc	$_040
	jnz	$_039
	cmp	dword ptr [rsi+0x6], 0
	jnz	$_039
	shl	edx, 1
$_039:	add	eax, 2097152
	jnc	$_040
	mov	eax, 2147483648
	inc	cx
$_040:	mov	ebx, ecx
	and	cx, 0x7FFF
	je	$_046
	cmp	cx, 32767
	jnz	$_042
	test	eax, 0x7FFFFFFF
	jz	$_041
	mov	eax, 4294967295
	jmp	$_047

$_041:	mov	eax, 4160749568
	shl	bx, 1
	rcr	eax, 1
	jmp	$_047

$_042:
	add	cx, -16368
	jns	$_043
	mov	dword ptr [qerrno+rip], 34
	mov	eax, 65536
	jmp	$_047

$_043:	cmp	cx, 31
	jnc	$_044
	cmp	cx, 30
	jnz	$_045
	cmp	eax, edx
	jbe	$_045
$_044:	mov	dword ptr [qerrno+rip], 34
	mov	eax, 4160618496
	shl	bx, 1
	rcr	eax, 1
	jmp	$_047

$_045:	and	eax, edx
	shl	eax, 1
	shrd	eax, ecx, 5
	shl	bx, 1
	rcr	eax, 1
	test	cx, cx
	jnz	$_047
	cmp	eax, 1
	jge	$_047
	mov	ebx, eax
	mov	dword ptr [qerrno+rip], 34
	mov	eax, ebx
	jmp	$_047

$_046:	and	eax, edx
$_047:	shr	eax, 16
	mov	ecx, eax
	mov	rax, rdi
	mov	word ptr [rax], cx
	cmp	rax, rsi
	jnz	$_048
	xor	ecx, ecx
	mov	word ptr [rax+0x2], cx
	mov	dword ptr [rax+0x4], ecx
	mov	dword ptr [rax+0x8], ecx
	mov	dword ptr [rax+0xC], ecx
$_048:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

__cvtq_ss:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rbx, rdx
	mov	edx, 4294967040
	mov	eax, dword ptr [rbx+0xA]
	mov	cx, word ptr [rbx+0xE]
	and	ecx, 0x7FFF
	neg	ecx
	rcr	eax, 1
	mov	ecx, eax
	shl	ecx, 25
	mov	cx, word ptr [rbx+0xE]
	jnc	$_050
	jnz	$_049
	cmp	dword ptr [rbx+0x6], 0
	jnz	$_049
	shl	edx, 1
$_049:	add	eax, 256
	jnc	$_050
	mov	eax, 2147483648
	inc	cx
$_050:	and	eax, edx
	mov	ebx, ecx
	and	cx, 0x7FFF
	jz	$_054
	cmp	cx, 32767
	jnz	$_051
	shl	eax, 1
	shr	eax, 8
	or	eax, 0xFF000000
	shl	bx, 1
	rcr	eax, 1
	jmp	$_054

$_051:
	add	cx, -16256
	jns	$_052
	mov	dword ptr [qerrno+rip], 34
	xor	eax, eax
	jmp	$_054

$_052:
	cmp	cx, 255
	jl	$_053
	mov	dword ptr [qerrno+rip], 34
	mov	eax, 4278190080
	shl	bx, 1
	rcr	eax, 1
	jmp	$_054

$_053:	shl	eax, 1
	shrd	eax, ecx, 8
	shl	bx, 1
	rcr	eax, 1
	test	cx, cx
	jnz	$_054
	cmp	eax, 8388608
	jge	$_054
	mov	ebx, eax
	mov	dword ptr [qerrno+rip], 34
	mov	eax, ebx
$_054:	mov	ecx, eax
	mov	rax, qword ptr [rbp+0x18]
	mov	dword ptr [rax], ecx
	cmp	rax, qword ptr [rbp+0x20]
	jnz	$_055
	xor	ecx, ecx
	mov	dword ptr [rax+0x4], ecx
	mov	dword ptr [rax+0x8], ecx
	mov	dword ptr [rax+0xC], ecx
$_055:	leave
	pop	rbx
	ret

__cvtq_sd:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rax, rdx
	movzx	ecx, word ptr [rax+0xE]
	mov	edx, dword ptr [rax+0xA]
	mov	ebx, ecx
	and	ebx, 0x7FFF
	mov	edi, ebx
	neg	ebx
	mov	eax, dword ptr [rax+0x6]
	rcr	edx, 1
	rcr	eax, 1
	mov	esi, 4294965248
	mov	ebx, eax
	shl	ebx, 22
	jnc	$_057
	jnz	$_056
	shl	ebx, 1
$_056:	add	eax, 2048
	adc	edx, 0
	jnc	$_057
	mov	edx, 2147483648
	inc	cx
$_057:	and	eax, esi
	mov	ebx, ecx
	and	cx, 0x7FFF
	add	cx, -15360
	cmp	cx, 2047
	jnc	$_060
	test	cx, cx
	jnz	$_058
	shrd	eax, edx, 12
	shl	edx, 1
	shr	edx, 12
	jmp	$_059

$_058:	shrd	eax, edx, 11
	shl	edx, 1
	shrd	edx, ecx, 11
$_059:	shl	bx, 1
	rcr	edx, 1
	jmp	$_065

$_060:
	cmp	cx, -15360
	jc	$_064
	cmp	cx, -52
	jl	$_062
	sub	cx, 12
	neg	cx
	cmp	cl, 32
	jc	$_061
	sub	cl, 32
	mov	esi, eax
	mov	eax, edx
	xor	edx, edx
$_061:	shrd	esi, eax, cl
	shrd	eax, edx, cl
	shr	edx, cl
	add	esi, esi
	adc	eax, 0
	adc	edx, 0
	jmp	$_063

$_062:	xor	eax, eax
	xor	edx, edx
	shl	ebx, 17
	rcr	edx, 1
$_063:	jmp	$_065

$_064:	shrd	eax, edx, 11
	shl	edx, 1
	shr	edx, 11
	shl	bx, 1
	rcr	edx, 1
	or	edx, 0x7FF00000
$_065:	xor	ebx, ebx
	cmp	edi, 15308
	jnc	$_068
	mov	rcx, qword ptr [rbp+0x30]
	test	edi, edi
	jnz	$_066
	cmp	edi, dword ptr [rcx+0x6]
	jnz	$_066
	cmp	edi, dword ptr [rcx+0xA]
	jz	$_067
$_066:	xor	eax, eax
	xor	edx, edx
	mov	ebx, 34
$_067:	jmp	$_071

$_068:	cmp	edi, 15309
	jc	$_070
	mov	edi, edx
	and	edi, 0x7FF00000
	mov	ebx, 34
	jz	$_069
	cmp	edi, 2146435072
	jz	$_069
	xor	ebx, ebx
$_069:	jmp	$_071

$_070:	cmp	edi, 15308
	jc	$_071
	mov	edi, edx
	or	edi, eax
	mov	ebx, 34
	jz	$_071
	mov	edi, edx
	and	edi, 0x7FF00000
	jz	$_071
	xor	ebx, ebx
$_071:	mov	rdi, qword ptr [rbp+0x28]
	mov	dword ptr [rdi], eax
	mov	dword ptr [rdi+0x4], edx
	test	ebx, ebx
	jz	$_072
	mov	dword ptr [qerrno+rip], ebx
$_072:	cmp	rdi, qword ptr [rbp+0x30]
	jnz	$_073
	xor	eax, eax
	mov	dword ptr [rdi+0x8], eax
	mov	dword ptr [rdi+0xC], eax
$_073:	mov	rax, rdi
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

__cvtq_ld:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rax, rcx
	mov	rdi, rdx
	xor	ecx, ecx
	mov	ebx, dword ptr [rdi+0x6]
	mov	edx, dword ptr [rdi+0xA]
	mov	cx, word ptr [rdi+0xE]
	mov	esi, ecx
	and	esi, 0x7FFF
	neg	esi
	rcr	edx, 1
	rcr	ebx, 1
	jnc	$_075
	cmp	ebx, -1
	jnz	$_074
	cmp	edx, -1
	jnz	$_074
	xor	ebx, ebx
	mov	edx, 2147483648
	inc	cx
	jmp	$_075

$_074:	add	ebx, 1
	adc	edx, 0
$_075:	mov	dword ptr [rax], ebx
	mov	dword ptr [rax+0x4], edx
	cmp	rax, rdi
	jnz	$_076
	mov	dword ptr [rax+0x8], ecx
	mov	dword ptr [rax+0xC], 0
	jmp	$_077

$_076:	mov	word ptr [rax+0x8], cx
$_077:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

__cvth_q:
	mov	rax, rcx
	movsx	edx, word ptr [rdx]
	mov	ecx, edx
	shl	edx, 21
	sar	ecx, 10
	and	cx, 0x1F
	test	cl, cl
	jz	$_081
	cmp	cl, 31
	jz	$_078
	add	cx, 16368
	jmp	$_080
$_078:	or	cx, 0x7FE0
	test	edx, 0x7FFFFFFF
	jz	$_079
	mov	dword ptr [qerrno+rip], 33
	mov	ecx, 65535
	mov	edx, 1073741824
	jmp	$_080
$_079:	xor	edx, edx
$_080:	jmp	$_083
$_081:	test	edx, edx
	jz	$_083
	or	cx, 0x3FF1
$_082:	test	edx, edx
	js	$_083
	shl	edx, 1
	dec	cx
	jmp	$_082
$_083:	shl	ecx, 1
	rcr	cx, 1
	mov	word ptr [rax+0xE], cx
	shl	edx, 1
	mov	dword ptr [rax+0xA], edx
	xor	edx, edx
	mov	qword ptr [rax], rdx
	mov	dword ptr [rax+0x8], edx
	ret

__cvtss_q:
	mov	rax, rcx
	mov	edx, dword ptr [rdx]
	mov	ecx, edx
	shl	edx, 8
	sar	ecx, 23
	xor	ch, ch
	test	cl, cl
	jz	$_086
	cmp	cl, -1
	jz	$_084
	add	cx, 16256
	jmp	$_085
$_084:	or	ch, 0xFFFFFFFF
	test	edx, 0x7FFFFFFF
	jnz	$_085
	or	edx, 0x40000000
	mov	dword ptr [qerrno+rip], 33
$_085:	jmp	$_088

$_086:	test	edx, edx
	jz	$_088
	or	cx, 0x3F81
$_087:	test	edx, edx
	js	$_088
	shl	edx, 1
	dec	cx
	jmp	$_087
$_088:	add	ecx, ecx
	rcr	cx, 1
	mov	word ptr [rax+0xE], cx
	shl	edx, 1
	mov	dword ptr [rax+0xA], edx
	xor	edx, edx
	mov	dword ptr [rax], edx
	mov	dword ptr [rax+0x4], edx
	mov	word ptr [eax+0x8], dx
	ret

__cvtsd_q:
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rbx, rcx
	mov	eax, dword ptr [rdx]
	mov	edx, dword ptr [rdx+0x4]
	mov	ecx, edx
	shld	edx, eax, 11
	shl	eax, 11
	sar	ecx, 20
	and	cx, 0x7FF
	jz	$_092
	cmp	cx, 2047
	jz	$_089
	add	cx, 15360
	jmp	$_091

$_089:	or	ch, 0x7F
	test	edx, 0x7FFFFFFF
	jnz	$_090
	test	eax, eax
	jz	$_091
$_090:	or	edx, 0x40000000
$_091:	or	edx, 0x80000000
	jmp	$_095

$_092:	test	edx, edx
	jnz	$_093
	test	eax, eax
	jz	$_095
$_093:	or	ecx, 0x3C01
	test	edx, edx
	jnz	$_094
	xchg	eax, edx
	sub	cx, 32
$_094:	test	edx, edx
	js	$_095
	shl	eax, 1
	rcl	edx, 1
	dec	rcx
	jnz	$_094
$_095:	add	ecx, ecx
	rcr	cx, 1
	shl	eax, 1
	rcl	edx, 1
	xchg	rax, rbx
	mov	dword ptr [rax+0x6], ebx
	mov	dword ptr [rax+0xA], edx
	mov	word ptr [rax+0xE], cx
	xor	ebx, ebx
	mov	dword ptr [rax], ebx
	mov	word ptr [rax+0x4], bx
	leave
	pop	rbx
	ret

$_096:
	mov	rax, qword ptr [rdx]
	movzx	edx, word ptr [rdx+0x8]
	add	dx, dx
	rcr	dx, 1
	shl	rax, 1
	shld	rdx, rax, 48
	shl	rax, 48
	mov	qword ptr [rcx], rax
	mov	qword ptr [rcx+0x8], rdx
	mov	rax, rcx
	ret

__cmpq:
	mov	rax, qword ptr [rdx]
	cmp	qword ptr [rcx], rax
	jnz	$_097
	mov	rax, qword ptr [rdx+0x8]
	cmp	qword ptr [rcx+0x8], rax
	jnz	$_097
	xor	eax, eax
	jmp	$_103

$_097:	cmp	byte ptr [rcx+0xF], 0
	jl	$_098
	cmp	byte ptr [rdx+0xF], 0
	jge	$_098
	mov	eax, 1
	jmp	$_103

$_098:	cmp	byte ptr [rcx+0xF], 0
	jge	$_099
	cmp	byte ptr [rdx+0xF], 0
	jl	$_099
	mov	rax, -1
	jmp	$_103

$_099:	cmp	byte ptr [rcx+0xF], 0
	jge	$_101
	mov	rax, qword ptr [rcx+0x8]
	cmp	qword ptr [rdx+0x8], rax
	jnz	$_100
	mov	rax, qword ptr [rcx]
	cmp	qword ptr [rdx], rax
$_100:	jmp	$_102

$_101:	mov	rax, qword ptr [rdx+0x8]
	cmp	qword ptr [rcx+0x8], rax
	jnz	$_102
	mov	rax, qword ptr [rdx]
	cmp	qword ptr [rcx], rax
$_102:	sbb	eax, eax
	sbb	eax, -1
$_103:	ret

$_104:
	mov	rax, qword ptr [rdx]
	mov	r8, qword ptr [rdx+0x8]
	shld	r9, r8, 16
	shld	r8, rax, 16
	shl	rax, 16
	mov	word ptr [rcx+0x10], r9w
	and	r9d, 0x7FFF
	neg	r9d
	rcr	r8, 1
	rcr	rax, 1
	mov	qword ptr [rcx], rax
	mov	qword ptr [rcx+0x8], r8
	mov	rax, rcx
	ret

$_105:
	mov	rax, qword ptr [rcx]
	test	eax, 0x4000
	jz	$_107
	mov	rdx, qword ptr [rcx+0x8]
	add	rax, 16384
	adc	rdx, 0
	jnc	$_106
	rcr	rdx, 1
	rcr	rax, 1
	inc	word ptr [rcx+0x10]
	cmp	word ptr [rcx+0x10], 32767
	jnz	$_106
	mov	word ptr [rcx+0x10], 32767
	xor	eax, eax
	xor	edx, edx
$_106:	mov	qword ptr [rcx], rax
	mov	qword ptr [rcx+0x8], rdx
$_107:	mov	rax, rcx
	ret

$_108:
	mov	qword ptr [rsp+0x8], rcx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rcx, rdx
	call	$_105
	mov	rax, qword ptr [rcx]
	mov	rdx, qword ptr [rcx+0x8]
	mov	cx, word ptr [rcx+0x10]
	shl	rax, 1
	rcl	rdx, 1
	shrd	rax, rdx, 16
	shrd	rdx, rcx, 16
	mov	rcx, qword ptr [rbp+0x10]
	mov	qword ptr [rcx], rax
	mov	qword ptr [rcx+0x8], rdx
	mov	rax, rcx
	leave
	ret

$_109:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	r11, rcx
	mov	rbx, qword ptr [rdx]
	mov	rdi, qword ptr [rdx+0x8]
	mov	si, word ptr [rdx+0x10]
	shl	esi, 16
	mov	rax, qword ptr [rcx]
	mov	rdx, qword ptr [rcx+0x8]
	mov	si, word ptr [rcx+0x10]
	add	si, 1
	jc	$_132
	jo	$_132
	add	esi, 65535
	jc	$_135
	jo	$_135
	sub	esi, 65536
	xor	esi, r8d
	mov	rcx, rax
	or	rcx, rdx
	je	$_126
$_110:	mov	rcx, rbx
	or	rcx, rdi
	je	$_128
$_111:	mov	ecx, esi
	rol	esi, 16
	sar	esi, 16
	sar	ecx, 16
	and	esi, 0x80007FFF
	and	ecx, 0x80007FFF
	mov	r9d, ecx
	rol	esi, 16
	rol	ecx, 16
	add	cx, si
	rol	esi, 16
	rol	ecx, 16
	sub	cx, si
	jz	$_113
	jnc	$_112
	mov	r9d, esi
	neg	cx
	xchg	rax, rbx
	xchg	rdi, rdx
$_112:
	cmp	cx, 128
	jbe	$_113
	mov	esi, r9d
	shl	esi, 1
	rcr	si, 1
	mov	rax, rbx
	mov	rdx, rdi
	jmp	$_125

$_113:	mov	esi, r9d
	mov	ch, 0
	test	ecx, ecx
	jns	$_114
	mov	ch, -1
	neg	rdi
	neg	rbx
	sbb	rdi, 0
	xor	esi, 0x80000000
$_114:	mov	r8d, 0
	test	cl, cl
	jz	$_118
	cmp	cl, 64
	jc	$_117
	test	rax, rax
	jz	$_115
	inc	r8d
$_115:	cmp	cl, -128
	jnz	$_116
	shr	rdx, 32
	or	r8d, edx
	xor	edx, edx
$_116:	mov	rax, rdx
	xor	edx, edx
$_117:	xor	r9d, r9d
	shrd	r9d, eax, cl
	or	r8d, r9d
	shrd	rax, rdx, cl
	shr	rdx, cl
$_118:	add	rax, rbx
	adc	rdx, rdi
	adc	ch, 0
	jns	$_120
	cmp	cl, -128
	jnz	$_119
	test	r8d, 0x7FFFFFFF
	jz	$_119
	add	rax, 1
	adc	rdx, 0
$_119:	neg	rdx
	neg	rax
	sbb	rdx, 0
	xor	ch, ch
	xor	esi, 0x80000000
$_120:	mov	r9d, ecx
	and	r9d, 0xFF00
	or	r9, rax
	or	r9, rdx
	jnz	$_121
	xor	esi, esi
$_121:	test	si, si
	jz	$_125
	test	ch, ch
	mov	ecx, r8d
	jnz	$_123
	rol	ecx, 1
	rol	ecx, 1
$_122:	dec	si
	jz	$_124
	adc	rax, rax
	adc	rdx, rdx
	jnc	$_122
$_123:	inc	si
	cmp	si, 32767
	je	$_130
	stc
	rcr	rdx, 1
	rcr	rax, 1
	add	ecx, ecx
	jnc	$_124
	adc	rax, 0
	adc	rdx, 0
	jnc	$_124
	rcr	rdx, 1
	rcr	rax, 1
	inc	si
	cmp	si, 32767
	jz	$_130
$_124:	add	esi, esi
	rcr	si, 1
$_125:	mov	qword ptr [r11], rax
	mov	qword ptr [r11+0x8], rdx
	mov	word ptr [r11+0x10], si
	mov	rax, r11
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_126:	shl	si, 1
	jnz	$_127
	shr	esi, 16
	mov	rax, rbx
	mov	rdx, rdi
	shl	esi, 1
	mov	rcx, rax
	or	rcx, rdx
	jz	$_125
	shr	esi, 1
	jmp	$_125

$_127:	rcr	si, 1
	jmp	$_110

$_128:	test	esi, 0x7FFF0000
	jz	$_125
	jmp	$_111

$_129:	mov	esi, 65535
	movabs	rdx, 0x4000000000000000
	xor	eax, eax
	jmp	$_125

$_130:	mov	esi, 32767
	xor	eax, eax
	xor	edx, edx
	jmp	$_125

$_131:	mov	rax, rbx
	mov	rdx, rdi
	shr	esi, 16
	jmp	$_125

$_132:	dec	si
	add	esi, 65536
	jc	$_133
	jo	$_133
	jns	$_125
	mov	rcx, rax
	or	rcx, rdx
	jne	$_125
	xor	esi, 0x8000
	jmp	$_125

$_133:	sub	esi, 65536
	mov	rcx, rax
	or	rcx, rdx
	or	rcx, rbx
	or	rcx, rdi
	jnz	$_134
	or	esi, 0xFFFFFFFF
	jmp	$_129

$_134:	cmp	rdx, rdi
	jc	$_131
	ja	$_125
	cmp	rax, rbx
	jbe	$_131
	jmp	$_125

$_135:
	sub	esi, 65536
	mov	rcx, rbx
	or	rcx, rdi
	jnz	$_131
	mov	ecx, esi
	shl	ecx, 16
	xor	esi, ecx
	and	esi, 0x80000000
	jmp	$_131

$_136:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	xor	r8d, r8d
	call	$_109
	leave
	ret

$_137:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	r8d, 2147483648
	call	$_109
	leave
	ret

$_138:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	r12
	push	r13
	push	rbp
	mov	rbp, rsp
	mov	rbx, qword ptr [rdx]
	mov	rdi, qword ptr [rdx+0x8]
	mov	si, word ptr [rdx+0x10]
	shl	esi, 16
	mov	rax, qword ptr [rcx]
	mov	rdx, qword ptr [rcx+0x8]
	mov	si, word ptr [rcx+0x10]
	add	si, 1
	jc	$_161
	jo	$_161
	add	esi, 65535
	jc	$_163
	jo	$_163
	sub	esi, 65536
	mov	rcx, rbx
	or	rcx, rdi
	je	$_154
$_139:	mov	rcx, rax
	or	rcx, rdx
	je	$_152
$_140:	mov	ecx, esi
	rol	ecx, 16
	sar	ecx, 16
	sar	esi, 16
	and	ecx, 0x80007FFF
	and	esi, 0x80007FFF
	rol	ecx, 16
	rol	esi, 16
	add	cx, si
	rol	ecx, 16
	rol	esi, 16
	test	cx, cx
	je	$_150
$_141:	test	si, si
	je	$_151
$_142:	sub	cx, si
	add	cx, 16383
	js	$_143
	cmp	cx, 32767
	ja	$_157
$_143:	cmp	cx, -65
	jl	$_156
	mov	r13, rcx
	mov	r12, rbp
	shrd	rax, rdx, 14
	shr	rdx, 14
	shrd	rbx, rdi, 14
	shr	rdi, 14
	mov	ecx, 115
	mov	rbp, rdi
	mov	r10, rax
	mov	r11, rdx
	xor	eax, eax
	xor	edx, edx
	xor	r8d, r8d
	xor	r9d, r9d
	xor	edi, edi
	xor	esi, esi
	add	rbx, rbx
	adc	rbp, rbp
$_144:	shr	rbp, 1
	rcr	rbx, 1
	rcr	r9, 1
	rcr	r8, 1
	sub	rdi, r8
	sbb	rsi, r9
	sbb	r10, rbx
	sbb	r11, rbp
	cmc
	jc	$_146
$_145:	add	rax, rax
	adc	rdx, rdx
	dec	ecx
	jz	$_147
	shr	rbp, 1
	rcr	rbx, 1
	rcr	r9, 1
	rcr	r8, 1
	add	rdi, r8
	adc	rsi, r9
	adc	r10, rbx
	adc	r11, rbp
	jnc	$_145
$_146:	adc	rax, rax
	adc	rdx, rdx
	dec	ecx
	jnz	$_144
$_147:	mov	rsi, r13
	mov	rbp, r12
	dec	si
	bt	rax, 0
	adc	rax, 0
	adc	rdx, 0
	bt	rdx, 50
	jnc	$_148
	rcr	rdx, 1
	rcr	rax, 1
	add	esi, 1
$_148:	shld	rdx, rax, 14
	shl	rax, 14
	test	si, si
	jle	$_159
	add	esi, esi
	rcr	si, 1
$_149:	mov	rcx, qword ptr [rbp+0x38]
	mov	qword ptr [rcx], rax
	mov	qword ptr [rcx+0x8], rdx
	mov	word ptr [rcx+0x10], si
	mov	rax, rcx
	leave
	pop	r13
	pop	r12
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_150:	dec	cx
	add	rax, rax
	adc	rdx, rdx
	jnc	$_150
	jmp	$_141

$_151:	dec	si
	add	rbx, rbx
	adc	rdi, rdi
	jnc	$_151
	jmp	$_142

$_152:	add	si, si
	jz	$_153
	rcr	si, 1
	jmp	$_140

$_153:	rcr	si, 1
	test	esi, 0x80008000
	jz	$_159
	mov	esi, 32768
	jmp	$_149

$_154:	test	esi, 0x7FFF0000
	jne	$_139
	mov	rcx, rax
	or	rcx, rdx
	jnz	$_157
	mov	ecx, esi
	add	cx, cx
	jnz	$_157
$_155:	mov	esi, 65535
	movabs	rdx, 0x4000000000000000
	xor	eax, eax
	jmp	$_149

$_156:
	and	cx, 0x7FFF
	cmp	cx, 16383
	jnc	$_159
$_157:	mov	esi, 32767
$_158:	xor	eax, eax
	xor	edx, edx
	jmp	$_149

$_159:	xor	esi, esi
	jmp	$_158

$_160:	mov	rax, rbx
	mov	rdx, rdi
	shr	esi, 16
	jmp	$_149

$_161:	dec	si
	add	esi, 65536
	jc	$_162
	jo	$_162
	jns	$_149
	mov	rcx, rax
	or	rcx, rdx
	jne	$_149
	xor	esi, 0x8000
	jmp	$_149

$_162:	sub	esi, 65536
	mov	rcx, rax
	or	rcx, rdx
	or	rcx, rbx
	or	rcx, rdi
	jz	$_155
	cmp	rdx, rdi
	jc	$_160
	ja	$_149
	cmp	rax, rbx
	jbe	$_160
	jmp	$_149

$_163:
	sub	esi, 65536
	mov	rcx, rbx
	or	rcx, rdi
	jnz	$_160
	mov	ecx, esi
	shl	ecx, 16
	xor	esi, ecx
	and	esi, 0x80000000
	jmp	$_160

$_164:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	r10, rcx
	mov	rbx, qword ptr [rdx]
	mov	rdi, qword ptr [rdx+0x8]
	mov	si, word ptr [rdx+0x10]
	shl	esi, 16
	mov	rax, qword ptr [rcx]
	mov	rdx, qword ptr [rcx+0x8]
	mov	si, word ptr [rcx+0x10]
	add	si, 1
	jc	$_178
	jo	$_178
	add	esi, 65535
	jc	$_181
	jo	$_181
	sub	esi, 65536
	mov	rcx, rax
	or	rcx, rdx
	je	$_170
$_165:	mov	rcx, rbx
	or	rcx, rdi
	je	$_172
$_166:	mov	ecx, esi
	rol	ecx, 16
	sar	ecx, 16
	sar	esi, 16
	and	ecx, 0x80007FFF
	and	esi, 0x80007FFF
	add	esi, ecx
	sub	si, 16382
	jc	$_167
	cmp	si, 32767
	ja	$_174
$_167:	cmp	si, -65
	jl	$_176
	mov	rcx, rbx
	mov	r11, rdi
	mov	r8, rax
	mov	r9, rdi
	mov	rdi, rdx
	mul	rcx
	mov	rbx, rdx
	mov	rax, rdi
	mul	r11
	mov	r11, rdx
	xchg	rax, rcx
	mov	rdx, rdi
	mul	rdx
	add	rbx, rax
	adc	rcx, rdx
	adc	r11, 0
	mov	rax, r8
	mov	rdx, r9
	mul	rdx
	add	rbx, rax
	adc	rcx, rdx
	adc	r11, 0
	mov	rax, rcx
	mov	rdx, r11
	test	rdx, rdx
	js	$_168
	add	rbx, rbx
	adc	rax, rax
	adc	rdx, rdx
	dec	si
$_168:	add	rbx, rbx
	adc	rax, 0
	adc	rdx, 0
	test	si, si
	jle	$_176
	add	esi, esi
	rcr	si, 1
$_169:	mov	qword ptr [r10], rax
	mov	qword ptr [r10+0x8], rdx
	mov	word ptr [r10+0x10], si
	mov	rax, r10
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_170:	add	si, si
	jz	$_171
	rcr	si, 1
	jmp	$_165

$_171:	rcr	si, 1
	test	esi, 0x80008000
	jz	$_176
	mov	esi, 32768
	jmp	$_169

$_172:	test	esi, 0x7FFF0000
	jne	$_166
	test	esi, 0x80008000
	jz	$_176
	mov	esi, 2147483648
	jmp	$_177

$_173:	mov	esi, 65535
	mov	edx, 1
	rol	rdx, 1
	xor	eax, eax
	jmp	$_169

$_174:	mov	esi, 32767
$_175:	xor	eax, eax
	xor	edx, edx
	jmp	$_169

$_176:	xor	esi, esi
	jmp	$_175

$_177:	mov	rax, rbx
	mov	rdx, rdi
	shr	esi, 16
	jmp	$_169

$_178:	dec	si
	add	esi, 65536
	jc	$_179
	jo	$_179
	jns	$_169
	test	rax, rax
	jne	$_169
	test	rdx, rdx
	jne	$_169
	xor	esi, 0x8000
	jmp	$_169

$_179:	sub	esi, 65536
	mov	rcx, rax
	or	rcx, rdx
	or	rcx, rbx
	or	rcx, rdi
	jnz	$_180
	or	esi, 0xFFFFFFFF
	jmp	$_173

$_180:	cmp	rdx, rdi
	jc	$_177
	ja	$_169
	cmp	rax, rbx
	jbe	$_177
	jmp	$_169

$_181:
	sub	esi, 65536
	test	rbx, rbx
	jnz	$_177
	test	rdi, rdi
	jnz	$_177
	mov	ecx, esi
	shl	ecx, 16
	xor	esi, ecx
	and	esi, 0x80000000
	jmp	$_177

__addq:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	rdx, qword ptr [rbp+0x10]
	lea	rcx, [rbp-0x28]
	call	$_104
	mov	rdx, qword ptr [rbp+0x18]
	lea	rcx, [rbp-0x50]
	call	$_104
	lea	rdx, [rbp-0x50]
	lea	rcx, [rbp-0x28]
	call	$_136
	lea	rdx, [rbp-0x28]
	mov	rcx, qword ptr [rbp+0x10]
	call	$_108
	leave
	ret

__subq:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	rdx, qword ptr [rbp+0x10]
	lea	rcx, [rbp-0x28]
	call	$_104
	mov	rdx, qword ptr [rbp+0x18]
	lea	rcx, [rbp-0x50]
	call	$_104
	lea	rdx, [rbp-0x50]
	lea	rcx, [rbp-0x28]
	call	$_137
	lea	rdx, [rbp-0x28]
	mov	rcx, qword ptr [rbp+0x10]
	call	$_108
	leave
	ret

__mulq:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	rdx, qword ptr [rbp+0x10]
	lea	rcx, [rbp-0x28]
	call	$_104
	mov	rdx, qword ptr [rbp+0x18]
	lea	rcx, [rbp-0x50]
	call	$_104
	lea	rdx, [rbp-0x50]
	lea	rcx, [rbp-0x28]
	call	$_164
	lea	rdx, [rbp-0x28]
	mov	rcx, qword ptr [rbp+0x10]
	call	$_108
	leave
	ret

__divq:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	rdx, qword ptr [rbp+0x10]
	lea	rcx, [rbp-0x28]
	call	$_104
	mov	rdx, qword ptr [rbp+0x18]
	lea	rcx, [rbp-0x50]
	call	$_104
	lea	rdx, [rbp-0x50]
	lea	rcx, [rbp-0x28]
	call	$_138
	lea	rdx, [rbp-0x28]
	mov	rcx, qword ptr [rbp+0x10]
	call	$_108
	leave
	ret

__sqrtq:
	mov	qword ptr [rsp+0x8], rcx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	rax, qword ptr [rcx]
	or	eax, dword ptr [rcx+0x8]
	or	ax, word ptr [rcx+0xC]
	mov	dx, word ptr [rcx+0xE]
	and	edx, 0x7FFF
	cmp	edx, 32767
	jnz	$_182
	test	eax, eax
	je	$_185
$_182:	test	edx, edx
	jnz	$_183
	test	eax, eax
	je	$_185
$_183:	test	byte ptr [rcx+0xF], 0xFFFFFF80
	jz	$_184
	mov	rdx, rcx
	call	__subq
	mov	rdx, rax
	mov	rcx, rax
	call	__divq
	jmp	$_185

$_184:	mov	rax, qword ptr [rcx]
	mov	qword ptr [rbp-0x10], rax
	mov	rax, qword ptr [rcx+0x8]
	mov	qword ptr [rbp-0x8], rax
	mov	rdx, rcx
	call	__cvtq_ld
	mov	rcx, qword ptr [rbp+0x10]
	fld	tbyte ptr [rcx]
	fsqrt
	fstp	tbyte ptr [rcx]
	mov	rdx, rcx
	call	$_096
	mov	rdx, qword ptr [rbp+0x10]
	mov	rax, qword ptr [rdx]
	mov	qword ptr [rbp-0x20], rax
	mov	rax, qword ptr [rdx+0x8]
	mov	qword ptr [rbp-0x18], rax
	lea	rcx, [rbp-0x10]
	call	__divq
	mov	rdx, rax
	lea	rcx, [rbp-0x20]
	call	__subq
	mov	qword ptr [rbp-0x10], 0
	mov	dword ptr [rbp-0x8], 0
	mov	dword ptr [rbp-0x4], 1073610752
	lea	rdx, [rbp-0x10]
	lea	rcx, [rbp-0x20]
	call	__mulq
	lea	rdx, [rbp-0x20]
	mov	rcx, qword ptr [rbp+0x10]
	call	__subq
$_185:	leave
	ret

$_186:
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	rdi, rcx
	mov	rsi, rdx
	mov	ecx, r8d
	xor	eax, eax
	mov	qword ptr [rdi], rax
	mov	qword ptr [rdi+0x8], rax
	mov	word ptr [rdi+0x10], ax
	mov	dword ptr [rdi+0x1C], eax
	or	ecx, 0x08
$_187:	lodsb
	test	al, al
	je	$_204
	cmp	al, 32
	jz	$_187
	cmp	al, 9
	jc	$_188
	cmp	al, 13
	jbe	$_187
$_188:	dec	rsi
	and	ecx, 0xFFFFFFF7
	cmp	al, 43
	jnz	$_189
	inc	rsi
	or	ecx, 0x01
$_189:	cmp	al, 45
	jnz	$_190
	inc	rsi
	or	ecx, 0x03
$_190:	lodsb
	test	al, al
	je	$_204
	or	al, 0x20
	cmp	al, 110
	jnz	$_199
	mov	ax, word ptr [rsi]
	or	ax, 0x2020
	cmp	ax, 28257
	jnz	$_197
	add	rsi, 2
	or	ecx, 0x20
	mov	word ptr [rdi+0x10], -1
	movzx	eax, byte ptr [rsi]
	cmp	al, 40
	jnz	$_196
	lea	rdx, [rsi+0x1]
	mov	al, byte ptr [rdx]
	jmp	$_192

$_191:	inc	rdx
	mov	al, byte ptr [rdx]
	jmp	$_192

$_192:	cmp	al, 95
	jz	$_191
	cmp	al, 48
	jc	$_193
	cmp	al, 57
	jbe	$_191
$_193:	cmp	al, 97
	jc	$_194
	cmp	al, 122
	jbe	$_191
$_194:	cmp	al, 65
	jc	$_195
	cmp	al, 90
	jbe	$_191
$_195:	cmp	al, 41
	jnz	$_196
	lea	rsi, [rdx+0x1]
$_196:	jmp	$_198

$_197:	dec	rsi
	or	ecx, 0x80
$_198:	jmp	$_204

$_199:	cmp	al, 105
	jnz	$_202
	mov	ax, word ptr [rsi]
	or	ax, 0x2020
	cmp	ax, 26222
	jnz	$_200
	add	rsi, 2
	or	ecx, 0x40
	jmp	$_201

$_200:	dec	rsi
	or	ecx, 0x80
$_201:	jmp	$_204

$_202:	cmp	al, 48
	jnz	$_203
	mov	al, byte ptr [rsi]
	or	al, 0x20
	cmp	al, 120
	jnz	$_203
	or	ecx, 0x10
	add	rsi, 2
$_203:	dec	rsi
$_204:	mov	dword ptr [rdi+0x18], ecx
	mov	qword ptr [rdi+0x20], rsi
	mov	eax, ecx
	leave
	pop	rdi
	pop	rsi
	ret

$_205:
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	dword ptr [rbp-0x4], 0
	mov	dword ptr [rbp-0x8], 0
	mov	rbx, rcx
	mov	rdi, rdx
	mov	rsi, qword ptr [rbx+0x20]
	mov	ecx, dword ptr [rbx+0x18]
	xor	eax, eax
	xor	edx, edx
$_206:	lodsb
	test	al, al
	jz	$_214
	cmp	al, 46
	jnz	$_207
	test	ecx, 0x800
	jnz	$_214
	or	ecx, 0x800
	jmp	$_213

$_207:	test	ecx, 0x10
	jz	$_209
	or	al, 0x20
	cmp	al, 48
	jc	$_214
	cmp	al, 102
	ja	$_214
	cmp	al, 57
	jbe	$_208
	cmp	al, 97
	jc	$_214
$_208:	jmp	$_210

$_209:	cmp	al, 48
	jc	$_214
	cmp	al, 57
	ja	$_214
$_210:	test	ecx, 0x800
	jz	$_211
	inc	dword ptr [rbp-0x8]
$_211:	or	ecx, 0x400
	or	edx, eax
	cmp	edx, 48
	jz	$_206
	cmp	dword ptr [rbp-0x4], 49
	jge	$_212
	stosb
$_212:	inc	dword ptr [rbp-0x4]
$_213:	jmp	$_206

$_214:
	mov	byte ptr [rdi], 0
	xor	edx, edx
	test	ecx, 0x400
	je	$_231
	xor	edi, edi
	test	ecx, 0x10
	jz	$_215
	cmp	al, 112
	jz	$_216
	cmp	al, 80
	jz	$_216
$_215:	cmp	al, 101
	jz	$_216
	cmp	al, 69
	jnz	$_224
$_216:	mov	al, byte ptr [rsi]
	lea	rdx, [rsi-0x1]
	cmp	al, 43
	jnz	$_217
	inc	rsi
$_217:	cmp	al, 45
	jnz	$_218
	inc	rsi
	or	ecx, 0x04
$_218:	and	ecx, 0xFFFFFBFF
$_219:	movzx	eax, byte ptr [rsi]
	cmp	al, 48
	jc	$_221
	cmp	al, 57
	ja	$_221
	cmp	edi, 100000000
	jnc	$_220
	imul	edi, edi, 10
	lea	edi, [rdi+rax-0x30]
$_220:	or	ecx, 0x400
	inc	rsi
	jmp	$_219

$_221:	test	ecx, 0x4
	jz	$_222
	neg	edi
$_222:	test	ecx, 0x400
	jnz	$_223
	mov	rsi, rdx
$_223:	jmp	$_225

$_224:	dec	rsi
$_225:	mov	edx, edi
	mov	eax, dword ptr [rbp-0x8]
	mov	edi, 38
	test	ecx, 0x10
	jz	$_226
	mov	edi, 32
	shl	eax, 2
$_226:	sub	edx, eax
	mov	eax, 1
	test	ecx, 0x10
	jz	$_227
	mov	eax, 4
$_227:	cmp	dword ptr [rbp-0x4], edi
	jle	$_229
	add	edx, dword ptr [rbp-0x4]
	mov	dword ptr [rbp-0x4], edi
	test	ecx, 0x10
	jz	$_228
	shl	edi, 2
$_228:	sub	edx, edi
$_229:	cmp	dword ptr [rbp-0x4], 0
	jle	$_230
	mov	edi, dword ptr [rbp-0x4]
	add	rdi, qword ptr [rbp+0x30]
	cmp	byte ptr [rdi-0x1], 48
	jnz	$_230
	add	edx, eax
	dec	dword ptr [rbp-0x4]
	jmp	$_229

$_230:	jmp	$_232

$_231:	mov	rsi, qword ptr [rbx+0x20]
$_232:	mov	dword ptr [rbx+0x18], ecx
	mov	qword ptr [rbx+0x20], rsi
	mov	dword ptr [rbx+0x1C], edx
	mov	eax, dword ptr [rbp-0x4]
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

_fltscale:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rbx, rcx
	mov	edi, dword ptr [rbx+0x1C]
	lea	rsi, [_fltpowtable+rip]
	cmp	edi, 0
	jge	$_233
	neg	edi
	add	rsi, 312
$_233:	test	edi, edi
	jz	$_237
	xor	ebx, ebx
$_234:	test	edi, edi
	jz	$_236
	cmp	ebx, 13
	jnc	$_236
	test	edi, 0x1
	jz	$_235
	mov	rdx, rsi
	mov	rcx, qword ptr [rbp+0x28]
	call	$_164
$_235:	inc	ebx
	shr	edi, 1
	add	rsi, 24
	jmp	$_234

$_236:	test	edi, edi
	jz	$_237
	xor	eax, eax
	mov	rbx, qword ptr [rbp+0x28]
	mov	qword ptr [rbx], rax
	mov	qword ptr [rbx+0x8], rax
	mov	word ptr [rbx+0x10], 32767
$_237:	mov	rax, qword ptr [rbp+0x28]
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_238:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 296
	xor	r8d, r8d
	mov	rdx, qword ptr [rbp+0x28]
	lea	rcx, [flt+rip]
	call	$_186
	test	eax, 0xE8
	jne	$_262
	lea	rdx, [rbp-0x100]
	lea	rcx, [flt+rip]
	call	$_205
	mov	dword ptr [rbp-0x104], eax
	test	eax, eax
	jnz	$_239
	or	byte ptr [flt+0x18+rip], 0x08
	jmp	$_262

$_239:	mov	byte ptr [rbp+rax-0x100], 0
	lea	rdx, [rbp-0x100]
	xor	eax, eax
	mov	al, byte ptr [rdx]
	mov	dword ptr [rbp-0x108], eax
	cmp	al, 43
	jz	$_240
	cmp	al, 45
	jnz	$_241
$_240:	inc	rdx
$_241:	mov	ebx, 16
	test	byte ptr [flt+0x18+rip], 0x10
	jnz	$_242
	mov	ebx, 10
$_242:	lea	rsi, [flt+rip]
$_243:	mov	al, byte ptr [rdx]
	test	al, al
	jz	$_245
	and	eax, 0xFFFFFFCF
	bt	eax, 6
	sbb	ecx, ecx
	and	ecx, 0x37
	sub	eax, ecx
	mov	ecx, 8
$_244:	movzx	edi, word ptr [rsi]
	imul	edi, ebx
	add	eax, edi
	mov	word ptr [rsi], ax
	add	rsi, 2
	shr	eax, 16
	dec	rcx
	jnz	$_244
	sub	rsi, 16
	inc	rdx
	jmp	$_243

$_245:	xor	ecx, ecx
	mov	rax, qword ptr [flt+rip]
	mov	rdx, qword ptr [flt+0x8+rip]
	test	rax, rax
	jnz	$_246
	test	rdx, rdx
	jz	$_251
$_246:	test	rdx, rdx
	jz	$_247
	bsr	rcx, rdx
	add	ecx, 64
	jmp	$_248

$_247:	bsr	rcx, rax
$_248:	mov	ch, cl
	mov	cl, 127
	sub	cl, ch
	cmp	cl, 64
	jc	$_249
	sub	cl, 64
	mov	rdx, rax
	xor	eax, eax
$_249:	shld	rdx, rax, cl
	shl	rax, cl
	mov	qword ptr [flt+rip], rax
	mov	qword ptr [flt+0x8+rip], rdx
	shr	ecx, 8
	add	ecx, 16383
	test	byte ptr [flt+0x18+rip], 0x10
	jz	$_250
	add	ecx, dword ptr [flt+0x1C+rip]
$_250:	jmp	$_252

$_251:	or	byte ptr [flt+0x18+rip], 0x08
$_252:	mov	edx, dword ptr [flt+0x18+rip]
	cmp	dword ptr [rbp-0x108], 45
	jz	$_253
	test	edx, 0x2
	jz	$_254
$_253:
	or	cx, 0x8000
$_254:	mov	ebx, ecx
	and	ebx, 0x7FFF
	jmp	$_257

$_255:	or	ecx, 0x7FFF
	xor	eax, eax
	mov	qword ptr [flt+rip], rax
	mov	qword ptr [flt+0x8+rip], rax
	test	edx, 0xA0
	jz	$_256
	or	ecx, 0x8000
	or	byte ptr [flt+0xF+rip], 0xFFFFFF80
$_256:	jmp	$_258

$_257:	test	edx, 0x3E0
	jnz	$_255
	cmp	ebx, 32767
	jnc	$_255
$_258:	mov	word ptr [flt+0x10+rip], cx
	and	ecx, 0x7FFF
	cmp	ecx, 32767
	jc	$_259
	mov	dword ptr [qerrno+rip], 34
	jmp	$_260

$_259:	cmp	dword ptr [flt+0x1C+rip], 0
	jz	$_260
	test	byte ptr [flt+0x18+rip], 0x10
	jnz	$_260
	lea	rcx, [flt+rip]
	call	_fltscale
$_260:	mov	eax, dword ptr [flt+0x1C+rip]
	add	eax, dword ptr [rbp-0x104]
	dec	eax
	cmp	eax, 4932
	jle	$_261
	or	byte ptr [flt+0x19+rip], 0x02
$_261:	cmp	eax, 4294962364
	jge	$_262
	or	byte ptr [flt+0x19+rip], 0x01
$_262:	lea	rdx, [flt+rip]
	lea	rcx, [flt+rip]
	call	$_108
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_263:
	mov	rcx, rdx
	xor	edx, edx
	test	rcx, rcx
	jz	$_264
	div	rcx
	jmp	$_265

$_264:	xor	eax, eax
$_265:	ret

__div64_:
	test	rax, rax
	js	$_266
	test	rdx, rdx
	js	$_266
	call	$_263
	jmp	$_268

$_266:	neg	rax
	test	rdx, rdx
	jns	$_267
	neg	rdx
	call	$_263
	neg	rdx
	jmp	$_268

$_267:	call	$_263
	neg	rdx
	neg	rax
$_268:	ret

__rem64_:
	call	__div64_
	mov	rax, rdx
	ret

_atoow:
	mov	r10, rcx
	mov	r11, rdx
	xor	edx, edx
	mov	qword ptr [rcx], rdx
	mov	qword ptr [rcx+0x8], rdx
	xor	ecx, ecx
	movzx	eax, word ptr [r11]
	or	eax, 0x2000
	cmp	eax, 30768
	jnz	$_269
	add	r11, 2
	sub	r9d, 2
$_269:	cmp	r8d, 16
	jnz	$_271
$_270:	movzx	eax, byte ptr [r11]
	inc	r11
	and	eax, 0xFFFFFFCF
	bt	eax, 6
	sbb	r8d, r8d
	and	r8d, 0x37
	sub	eax, r8d
	shld	rdx, rcx, 4
	shl	rcx, 4
	add	rcx, rax
	dec	r9d
	jnz	$_270
	jmp	$_275

$_271:	cmp	r8d, 10
	jnz	$_273
	mov	cl, byte ptr [r11]
	inc	r11
	sub	cl, 48
$_272:	dec	r9d
	jz	$_275
	mov	r8, rdx
	mov	rax, rcx
	shld	rdx, rcx, 3
	shl	rcx, 3
	add	rcx, rax
	adc	rdx, r8
	add	rcx, rax
	adc	rdx, r8
	movzx	eax, byte ptr [r11]
	inc	r11
	sub	al, 48
	add	rcx, rax
	adc	rdx, 0
	jmp	$_272

$_273:	movzx	eax, byte ptr [r11]
	and	eax, 0xFFFFFFCF
	bt	eax, 6
	sbb	ecx, ecx
	and	ecx, 0x37
	sub	eax, ecx
	mov	ecx, 8
$_274:	movzx	edx, word ptr [r10]
	imul	edx, r8d
	add	eax, edx
	mov	word ptr [r10], ax
	add	r10, 2
	shr	eax, 16
	dec	ecx
	jnz	$_274
	sub	r10, 16
	inc	r11
	dec	r9d
	jnz	$_273
	mov	rcx, qword ptr [r10]
	mov	rdx, qword ptr [r10+0x8]
$_275:	mov	rax, r10
	mov	qword ptr [rax], rcx
	mov	qword ptr [rax+0x8], rdx
	ret

_atoqw:
	push	rbx
	push	rbp
	mov	rbp, rsp
	xor	edx, edx
	xor	eax, eax
$_276:	mov	dl, byte ptr [rcx]
	inc	rcx
	cmp	dl, 32
	jz	$_276
	mov	bl, dl
	cmp	dl, 43
	jz	$_277
	cmp	dl, 45
	jnz	$_278
$_277:	mov	dl, byte ptr [rcx]
	inc	rcx
$_278:	sub	dl, 48
	jc	$_279
	cmp	dl, 9
	ja	$_279
	imul	eax, eax, 10
	add	eax, edx
	mov	dl, byte ptr [rcx]
	inc	rcx
	jmp	$_278

$_279:
	cmp	bl, 45
	jnz	$_280
	neg	eax
$_280:	leave
	pop	rbx
	ret

atofloat:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	dword ptr [qerrno+rip], 0
	cmp	byte ptr [rbp+0x30], 0
	je	$_283
	mov	rcx, qword ptr [rbp+0x18]
	call	tstrlen@PLT
	lea	eax, [rax-0x1]
	mov	dword ptr [rbp+0x28], eax
	jmp	$_281

$C00F1: jmp	$_282

$C00F7: mov	rcx, qword ptr [rbp+0x18]
	cmp	byte ptr [rcx], 48
	jnz	$C00FD
	inc	qword ptr [rbp+0x18]
	dec	dword ptr [rbp+0x28]
	jmp	$_282

$C00FD: mov	rdx, qword ptr [rbp+0x18]
	mov	ecx, 2104
	call	asmerr@PLT
	jmp	$_282

$_281:	cmp	eax, 4
	jl	$C00FD
	cmp	eax, 33
	jg	$C00FD
	push	rax
	lea	r11, [$C00FD+rip]
	movzx	eax, byte ptr [r11+rax-(4)+(IT$C00FE-$C00FD)]
	movzx	eax, byte ptr [r11+rax*1+($C00FE-$C00FD)]
	sub	r11, rax
	pop	rax
	jmp	r11
$C00FE:
	.byte $C00FD-$C00F1
	.byte $C00FD-$C00F7
	.byte 0
IT$C00FE:
	.byte 0
	.byte 1
	.byte 2
	.byte 2
	.byte 0
	.byte 1
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 2
	.byte 0
	.byte 1
	.byte 2
	.byte 2
	.byte 0
	.byte 1
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
	.byte 0
	.byte 1

$_282:	mov	r9d, dword ptr [rbp+0x28]
	mov	r8d, 16
	mov	rdx, qword ptr [rbp+0x18]
	mov	rcx, qword ptr [rbp+0x10]
	call	_atoow
	mov	eax, dword ptr [rbp+0x20]
	mov	rcx, qword ptr [rbp+0x10]
	mov	rdx, rcx
	add	rcx, rax
	add	rdx, 16
$C00FF: cmp	rcx, rdx
	jnc	$C0101
	cmp	byte ptr [rcx], 0
	jz	$C0100
	mov	rdx, qword ptr [rbp+0x18]
	mov	ecx, 2104
	call	asmerr@PLT
	jmp	$C0101

$C0100: inc	rcx
	jmp	$C00FF

$C0101: mov	eax, dword ptr [rbp+0x28]
	shr	eax, 1
	cmp	eax, dword ptr [rbp+0x20]
	je	$C0103
	jmp	$C0104
$C0105: mov	rdx, qword ptr [rbp+0x10]
	mov	rcx, qword ptr [rbp+0x10]
	call	__cvth_q
	jmp	$C0106
$C0107: mov	rdx, qword ptr [rbp+0x10]
	mov	rcx, qword ptr [rbp+0x10]
	call	__cvtss_q
	jmp	$C0106
$C0108: mov	rdx, qword ptr [rbp+0x10]
	mov	rcx, qword ptr [rbp+0x10]
	call	__cvtsd_q
	jmp	$C0106
$C0109: mov	rdx, qword ptr [rbp+0x10]
	mov	rcx, qword ptr [rbp+0x10]
	call	$_096
	jmp	$C0106
$C010A: jmp	$C0106
$C010B: cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$C010C
	mov	ecx, 7004
	call	asmerr@PLT
$C010C: mov	r8d, dword ptr [rbp+0x20]
	xor	edx, edx
	mov	rcx, qword ptr [rbp+0x10]
	call	tmemset@PLT
	jmp	$C0106
$C0104: cmp	eax, 2
	jz	$C0105
	cmp	eax, 4
	jz	$C0107
	cmp	eax, 8
	jz	$C0108
	cmp	eax, 10
	jz	$C0109
	cmp	eax, 16
	jz	$C010A
	jmp	$C010B

$C0106: cmp	dword ptr [qerrno+rip], 0
	jz	$C0103
	mov	ecx, 2071
	call	asmerr@PLT
$C0103: jmp	$_297

$_283:	mov	rcx, qword ptr [rbp+0x18]
	call	$_238
	mov	rdx, rax
	mov	rcx, qword ptr [rbp+0x10]
	mov	rax, qword ptr [rdx]
	mov	qword ptr [rcx], rax
	mov	rax, qword ptr [rdx+0x8]
	mov	qword ptr [rcx+0x8], rax
	cmp	dword ptr [qerrno+rip], 0
	jz	$_284
	mov	rdx, qword ptr [rbp+0x18]
	mov	ecx, 2104
	call	asmerr@PLT
$_284:	cmp	dword ptr [rbp+0x28], 0
	jz	$_285
	mov	rcx, qword ptr [rbp+0x10]
	or	byte ptr [rcx+0xF], 0xFFFFFF80
$_285:	mov	eax, dword ptr [rbp+0x20]
	jmp	$_296

$_286:	mov	rdx, qword ptr [rbp+0x10]
	mov	rcx, qword ptr [rbp+0x10]
	call	$_037
	cmp	dword ptr [qerrno+rip], 0
	jz	$_287
	mov	ecx, 2071
	call	asmerr@PLT
$_287:	jmp	$_297

$_288:	mov	rdx, qword ptr [rbp+0x10]
	mov	rcx, qword ptr [rbp+0x10]
	call	__cvtq_ss
	cmp	dword ptr [qerrno+rip], 0
	jz	$_289
	mov	ecx, 2071
	call	asmerr@PLT
$_289:	jmp	$_297

$_290:	mov	rdx, qword ptr [rbp+0x10]
	mov	rcx, qword ptr [rbp+0x10]
	call	__cvtq_sd
	cmp	dword ptr [qerrno+rip], 0
	jz	$_291
	mov	ecx, 2071
	call	asmerr@PLT
$_291:	jmp	$_297

$_292:	mov	rdx, qword ptr [rbp+0x10]
	mov	rcx, qword ptr [rbp+0x10]
	call	__cvtq_ld
$_293:	jmp	$_297

$_294:	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_295
	mov	ecx, 7004
	call	asmerr@PLT
$_295:	mov	r8d, dword ptr [rbp+0x20]
	xor	edx, edx
	mov	rcx, qword ptr [rbp+0x10]
	call	tmemset@PLT
	jmp	$_297

$_296:	cmp	al, 2
	je	$_286
	cmp	al, 4
	je	$_288
	cmp	al, 8
	jz	$_290
	cmp	al, 10
	jz	$_292
	cmp	al, 16
	jz	$_293
	jmp	$_294

$_297:
	leave
	ret

quad_resize:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rsi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	dword ptr [qerrno+rip], 0
	mov	rbx, qword ptr [rbp+0x20]
	movzx	esi, word ptr [rbx+0xE]
	and	esi, 0x7FFF
	mov	eax, dword ptr [rbp+0x28]
	jmp	$_308

$_298:	mov	rdx, rbx
	mov	rcx, rbx
	call	__cvtq_ld
	jmp	$_309

$_299:	test	byte ptr [rbx+0xF], 0xFFFFFF80
	jz	$_300
	or	byte ptr [rbx+0x43], 0x20
	and	byte ptr [rbx+0xF], 0x7F
$_300:	mov	rdx, rbx
	mov	rcx, rbx
	call	__cvtq_sd
	test	byte ptr [rbx+0x43], 0x20
	jz	$_301
	or	byte ptr [rbx+0x7], 0xFFFFFF80
$_301:	mov	byte ptr [rbx+0x40], 39
	jmp	$_309

$_302:	test	byte ptr [rbx+0xF], 0xFFFFFF80
	jz	$_303
	or	byte ptr [rbx+0x43], 0x20
	and	byte ptr [rbx+0xF], 0x7F
$_303:	mov	rdx, rbx
	mov	rcx, rbx
	call	__cvtq_ss
	test	byte ptr [rbx+0x43], 0x20
	jz	$_304
	or	byte ptr [rbx+0x3], 0xFFFFFF80
$_304:	mov	byte ptr [rbx+0x40], 35
	jmp	$_309

$_305:	test	byte ptr [rbx+0xF], 0xFFFFFF80
	jz	$_306
	or	byte ptr [rbx+0x43], 0x20
	and	byte ptr [rbx+0xF], 0x7F
$_306:	mov	rdx, rbx
	mov	rcx, rbx
	call	$_037
	test	byte ptr [rbx+0x43], 0x20
	jz	$_307
	or	byte ptr [rbx+0x1], 0xFFFFFF80
$_307:	mov	byte ptr [rbx+0x40], 33
	jmp	$_309

$_308:	cmp	eax, 10
	je	$_298
	cmp	eax, 8
	je	$_299
	cmp	eax, 4
	jz	$_302
	cmp	eax, 2
	jz	$_305
$_309:	cmp	dword ptr [qerrno+rip], 0
	jz	$_310
	cmp	esi, 32767
	jz	$_310
	mov	ecx, 2071
	call	asmerr@PLT
$_310:	leave
	pop	rbx
	pop	rsi
	ret

$_311:
	mov	dx, word ptr [rcx+0x10]
	mov	eax, edx
	and	eax, 0x7FFF
	cmp	eax, 16383
	jge	$_313
	xor	eax, eax
	test	dx, 0x8000
	jz	$_312
	dec	rax
$_312:	jmp	$_316

$_313:	cmp	eax, 16445
	jle	$_315
	mov	dword ptr [qerrno+rip], 34
	movabs	rax, 0x7FFFFFFFFFFFFFFF
	test	edx, 0x8000
	jz	$_314
	movabs	rax, 0x8000000000000000
$_314:	jmp	$_316

$_315:	mov	r10, qword ptr [rcx+0x8]
	mov	ecx, eax
	xor	eax, eax
	sub	ecx, 16383
	shl	r10, 1
	adc	eax, eax
	shld	rax, r10, cl
	test	edx, 0x8000
	jz	$_316
	neg	rax
$_316:	ret

$_317:
	mov	rax, rdx
	mov	rdx, rcx
	mov	r8d, 16383
	test	rax, rax
	jns	$_318
	neg	rax
	or	r8d, 0x8000
$_318:	xor	r9d, r9d
	test	rax, rax
	jz	$_319
	bsr	r9, rax
	mov	ecx, 63
	sub	ecx, r9d
	shl	rax, cl
	add	r9d, r8d
$_319:	xor	ecx, ecx
	mov	qword ptr [rdx], rcx
	mov	qword ptr [rdx+0x8], rax
	mov	word ptr [rdx+0x10], r9w
	mov	rax, rdx
	ret

_flttostr:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 664
	mov	rbx, rdx
	mov	rcx, r8
	mov	eax, dword ptr [rbx+0x2C]
	add	rax, rcx
	dec	rax
	mov	qword ptr [rbp-0x270], rax
	mov	eax, 20
	test	byte ptr [rbp+0x42], 0x10
	jz	$_320
	mov	eax, 23
	jmp	$_321

$_320:	test	byte ptr [rbp+0x42], 0x20
	jz	$_321
	mov	eax, 33
$_321:	mov	dword ptr [rbp-0x18], eax
	xor	eax, eax
	mov	dword ptr [rbx+0x1C], eax
	mov	dword ptr [rbx+0x20], eax
	mov	dword ptr [rbx+0x24], eax
	mov	dword ptr [rbx+0x28], eax
	mov	dword ptr [rbx+0x18], eax
	mov	rdx, qword ptr [rbp+0x28]
	lea	rcx, [rbp-0x40]
	call	$_104
	mov	ax, word ptr [rbp-0x30]
	bt	eax, 15
	sbb	ecx, ecx
	mov	dword ptr [rbx+0x14], ecx
	and	eax, 0x7FFF
	mov	word ptr [rbp-0x30], ax
	movzx	ecx, ax
	xor	eax, eax
	mov	dword ptr [rbp-0x28], eax
	cmp	ecx, 32767
	jnz	$_325
	or	rax, qword ptr [rbp-0x40]
	or	rax, qword ptr [rbp-0x38]
	jnz	$_322
	mov	eax, 6712937
	or	byte ptr [rbx+0x8], 0x40
	jmp	$_323

$_322:	mov	eax, 7233902
	or	byte ptr [rbx+0x8], 0x20
$_323:	test	byte ptr [rbp+0x42], 0x01
	jz	$_324
	and	eax, 0xFFDFDFDF
$_324:	mov	rcx, qword ptr [rbp+0x38]
	mov	dword ptr [rcx], eax
	mov	dword ptr [rbx+0x1C], 3
	mov	eax, 64
	jmp	$_416

$_325:	test	ecx, ecx
	jnz	$_326
	mov	dword ptr [rbx+0x14], eax
	mov	dword ptr [rbp-0x10], eax
	mov	dword ptr [rbp-0x28], 8
	jmp	$_332

$_326:	mov	esi, ecx
	sub	ecx, 16382
	mov	eax, 30103
	imul	ecx
	mov	ecx, 100000
	idiv	ecx
	sub	eax, 8
	mov	dword ptr [rbp-0x10], eax
	test	eax, eax
	je	$_332
	jns	$_327
	neg	eax
	add	eax, 7
	and	eax, 0xFFFFFFF8
	neg	eax
	mov	dword ptr [rbp-0x10], eax
	neg	eax
	mov	dword ptr [rbp-0x24], eax
	lea	rcx, [rbp-0x40]
	call	_fltscale
	jmp	$_332

$_327:	mov	eax, dword ptr [rbp-0x38]
	mov	edx, dword ptr [rbp-0x34]
	cmp	esi, 16436
	jc	$_328
	cmp	esi, 16436
	jnz	$_329
	cmp	edx, -1910781505
	jc	$_328
	cmp	edx, -1910781505
	jnz	$_329
	cmp	eax, 67108864
	jnc	$_329
$_328:	mov	dword ptr [rbp-0x10], 0
	jmp	$_332

$_329:	cmp	esi, 16489
	jc	$_330
	cmp	esi, 16489
	jnz	$_331
	cmp	edx, -1647989336
	jc	$_330
	cmp	edx, -1647989336
	jnz	$_331
	cmp	eax, 728806813
	jnc	$_331
$_330:	mov	dword ptr [rbp-0x10], 16
$_331:	mov	eax, dword ptr [rbp-0x10]
	and	eax, 0xFFFFFFF8
	mov	dword ptr [rbp-0x10], eax
	neg	eax
	mov	dword ptr [rbp-0x24], eax
	lea	rcx, [rbp-0x40]
	call	_fltscale
$_332:	mov	eax, dword ptr [rbx]
	test	byte ptr [rbx+0x9], 0x20
	jz	$_334
	add	eax, dword ptr [rbp-0x10]
	add	eax, 18
	cmp	dword ptr [rbx+0x4], 0
	jle	$_333
	add	eax, dword ptr [rbx+0x4]
$_333:	jmp	$_335

$_334:	add	eax, 24
$_335:	cmp	eax, 495
	jbe	$_336
	mov	eax, 495
$_336:	mov	dword ptr [rbp-0x8], eax
	mov	ecx, dword ptr [rbp-0x18]
	add	ecx, 8
	mov	dword ptr [rbp-0x14], ecx
	xor	eax, eax
	mov	qword ptr [rbp-0x278], rax
	lea	rdi, [rbp-0x268]
	mov	word ptr [rdi], 48
	inc	rdi
	mov	dword ptr [rbp-0x4], 0
	jmp	$_343

$_337:	sub	dword ptr [rbp-0x8], 16
	cmp	qword ptr [rbp-0x278], 0
	jnz	$_338
	lea	rcx, [rbp-0x40]
	call	$_311
	mov	qword ptr [rbp-0x278], rax
	cmp	dword ptr [rbp-0x8], 0
	jle	$_338
	mov	rdx, qword ptr [rbp-0x278]
	lea	rcx, [rbp-0x68]
	call	$_317
	lea	rdx, [rbp-0x68]
	lea	rcx, [rbp-0x40]
	call	$_137
	lea	rdx, [_fltpowtable+0x60+rip]
	lea	rcx, [rbp-0x40]
	call	$_164
$_338:	mov	ecx, 16
	mov	rax, qword ptr [rbp-0x278]
	mov	qword ptr [rbp-0x278], 0
	test	rax, rax
	jz	$_341
	mov	r8d, 10
$_339:	test	ecx, ecx
	jz	$_340
	xor	edx, edx
	div	r8
	add	dl, 48
	mov	byte ptr [rdi+rcx-0x1], dl
	dec	ecx
	jmp	$_339

$_340:	add	rdi, 16
	jmp	$_342

$_341:	mov	al, 48
	rep stosb
$_342:	add	dword ptr [rbp-0x4], 16
$_343:	cmp	dword ptr [rbp-0x8], 0
	jg	$_337
	mov	eax, dword ptr [rbp-0x4]
	mov	edx, 510
	lea	rsi, [rbp-0x267]
	mov	ecx, dword ptr [rbp-0x10]
	add	ecx, 15
$_344:	test	edx, edx
	jz	$_345
	cmp	byte ptr [rsi], 48
	jnz	$_345
	dec	eax
	dec	ecx
	dec	edx
	inc	rsi
	jmp	$_344

$_345:	mov	dword ptr [rbp-0x8], eax
	mov	rbx, qword ptr [rbp+0x30]
	mov	edx, dword ptr [rbx]
	test	byte ptr [rbx+0x9], 0x20
	jz	$_346
	add	ecx, dword ptr [rbx+0x4]
	lea	edx, [rdx+rcx+0x1]
	jmp	$_349

$_346:	test	byte ptr [rbx+0x9], 0x10
	jz	$_349
	cmp	dword ptr [rbx+0x4], 0
	jle	$_347
	inc	edx
	jmp	$_348

$_347:	add	edx, dword ptr [rbx+0x4]
$_348:	inc	ecx
	sub	ecx, dword ptr [rbx+0x4]
$_349:	cmp	edx, 0
	jl	$_360
	cmp	edx, eax
	jle	$_350
	mov	edx, eax
$_350:	mov	eax, dword ptr [rbp-0x18]
	cmp	edx, eax
	jle	$_351
	mov	edx, eax
$_351:	mov	dword ptr [rbp-0x14], eax
	mov	eax, 48
	cmp	dword ptr [rbp-0x8], edx
	jle	$_352
	cmp	byte ptr [rsi+rdx], 53
	jge	$_353
$_352:	cmp	edx, dword ptr [rbp-0x18]
	jnz	$_354
	cmp	byte ptr [rsi+rdx-0x1], 57
	jnz	$_354
$_353:	mov	al, 57
$_354:	mov	edi, dword ptr [rbx+0x4]
	add	edi, dword ptr [rbx]
	cmp	al, 57
	jnz	$_358
	cmp	edx, edi
	jnz	$_358
	cmp	byte ptr [rsi+rdx], 57
	jz	$_358
	cmp	byte ptr [rsi+rdx-0x1], 57
	jnz	$_358
	jmp	$_356

$_355:	dec	edi
	cmp	byte ptr [rsi+rdi], 57
	jnz	$_357
$_356:	test	edi, edi
	jnz	$_355
$_357:	cmp	byte ptr [rsi+rdi], 57
	jnz	$_358
	mov	al, 48
$_358:	lea	rdi, [rsi+rdx-0x1]
	xchg	edx, ecx
	inc	ecx
	std
	repe scasb
	cld
	xchg	edx, ecx
	inc	rdi
	cmp	al, 57
	jnz	$_359
	inc	byte ptr [rdi]
$_359:	sub	rdi, rsi
	jns	$_360
	dec	rsi
	inc	edx
	inc	ecx
$_360:	cmp	edx, 0
	jle	$_361
	cmp	dword ptr [rbp-0x28], 8
	jnz	$_362
$_361:	mov	edx, 1
	xor	ecx, ecx
	mov	byte ptr [rbp-0x268], 48
	mov	dword ptr [rbx+0x14], ecx
	lea	rsi, [rbp-0x268]
$_362:	mov	dword ptr [rbp-0x4], 0
	mov	eax, dword ptr [rbx+0x8]
	test	eax, 0x2000
	jnz	$_364
	test	eax, 0x4000
	je	$_381
	cmp	ecx, -1
	jl	$_363
	cmp	ecx, dword ptr [rbx]
	jl	$_364
$_363:	test	eax, 0x8000
	je	$_381
$_364:	mov	rdi, qword ptr [rbp+0x38]
	inc	ecx
	test	eax, 0x4000
	jz	$_366
	cmp	edx, dword ptr [rbx]
	jge	$_365
	test	eax, 0x800
	jnz	$_365
	mov	dword ptr [rbx], edx
$_365:	sub	dword ptr [rbx], ecx
	cmp	dword ptr [rbx], 0
	jge	$_366
	mov	dword ptr [rbx], 0
$_366:	cmp	ecx, 0
	jg	$_371
	test	eax, 0x8000
	jnz	$_368
	mov	byte ptr [rdi], 48
	inc	dword ptr [rbp-0x4]
	cmp	dword ptr [rbx], 0
	jg	$_367
	test	eax, 0x800
	jz	$_368
$_367:	mov	byte ptr [rdi+0x1], 46
	inc	dword ptr [rbp-0x4]
$_368:	mov	eax, dword ptr [rbp-0x4]
	mov	dword ptr [rbx+0x1C], eax
	mov	eax, ecx
	neg	eax
	cmp	dword ptr [rbx], eax
	jge	$_369
	mov	ecx, dword ptr [rbx]
	neg	ecx
$_369:	mov	eax, ecx
	neg	eax
	mov	dword ptr [rbx+0x18], eax
	mov	dword ptr [rbx+0x20], eax
	add	dword ptr [rbx], ecx
	cmp	dword ptr [rbx], edx
	jge	$_370
	mov	edx, dword ptr [rbx]
$_370:	mov	dword ptr [rbx+0x24], edx
	sub	edx, dword ptr [rbx]
	neg	edx
	mov	dword ptr [rbx+0x28], edx
	mov	ecx, dword ptr [rbx+0x1C]
	add	rdi, rcx
	mov	ecx, dword ptr [rbx+0x20]
	mov	eax, dword ptr [rbx+0x24]
	add	eax, dword ptr [rbx+0x28]
	add	eax, ecx
	lea	rax, [rdi+rax]
	cmp	rax, qword ptr [rbp-0x270]
	ja	$_417
	add	dword ptr [rbp-0x4], ecx
	mov	al, 48
	rep stosb
	mov	ecx, dword ptr [rbx+0x24]
	add	dword ptr [rbp-0x4], ecx
	rep movsb
	mov	ecx, dword ptr [rbx+0x28]
	add	dword ptr [rbp-0x4], ecx
	rep stosb
	jmp	$_380

$_371:	cmp	edx, ecx
	jge	$_374
	add	dword ptr [rbp-0x4], edx
	mov	dword ptr [rbx+0x1C], edx
	mov	eax, ecx
	sub	eax, edx
	mov	dword ptr [rbx+0x20], eax
	mov	dword ptr [rbx+0x18], ecx
	mov	ecx, edx
	rep movsb
	lea	rcx, [rdi+rax+0x2]
	cmp	rcx, qword ptr [rbp-0x270]
	ja	$_417
	mov	ecx, eax
	mov	eax, 48
	add	dword ptr [rbp-0x4], ecx
	rep stosb
	mov	ecx, dword ptr [rbx]
	test	byte ptr [rbx+0x9], 0xFFFFFF80
	jnz	$_373
	cmp	ecx, 0
	jg	$_372
	test	byte ptr [rbx+0x9], 0x08
	jz	$_373
$_372:	mov	byte ptr [rdi], 46
	inc	rdi
	inc	dword ptr [rbp-0x4]
	mov	dword ptr [rbx+0x24], 1
$_373:	lea	rdx, [rdi+rcx]
	cmp	rdx, qword ptr [rbp-0x270]
	ja	$_417
	mov	dword ptr [rbx+0x28], ecx
	add	dword ptr [rbp-0x4], ecx
	rep stosb
	jmp	$_380

$_374:	mov	dword ptr [rbx+0x18], ecx
	add	dword ptr [rbp-0x4], ecx
	sub	edx, ecx
	rep movsb
	mov	rdi, qword ptr [rbp+0x38]
	mov	ecx, dword ptr [rbx+0x18]
	test	byte ptr [rbx+0x9], 0xFFFFFF80
	jnz	$_377
	cmp	dword ptr [rbx], 0
	jg	$_375
	test	byte ptr [rbx+0x9], 0x08
	jz	$_376
$_375:	mov	eax, dword ptr [rbp-0x4]
	mov	byte ptr [rdi+rax], 46
	inc	dword ptr [rbp-0x4]
$_376:	jmp	$_378

$_377:	cmp	byte ptr [rdi], 48
	jnz	$_378
	mov	dword ptr [rbx+0x18], 0
$_378:	cmp	dword ptr [rbx], edx
	jge	$_379
	mov	edx, dword ptr [rbx]
$_379:	mov	eax, dword ptr [rbp-0x4]
	add	rdi, rax
	mov	ecx, edx
	rep movsb
	add	dword ptr [rbp-0x4], edx
	mov	eax, dword ptr [rbp-0x4]
	mov	dword ptr [rbx+0x1C], eax
	mov	eax, edx
	mov	ecx, dword ptr [rbx]
	add	edx, ecx
	mov	dword ptr [rbx+0x20], edx
	sub	ecx, eax
	add	dword ptr [rbp-0x4], ecx
	lea	rdx, [rdi+rcx]
	cmp	rdx, qword ptr [rbp-0x270]
	ja	$_417
	mov	eax, 48
	rep stosb
$_380:	mov	edi, dword ptr [rbp-0x4]
	add	rdi, qword ptr [rbp+0x38]
	mov	byte ptr [rdi], 0
	jmp	$_416

$_381:	mov	eax, dword ptr [rbx]
	cmp	dword ptr [rbx+0x4], 0
	jg	$_382
	add	eax, dword ptr [rbx+0x4]
	jmp	$_383

$_382:	sub	eax, dword ptr [rbx+0x4]
	inc	eax
$_383:	mov	dword ptr [rbp-0x4], 0
	test	byte ptr [rbx+0x9], 0x40
	jz	$_386
	cmp	edx, eax
	jnc	$_384
	test	byte ptr [rbx+0x9], 0x08
	jnz	$_384
	mov	eax, edx
$_384:	dec	eax
	cmp	eax, 0
	jge	$_385
	xor	eax, eax
$_385:	cmp	ecx, -5
	jle	$_386
	cmp	ecx, 0
	jge	$_386
	neg	ecx
	add	eax, ecx
	add	edx, ecx
	sub	rsi, rcx
	xor	ecx, ecx
$_386:	mov	dword ptr [rbx], eax
	mov	dword ptr [rbp-0x10], ecx
	mov	dword ptr [rbp-0xC], edx
	mov	rdi, qword ptr [rbp+0x38]
	cmp	dword ptr [rbx+0x4], 0
	jg	$_388
	mov	byte ptr [rdi], 48
	inc	dword ptr [rbp-0x4]
	cmp	ecx, dword ptr [rbp-0x14]
	jl	$_387
	inc	dword ptr [rbp-0x10]
$_387:	jmp	$_390

$_388:	mov	eax, dword ptr [rbx+0x4]
	cmp	eax, edx
	jbe	$_389
	mov	eax, edx
$_389:	mov	edx, eax
	mov	ecx, dword ptr [rbp-0x4]
	add	rdi, rcx
	mov	ecx, eax
	mov	rax, rsi
	rep movsb
	mov	rsi, rax
	add	dword ptr [rbp-0x4], edx
	add	rsi, rdx
	sub	dword ptr [rbp-0xC], edx
	cmp	edx, dword ptr [rbx+0x4]
	jge	$_390
	mov	ecx, dword ptr [rbx+0x4]
	sub	ecx, edx
	add	dword ptr [rbp-0x4], ecx
	mov	edi, dword ptr [rbp-0x4]
	add	rdi, qword ptr [rbp+0x38]
	mov	al, 48
	rep stosb
$_390:	mov	edx, dword ptr [rbp-0x4]
	mov	rdi, qword ptr [rbp+0x38]
	mov	dword ptr [rbx+0x18], edx
	mov	eax, dword ptr [rbx]
	test	byte ptr [rbx+0x9], 0xFFFFFF80
	jnz	$_392
	cmp	eax, 0
	jg	$_391
	test	byte ptr [rbx+0x9], 0x08
	jz	$_392
$_391:	mov	byte ptr [rdi+rdx], 46
	inc	dword ptr [rbp-0x4]
$_392:	mov	ecx, dword ptr [rbx+0x4]
	cmp	ecx, 0
	jge	$_393
	neg	ecx
	add	rdi, rdx
	add	dword ptr [rbp-0x4], ecx
	mov	al, 48
	rep stosb
$_393:	mov	ecx, dword ptr [rbp-0xC]
	mov	eax, dword ptr [rbx]
	cmp	eax, 0
	jle	$_396
	cmp	eax, ecx
	jge	$_394
	mov	ecx, eax
	mov	dword ptr [rbp-0xC], eax
$_394:	test	ecx, ecx
	jz	$_395
	mov	edi, dword ptr [rbp-0x4]
	add	rdi, qword ptr [rbp+0x38]
	add	dword ptr [rbp-0x4], ecx
	rep movsb
$_395:	mov	eax, dword ptr [rbp-0x4]
	mov	dword ptr [rbx+0x1C], eax
	mov	ecx, dword ptr [rbx]
	sub	ecx, dword ptr [rbp-0xC]
	mov	dword ptr [rbx+0x20], ecx
	mov	edi, dword ptr [rbp-0x4]
	add	rdi, qword ptr [rbp+0x38]
	add	dword ptr [rbp-0x4], ecx
	mov	eax, 48
	rep stosb
$_396:	mov	edi, dword ptr [rbp-0x10]
	mov	rsi, qword ptr [rbp+0x38]
	mov	ecx, dword ptr [rbp-0x4]
	test	byte ptr [rbx+0x9], 0x40
	jz	$_397
	test	edi, edi
	jnz	$_397
	mov	edx, ecx
	jmp	$_415

$_397:	mov	eax, dword ptr [rbx+0xC]
	test	al, al
	jz	$_398
	mov	byte ptr [rsi+rcx], al
	inc	dword ptr [rbp-0x4]
	inc	ecx
$_398:	cmp	edi, 0
	jl	$_399
	mov	byte ptr [rsi+rcx], 43
	jmp	$_400

$_399:	mov	byte ptr [rsi+rcx], 45
	neg	edi
$_400:	inc	dword ptr [rbp-0x4]
	mov	eax, edi
	mov	ecx, dword ptr [rbx+0x10]
	jmp	$_407

$_401:	mov	ecx, 3
	cmp	eax, 1000
	jl	$_402
	mov	ecx, 4
$_402:	jmp	$_408

$_403:	cmp	eax, 10
	jl	$_404
	mov	ecx, 2
$_404:	cmp	eax, 100
	jl	$_405
	mov	ecx, 3
$_405:	cmp	eax, 1000
	jl	$_406
	mov	ecx, 4
$_406:	jmp	$_408

$_407:	cmp	ecx, 0
	jz	$_401
	cmp	ecx, 1
	jz	$_403
	cmp	ecx, 2
	jz	$_404
	cmp	ecx, 3
	jz	$_405
$_408:	mov	dword ptr [rbx+0x10], ecx
	cmp	ecx, 4
	jc	$_410
	xor	edx, edx
	cmp	eax, 1000
	jc	$_409
	mov	ecx, 1000
	div	ecx
	mov	edx, eax
	imul	eax, eax, 1000
	sub	edi, eax
	mov	ecx, dword ptr [rbx+0x10]
$_409:	lea	eax, [rdx+0x30]
	mov	edx, dword ptr [rbp-0x4]
	mov	byte ptr [rsi+rdx], al
	inc	dword ptr [rbp-0x4]
$_410:	cmp	ecx, 3
	jc	$_412
	xor	edx, edx
	cmp	edi, 100
	jl	$_411
	mov	eax, edi
	mov	ecx, 100
	div	ecx
	mov	edx, eax
	imul	eax, eax, 100
	sub	edi, eax
	mov	ecx, dword ptr [rbx+0x10]
$_411:	lea	eax, [rdx+0x30]
	mov	edx, dword ptr [rbp-0x4]
	mov	byte ptr [rsi+rdx], al
	inc	dword ptr [rbp-0x4]
$_412:	cmp	ecx, 2
	jc	$_414
	xor	edx, edx
	cmp	edi, 10
	jl	$_413
	mov	eax, edi
	mov	ecx, 10
	div	ecx
	mov	edx, eax
	imul	eax, eax, 10
	sub	edi, eax
	mov	ecx, dword ptr [rbx+0x10]
$_413:	lea	eax, [rdx+0x30]
	mov	edx, dword ptr [rbp-0x4]
	mov	byte ptr [rsi+rdx], al
	inc	dword ptr [rbp-0x4]
$_414:	mov	edx, dword ptr [rbp-0x4]
	lea	eax, [rdi+0x30]
	mov	byte ptr [rsi+rdx], al
	inc	edx
$_415:	mov	eax, edx
	sub	eax, dword ptr [rbx+0x1C]
	mov	dword ptr [rbx+0x24], eax
	xor	eax, eax
	mov	byte ptr [rsi+rdx], al
$_416:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_417:
	mov	rdi, qword ptr [rbp+0x38]
	lea	rsi, [e_space+rip]
	mov	ecx, 18
	rep movsb
	jmp	$_416


.SECTION .data
	.ALIGN	16

_fltpowtable:
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA0
	.byte  0x02, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC8
	.byte  0x05, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x9C
	.byte  0x0C, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0xBC, 0xBE
	.byte  0x19, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x04, 0xBF, 0xC9, 0x1B, 0x8E
	.byte  0x34, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0xF0
	.byte  0x9D, 0xB5, 0x70, 0x2B, 0xA8, 0xAD, 0xC5, 0x9D
	.byte  0x69, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0xFE, 0x25, 0x6B, 0xC7, 0x71, 0x6B, 0xBF, 0x3C
	.byte  0xD5, 0xA6, 0xCF, 0xFF, 0x49, 0x1F, 0x78, 0xC2
	.byte  0xD3, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x37, 0x01, 0xB1, 0x36, 0x6C, 0x33, 0x6F, 0xC6
	.byte  0xDF, 0x8C, 0xE9, 0x80, 0xC9, 0x47, 0xBA, 0x93
	.byte  0xA8, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0xB7, 0xEA, 0xFE, 0x98, 0x1B, 0x90, 0xBB, 0xDD
	.byte  0x8D, 0xDE, 0xF9, 0x9D, 0xFB, 0xEB, 0x7E, 0xAA
	.byte  0x51, 0x43, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x59, 0x50, 0xBC, 0x54, 0x5C, 0x65, 0xCC
	.byte  0xC6, 0x91, 0x0E, 0xA6, 0xAE, 0xA0, 0x19, 0xE3
	.byte  0xA3, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0xD0, 0x50, 0x8B, 0xF1, 0x28, 0x3D, 0x0D, 0x65
	.byte  0x17, 0x0C, 0x75, 0x81, 0x86, 0x75, 0x76, 0xC9
	.byte  0x48, 0x4D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x52, 0xCE, 0x9A, 0x32, 0xCE, 0x28, 0x4D, 0xA7
	.byte  0xE4, 0x5D, 0x3D, 0xC5, 0x5D, 0x3B, 0x8B, 0x9E
	.byte  0x92, 0x5A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x80, 0x4A, 0x80, 0x3F, 0x15, 0x4C, 0xC9
	.byte  0x9A, 0x97, 0x20, 0x8A, 0x02, 0x52, 0x60, 0xC4
	.byte  0x25, 0x75, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC
	.byte  0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC
	.byte  0xFB, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x70, 0x3D, 0x0A, 0xD7, 0xA3, 0x70, 0x3D
	.byte  0x0A, 0xD7, 0xA3, 0x70, 0x3D, 0x0A, 0xD7, 0xA3
	.byte  0xF8, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0xA8, 0xA4, 0x4E, 0x40, 0x13, 0x61, 0xC3, 0xD3
	.byte  0x2B, 0x65, 0x19, 0xE2, 0x58, 0x17, 0xB7, 0xD1
	.byte  0xF1, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x7C, 0xBA, 0x36, 0x2B, 0x0D, 0xC2, 0xFD
	.byte  0xFC, 0xCE, 0x61, 0x84, 0x11, 0x77, 0xCC, 0xAB
	.byte  0xE4, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0xB0, 0xA9, 0x89, 0x79, 0x68, 0xBE, 0x2E, 0x4C
	.byte  0x5B, 0xE1, 0x4D, 0xC4, 0xBE, 0x94, 0x95, 0xE6
	.byte  0xC9, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x4A, 0x81, 0xA5, 0xED, 0x18, 0xDE, 0x67
	.byte  0xBA, 0x94, 0x39, 0x45, 0xAD, 0x1E, 0xB1, 0xCF
	.byte  0x94, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x60, 0xB3, 0x47, 0xD7, 0x98, 0x23, 0x3F
	.byte  0xA5, 0xE9, 0x39, 0xA5, 0x27, 0xEA, 0x7F, 0xA8
	.byte  0x2A, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0xC0, 0x5D, 0xD0, 0xF6, 0xB3, 0x7C, 0xAC
	.byte  0xA0, 0xE4, 0xBC, 0x64, 0x7C, 0x46, 0xD0, 0xDD
	.byte  0x55, 0x3E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x40, 0xFB, 0xFE, 0x55, 0x11, 0x91, 0xFA
	.byte  0x39, 0x19, 0x7A, 0x63, 0x25, 0x43, 0x31, 0xC0
	.byte  0xAC, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0xF2, 0xE3, 0x32, 0xD3, 0x32, 0x71
	.byte  0x1C, 0xD2, 0x23, 0xDB, 0x32, 0xEE, 0x49, 0x90
	.byte  0x5A, 0x39, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0xD4, 0x6B, 0x58, 0x01, 0xA6, 0x87
	.byte  0xBD, 0xC0, 0x57, 0xDA, 0xA5, 0x82, 0xA6, 0xA2
	.byte  0xB5, 0x32, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0xEB, 0xF2, 0xD4, 0x12, 0x25, 0x49
	.byte  0xE4, 0x2D, 0x36, 0x34, 0x4F, 0x53, 0xAE, 0xCE
	.byte  0x6B, 0x25, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte  0x00, 0x00, 0xC4, 0xA1, 0x23, 0x81, 0xE3, 0x2D
	.byte  0xDE, 0x9F, 0xCE, 0xD2, 0xC8, 0x04, 0xDD, 0xA6
	.byte  0xD8, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

flt:	.quad  0x0000000000000000
	.quad  0x0000000000000000
	.quad  0x0000000000000000
	.quad  0x0000000000000000
	.quad  0x0000000000000000

qerrno: .int   0x00000000

e_space:
	.asciz "#not enough space"


.att_syntax prefix
