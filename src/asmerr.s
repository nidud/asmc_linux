
.intel_syntax noprefix

.global asmerr
.global WriteError
.global PrintNote

.extern jmpenv
.extern print_source_nesting_structure
.extern GetCurrOffset
.extern warning_disable
.extern LstWrite
.extern LstNL
.extern LstPrintf
.extern tstrcat
.extern tstrcpy
.extern tstrlen
.extern tvsprintf
.extern tsprintf
.extern tprintf
.extern write_logo
.extern Options
.extern ModuleInfo
.extern Parse_Pass
.extern exit
.extern fwrite
.extern fclose
.extern fopen
.extern remove


.SECTION .text
	.ALIGN	16

$_001:	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	call	write_logo@PLT
	mov	r8, qword ptr [rbp+0x38]
	mov	rdx, qword ptr [rbp+0x30]
	mov	rcx, qword ptr [rbp+0x28]
	call	tvsprintf@PLT
	cmp	byte ptr [Options+0xC+rip], 0
	jnz	$_002
	mov	rdx, qword ptr [rbp+0x28]
	lea	rcx, [DS00C6+rip]
	call	tprintf@PLT
$_002:	mov	rbx, qword ptr [ModuleInfo+0xA8+rip]
	mov	rcx, qword ptr [ModuleInfo+0x88+rip]
	test	rcx, rcx
	jnz	$_004
	test	rbx, rbx
	jz	$_004
	lea	rsi, [DS00C7+rip]
	mov	rdi, rbx
	call	fopen@PLT
	test	rax, rax
	jz	$_003
	mov	qword ptr [ModuleInfo+0x88+rip], rax
	jmp	$_004

$_003:	mov	qword ptr [ModuleInfo+0xA8+rip], rax
	mov	byte ptr [Options+0xC+rip], al
	mov	rdx, rbx
	mov	ecx, 4910
	call	asmerr
$_004:	mov	rbx, qword ptr [ModuleInfo+0x88+rip]
	test	rbx, rbx
	jz	$_005
	mov	rcx, qword ptr [rbp+0x28]
	call	tstrlen@PLT
	mov	rcx, rbx
	mov	edx, eax
	mov	esi, 1
	mov	rdi, qword ptr [rbp+0x28]
	call	fwrite@PLT
	mov	rcx, rbx
	mov	edx, 1
	mov	esi, 1
	lea	rdi, [DS00C6+0x2+rip]
	call	fwrite@PLT
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_005
	cmp	qword ptr [ModuleInfo+0x80+rip], 0
	jz	$_005
	call	GetCurrOffset@PLT
	xor	r8d, r8d
	mov	edx, eax
	mov	ecx, 4
	call	LstWrite@PLT
	mov	rdx, qword ptr [rbp+0x28]
	lea	rcx, [DS00C8+rip]
	call	LstPrintf@PLT
	call	LstNL@PLT
$_005:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

$_006:
	sub	rsp, 40
	cmp	qword ptr [ModuleInfo+0x90+rip], 0
	jz	$_007
	mov	edx, 3
	lea	rcx, [jmpenv+rip]
	mov	rbp, qword ptr [rcx+0x10]
	mov	rbx, qword ptr [rcx]
	mov	r12, qword ptr [rcx+0x18]
	mov	r13, qword ptr [rcx+0x20]
	mov	r14, qword ptr [rcx+0x28]
	mov	r15, qword ptr [rcx+0x30]
	mov	rsp, qword ptr [rcx+0x8]
	mov	rcx, qword ptr [rcx+0x38]
	mov	eax, edx
	jmp	rcx

$_007:
	mov	rcx, qword ptr [ModuleInfo+0x78+rip]
	test	rcx, rcx
	jz	$_008
	mov	rdi, rcx
	call	fclose@PLT
	mov	rdi, qword ptr [ModuleInfo+0x98+rip]
	call	remove@PLT
$_008:	mov	edi, 1
	call	exit@PLT

asmerr:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 1064
	lea	rdi, [rbp-0x400]
	mov	ebx, ecx
	cmp	ebx, 1000
	jc	$_031
	cmp	ebx, 8021
	ja	$_031
	cmp	ebx, 4000
	jc	$_011
	cmp	byte ptr [Options+0xE+rip], 0
	jnz	$_009
	cmp	byte ptr [Options+0xD+rip], 0
	je	$_032
