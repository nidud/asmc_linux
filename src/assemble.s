
.intel_syntax noprefix

.global ConvertSectionName
.global OutputByte
.global FillDataBytes
.global OutputBytes
.global SetCurrOffset
.global WritePreprocessedLine
.global SetMasm510
.global close_files
.global AssembleModule
.global Parse_Pass
.global write_to_file
.global ModuleInfo
.global LinnumQueue
.global jmpenv

.extern MacroLocals
.extern LstWriteCRef
.extern LstInit
.extern ExprEvalInit
.extern ProcInit
.extern LabelInit
.extern CondInit
.extern CondCheckOpen
.extern RestoreState
.extern SkipSavedState
.extern FastpassInit
.extern UseSavedState
.extern StoreState
.extern LineStoreCurr
.extern elf_init
.extern coff_init
.extern bin_init
.extern QueueDeleteLinnum
.extern LinnumFini
.extern LinnumInit
.extern LclDup
.extern MemFini
.extern MemInit
.extern Tokenize
.extern AssumeInit
.extern MacroInit
.extern PragmaCheckOpen
.extern PragmaInit
.extern ClassCheckOpen
.extern ClassInit
.extern HllCheckOpen
.extern HllInit
.extern ContextInit
.extern RunLineQueue
.extern AddLineQueueX
.extern set_curr_srcfile
.extern ClearSrcStack
.extern InputFini
.extern InputPassInit
.extern InputInit
.extern AddStringToIncludePath
.extern SearchFile
.extern GetExtPart
.extern GetFNamePart
.extern Mangle
.extern omf_FlushCurrSeg
.extern omf_OutSelect
.extern omf_set_filepos
.extern omf_init
.extern TypesInit
.extern ResWordsFini
.extern ResWordsInit
.extern DisableKeyword
.extern SegmentFini
.extern SegmentInit
.extern ProcessFile
.extern ParseLine
.extern sym_remove_table
.extern SymTables
.extern store_fixup
.extern tgetenv
.extern tstrncpy
.extern tstrcat
.extern tstrcpy
.extern tstrchr
.extern tstrlen
.extern tmemcmp
.extern tmemcpy
.extern tstrupr
.extern tfprintf
.extern tsprintf
.extern tprintf
.extern SetCPU
.extern asmerr
.extern LastCodeBufSize
.extern ModelToken
.extern MacroLevel
.extern DefaultDir
.extern Options
.extern WriteError
.extern SymSetCmpFunc
.extern SymMakeAllSymbolsPublic
.extern SymPassInit
.extern SymInit
.extern SymFind
.extern SymCreate
.extern rewind
.extern fwrite
.extern fclose
.extern fopen
.extern remove


.SECTION .text
	.ALIGN	16

ConvertSectionName:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	lea	rbx, [cst+rip]
	mov	rdi, qword ptr [rbp+0x28]
	xor	esi, esi
$_001:	cmp	esi, 4
	jnc	$_007
	inc	esi
	mov	r8d, dword ptr [rbx]
	mov	rdx, qword ptr [rbx+0x8]
	mov	rcx, qword ptr [rdi+0x8]
	call	tmemcmp@PLT
	test	rax, rax
	jnz	$_006
	mov	edx, dword ptr [rbx]
	add	rdx, qword ptr [rdi+0x8]
	mov	al, byte ptr [rdx]
	test	al, al
	jz	$_002
	cmp	al, 36
	jnz	$_006
	test	byte ptr [rbx+0x4], 0x01
	jnz	$_006
$_002:	mov	rcx, qword ptr [rbp+0x30]
	test	rcx, rcx
	jz	$_004
	mov	rax, qword ptr [rdi+0x68]
	cmp	esi, 4
	jnz	$_003
	cmp	dword ptr [rax+0x18], 0
	jnz	$_004
$_003:	lea	rax, [stt+rip]
	movzx	eax, byte ptr [rax+rsi-0x1]
	mov	dword ptr [rcx], eax
$_004:	mov	rax, qword ptr [rbx+0x10]
	cmp	byte ptr [rdx], 0
	jz	$_005
	mov	rbx, rdx
	mov	rdx, rax
	mov	rcx, qword ptr [rbp+0x38]
	call	tstrcpy@PLT
	mov	rdx, rbx
	mov	rcx, rax
	call	tstrcat@PLT
$_005:	jmp	$_008

$_006:	add	rbx, 24
	jmp	$_001

$_007:	mov	rax, qword ptr [rbp+0x28]
	mov	rax, qword ptr [rax+0x8]
$_008:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

OutputByte:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rsi, qword ptr [ModuleInfo+0x1F8+rip]
	mov	rdi, qword ptr [rsi+0x68]
	cmp	dword ptr [write_to_file+rip], 0
	jz	$_010
	mov	ebx, dword ptr [rdi+0xC]
	sub	ebx, dword ptr [rdi+0x8]
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_009
	cmp	ebx, 1014
	jc	$_009
	call	omf_FlushCurrSeg@PLT
	mov	ebx, dword ptr [rdi+0xC]
	sub	ebx, dword ptr [rdi+0x8]
$_009:	mov	eax, dword ptr [rbp+0x28]
	mov	rcx, qword ptr [rdi+0x10]
	mov	byte ptr [rcx+rbx], al
	jmp	$_011

$_010:	mov	eax, dword ptr [rdi+0xC]
	cmp	eax, dword ptr [rdi+0x8]
	jnc	$_011
	mov	dword ptr [rdi+0x8], eax
$_011:	inc	dword ptr [rdi+0xC]
	inc	dword ptr [rdi+0x18]
	mov	byte ptr [rdi+0x70], 1
	mov	eax, dword ptr [rdi+0xC]
	cmp	eax, dword ptr [rsi+0x50]
	jle	$_012
	mov	dword ptr [rsi+0x50], eax
$_012:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

FillDataBytes:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	cmp	byte ptr [ModuleInfo+0x1EE+rip], 0
	jz	$_013
	mov	ecx, 1
	call	omf_OutSelect@PLT
$_013:	jmp	$_015

$_014:	movzx	ecx, byte ptr [rbp+0x10]
	call	OutputByte
	dec	dword ptr [rbp+0x18]
$_015:	cmp	dword ptr [rbp+0x18], 0
	jnz	$_014
	leave
	ret

OutputBytes:
	mov	qword ptr [rsp+0x8], rcx
	mov	qword ptr [rsp+0x10], rdx
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, qword ptr [ModuleInfo+0x1F8+rip]
	mov	rdi, qword ptr [rsi+0x68]
	cmp	dword ptr [write_to_file+rip], 0
	jz	$_018
	mov	ebx, dword ptr [rdi+0xC]
	sub	ebx, dword ptr [rdi+0x8]
	add	edx, ebx
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_016
	cmp	edx, 1014
	jc	$_016
	call	omf_FlushCurrSeg@PLT
	mov	ebx, dword ptr [rdi+0xC]
	sub	ebx, dword ptr [rdi+0x8]
