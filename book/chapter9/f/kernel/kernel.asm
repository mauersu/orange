
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                               kernel.asm
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                                                     Forrest Yu, 2005
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


%include "sconst.inc"

; 导入函数
extern	cstart
extern	kernel_main
extern	exception_handler
extern	spurious_irq
extern	clock_handler
extern	disp_str
extern	delay
extern	irq_table

; 导入全局变量
extern	gdt_ptr
extern	idt_ptr
extern	p_proc_ready
extern	tss
extern	disp_pos
extern	k_reenter
extern	sys_call_table

bits 32

[SECTION .data]
clock_int_msg		db	"^", 0

[SECTION .bss]
StackSpace		resb	2 * 1024
StackTop:		; 栈顶

[section .text]	; 代码在此

global _start	; 导出 _start

global restart
global sys_call

global	divide_error
global	single_step_exception
global	nmi
global	breakpoint_exception
global	over(tep_ex+++dde_�3�          _obal	breakpoint_exception
global	over(tep_ex+++dde_�3�          _obal	breakpoine_�e _obal	bcopr_not_availbss]
breakpoiouss]_fault _obal	bcopr_seg_er(trun _obal	breakpo

[S
global	egm		d_not_pept		dS
global	 导xception
global	ovgenerkpoallt restalobal	ovpag]_fault _obal	bcopr_eption
globalhwt_e00n
globalhwt_e01n
globalhwt_e02n
globalhwt_e03n
globalhwt_e04n
globalhwt_e05n
globalhwt_e06n
globalhwt_e07n
globalhwt_e08n
globalhwt_e09n
globalhwt_e10n
globalhwt_e11n
globalhwt_e12n
globalhwt_e13n
globalhwt_e14n
globalhwt_e15l_msingle:
star��时内存看上去是这样的（更详细的内存情况ll
 LOADER.ASM 中有说明）：
staaaaaaaaaaaaaa┃++++++++++++++++++++++++++++++++++++┃
staaaaaaaaaaaaaa┃+++++++++++++++++...++++++++++++++++┃
staaaaaaaaaaaaaa┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┃■■■■■■Pag]  Tbss]s■■■■■■┃
staaaaaaaaaaaaaa┃■■■■■(大小由LOADER决定)■■■■┃ Pag]TblBase
staaaa00101000ha┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┃■■■■Pag] Dir reory Tbss]■■■■┃ Pag]DirBase = 1M
staaaa00100000ha┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┃□□□□ Hardwar]  Rpt	rved □□□□┃ B8000ha← gs
staaaaaaa9FC00ha┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┃■■■■■■■LOADER.BIN■■■■■■┃ somewher] in LOADERa← esp
staaaaaaa90000ha┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┃■■■■■■■KERNEL.BIN■■■■■■┃
staaaaaaa80000ha┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┃■■■■■■■■KERNEL■■■■■■■┃ 30400ha← KERNEL xter�� (Kk_hanEntryPnt_ePhyAddr)
staaaaaaa30000ha┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┋                 ...++++++++++++++++┋
staaaaaaaaaaaaaa┋                                    ┋
staaaaaaaaaaa0ha┗━━━━━━━━━━━━━━━━━━┛a← cs, ds, es, fs, ss
st
st
st GDT syer��相应的描述符是这样的：
st
st		              Descripeors               Sel reors
staaaaaaaaaaaaaa┏━━━━━━━━━━━━━━━━━━┓
staaaaaaaaaaaaaa┃+++++++++Dummy Descripeoraaaaaaaaaaa┃
staaaaaaaaaaaaaa┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┃+++++++++DESC_FLAT_C++++(0～4G)aaaaa┃+++8h = cs
staaaaaaaaaaaaaa┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┃+++++++++DESC_FLAT_RW+++(0～4G)aaaaa┃++10h = ds, es, fs, ss
staaaaaaaaaaaaaa┣━━━━━━━━━━━━━━━━━━┫
staaaaaaaaaaaaaa┃+++++++++DESC_VIDEO                 ┃++1Bh = gs
staaaaaaaaaaaaaa┗━━━━━━━━━━━━━━━━━━┛
st
st 注意! ll
使用 C sys_ca的时候一定要保证 ds, es, ss 这几个段寄存器的值是一样的
st 因为编译器有可能编译出使用它们的sys_ca, 而编译器默认它们是一样的. 比如串拷贝操作会用到 ds 和 es.
st
st


st 把 esp sy� LOADERa挪到 KERNEL
	mov	esp, ; 导出st 堆rt
ll
 	;  段中

	mov	dword [.data]
