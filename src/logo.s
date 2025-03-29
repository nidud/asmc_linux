
.intel_syntax noprefix

.global write_logo
.global write_usage
.global write_options
.global banner_printed
.global cp_logo

.extern tprintf


.SECTION .text
	.ALIGN	16

write_logo:
	sub	rsp, 40
	cmp	byte ptr [banner_printed+rip], 0
	jnz	$_001
	mov	byte ptr [banner_printed+rip], 1
	mov	r9d, 25
	mov	r8d, 36
	mov	edx, 2
	lea	rcx, [cp_logo+rip]
	call	tprintf@PLT
	lea	rdx, [cp_copyright+rip]
	lea	rcx, [DS0000+rip]
	call	tprintf@PLT
$_001:	add	rsp, 40
	ret

write_usage:
	sub	rsp, 40
	call	write_logo
	lea	rcx, [cp_usage+rip]
	call	tprintf@PLT
	add	rsp, 40
	ret

write_options:
	sub	rsp, 40
	call	write_logo
	lea	rcx, [cp_options+rip]
	call	tprintf@PLT
	add	rsp, 40
	ret


.SECTION .data
	.ALIGN	16

banner_printed:
	.byte  0x00

cp_logo:
	.asciz "Asmc Macro Assembler Version %d.%02d.%02d"

cp_copyright:
	.asciz "Copyright (C) The Asmc Contributors. All Rights Reserved.\n"

cp_usage:
	.ascii "USAGE: ASMC [options] filename [ [options] filename] ... [-link link_options]\n"
	.asciz "Use option -h for more info\n"

cp_options:
	.ascii "        ASMC [options] filename [ [options] filename] ... [-link link_options]\n"
	.ascii "\n"
	.ascii "-<0|1|..|10>[p] Set CPU: 0=8086 (default), 1=80186, 2=80286, 3=80386, 4=80486,\n"
	.ascii " 5=Pentium,6=PPro,7=P2,8=P3,9=P4,10=x86-64; <p> allows privileged instructions\n"
	.ascii "-assert Generate .assert() code            -autostack Auto stack space for arguments\n"
	.ascii "-bin Generate plain binary file            -Bl<file> Selects an alternate linker\n"
	.ascii "-c Assembles only - no linking             -Cs Push USES registers before prolouge\n"
	.ascii "-coff Generate COFF format object file     -C<p|u|x> Set OPTION CASEMAP\n"
	.ascii "-D<name>[=text] Define text macro          -dotname Allow dot .identifiers\n"
	.ascii "-e<number> Set error limit number          -elf[64] Generate ELF object file\n"
	.ascii "-endbr Insert ENDBR at function entry      -EP Output preprocessed listing to stdout\n"
	.ascii "-eq Don't display error messages           -Fd[file] Write import definition file\n"
	.ascii "-Fi<file> Force <file> to be included      -Fl[file] Generate listing\n"
	.ascii "-Fo<file> Name object file                 -Fw<file> Set errors file name\n"
	.ascii "-fpic, -fno-pic Position Independent Code  -frame Auto generate unwind information\n"
	.ascii "-FPi Generate 80x87 emulator encoding      -FPi87 80x87 instructions (default)\n"
	.ascii "-fpc Disallow floating-point instructions  -fp<n> Set FPU: 0=8087, 2=80287, 3=80387\n"
	.ascii "-Ge force stack checking for all funcs     -G<cdzvs> Pascal, C, Std/Vector/Sys-call\n"
	.ascii "-homeparams Copy Reg. parameters to Stack  -I<name> Add include path\n"
	.ascii "-idd[t] Assemble as binary data [or text]  -logo Print logo string and exit\n"
	.ascii "-m<t|s|c|m|l|h|f> Set memory model         -mz Generate DOS MZ binary file\n"
	.ascii "-MD[d] (dynamic) Defines _MSVCRT [_DEBUG]  -MT[d] (static) Defines _MT [_DEBUG]\n"
	.ascii "-nc<name> Set class name of code segment   -nd<name> Set name of data segment\n"
	.ascii "-nm<name> Set name of module               -nolib Ignore INCLUDELIB directive\n"
	.ascii "-nt<name> Set name of text segment         -pe[c|g|d] Generate PE binary file\n"
	.ascii "-q, -nologo Suppress copyright message     -r Recurse subdirectories\n"
	.ascii "-Sa Maximize source listing                -safeseh Assert exception handlers\n"
	.ascii "-Sf Generate first pass listing            -Sg Display generated code in listing\n"
	.ascii "-Sn Suppress symbol-table listing          -Sp[n] Set segment alignment\n"
	.ascii "-stackalign Align locals to 16-byte        -sysvregs Strip RDI/RSI from USES\n"
	.ascii "-Sx List false conditionals                -w Same as -W0 -WX\n"
	.ascii "-W<number> Set warning level               -win64 Generate 64-bit COFF object\n"
	.ascii "-ws Store quoted strings as unicode        -WX Treat all warnings as errors\n"
	.ascii "-X Ignore INCLUDE environment path         -Z7 Add full symbolic debug info\n"
	.ascii "-zcw No decoration for C symbols           -Zd Add line number debug info\n"
	.ascii "-Zf Make all symbols public                -zf<0|1> Set FASTCALL type: MS-OW\n"
	.ascii "-Zg Generate code to match Masm            -Zi[012348] Add symbolic debug info\n"
	.ascii "-zlc No OMF records of data in code        -zld No OMF records of far call\n"
	.ascii "-Zm Enable MASM 5.10 compatibility         -Zv8 Enable Masm v8+ PROC visibility\n"
	.ascii "-Zne Disable non Masm extensions           -zl<f|p|s> Suppress items in COFF\n"
	.ascii "-Zp[n] Set structure alignment             -Zs Perform syntax check only\n"
	.ascii "-zt<0|1|2> Set STDCALL decoration          -zze No export symbol decoration\n"
	.asciz "-zzs Store name of start address\n"

DS0000:
	.asciz "\n%s\n"


.att_syntax prefix