$_016:	cmp	qword ptr [rbp+0x38], 0
	jz	$_017
	mov	r8, qword ptr [rbp+0x28]
	mov	rdx, rsi
	mov	rcx, qword ptr [rbp+0x38]
	call	store_fixup@PLT
$_017:	mov	rdx, rdi
	mov	rax, rsi
	mov	rdi, qword ptr [rdi+0x10]
	add	rdi, rbx
	mov	ecx, dword ptr [rbp+0x30]
	mov	rsi, qword ptr [rbp+0x28]
	rep movsb
	mov	rdi, rdx
	mov	rsi, rax
	jmp	$_019

$_018:	mov	eax, dword ptr [rdi+0xC]
	cmp	eax, dword ptr [rdi+0x8]
	jnc	$_019
	mov	dword ptr [rdi+0x8], eax
$_019:	mov	eax, dword ptr [rbp+0x30]
	add	dword ptr [rdi+0xC], eax
	add	dword ptr [rdi+0x18], eax
	mov	byte ptr [rdi+0x70], 1
	mov	eax, dword ptr [rdi+0xC]
	cmp	eax, dword ptr [rsi+0x50]
	jle	$_020
	mov	dword ptr [rsi+0x50], eax
$_020:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

SetCurrOffset:
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	ebx, edx
	mov	rsi, rcx
	mov	eax, r8d
	mov	ecx, dword ptr [write_to_file+rip]
	mov	rdi, qword ptr [rsi+0x68]
	test	eax, eax
	jz	$_021
	add	ebx, dword ptr [rdi+0xC]
$_021:	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_025
	cmp	rsi, qword ptr [ModuleInfo+0x1F8+rip]
	jnz	$_024
	test	ecx, ecx
	jz	$_022
	call	omf_FlushCurrSeg@PLT
$_022:	cmp	dword ptr [rbp+0x40], 0
	jz	$_023
	cmp	byte ptr [ModuleInfo+0x1EE+rip], 0
	jz	$_023
	mov	ecx, 1
	call	omf_OutSelect@PLT
$_023:	mov	dword ptr [LastCodeBufSize+rip], ebx
$_024:	mov	dword ptr [rdi+0x8], ebx
	jmp	$_026

$_025:	test	ecx, ecx
	jnz	$_026
	test	eax, eax
	jnz	$_026
	cmp	dword ptr [rdi+0x18], 0
	jnz	$_026
	mov	dword ptr [rdi+0x8], ebx
$_026:	mov	dword ptr [rdi+0xC], ebx
	mov	byte ptr [rdi+0x70], 0
	mov	eax, dword ptr [rdi+0xC]
	cmp	eax, dword ptr [rsi+0x50]
	jle	$_027
	mov	dword ptr [rsi+0x50], eax
$_027:	xor	eax, eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

WriteModule:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 72
	mov	rbx, qword ptr [SymTables+0x20+rip]
	jmp	$_031
$_029:	mov	rax, qword ptr [rbx+0x68]
	cmp	byte ptr [rax+0x68], 0
	jnz	$_030
	cmp	dword ptr [rbx+0x50], 65536
	jle	$_030
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_030
	mov	rdx, qword ptr [rbx+0x8]
	mov	ecx, 2103
	call	asmerr@PLT
$_030:	mov	rbx, qword ptr [rbx+0x70]
$_031:	test	rbx, rbx
	jnz	$_029
	call	qword ptr [ModuleInfo+0x158+rip]
	mov	rbx, qword ptr [Options+0x30+rip]
	test	rbx, rbx
	je	$_037
	lea	rsi, [DS0000+rip]
	mov	rdi, rbx
	call	fopen@PLT
	test	rax, rax
	jnz	$_032
	mov	rdx, rbx
	mov	ecx, 3020
	call	asmerr@PLT
	jmp	$_037

$_032:	mov	qword ptr [rbp-0x8], rax
	mov	rbx, qword ptr [SymTables+0x10+rip]
	jmp	$_036

$_033:	mov	rcx, qword ptr [rbx+0x50]
	test	byte ptr [rbx+0x15], 0x08
	jz	$_035
	test	rcx, rcx
	jz	$_035
	cmp	byte ptr [rcx+0xC], 0
	jz	$_035
	test	byte ptr [rbx+0x3B], 0x02
	jz	$_034
	test	byte ptr [rbx+0x14], 0x08
	jz	$_035
$_034:	mov	rdx, qword ptr [ModuleInfo+0x188+rip]
	mov	rcx, rbx
	call	Mangle@PLT
	mov	rcx, qword ptr [rbx+0x50]
	mov	rax, qword ptr [rbx+0x8]
	mov	qword ptr [rsp+0x20], rax
	lea	r9, [rcx+0xC]
	mov	r8, qword ptr [ModuleInfo+0x188+rip]
	lea	rdx, [DS0001+rip]
	mov	rcx, qword ptr [ModuleInfo+0x178+rip]
	call	tsprintf@PLT
	mov	dword ptr [rbp-0xC], eax
	mov	rcx, qword ptr [rbp-0x8]
	mov	edx, dword ptr [rbp-0xC]
	mov	esi, 1
	mov	rdi, qword ptr [ModuleInfo+0x178+rip]
	call	fwrite@PLT
	cmp	dword ptr [rbp-0xC], eax
	jz	$_035
	call	WriteError@PLT
$_035:	mov	rbx, qword ptr [rbx+0x70]
$_036:	test	rbx, rbx
	jne	$_033
	mov	rdi, qword ptr [rbp-0x8]
	call	fclose@PLT
$_037:	xor	eax, eax
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

add_cmdline_tmacros:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rsi, qword ptr [Options+0x60+rip]
	jmp	$_049

$_039:	lea	rdi, [rsi+0x8]
	mov	edx, 61
	mov	rcx, rdi
	call	tstrchr@PLT
	test	rax, rax
	jnz	$_040
	mov	rcx, rdi
	call	tstrlen@PLT
	lea	rbx, [rdi+rax]
	jmp	$_041

$_040:	mov	rbx, rax
	mov	rax, rbx
	sub	rax, rdi
	inc	eax
	mov	dword ptr [rbp-0x4], eax
	mov	eax, dword ptr [rbp-0x4]
	add	eax, 15
	and	eax, 0xFFFFFFF0
	sub	rsp, rax
	lea	rax, [rsp+0x20]
	mov	r8d, dword ptr [rbp-0x4]
	mov	rdx, rdi
	mov	rcx, rax
	call	tmemcpy@PLT
	mov	ecx, dword ptr [rbp-0x4]
	mov	byte ptr [rax+rcx-0x1], 0
	inc	rbx
	mov	rdi, rax