$_009:	cmp	ebx, 5000
	jc	$_010
	cmp	ebx, 8000
	jnc	$_010
	cmp	byte ptr [Options+0xD+rip], 3
	jc	$_032
$_010:	mov	ecx, ebx
	call	warning_disable@PLT
	test	rax, rax
	jne	$_032
$_011:	lea	rdx, [DS00C9+rip]
	mov	rcx, rdi
	call	tstrcpy@PLT
	mov	rdx, qword ptr [ModuleInfo+0xD8+rip]
	jmp	$_015

$_012:	movzx	eax, word ptr [rdx+0xA]
	mov	rcx, qword ptr [ModuleInfo+0xB0+rip]
	mov	rcx, qword ptr [rcx+rax*8]
	mov	eax, dword ptr [rdx+0x18]
	cmp	word ptr [rdx+0x8], 0
	mov	rdx, qword ptr [rdx]
	jnz	$_015
	cmp	byte ptr [ModuleInfo+0x1E0+rip], 0
	jz	$_013
	mov	r8, rcx
	lea	rdx, [DS00CA+rip]
	mov	rcx, rdi
	call	tsprintf@PLT
	jmp	$_014

$_013:	mov	r9d, eax
	mov	r8, rcx
	lea	rdx, [DS00CB+rip]
	mov	rcx, rdi
	call	tsprintf@PLT
$_014:	jmp	$_016

$_015:	test	rdx, rdx
	jnz	$_012
$_016:	cmp	ebx, 2000
	jnc	$_017
	lea	rax, [DS00CC+rip]
	jmp	$_019

$_017:	cmp	ebx, 4000
	jnc	$_018
	lea	rax, [DS00CC+0x6+rip]
	jmp	$_019

$_018:	lea	rax, [DS00CD+rip]
$_019:	mov	rdx, rax
	mov	rcx, rdi
	call	tstrcat@PLT
	mov	rcx, rdi
	call	tstrlen@PLT
	add	rdi, rax
	mov	r8d, ebx
	lea	rdx, [DS00CE+rip]
	mov	rcx, rdi
	call	tsprintf@PLT
	xor	ecx, ecx
	lea	eax, [rbx-0x3E8]
	jmp	$_021

$_020:	add	ecx, 1
	sub	eax, 1000
$_021:	cmp	eax, 1000
	jnc	$_020
	cmp	eax, 910
	jnz	$_022
	mov	eax, 14
$_022:	lea	rdx, [maxid+rip]
	cmp	eax, dword ptr [rdx+rcx*4]
	jnc	$_031
	lea	rsi, [table+rip]
	mov	rsi, qword ptr [rsi+rcx*8]
	mov	rsi, qword ptr [rsi+rax*8]
	lea	rdx, [DS0003+rip]
	cmp	rsi, rdx
	je	$_031
	lea	rdi, [rbp-0x400]
	mov	rdx, rsi
	mov	rcx, rdi
	call	tstrcat@PLT
	lea	r8, [rbp+0x30]
	mov	rdx, rdi
	lea	rcx, [rbp-0x200]
	call	$_001
	lea	rsi, [rbp-0x200]
	mov	ebx, dword ptr [rbp+0x28]
	cmp	ebx, 1012
	jnz	$_023
	call	$_006
$_023:	cmp	ebx, 4000
	jc	$_026
	cmp	byte ptr [Options+0xE+rip], 0
	jnz	$_024
	inc	dword ptr [ModuleInfo+0x4+rip]
	jmp	$_025

$_024:	inc	dword ptr [ModuleInfo+rip]
$_025:	jmp	$_027

$_026:	inc	dword ptr [ModuleInfo+rip]
$_027:	mov	eax, dword ptr [Options+0x8+rip]
	cmp	eax, -1
	jz	$_028
	inc	eax
	cmp	dword ptr [ModuleInfo+rip], eax
	jc	$_028
	mov	ecx, 1012
	call	asmerr
$_028:	cmp	ebx, 2000
	jc	$_029
	call	print_source_nesting_structure@PLT
	jmp	$_030

$_029:	call	$_006
$_030:	jmp	$_032