c][sect	sos
	[os
extebal irq
ex() 中将会用到 os
exter	loba_irq
ex_stall

gltern	s中改
ex了os
exte，让它指向新的GDT
	los
	[os
extebal 使用新的GDT

	lis
	[nter
ex]

	jmp	SELn .OR_KERNEL_CS:c	ovit
c	ovit _sta“这个跳转指令强制使用刚刚初始化的结构”——<<OS:D&I 2nd>> P90.

stjmp 0x40:0
stud2


sxor	eax, eax
	mov	ax, SELn .OR_TSS
	ltr	ax

ststi
	jmp	ck_handler
e
sthlt read中断和异常 -- 硬件中断ead---------------------------------
%macrolhwt_edleep_r	1r	loba_save
sin	al, INT_M_CTLMASKsta`.
sor	al, (1 << %1)_sta | 屏蔽当前中断e	out	INT_M_CTLMASK, bal; /
	mov	al, EOI		sta`. 置EOI位e	out	INT_M_CTL, ball; /
	stil; CPUll
响应中断的过程中会自动关中断，这句之后就允许响应新的中断e	push	%1		sta`.r	loba_[n	p_proc_ + 4 * %1]sta | 中断处理程序e	p��secx	ll; /
	cli
sin	al, INT_M_CTLMASKsta`.
sand	al, ~(1 << %1)_sta | 恢复�er��当前中断e	out	INT_M_CTLMASK, bal; /
	ret
%endmacro reALIGN	16
hwt_e00 _staI	db	rupt routine foran	p 0 (the Stack).
shwt_edleep_r	0reALIGN	16
hwt_e01 _staI	db	rupt routine foran	p 1 (keyboard)
lhwt_edleep_r	1reALIGN	16
hwt_e02 _staI	db	rupt routine foran	p 2 (cascade!)
lhwt_edleep_r	2reALIGN	16
hwt_e03 _staI	db	rupt routine foran	p 3 (second t	rial)
lhwt_edleep_r	3reALIGN	16
hwt_e04 _staI	db	rupt routine foran	p 4 (first t	rial)
lhwt_edleep_r	4reALIGN	16
hwt_e05 _staI	db	rupt routine foran	p 5 (XT wt_cheep_r)
lhwt_edleep_r	5reALIGN	16
hwt_e06 _staI	db	rupt routine foran	p 6 (floppy)
lhwt_edleep_r	6reALIGN	16
hwt_e07 _staI	db	rupt routine foran	p 7 (prinp_r)
lhwt_edleep_r	7
ead---------------------------------
%macrolhwt_edslave	1r	loba_save
sin	al, INT_S_CTLMASKsta`.
sor	al, (1 << (%1 - 8))sta | 屏蔽当前中断e	out	INT_S_CTLMASK, bal; /
	mov	al, EOI		sta`. 置EOI位(leep_r)e	out	INT_M_CTL, ball; /
	n��s		sta`. 置EOI位(slave)e	out	INT_S_CTL, ball; /  一定注意：slave和leep_r都要置EOI
	stil; CPUll
响应中断的过程中会自动关中断，这句之后就允许响应新的中断e	push	%1		sta`.r	loba_[n	p_proc_ + 4 * %1]sta | 中断处理程序e	p��secx	ll; /
	cli
sin	al, INT_S_CTLMASKsta`.
sand	al, ~(1 << (%1 - 8))sta | 恢复�er��当前中断e	out	INT_S_CTLMASK, bal; /
	ret
%endmacro ad---------------------------------
eALIGN	16
hwt_e08 _staI	db	rupt routine foran	p 8 (realtime Stack).
shwt_edslave	8
eALIGN	16
hwt_e09 _staI	db	rupt routine foran	p 9 (n	p 2 redir reed)
lhwt_edslave	9
eALIGN	16
hwt_e10 _staI	db	rupt routine foran	p 10
lhwt_edslave	10reALIGN	16
hwt_e11 _staI	db	rupt routine foran	p 11
lhwt_edslave	11reALIGN	16
hwt_e12 _staI	db	rupt routine foran	p 12
lhwt_edslave	12reALIGN	16
hwt_e13 _staI	db	rupt routine foran	p 13 (FPU ception
g)
lhwt_edslave	13reALIGN	16
hwt_e14 _staI	db	rupt routine foran	p 14 (AT wt_cheep_r)
lhwt_edslave	14reALIGN	16
hwt_e15 _staI	db	rupt routine foran	p 15
lhwt_edslave	15l_mead中断和异常 -- 异常
int_exceptio:e	push	0xFFFFFFFFstano ept e_�e 	push	0_stav reor_no	=sec	jmp	ception
gl	over(tep_ex+++dde_�3:e	push	0xFFFFFFFFstano ept e_�e 	push	1_stav reor_no	=s1c	jmp	ception
glnmi:e	push	0xFFFFFFFFstano ept e_�e 	push	2_stav reor_no	=s2c	jmp	ception
gleakpoint_exception
g:e	push	0xFFFFFFFFstano ept e_�e 	push	3_stav reor_no	=s3c	jmp	ception
gler(tep_e:e	push	0xFFFFFFFFstano ept e_�e 	push	4_stav reor_no	=s4c	jmp	ception
gle3�         :e	push	0xFFFFFFFFstano ept e_�e 	push	5_stav reor_no	=s5c	jmp	ception
glreakpoine_�e:e	push	0xFFFFFFFFstano ept e_�e 	push	6_stav reor_no	=s6c	jmp	ception
glcopr_not_availbss]:e	push	0xFFFFFFFFstano ept e_�e 	push	7_stav reor_no	=s7c	jmp	ception
gliouss]_fault:e	push	8_stav reor_no	=s8c	jmp	ception
glcopr_seg_er(trun:e	push	0xFFFFFFFFstano ept e_�e 	push	9_stav reor_no	=s9c	jmp	ception
glreakpotss:e	push	10_stav reor_no	=sAc	jmp	ception
gl	egm		d_not_pept		d:e	push	11_stav reor_no	=sBc	jmp	ception
gl	 导xception
g:e	push	12_stav reor_no	=sCc	jmp	ception
glgenerkpoallt resta:e	push	13_stav reor_no	=sDc	jmp	ception
glpag]_fault:e	push	14_stav reor_no	=sEc	jmp	ception
glcopr_eptio:e	push	0xFFFFFFFFstano ept e_�e 	push	16_stav reor_no	=s10hc	jmp	ception
gl
ception
g:e	loba_isp_str
extern	del	add	esp, 4*2sta让rt

gl指向 EIP，堆rt
中从
gl向下依次是：EIP、CS、EFLAGS
	hlt r; =============================================================================2005
; ++++++++++++++++++++++++++++++save
; =============================================================================2save:
++++++++pushad++++++++++ta`.
++++++++push++++ds++++++ta |
++++++++push++++es++++++ta | 保存原寄存器值
++++++++push++++fs++++++ta |
++++++++push++++gs++++++ta/e
stt 注意，从这里开始，一直到 `mov esp, ; 导出'，中间坚决不能用+push/p�� 指令，
stt 因为当前 esp 指向 all_tproc_ 里的某个位置，push+会破坏掉进程表，导致灾难性后果！

	mov	esi, edxal 保存 edx，因为 edx 里保存了系统调用的参n	sps		st（没用栈，而是用了另一个寄存器 esi）
	mov	dx, ss
smov	ds, dx
	mov	es, dx
	mov	fs, dx

	mov	edx, esist 恢复 edx

++++++++mov ++++esi, esp                    ;esi = 进程表起始地址

++++++++t_c+++++dword [_msg		db	]           ;_msg		db	++;
++++++++cmp+++++dword [_msg		db	], 0        ;if(_msg		db	 ==0)
++++++++jne     .1                          ;{
++++++++mov ++++esp, ; 导出               ;++mov esp, ; 导出 <--切换到内核栈
++++++++push++++eption
                     ;++push+eption
g++++++++jmp+++++[esi + RETADR - P_STACKBASE];++epturn;
.1:                                         ;} else { 已经ll
内核栈，不需要再切换
++++++++push++++eption
msg		db	             ;++push+eption
msg		db	"++++++++jmp+++++[esi + RETADR - P_STACKBASE];++epturn;
                                            ;}
 r; =============================================================================2005
; ++++++++++++++++++++++++++++mi
global; =============================================================================2si
globa:
++++++++loba++++mave

++++++++sti
	push	esi

	push	dword [_call_table
]
	push	edx
	push	ecx
	push	ebx
++++++++loba++++[[SECTION .bss] + eax * 4]l	add	esp, 4 * 4
e	p��sesi
++++++++mov ++++[esi + EAXREG - P_STACKBASE], eax
++++++++lli

++++++++ret
 r; ====================================================================================2005
; ++++++++++++++++++++++++++++++eption
g; ====================================================================================2eption
:
	mov	esp, [_call_table
]
	lls
	[esp + P_LDT_SEL] 
	lea	eax, [esp + P_STACKTOP]
	mov	dword [tss + TSS3_S_SP0], eax
eption
msg		db	:
	dec	dword [_msg		db	]e	p��sgs
sp��sfse	p��sese	p��sdse	p��adl	add	esp, 4
	iretd