$_041:	xor	ecx, ecx
	movzx	eax, byte ptr [rdi]
	cmp	al, 46
	jz	$_042
	test	byte ptr [r15+rax], 0x44
	jnz	$_042
	inc	ecx
	jmp	$_045

$_042:	lea	rdx, [rdi+0x1]
	mov	al, byte ptr [rdx]
$_043:	test	eax, eax
	jz	$_045
	test	byte ptr [r15+rax], 0x44
	jnz	$_044
	inc	ecx
	jmp	$_045

$_044:	inc	rdx
	mov	al, byte ptr [rdx]
	jmp	$_043

$_045:	test	ecx, ecx
	jz	$_046
	mov	rdx, rdi
	mov	ecx, 2008
	call	asmerr@PLT
	jmp	$_050

$_046:	mov	rcx, rdi
	call	SymFind@PLT
	test	rax, rax
	jnz	$_047
	mov	rcx, rdi
	call	SymCreate@PLT
	mov	byte ptr [rax+0x18], 10
$_047:	cmp	byte ptr [rax+0x18], 10
	jz	$_048
	mov	rdx, rdi
	mov	ecx, 2005
	call	asmerr@PLT
	jmp	$_050

$_048:	or	byte ptr [rax+0x14], 0x22
	mov	qword ptr [rax+0x28], rbx
	mov	rsi, qword ptr [rsi]
$_049:	test	rsi, rsi
	jne	$_039
$_050:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

add_incpaths:
	push	rsi
	sub	rsp, 32
	mov	rsi, qword ptr [Options+0x68+rip]
	jmp	$_053

$_052:	lea	rcx, [rsi+0x8]
	call	AddStringToIncludePath@PLT
	mov	rsi, qword ptr [rsi]
$_053:	test	rsi, rsi
	jnz	$_052
	add	rsp, 32
	pop	rsi
	ret

CmdlParamsInit:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	test	ecx,ecx
	jnz	$_055
	call	add_cmdline_tmacros
	call	add_incpaths
	cmp	byte ptr [Options+0xC7+rip], 0
	jnz	$_055
	lea	rcx, [DS0002+rip]
	call	tgetenv@PLT
	test	rax, rax
	jz	$_055
	mov	rcx, rax
	call	AddStringToIncludePath@PLT
$_055:	leave
	ret

WritePreprocessedLine:
	mov	qword ptr [rsp+0x8], rcx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	cmp	dword ptr [ModuleInfo+0x220+rip], 0
	jle	$_060
	jmp	$_057

$_056:	inc	rcx
$_057:	movzx	eax, byte ptr [rcx]
	test	byte ptr [r15+rax], 0x08
	jnz	$_056
	cmp	eax, 37
	jnz	$_058
	inc	rcx
	jmp	$_059

$_058:	mov	rcx, qword ptr [rbp+0x10]
$_059:	mov	rdx, rcx
	lea	rcx, [DS0001+0x10+rip]
	call	tprintf@PLT
	mov	byte ptr [PrintEmptyLine+rip], 1
	jmp	$_061

$_060:	cmp	byte ptr [PrintEmptyLine+rip], 0
	jz	$_061
	mov	byte ptr [PrintEmptyLine+rip], 0
	lea	rcx, [DS0001+0x12+rip]
	call	tprintf@PLT
$_061:	leave
	ret

SetMasm510:
	mov	eax, ecx
	lea	rcx, [ModuleInfo+rip]
	mov	byte ptr [rcx+0x1D6], al
	mov	byte ptr [rcx+0x1D8], al
	mov	byte ptr [rcx+0x1D4], al
	mov	byte ptr [rcx+0x1DA], al
	test	eax, eax
	jz	$_062
	cmp	byte ptr [rcx+0x1B5], 0
	jnz	$_062
	mov	byte ptr [rcx+0x1BB], 2
	cmp	byte ptr [rcx+0x1B6], 0
	jnz	$_062
	mov	byte ptr [rcx+0x1D7], 0
	mov	byte ptr [rcx+0x1D2], 0
$_062:	ret

ModulePassInit:
	push	rsi
	push	rdi
	push	rbx
	sub	rsp, 32
	lea	rdi, [Options+rip]
	lea	rbx, [ModuleInfo+rip]
	mov	ecx, dword ptr [rdi+0xB4]
	mov	esi, dword ptr [rdi+0xB0]
	mov	byte ptr [rbx+0x1D2], 0
	mov	byte ptr [rbx+0x1D3], 0
	mov	byte ptr [rbx+0x1BB], 0
	mov	byte ptr [rbx+0x1D7], 1
	mov	dword ptr [rbx+0x340], 9
	cmp	dword ptr [UseSavedState+rip], 0
	jne	$_070
	mov	eax, dword ptr [rdi+0xAC]
	mov	byte ptr [rbx+0x1B6], al
	mov	eax, dword ptr [rdi+0xB8]
	mov	byte ptr [rbx+0x1B9], al
	mov	eax, ecx
	and	eax, 0xF0
	cmp	byte ptr [rbx+0x1B8], 3
	jnz	$_068
	cmp	eax, 112
	jnc	$_064
	mov	ecx, 120
$_064:	mov	esi, 7
	cmp	byte ptr [rbx+0x1B6], 0
	jnz	$_067
	cmp	dword ptr [rdi+0xA4], 2
	jz	$_065
	cmp	dword ptr [rdi+0xA4], 0
	jnz	$_066
$_065:	mov	byte ptr [rbx+0x1B6], 7
	jmp	$_067

$_066:	cmp	dword ptr [rdi+0xA4], 3
	jnz	$_067
	mov	byte ptr [rbx+0x1B6], 2
$_067:	jmp	$_069

$_068:	cmp	esi, 7
	jnz	$_069
	cmp	eax, 48
	jnc	$_069
	mov	ecx, 48
$_069:	call	SetCPU@PLT
	test	esi, esi
	jz	$_070
	lea	rcx, [ModelToken+rip]
	mov	rcx, qword ptr [rcx+rsi*8-0x8]
	mov	r8, rcx
	mov	edx, 454
	lea	rcx, [DS0003+rip]
	call	AddLineQueueX@PLT