$_031:	lea	rdx, [DS0003+rip]
	lea	rcx, [DS00CF+rip]
	call	tprintf@PLT
	call	$_006
$_032:	mov	rax, -1
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

WriteError:
	sub	rsp, 40
	mov	rdx, qword ptr [ModuleInfo+0x98+rip]
	mov	ecx, 1002
	call	asmerr
	add	rsp, 40
	ret

PrintNote:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rbp
	mov	rbp, rsp
	sub	rsp, 544
	lea	rdx, [NOTE+rip]
	lea	r8, [rbp+0x18]
	mov	rdx, qword ptr [rdx+rcx*8]
	lea	rcx, [rbp-0x200]
	call	$_001
	leave
	ret


.SECTION .data
	.ALIGN	16

E0:
	.quad  DS0000
	.quad  DS0001
	.quad  DS0002
	.quad  DS0003
	.quad  DS0003
	.quad  DS0004
	.quad  DS0005
	.quad  DS0006
	.quad  DS0007
	.quad  DS0008
	.quad  DS0009
	.quad  DS000A
	.quad  DS000B
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS000C
	.quad  DS000D

E1:
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
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
	.quad  DS0003
	.quad  DS001B
	.quad  DS001C
	.quad  DS0003
	.quad  DS0003
	.quad  DS001D
	.quad  DS001E
	.quad  DS001F
	.quad  DS0020
	.quad  DS0021
	.quad  DS0003
	.quad  DS0022
	.quad  DS0023
	.quad  DS0024
	.quad  DS0025
	.quad  DS0026
	.quad  DS0027
	.quad  DS0028
	.quad  DS0003
	.quad  DS0029
	.quad  DS002A
	.quad  DS0003
	.quad  DS0008
	.quad  DS0003
	.quad  DS002B
	.quad  DS0003
	.quad  DS002C
	.quad  DS0003
	.quad  DS002D
	.quad  DS002E
	.quad  DS002F
	.quad  DS0030
	.quad  DS0003
	.quad  DS0031
	.quad  DS0032
	.quad  DS0033
	.quad  DS0034
	.quad  DS0035
	.quad  DS0036
	.quad  DS0037
	.quad  DS0038
	.quad  DS0039
	.quad  DS003A
	.quad  DS003B
	.quad  DS003C
	.quad  DS003D
	.quad  DS003E
	.quad  DS003F
	.quad  DS0040
	.quad  DS0041
	.quad  DS0003
	.quad  DS0042
	.quad  DS0003
	.quad  DS0043
	.quad  DS0044
	.quad  DS0045
	.quad  DS0003
	.quad  DS0046
	.quad  DS0047
	.quad  DS0048
	.quad  DS0049
	.quad  DS0003
	.quad  DS004A
	.quad  DS004B
	.quad  DS004C
	.quad  DS004D
	.quad  DS004E
	.quad  DS004F
	.quad  DS0050
	.quad  DS0051
	.quad  DS0052
	.quad  DS0053
	.quad  DS0054
	.quad  DS0055
	.quad  DS0056
	.quad  DS0057
	.quad  DS0058
	.quad  DS0059
	.quad  DS005A
	.quad  DS005B
	.quad  DS005C
	.quad  DS005D
	.quad  DS0003
	.quad  DS005E
	.quad  DS005F
	.quad  DS0003
	.quad  DS0060
	.quad  DS0061
	.quad  DS0062
	.quad  DS0003
	.quad  DS0063
	.quad  DS0064
	.quad  DS0003
	.quad  DS0065
	.quad  DS0066
	.quad  DS0067
	.quad  DS0068
	.quad  DS0069
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS006A
	.quad  DS006B
	.quad  DS006C
	.quad  DS0003
	.quad  DS006D
	.quad  DS0003
	.quad  DS006E
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS006F
	.quad  DS0003
	.quad  DS0070
	.quad  DS0071
	.quad  DS0072
	.quad  DS0003
	.quad  DS0003
	.quad  DS0073
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0074
	.quad  DS0075
	.quad  DS0076
	.quad  DS0077
	.quad  DS0078
	.quad  DS0003
	.quad  DS0079
	.quad  DS007A
	.quad  DS0003
	.quad  DS0003
	.quad  DS007B
	.quad  DS0003
	.quad  DS0003
	.quad  DS007C
	.quad  DS0003
	.quad  DS007D
	.quad  DS007E
	.quad  DS0003
	.quad  DS007F
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0080
	.quad  DS0081
	.quad  DS0003
	.quad  DS0082
	.quad  DS0083
	.quad  DS0003
	.quad  DS0084
	.quad  DS0003
	.quad  DS0003
	.quad  DS0085
	.quad  DS0003
	.quad  DS0003
	.quad  DS0086
	.quad  DS0087
	.quad  DS0003
	.quad  DS0088
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0089
	.quad  DS0003
	.quad  DS008A
	.quad  DS008B
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS008C
	.quad  DS008D
	.quad  DS0003
	.quad  DS008E
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS008F
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS0090
	.quad  DS0003
	.quad  DS0003
	.quad  DS0091
	.quad  DS0003
	.quad  DS0003