$_070:	movzx	eax, byte ptr [rdi+0x97]
	mov	ecx, eax
	call	SetMasm510
	mov	byte ptr [rbx+0x1CD], 0
	mov	byte ptr [rbx+0x1D5], 1
	mov	al, byte ptr [rdi+0x92]
	mov	byte ptr [rbx+0x1DB], al
	mov	byte ptr [rbx+0x1DC], 1
	mov	al, byte ptr [rdi+0x9A]
	mov	byte ptr [rbx+0x1DD], al
	mov	al, byte ptr [rdi+0x9B]
	mov	byte ptr [rbx+0x1DE], al
	mov	eax, dword ptr [rdi+0x9C]
	mov	dword ptr [rbx+0x1C8], eax
	mov	al, byte ptr [rdi+0x94]
	mov	byte ptr [rbx+0x1D0], al
	mov	al, byte ptr [rdi+0x95]
	mov	byte ptr [rbx+0x1D1], al
	call	SymSetCmpFunc@PLT
	mov	byte ptr [rbx+0x1BA], 0
	mov	byte ptr [rbx+0x1C4], 10
	mov	al, byte ptr [rdi+0xC8]
	mov	byte ptr [rbx+0x1C5], al
	mov	byte ptr [rbx+0x1C7], 0
	mov	al, byte ptr [rbx+0x334]
	and	al, 0x04
	or	al, byte ptr [rdi+0xCA]
	mov	byte ptr [rbx+0x334], al
	mov	al, byte ptr [rdi+0xCB]
	mov	byte ptr [rbx+0x335], al
	mov	al, byte ptr [rdi+0xCC]
	mov	byte ptr [rbx+0x336], al
	mov	eax, dword ptr [rdi+0xBC]
	mov	dword ptr [rbx+0x344], eax
	mov	al, byte ptr [rdi+0xD0]
	mov	byte ptr [rbx+0x1E5], al
	mov	al, byte ptr [rdi+0xD4]
	mov	byte ptr [rbx+0x1E1], al
	mov	al, byte ptr [rdi+0xC4]
	mov	byte ptr [rbx+0x350], al
	mov	eax, dword ptr [rdi+0xC0]
	mov	dword ptr [rbx+0x34C], eax
	mov	al, byte ptr [rdi+0xC5]
	mov	byte ptr [rbx+0x351], al
	mov	al, byte ptr [rdi+0xD5]
	mov	byte ptr [rbx+0x352], al
	mov	al, byte ptr [rdi+0xD6]
	mov	byte ptr [rbx+0x353], al
	mov	al, byte ptr [rdi+0xD8]
	mov	byte ptr [rbx+0x1D4], al
	mov	al, byte ptr [rdi+0xD9]
	mov	byte ptr [rbx+0x354], al
	mov	al, byte ptr [rdi+0xDA]
	mov	byte ptr [rbx+0x355], al
	mov	al, byte ptr [rdi+0x98]
	mov	byte ptr [rbx+0x337], al
	mov	byte ptr [rbx+0x356], 0
	cmp	qword ptr [rbx+0x60], 0
	jz	$_073
	mov	rax, qword ptr [SymTables+0x10+rip]
	jmp	$_072

$_071:	and	dword ptr [rax+0x14], 0xFFFFFFF7
	mov	rax, qword ptr [rax+0x70]
$_072:	test	rax, rax
	jnz	$_071
$_073:	add	rsp, 32
	pop	rbx
	pop	rdi
	pop	rsi
	ret

PassOneChecks:
	push	rsi
	push	rdi
	sub	rsp, 40
	call	HllCheckOpen@PLT
	call	CondCheckOpen@PLT
	call	ClassCheckOpen@PLT
	call	PragmaCheckOpen@PLT
	cmp	byte ptr [ModuleInfo+0x1E0+rip], 0
	jnz	$_075
	mov	ecx, 2088
	call	asmerr@PLT
$_075:	lea	rdx, [ModuleInfo+0x10+rip]
	mov	rcx, qword ptr [rdx]
	jmp	$_080

$_076:	mov	rax, qword ptr [rcx+0x8]
	cmp	byte ptr [rax+0x18], 1
	jnz	$_077
	mov	rdx, rcx
	jmp	$_079

$_077:	cmp	byte ptr [rax+0x18], 2
	jnz	$_078
	test	byte ptr [rax+0x3B], 0x02
	jz	$_078
	mov	rax, qword ptr [rcx]
	mov	qword ptr [rdx], rax
	mov	rcx, rdx
	jmp	$_079

$_078:	mov	dword ptr [UseSavedState+rip], 0
	jmp	$_088

$_079:	mov	rcx, qword ptr [rcx]
$_080:	test	rcx, rcx
	jnz	$_076
	mov	rax, qword ptr [SymTables+0x20+rip]
	jmp	$_083

$_081:	cmp	qword ptr [rax+0x30], 0
	jnz	$_082
	mov	dword ptr [UseSavedState+rip], 0
	jmp	$_088

$_082:	mov	rax, qword ptr [rax+0x70]
$_083:	test	rax, rax
	jnz	$_081
	mov	rax, qword ptr [ModuleInfo+0x30+rip]
	jmp	$_087

$_084:	cmp	byte ptr [rax+0x18], 1
	jnz	$_085
	test	byte ptr [rax+0x15], 0x08
	jnz	$_086
$_085:	mov	dword ptr [UseSavedState+rip], 0
	jmp	$_088

$_086:	mov	rax, qword ptr [rax+0x70]
$_087:	test	rax, rax
	jnz	$_084
$_088:	cmp	dword ptr [Options+0xA4+rip], 2
	jz	$_089
	cmp	dword ptr [Options+0xA4+rip], 3
	jnz	$_095
$_089:	mov	rcx, qword ptr [SymTables+0x50+rip]
	jmp	$_094

$_090:	mov	rax, qword ptr [rcx+0x28]
	test	rax, rax
	jz	$_091
	cmp	byte ptr [rax+0x18], 2
	jz	$_092
	cmp	byte ptr [rax+0x18], 1
	jnz	$_091
	test	dword ptr [rax+0x14], 0x80
	jnz	$_092
$_091:	mov	dword ptr [UseSavedState+rip], 0
	jmp	$_095

$_092:	cmp	byte ptr [rax+0x18], 2
	jnz	$_093
	or	byte ptr [rax+0x14], 0x01
$_093:	mov	rcx, qword ptr [rcx+0x70]
$_094:	test	rcx, rcx
	jnz	$_090
$_095:	mov	rdi, qword ptr [SymTables+0x10+rip]
	jmp	$_102

$_096:	mov	rsi, rdi
	mov	rdi, qword ptr [rsi+0x70]
	test	byte ptr [rsi+0x14], 0x01
	jz	$_097
	and	byte ptr [rsi+0x3B], 0xFFFFFFFD
$_097:	test	byte ptr [rsi+0x3B], 0x02
	jz	$_098
	test	byte ptr [rsi+0x14], 0x08
	jnz	$_098
	mov	rdx, rsi
	lea	rcx, [SymTables+0x10+rip]
	call	sym_remove_table@PLT
	jmp	$_102

$_098:	test	byte ptr [rsi+0x3B], 0x01
	jnz	$_102
	mov	rax, qword ptr [rsi+0x58]
	test	rax, rax
	jz	$_102
	cmp	byte ptr [rax+0x18], 1
	jnz	$_101
	test	dword ptr [rax+0x14], 0x80
	jnz	$_100
	cmp	dword ptr [Options+0xA4+rip], 2
	jz	$_099
	cmp	dword ptr [Options+0xA4+rip], 3
	jnz	$_100