E2:
	.quad  DS0092
	.quad  DS0093
	.quad  DS0094
	.quad  DS0095
	.quad  DS0096
	.quad  DS0097
	.quad  DS0098
	.quad  DS0099
	.quad  DS009A
	.quad  DS009B
	.quad  DS009C
	.quad  DS009C
	.quad  DS009D
	.quad  DS009E
	.quad  DS009F
	.quad  DS00A0
	.quad  DS00A1
	.quad  DS00A2
	.quad  DS00A3
	.quad  DS00A4
	.quad  DS0000
	.quad  DS0001
	.quad  DS00A5

W1:
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS00A6
	.quad  DS0003
	.quad  DS00A7
	.quad  DS00A8
	.quad  DS00A9
	.quad  DS00AA
	.quad  DS0003
	.quad  DS0003
	.quad  DS00AB
	.quad  DS00AC
	.quad  DS0003
	.quad  DS0000

W2:
	.quad  DS0003

W3:
	.quad  DS0003
	.quad  DS0003
	.quad  DS0003
	.quad  DS00AD
	.quad  DS00AE
	.quad  DS00AF

W4:
	.quad  DS00B0
	.quad  DS0055
	.quad  DS0072
	.quad  DS00B1
	.quad  DS00B2
	.quad  DS00B3
	.quad  DS00B4
	.quad  DS00B5
	.quad  DS00B6
	.quad  DS00B7

W5:
	.quad  DS0005
	.quad  DS0081
	.quad  DS008A
	.quad  DS0060
	.quad  DS000E
	.quad  DS00B8
	.quad  DS00B9
	.quad  DS00BA
	.quad  DS00BB
	.quad  DS00BC
	.quad  DS00BD
	.quad  DS00BE
	.quad  DS00BF
	.quad  DS00C0
	.quad  DS00C1
	.quad  DS00C2
	.quad  DS0003
	.quad  DS00B3+0xA
	.quad  DS00C3
	.quad  DS00C4
	.quad  DS0021
	.quad  DS00C5

table:
	.quad  E0
	.quad  E1
	.quad  E2
	.quad  W1
	.quad  W2
	.quad  W3
	.quad  W4
	.quad  W5

maxid:
	.byte  0x13, 0x00, 0x00, 0x00, 0xDC, 0x00, 0x00, 0x00
	.byte  0x17, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00
	.byte  0x01, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00
	.byte  0x0A, 0x00, 0x00, 0x00, 0x16, 0x00, 0x00, 0x00

N0000:
	.asciz "%*s%s(%u): Included by"

N0001:
	.asciz "%*s%s(%u)[%s]: Macro called from"

N0002:
	.asciz "%*s%s(%u): iteration %u: Macro called from"

N0003:
	.asciz "%*s%s(%u): Main line code"

NOTE:
	.quad  N0000
	.quad  N0001
	.quad  N0002
	.quad  N0003

DS00C6:
	.asciz "%s\n"

DS00C7:
	.asciz "w"

DS00C8:
	.asciz "                           %s"

DS00C9:
	.asciz "ASMC : "

DS00CA:
	.asciz "%s : "

DS00CB:
	.asciz "%s(%u) : "

DS00CC:
	.asciz "fatal error"

DS00CD:
	.asciz "warning"

DS00CE:
	.asciz " A%04u: "

DS00CF:
	.asciz "ASMC : fatal error A1901: %s\n"


.SECTION .rodata
	.ALIGN	16