$_099:	call	SkipSavedState@PLT
$_100:	jmp	$_102

$_101:	cmp	byte ptr [rax+0x18], 2
	jz	$_102
	mov	dword ptr [UseSavedState+rip], 0
$_102:	test	rdi, rdi
	jnz	$_096
	cmp	dword ptr [ModuleInfo+rip], 0
	jnz	$_105
	cmp	byte ptr [Options+0xA2+rip], 0
	jz	$_103
	call	SymMakeAllSymbolsPublic@PLT
$_103:	cmp	byte ptr [Options+0xC9+rip], 0
	jnz	$_104
	mov	dword ptr [write_to_file+rip], 1
$_104:	cmp	qword ptr [ModuleInfo+0x168+rip], 0
	jz	$_105
	call	qword ptr [ModuleInfo+0x168+rip]
$_105:	add	rsp, 40
	pop	rdi
	pop	rsi
	ret

OnePass:
	push	rsi
	push	rdi
	sub	rsp, 40
	call	InputPassInit@PLT
	call	ModulePassInit
	mov	ecx, dword ptr [Parse_Pass+rip]
	call	SymPassInit@PLT
	call	LabelInit@PLT
	mov	ecx, dword ptr [Parse_Pass+rip]
	call	SegmentInit@PLT
	mov	ecx, dword ptr [Parse_Pass+rip]
	call	ContextInit@PLT
	call	ProcInit@PLT
	call	TypesInit@PLT
	mov	ecx, dword ptr [Parse_Pass+rip]
	call	HllInit@PLT
	call	ClassInit@PLT
	call	PragmaInit@PLT
	mov	ecx, dword ptr [Parse_Pass+rip]
	call	MacroInit@PLT
	mov	ecx, dword ptr [Parse_Pass+rip]
	call	AssumeInit@PLT
	mov	ecx, dword ptr [Parse_Pass+rip]
	call	CmdlParamsInit
	xor	eax, eax
	mov	byte ptr [ModuleInfo+0x1E0+rip], al
	mov	byte ptr [ModuleInfo+0x1ED+rip], al
	call	LinnumInit@PLT
	cmp	qword ptr [ModuleInfo+0xC8+rip], 0
	jz	$_107
	call	RunLineQueue@PLT
$_107:	mov	dword ptr [StoreState+rip], 0
	cmp	dword ptr [Parse_Pass+rip], 0
	jbe	$_112
	cmp	dword ptr [UseSavedState+rip], 1
	jne	$_112
	call	RestoreState@PLT
	mov	qword ptr [LineStoreCurr+rip], rax
	mov	rsi, rax
	jmp	$_110

$_108:	mov	edx, dword ptr [rsi+0x10]
	mov	ecx, dword ptr [rsi+0x14]
	call	set_curr_srcfile@PLT
	mov	byte ptr [ModuleInfo+0x1C6+rip], 0
	mov	eax, dword ptr [rsi+0x18]
	mov	dword ptr [MacroLevel+rip], eax
	mov	qword ptr [ModuleInfo+0x218+rip], 0
	xor	r9d, r9d
	mov	r8, qword ptr [ModuleInfo+0x180+rip]
	xor	edx, edx
	lea	rcx, [rsi+0x20]
	call	Tokenize@PLT
	test	rax, rax
	jz	$_109
	mov	dword ptr [ModuleInfo+0x220+rip], eax
	mov	rcx, qword ptr [ModuleInfo+0x180+rip]
	call	ParseLine@PLT
$_109:	mov	rsi, qword ptr [rsi]
	mov	qword ptr [LineStoreCurr+rip], rsi
$_110:	test	rsi, rsi
	jz	$_111
	cmp	byte ptr [ModuleInfo+0x1E0+rip], 0
	jz	$_108
$_111:	jmp	$_115

$_112:	mov	rsi, qword ptr [Options+0x58+rip]
	jmp	$_114

$_113:	lea	rax, [rsi+0x8]
	mov	rsi, qword ptr [rsi]
	mov	edx, 1
	mov	rcx, rax
	call	SearchFile@PLT
	test	rax, rax
	jz	$_114
	mov	rcx, qword ptr [ModuleInfo+0x180+rip]
	call	ProcessFile@PLT
$_114:	test	rsi, rsi
	jnz	$_113
	mov	rcx, qword ptr [ModuleInfo+0x180+rip]
	call	ProcessFile@PLT
$_115:	call	LinnumFini@PLT
	cmp	dword ptr [Parse_Pass+rip], 0
	jnz	$_116
	call	PassOneChecks
$_116:	call	ClearSrcStack@PLT
	mov	eax, 1
	add	rsp, 40
	pop	rdi
	pop	rsi
	ret

get_module_name:
	push	rsi
	push	rdi
	sub	rsp, 40
	mov	rsi, qword ptr [Options+0x38+rip]
	test	rsi, rsi
	jz	$_118
	mov	r8d, 260
	mov	rdx, rsi
	lea	rcx, [ModuleInfo+0x230+rip]
	call	tstrncpy@PLT
	mov	byte ptr [ModuleInfo+0x333+rip], 0
	jmp	$_120

$_118:	mov	rcx, qword ptr [ModuleInfo+0x90+rip]
	call	GetFNamePart@PLT
	mov	rsi, rax
	mov	rcx, rax
	call	GetExtPart@PLT
	cmp	rax, rsi
	jnz	$_119
	mov	rcx, rsi
	call	tstrlen@PLT
	add	rax, rsi
$_119:	sub	rax, rsi
	lea	rcx, [ModuleInfo+0x230+rip]
	mov	byte ptr [rcx+rax], 0
	mov	r8d, eax
	mov	rdx, rsi
	call	tmemcpy@PLT
$_120:	lea	rsi, [ModuleInfo+0x230+rip]
	mov	rcx, rsi
	call	tstrupr@PLT
	xor	eax, eax
$_121:	lodsb
	test	al, al
	jz	$_122
	test	byte ptr [r15+rax], 0x44
	jnz	$_121
	mov	byte ptr [rsi-0x1], 95
	jmp	$_121
$_122:	cmp	byte ptr [ModuleInfo+0x230+rip], 57
	ja	$_123
	cmp	byte ptr [ModuleInfo+0x230+rip], 48
	jc	$_123
	mov	byte ptr [ModuleInfo+0x230+rip], 95
$_123:	add	rsp, 40
	pop	rdi
	pop	rsi
	ret