DS0000:
	.asciz "cannot open file : %s"

DS0001:
	.asciz "I/O error closing file : %s"

DS0002:
	.asciz "I/O error writing file : %s"

DS0003:
	.asciz "Internal Assembler Error"

DS0004:
	.asciz "assembler limit : macro parameter name table full"

DS0005:
	.asciz "invalid command-line option: %s"

DS0006:
	.asciz "nesting level too deep"

DS0007:
	.asciz "unmatched macro nesting"

DS0008:
	.asciz "line too long"

DS0009:
	.asciz "unmatched block nesting : %s"

DS000A:
	.asciz "directive must be in control block"

DS000B:
	.asciz "error count exceeds 100; stopping assembly"

DS000C:
	.asciz "missing source filename"

DS000D:
	.asciz "Not enough space"

DS000E:
	.asciz "symbol type conflict : %s"

DS000F:
	.asciz "symbol redefinition : %s"

DS0010:
	.asciz "undefined symbol : %s"

DS0011:
	.asciz "non-benign record redefinition %s : %s"

DS0012:
	.asciz "syntax error : %s"

DS0013:
	.asciz "syntax error in expression"

DS0014:
	.asciz "invalid type expression"

DS0015:
	.asciz "distance invalid for word size of current segment"

DS0016:
	.asciz "PROC, MACRO, or macro repeat directive must precede LOCAL"

DS0017:
	.asciz ".MODEL must precede this directive"

DS0018:
	.asciz "cannot define as public or external : %s"

DS0019:
	.asciz "segment attributes cannot change : %s (%s)"

DS001A:
	.asciz "expression expected"

DS001B:
	.asciz "invalid use of external symbol : %s"

DS001C:
	.asciz "operand must be RECORD type or field"

DS001D:
	.asciz "instruction operands must be the same size : %d - %d"

DS001E:
	.asciz "instruction operand must have size"

DS001F:
	.asciz "invalid operand size for instruction"

DS0020:
	.asciz "operands must be in same segment"

DS0021:
	.asciz "constant expected"

DS0022:
	.asciz "expression must be a code address"

DS0023:
	.asciz "multiple base registers not allowed"

DS0024:
	.asciz "multiple index registers not allowed"

DS0025:
	.asciz "must be index or base register"

DS0026:
	.asciz "invalid use of register"

DS0027:
	.asciz "invalid INVOKE argument : %d"

DS0028:
	.asciz "must be in segment block"

DS0029:
	.asciz "too many initial values for structure: %s"

DS002A:
	.asciz "statement not allowed inside structure definition"

DS002B:
	.asciz "string or text literal too long"

DS002C:
	.asciz "identifier too long"

DS002D:
	.asciz "missing angle bracket or brace in literal"

DS002E:
	.asciz "missing single or double quotation mark in string"

DS002F:
	.asciz "empty (null) string"

DS0030:
	.asciz "nondigit in number : %s"

DS0031:
	.asciz "real or BCD number not allowed"

DS0032:
	.asciz "text item required"

DS0033:
	.asciz "forced error : %s"

DS0034:
	.asciz "forced error : value equal to 0 : %d: %s"

DS0035:
	.asciz "forced error : value not equal to 0 : %d: %s"

DS0036:
	.asciz "forced error : symbol not defined : %s"

DS0037:
	.asciz "forced error : symbol defined : %s"

DS0038:
	.asciz "forced error : string blank : %s: %s"

DS0039:
	.asciz "forced error : string not blank : <%s>: %s"

DS003A:
	.asciz "forced error : strings equal : <%s>: <%s>: %s"

DS003B:
	.asciz "forced error : strings not equal : <%s>: <%s>: %s"

DS003C:
	.asciz "[[[ELSE]]]IF2/.ERR2 not allowed : single-pass assembler"

DS003D:
	.asciz "expression too complex for .UNTILCXZ"

DS003E:
	.asciz "can ALIGN only to power of 2 : %u"

DS003F:
	.asciz "struct alignment must be 1, 2, 4, 8, 16 or 32"

DS0040:
	.asciz "expected : %s"

DS0041:
	.asciz "incompatible CPU mode and segment size"

DS0042:
	.asciz "instruction prefix not allowed"

DS0043:
	.asciz "invalid instruction operands"

DS0044:
	.asciz "initializer too large for specified size"

DS0045:
	.asciz "cannot access symbol in given segment or group: %s"

DS0046:
	.asciz "cannot access label through segment registers : %s"

DS0047:
	.asciz "jump destination too far : by %d bytes"

DS0048:
	.asciz "jump destination must specify a label"

DS0049:
	.asciz "instruction does not allow NEAR indirect addressing"

DS004A:
	.asciz "instruction does not allow FAR direct addressing"

DS004B:
	.asciz "jump distance not possible in current CPU mode"

DS004C:
	.asciz "missing operand after unary operator"

DS004D:
	.asciz "cannot mix 16- and 32-bit registers"

DS004E:
	.asciz "invalid scale value"

DS004F:
	.asciz "constant value too large"

DS0050:
	.asciz "instruction or register not accepted in current CPU mode"

DS0051:
	.asciz "reserved word expected"

DS0052:
	.asciz "instruction form requires 80386/486"

DS0053:
	.asciz "END directive required at end of file"

DS0054:
	.asciz "too many bits in RECORD : %s"

DS0055:
	.asciz "positive value expected"

DS0056:
	.asciz "index value past end of string"

DS0057:
	.asciz "count must be positive or zero"

DS0058:
	.asciz "count value too large"

DS0059:
	.asciz "operand must be relocatable"

DS005A:
	.asciz "constant or relocatable label expected"

DS005B:
	.asciz "segment, group, or segment register expected"

DS005C:
	.asciz "segment expected : %s"

DS005D:
	.asciz "invalid operand for OFFSET"

DS005E:
	.asciz "segment or group not allowed"

DS005F:
	.asciz "cannot add two relocatable labels"

DS0060:
	.asciz "segment exceeds 64K limit: %s"

DS0061:
	.asciz "invalid type for data declaration : %s"

DS0062:
	.asciz "HIGH and LOW require immediate operands"

DS0063:
	.asciz "cannot have implicit far jump or call to near label"

DS0064:
	.asciz "use of register assumed to ERROR"

DS0065:
	.asciz "COMMENT delimiter expected"

DS0066:
	.asciz "conflicting parameter definition : %s"

DS0067:
	.asciz "PROC and prototype calling conventions conflict"

DS0068:
	.asciz "invalid radix tag"

DS0069:
	.asciz "INVOKE argument type mismatch : %d"

DS006A:
	.asciz "language type must be specified"

DS006B:
	.asciz "PROLOGUE must be macro function"

DS006C:
	.asciz "EPILOGUE must be macro procedure : %s"

DS006D:
	.asciz "text macro nesting level too deep"

DS006E:
	.asciz "missing macro argument"

DS006F:
	.asciz "VARARG parameter must be last parameter"

DS0070:
	.asciz "VARARG parameter requires C calling convention"

DS0071:
	.asciz "ORG needs a constant or local offset"

DS0072:
	.asciz "register value overwritten by INVOKE"

DS0073:
	.asciz "too many arguments to INVOKE"

DS0074:
	.asciz "too many operands to instruction"

DS0075:
	.asciz "cannot have more than one .ELSE clause per .IF block"

DS0076:
	.asciz "expected data label"

DS0077:
	.asciz "cannot nest procedures : %s"

DS0078:
	.asciz "EXPORT must be FAR : %s"

DS0079:
	.asciz "macro label not defined : %s"

DS007A:
	.asciz "invalid symbol type in expression : %s"

DS007B:
	.asciz "special register cannot be first operand"

DS007C:
	.asciz "syntax error in control-flow directive"

DS007D:
	.asciz "constant value out of range"

DS007E:
	.asciz "missing right parenthesis"

DS007F:
	.asciz "structure cannot be instanced"

DS0080:
	.asciz "structure field expected"

DS0081:
	.asciz "unexpected literal found in expression : %s"

DS0082:
	.asciz "divide by zero in expression"

DS0083:
	.asciz "directive must appear inside a macro"

DS0084:
	.asciz "too few bits in RECORD : %s"

DS0085:
	.asciz "invalid qualified type"

DS0086:
	.asciz "invalid use of FL    AT"

DS0087:
	.asciz "structure improperly initialized"

DS0088:
	.asciz "initializer must be a string or single item"

DS0089:
	.asciz "must use floating point initializer"