ModuleInit:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	eax, dword ptr [Options+0xA8+rip]
	mov	byte ptr [ModuleInfo+0x1B8+rip], al
	mov	eax, dword ptr [Options+0xA4+rip]
	mov	ecx, 16
	mul	ecx
	lea	rdx, [formatoptions+rip]
	add	rax, rdx
	mov	qword ptr [ModuleInfo+0x1A8+rip], rax
	mov	qword ptr [rbp-0x8], rax
	xor	eax, eax
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_125
	cmp	byte ptr [Options+0x89+rip], 0
	jnz	$_125
	inc	eax
$_125:	mov	byte ptr [ModuleInfo+0x1EE+rip], al
	mov	dword ptr [ModuleInfo+rip], 0
	mov	dword ptr [ModuleInfo+0x4+rip], 0
	mov	byte ptr [ModuleInfo+0x1B5+rip], 0
	mov	byte ptr [ModuleInfo+0x1B7+rip], 0
	mov	byte ptr [ModuleInfo+0x1D9+rip], 0
	cmp	dword ptr [Options+0x4+rip], 1
	jnz	$_126
	inc	byte ptr [ModuleInfo+0x1D9+rip]
$_126:	call	get_module_name
	mov	rdx, rdi
	lea	rdi, [SymTables+rip]
	mov	ecx, 96
	xor	eax, eax
	rep stosb
	mov	rdi, rdx
	mov	r10, qword ptr [rbp-0x8]
	call	qword ptr [r10]
	leave
	ret

ReswTableInit:
	sub	rsp, 40
	call	ResWordsInit@PLT
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_128
	mov	ecx, 239
	call	DisableKeyword@PLT
	mov	ecx, 251
	call	DisableKeyword@PLT
$_128:	cmp	byte ptr [Options+0xC6+rip], 0
	jnz	$_129
	mov	ecx, 558
	call	DisableKeyword@PLT
	mov	ecx, 325
	call	DisableKeyword@PLT
	mov	ecx, 322
	call	DisableKeyword@PLT
	mov	ecx, 254
	call	DisableKeyword@PLT
	mov	ecx, 240
	call	DisableKeyword@PLT
	mov	ecx, 256
	call	DisableKeyword@PLT
	mov	ecx, 247
	call	DisableKeyword@PLT
	mov	ecx, 259
	call	DisableKeyword@PLT
	mov	ecx, 257
	call	DisableKeyword@PLT
	mov	ecx, 235
	call	DisableKeyword@PLT
	mov	ecx, 242
	call	DisableKeyword@PLT
$_129:	add	rsp, 40
	ret

open_files:
	push	rsi
	push	rdi
	sub	rsp, 40
	lea	rsi, [DS0004+rip]
	mov	rdi, qword ptr [ModuleInfo+0x90+rip]
	call	fopen@PLT
	test	rax, rax
	jnz	$_131
	mov	rdx, qword ptr [ModuleInfo+0x90+rip]
	mov	ecx, 1000
	call	asmerr@PLT
$_131:	mov	qword ptr [ModuleInfo+0x70+rip], rax
	cmp	byte ptr [Options+0xC9+rip], 0
	jnz	$_133
	lea	rsi, [DS0005+rip]
	mov	rdi, qword ptr [ModuleInfo+0x98+rip]
	call	fopen@PLT
	test	rax, rax
	jnz	$_132
	mov	rdx, qword ptr [ModuleInfo+0x98+rip]
	mov	ecx, 1000
	call	asmerr@PLT
$_132:	mov	qword ptr [ModuleInfo+0x78+rip], rax
$_133:	cmp	byte ptr [Options+0x92+rip], 0
	jz	$_135
	lea	rsi, [DS0005+rip]
	mov	rdi, qword ptr [ModuleInfo+0xA0+rip]
	call	fopen@PLT
	test	rax, rax
	jnz	$_134
	mov	rdx, qword ptr [ModuleInfo+0xA0+rip]
	mov	ecx, 1000
	call	asmerr@PLT
$_134:	mov	qword ptr [ModuleInfo+0x80+rip], rax
$_135:	add	rsp, 40
	pop	rdi
	pop	rsi
	ret

iddc_file:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 344
	call	GetFNamePart@PLT
	mov	rdx, rax
	lea	rcx, [rbp-0x104]
	call	tstrcpy@PLT
	mov	rbx, rax
	mov	rcx, rbx
	call	GetExtPart@PLT
	cmp	rax, rbx
	jnz	$_137
	lea	rdx, [DS0006+rip]
	mov	rcx, rax
	call	tstrcat@PLT
	jmp	$_138

$_137:	lea	rdx, [DS0006+rip]
	mov	rcx, rax
	call	tstrcpy@PLT
$_138:	mov	rdx, rbx
	lea	rcx, [iddcfile+rip]
	call	tstrcpy@PLT
	mov	qword ptr [rbp-0x110], rax
	lea	rsi, [DS0005+rip]
	mov	rdi, rax
	call	fopen@PLT
	test	rax, rax
	jnz	$_139
	mov	rdx, qword ptr [rbp-0x110]
	mov	ecx, 1000
	call	asmerr@PLT
$_139:	mov	qword ptr [rbp-0x118], rax
	mov	rcx, rbx
	call	GetExtPart@PLT
	mov	byte ptr [rax], 0
	mov	rax, qword ptr [rbp+0x28]
	mov	qword ptr [rsp+0x30], rax
	mov	qword ptr [rsp+0x28], rbx
	mov	qword ptr [rsp+0x20], rbx
	mov	r9, rbx
	mov	r8, rbx
	lea	rdx, [DS0007+rip]
	mov	rcx, qword ptr [rbp-0x118]
	call	tfprintf@PLT
	cmp	byte ptr [Options+0xD7+rip], 2
	jnz	$_140
	lea	rdx, [DS0008+rip]
	mov	rcx, qword ptr [rbp-0x118]
	call	tfprintf@PLT
$_140:	lea	rdx, [DS0009+rip]
	mov	rcx, qword ptr [rbp-0x118]
	call	tfprintf@PLT
	mov	rdi, qword ptr [rbp-0x118]
	call	fclose@PLT
	mov	rax, qword ptr [rbp-0x110]
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

close_files:
	push	rsi
	push	rdi
	sub	rsp, 40
	mov	rax, qword ptr [ModuleInfo+0x70+rip]
	test	rax, rax
	jz	$_141
	mov	rdi, rax
	call	fclose@PLT
	test	rax, rax
	jz	$_141
	mov	rdx, qword ptr [ModuleInfo+0x90+rip]
	mov	ecx, 3021
	call	asmerr@PLT
$_141:	mov	rax, qword ptr [ModuleInfo+0x78+rip]
	test	rax, rax
	jz	$_142
	mov	rdi, rax
	call	fclose@PLT
	test	rax, rax
	jz	$_142
	mov	rdx, qword ptr [ModuleInfo+0x98+rip]
	mov	ecx, 3021
	call	asmerr@PLT
$_142:	cmp	byte ptr [Options+0xC9+rip], 0
	jnz	$_143
	cmp	dword ptr [ModuleInfo+rip], 0
	jnz	$_144
$_143:	cmp	dword ptr [remove_obj+rip], 0
	jz	$_145
$_144:	mov	dword ptr [remove_obj+rip], 0
	mov	rdi, qword ptr [ModuleInfo+0x98+rip]
	call	remove@PLT
$_145:	mov	rax, qword ptr [ModuleInfo+0x80+rip]
	test	rax, rax
	jz	$_146
	mov	rdi, rax
	call	fclose@PLT
	mov	qword ptr [ModuleInfo+0x80+rip], 0
$_146:	mov	rax, qword ptr [ModuleInfo+0x88+rip]
	test	rax, rax
	jz	$_147
	mov	rdi, rax
	call	fclose@PLT
	mov	qword ptr [ModuleInfo+0x88+rip], 0
	jmp	$_148

$_147:	cmp	qword ptr [ModuleInfo+0xA8+rip], 0
	jz	$_148
	mov	rdi, qword ptr [ModuleInfo+0xA8+rip]
	call	remove@PLT
$_148:	add	rsp, 40
	pop	rdi
	pop	rsi
	ret

GetExt:
	lea	rax, [currentftype+rip]
	mov	edx, 1836278062
	jmp	$_157
$_150:	mov	edx, 1784835886
	cmp	dword ptr [Options+0xA4+rip], 0
	jnz	$_153
	mov	edx, 1852400174
	cmp	dword ptr [Options+0xA8+rip], 1
	jz	$_151
	cmp	dword ptr [Options+0xA8+rip], 2
	jz	$_151
	cmp	dword ptr [Options+0xA8+rip], 3
	jnz	$_152
$_151:	mov	edx, 1702389038
	cmp	byte ptr [Options+0xCF+rip], 0
	jz	$_152
	mov	edx, 1819042862
$_152:	jmp	$_154
$_153:	cmp	dword ptr [Options+0xA4+rip], 3
	jnz	$_154
	and	edx, 0xFFFF
$_154:	jmp	$_158
$_155:	mov	edx, 1953721390
	jmp	$_158
$_156:	mov	edx, 1920099630
	jmp	$_158
$_157:	cmp	ecx, 1
	jz	$_150
	cmp	ecx, 2
	jz	$_155
	cmp	ecx, 3
	jz	$_156
$_158:	mov	dword ptr [rax], edx
	ret

SetFilenames:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 296
	call	LclDup@PLT
	mov	qword ptr [ModuleInfo+0x90+rip], rax
	mov	rcx, rax
	call	GetFNamePart@PLT
	mov	rsi, rax
	mov	edi, 1
	lea	rbx, [rbp-0x104]
	jmp	$_165
$_160:	lea	rax, [Options+rip]
	mov	rax, qword ptr [rax+rdi*8+0x10]
	test	rax, rax
	jnz	$_162
	mov	byte ptr [rbx], 0
	lea	rcx, [DefaultDir+rip]
	mov	rax, qword ptr [rcx+rdi*8]
	test	rax, rax
	jz	$_161
	mov	rdx, rax
	mov	rcx, rbx
	call	tstrcpy@PLT
$_161:	mov	rdx, rsi
	mov	rcx, rbx
	call	tstrcat@PLT
	mov	rcx, rax
	call	GetExtPart@PLT
	mov	rbx, rax
	mov	ecx, edi
	call	GetExt
	mov	rdx, rax
	mov	rcx, rbx
	call	tstrcpy@PLT
	lea	rbx, [rbp-0x104]
	jmp	$_164
$_162:	mov	rdx, rax
	mov	rcx, rbx
	call	tstrcpy@PLT
	mov	rcx, rax
	call	GetFNamePart@PLT
	cmp	byte ptr [rax], 0
	jnz	$_163
	mov	rdx, rsi
	mov	rcx, rax
	call	tstrcpy@PLT
$_163:	mov	rcx, rax
	call	GetExtPart@PLT
	cmp	byte ptr [rax], 0
	jnz	$_164
	mov	rbx, rax
	mov	ecx, edi
	call	GetExt
	mov	rdx, rax
	mov	rcx, rbx
	call	tstrcpy@PLT
	lea	rbx, [rbp-0x104]
$_164:	mov	rcx, rbx
	call	LclDup@PLT
	lea	rcx, [ModuleInfo+rip]
	mov	qword ptr [rcx+rdi*8+0x90], rax
	inc	edi
$_165:	cmp	rdi, 4
	jc	$_160
	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret

AssembleInit:
	mov	qword ptr [rsp+0x8], rcx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	call	MemInit@PLT
	mov	dword ptr [write_to_file+rip], 0
	mov	qword ptr [LinnumQueue+rip], 0
	mov	rcx, qword ptr [rbp+0x10]
	call	SetFilenames
	call	FastpassInit@PLT
	call	open_files
	call	ReswTableInit
	call	SymInit@PLT
	call	InputInit@PLT
	call	ModuleInit
	call	CondInit@PLT
	call	ExprEvalInit@PLT
	call	LstInit@PLT
	leave
	ret

AssembleFini:
	sub	rsp, 40
	call	SegmentFini@PLT
	call	ResWordsFini@PLT
	mov	qword ptr [ModuleInfo+0x10+rip], 0
	call	InputFini@PLT
	call	close_files
	xor	eax, eax
	mov	ecx, 4
	lea	rdx, [ModuleInfo+0x90+rip]
$_168:	mov	qword ptr [rdx+rcx*8-0x8], rax
	dec	rcx
	jnz	$_168
	call	MemFini@PLT
	add	rsp, 40
	ret

AssembleModule:
	mov	qword ptr [rsp+0x8], rcx
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	xor	eax, eax
	mov	dword ptr [MacroLocals+rip], eax
	mov	qword ptr [ModuleInfo+0xF0+rip], rax
	lea	rdi, [ModuleInfo+rip]
	mov	ecx, 856
	rep stosb
	mov	byte ptr [ModuleInfo+0x1C4+rip], 10
	dec	eax
	mov	dword ptr [rbp-0x8], eax
	cmp	byte ptr [Options+rip], 0
	jnz	$_169
	mov	rdx, qword ptr [rbp+0x28]
	lea	rcx, [DS000A+rip]
	call	tprintf@PLT
$_169:	lea	rcx, [jmpenv+rip]
	xor	eax, eax
	mov	qword ptr [rcx+0x10], rbp
	mov	qword ptr [rcx], rbx
	mov	qword ptr [rcx+0x8], rsp
	mov	qword ptr [rcx+0x18], r12
	mov	qword ptr [rcx+0x20], r13
	mov	qword ptr [rcx+0x28], r14
	mov	qword ptr [rcx+0x30], r15
	lea	rdx, [$_170+rip]
	mov	qword ptr [rcx+0x38], rdx