DS008A:
	.asciz "invalid combination with segment alignment : %d"

DS008B:
	.asciz "INVOKE requires prototype for procedure"

DS008C:
	.asciz ".STARTUP does not work with 32-bit segments"

DS008D:
	.asciz "ORG directive not allowed in unions"

DS008E:
	.asciz "illegal use of segment register"

DS008F:
	.asciz "missing operator in expression"

DS0090:
	.asciz "GROUP directive not allowed with /coff option"

DS0091:
	.asciz "must be public or external : %s"

DS0092:
	.asciz "assembly passes reached: %u"

DS0093:
	.asciz "invalid fixup type for %s : %s"

DS0094:
	.asciz "/PE option requires FLAT memory model"

DS0095:
	.asciz "/bin: invalid start label"

DS0096:
	.asciz "cannot use TR%u-TR%u with current CPU setting"

DS0097:
	.asciz "no segment information to create fixup: %s"

DS0098:
	.asciz "not supported with current output format: %s"

DS0099:
	.asciz "missing .ENDPROLOG: %s"

DS009A:
	.asciz ".ENDPROLOG found before EH directives"

DS009B:
	.asciz "missing FRAME in PROC, no unwind code will be generated"

DS009C:
	.asciz "too many unwind codes in FRAME procedure"

DS009D:
	.asciz "registers AH-DH may not be used with SPL-DIL or R8-R15"

DS009E:
	.asciz "multiple overrides"

DS009F:
	.asciz "unknown fixup type: %u at %s.%X"

DS00A0:
	.asciz "filename parameter must be enclosed in <> or quotes"

DS00A1:
	.asciz "literal expected after '='"

DS00A2:
	.asciz ".SAFESEH argument must be a PROC"

DS00A3:
	.asciz "invalid operand for %s : %s"

DS00A4:
	.asciz "invalid fixup type for %s : %u at location %s:%X"

DS00A5:
	.asciz ".CASE redefinition : %s(%d) : %s(%d)"

DS00A6:
	.asciz "start address on END directive ignored with .STARTUP"

DS00A7:
	.asciz "unknown default prologue argument"

DS00A8:
	.asciz "too many arguments in macro call : %s"

DS00A9:
	.asciz "option untranslated, directive required : %s"

DS00AA:
	.asciz "invalid command-line option value, default is used : %s"

DS00AB:
	.asciz "multiple .MODEL directives found : .MODEL ignored"

DS00AC:
	.asciz "line number information for segment without class 'CODE' : %s"

DS00AD:
	.asciz "conditional jump lengthened"

DS00AE:
	.asciz "procedure argument or local not referenced : %s"

DS00AF:
	.asciz "expression condition may be pass-dependent: %s"

DS00B0:
	.asciz "symbol language attribute conflict : %s"

DS00B1:
	.asciz "far call is converted to near call."

DS00B2:
	.asciz "floating-point initializer ignored"

DS00B3:
	.asciz "directive ignored: %s"

DS00B4:
	.asciz "parameter/local name is reserved word: %s"

DS00B5:
	.asciz ".CASE without .ENDC: assumed fall through"

DS00B6:
	.asciz "cannot delay macro function: %s"

DS00B7:
	.asciz "magnitude of offset exceeds 16 bit"

DS00B8:
	.asciz "IF[n]DEF expects a plain symbol as argument : %s"

DS00B9:
	.asciz "instructions and initialized data not supported in %s segments"

DS00BA:
	.asciz "16bit fixup for 32bit label : %s"

DS00BB:
	.asciz "displacement out of range: 0x%lX"

DS00BC:
	.asciz "no start label defined"

DS00BD:
	.asciz "no stack defined"

DS00BE:
	.asciz "for -coff leading underscore required for start label: %s"

DS00BF:
	.asciz "library name is missing"

DS00C0:
	.asciz "ELF GNU extensions (8/16-bit relocations) used"

DS00C1:
	.asciz "LOADDS ignored in flat model"

DS00C2:
	.asciz "directive ignored without -%s switch"

DS00C3:
	.asciz "group definition too large, truncated : %s"

DS00C4:
	.asciz "size not specified, assuming: %s"

DS00C5:
	.asciz "opcode size suffix ignored for segment registers"


.att_syntax prefix