$_170:	test	rax, rax
	jz	$_173
	cmp	eax, 1
	jnz	$_171
	call	ClearSrcStack@PLT
	call	AssembleFini
	xor	eax, eax
	mov	dword ptr [MacroLocals+rip], eax
	lea	rdi, [ModuleInfo+rip]
	mov	ecx, 856
	rep stosb
	dec	eax
	mov	dword ptr [rbp-0x8], eax
	jmp	$_173

$_171:	cmp	qword ptr [ModuleInfo+0xD8+rip], 0
	jz	$_172
	call	ClearSrcStack@PLT
$_172:	jmp	$_191

$_173:	cmp	byte ptr [Options+0xD7+rip], 0
	jz	$_174
	mov	rcx, qword ptr [rbp+0x28]
	call	iddc_file
	mov	qword ptr [rbp+0x28], rax
$_174:	mov	rcx, qword ptr [rbp+0x28]
	call	AssembleInit
	mov	dword ptr [Parse_Pass+rip], 0
$_175:	call	OnePass
	xor	eax, eax
	cmp	dword ptr [ModuleInfo+rip], eax
	ja	$_189
	mov	dword ptr [rbp-0x4], eax
	mov	rsi, qword ptr [SymTables+0x20+rip]
	jmp	$_177

$_176:	mov	eax, dword ptr [rsi+0x50]
	add	dword ptr [rbp-0x4], eax
	mov	rsi, qword ptr [rsi+0x70]
$_177:	test	rsi, rsi
	jnz	$_176
	mov	eax, dword ptr [rbp-0x4]
	cmp	byte ptr [ModuleInfo+0x1ED+rip], 0
	jnz	$_178
	cmp	eax, dword ptr [rbp-0x8]
	je	$_189
$_178:	mov	dword ptr [rbp-0x8], eax
	cmp	dword ptr [Parse_Pass+rip], 199
	jc	$_179
	mov	edx, 200
	mov	ecx, 3000
	call	asmerr@PLT
$_179:	cmp	byte ptr [Options+0x1+rip], 0
	jz	$_185
	cmp	dword ptr [Options+0xA4+rip], 2
	jnz	$_184
	mov	rsi, qword ptr [SymTables+0x20+rip]
	jmp	$_183

$_180:	mov	rbx, qword ptr [rsi+0x68]
	test	rbx, rbx
	jz	$_182
	cmp	qword ptr [rbx+0x38], 0
	jz	$_181
	mov	rcx, qword ptr [rbx+0x38]
	call	QueueDeleteLinnum@PLT
$_181:	mov	qword ptr [rbx+0x38], 0
$_182:	mov	rsi, qword ptr [rsi+0x70]
$_183:	test	rsi, rsi
	jnz	$_180
	jmp	$_185

$_184:	lea	rcx, [LinnumQueue+rip]
	call	QueueDeleteLinnum@PLT
	mov	qword ptr [LinnumQueue+rip], 0
$_185:	mov	rdi, qword ptr [ModuleInfo+0x70+rip]
	call	rewind@PLT
	cmp	dword ptr [write_to_file+rip], 0
	jz	$_186
	cmp	dword ptr [Options+0xA4+rip], 1
	jnz	$_186
	call	omf_set_filepos@PLT
$_186:	inc	dword ptr [Parse_Pass+rip]
	cmp	qword ptr [ModuleInfo+0x80+rip], 0
	jz	$_188
	cmp	dword ptr [UseSavedState+rip], 0
	jnz	$_187
	mov	rdi, qword ptr [ModuleInfo+0x80+rip]
	call	rewind@PLT
	call	LstInit@PLT
	jmp	$_188

$_187:	cmp	dword ptr [Parse_Pass+rip], 1
	jnz	$_188
	cmp	byte ptr [Options+0xA1+rip], 0
	jz	$_188
	call	LstInit@PLT
$_188:	jmp	$_175

$_189:	cmp	dword ptr [Parse_Pass+rip], 0
	jbe	$_190
	cmp	dword ptr [write_to_file+rip], 0
	jz	$_190
	call	WriteModule
$_190:	call	LstWriteCRef@PLT
$_191:	call	AssembleFini
	xor	eax, eax
	cmp	eax, dword ptr [ModuleInfo+rip]
	jnz	$_192
	inc	eax
$_192:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret


.SECTION .data
	.ALIGN	16

Parse_Pass:
	.int   0x00000000

write_to_file:
	.int   0x00000000

cp_text1:
	.asciz "_TEXT"

cp_text2:
	.asciz ".text"

cp_data1:
	.asciz "_DATA"

cp_data2:
	.asciz ".data"

cp_const:
	.asciz "CONST"

cp_rdata:
	.asciz ".rdata"

cp_bss1:
	.asciz "_BSS"

cp_bss2:
	.asciz ".bss\0"

formatoptions:
	.quad  bin_init
	.quad  0x0000004E49420000
	.quad  omf_init
	.quad  0x000000464D4F0000
	.quad  coff_init
	.quad  0x000046464F430E12
	.quad  elf_init
	.quad  0x000000464C450F00

cst:
	.byte  0x05, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.quad  cp_text1
	.quad  cp_text2
	.quad  0x0000000100000005
	.quad  cp_data1
	.quad  cp_data2
	.quad  0x0000000100000005
	.quad  cp_const
	.quad  cp_rdata
	.quad  0x0000000000000004
	.quad  cp_bss1
	.quad  cp_bss2

stt:
	.byte  0x01, 0x02, 0x02, 0x03

currentftype:
	.zero  8 * 1

remove_obj:
	.int   0x00000000

DS0000:
	.asciz "w"

DS0001:
	.asciz "import '%s'  %s.%s\n"

DS0002:
	.asciz "INCLUDE"

PrintEmptyLine:
	.byte  0x01

DS0003:
	.asciz "%r %s"

DS0004:
	.asciz "rb"

DS0005:
	.asciz "wb"

DS0006:
	.asciz ".s"

DS0007:
	.ascii "public IDD_%s\n"
	.ascii ".data\n"
	.ascii "PIDD typedef ptr\n"
	.ascii "IDD_%s PIDD %s_RC\n"
	.ascii "%s_RC label byte\n"
	.asciz "incbin <%s>\n"

DS0008:
	.asciz "db 0\n"

DS0009:
	.asciz "end\n"

DS000A:
	.asciz " Assembling: %s\n"


.SECTION .bss
	.ALIGN	16

ModuleInfo:
	.zero	107 * 8

LinnumQueue:
	.zero	2 * 8

jmpenv:
	.zero	64 * 1

iddcfile:
	.zero	256 * 1


.att_syntax prefix
