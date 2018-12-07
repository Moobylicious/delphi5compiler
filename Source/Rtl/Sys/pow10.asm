
; *******************************************************
; *							*
; *     Delphi Runtime Library                          *
; *							*
; *	Copyright (c) 1996,98 Inprise Corporation	*
; *							*
; *******************************************************

	INCLUDE	SE.ASM

	.386
	.MODEL	FLAT

	PUBLIC	_Pow10,FPower10

	.CODE

;	FUNCTION _Pow10( val: Extended; int pow: Integer ) : Extended;

_Pow10	PROC

; ->	FST(0)	val
; ->	EAX	Power
; <-	FST(0)	val * 10**Power

;	This routine generates 10**power with no more than two
;	floating point multiplications. Up to 10**31, no multiplications
;	are needed.

FPower10:

	TEST	EAX,EAX
	JL	@@neg
	JE	@@exit
	CMP	EAX,5120
	JGE	@@inf
	MOV	EDX,EAX
	AND	EDX,01FH
	LEA	EDX,[EDX+EDX*4]
	FLD	tab0[EDX*2]
	FMULP

	SHR	EAX,5
	JE	@@exit

	MOV	EDX,EAX
	AND	EDX,0FH
	JE	@@skip2ndMul
	LEA	EDX,[EDX+EDX*4]
	FLD	tab1-10[EDX*2]
	FMULP

@@skip2ndMul:

	SHR	EAX,4
	JE	@@exit
	LEA	EAX,[EAX+EAX*4]
	FLD	tab2-10[EAX*2]
	FMULP

@@exit:
	RET

@@neg:
	NEG	EAX
	CMP	EAX,5120
	JGE	@@zero
	MOV	EDX,EAX
	AND	EDX,01FH
	LEA	EDX,[EDX+EDX*4]
	FLD	tab0[EDX*2]
	FDIVP

	SHR	EAX,5
	JE	@@exit

	MOV	EDX,EAX
	AND	EDX,0FH
	JE	@@skip2ndDiv
	LEA	EDX,[EDX+EDX*4]
	FLD	tab1-10[EDX*2]
	FDIVP

@@skip2ndDiv:

	SHR	EAX,4
	JE	@@exit
	LEA	EAX,[EAX+EAX*4]
	FLD	tab2-10[EAX*2]
	FDIVP

	RET

@@inf:
	FLD	inf
	RET

@@zero:
	FLDZ
	RET

inf	DT	7FFF8000000000000000R

if 0	; unfortunately, tasm32 makes some numbers one bit too small...
tab0	DT	1E0
	DT	1E1
	DT	1E2
	DT	1E3
	DT	1E4
	DT	1E5
	DT	1E6
	DT	1E7
	DT	1E8
	DT	1E9
	DT	1E10
	DT	1E11
	DT	1E12
	DT	1E13
	DT	1E14
	DT	1E15
	DT	1E16
	DT	1E17
	DT	1E18
	DT	1E19
	DT	1E20
	DT	1E21
	DT	1E22
	DT	1E23
	DT	1E24
	DT	1E25
	DT	1E26
	DT	1E27
	DT	1E28
	DT	1E29
	DT	1E30
	DT	1E31

tab1	DT	1E32
	DT	1E64
	DT	1E96
	DT	1E128
	DT	1E160
	DT	1E192
	DT	1E224
	DT	1E256
	DT	1E288
	DT	1E320
	DT	1E352
	DT	1E384
	DT	1E416
	DT	1E448
	DT	1E480

tab2	DT	1E512
	DT	1E1024
	DT	1E1536
	DT	1E2048
	DT	1E2560
	DT	1E3072
	DT	1E3584
	DT	1E4096
	DT	1E4608

else	;	these are better numbers ...

tab0	DT	3FFF8000000000000000R	; 10**0
	DT	4002A000000000000000R	; 10**1
	DT	4005C800000000000000R	; 10**2
	DT	4008FA00000000000000R	; 10**3
	DT	400C9C40000000000000R	; 10**4
	DT	400FC350000000000000R	; 10**5
	DT	4012F424000000000000R	; 10**6
	DT	40169896800000000000R	; 10**7
	DT	4019BEBC200000000000R	; 10**8
	DT	401CEE6B280000000000R	; 10**9
	DT	40209502F90000000000R	; 10**10
	DT	4023BA43B74000000000R	; 10**11
	DT	4026E8D4A51000000000R	; 10**12
	DT	402A9184E72A00000000R	; 10**13
	DT	402DB5E620F480000000R	; 10**14
	DT	4030E35FA931A0000000R	; 10**15
	DT	40348E1BC9BF04000000R	; 10**16
	DT	4037B1A2BC2EC5000000R	; 10**17
	DT	403ADE0B6B3A76400000R	; 10**18
	DT	403E8AC7230489E80000R	; 10**19
	DT	4041AD78EBC5AC620000R	; 10**20
	DT	4044D8D726B7177A8000R	; 10**21
	DT	4048878678326EAC9000R	; 10**22
	DT	404BA968163F0A57B400R	; 10**23
	DT	404ED3C21BCECCEDA100R	; 10**24
	DT	405284595161401484A0R	; 10**25
	DT	4055A56FA5B99019A5C8R	; 10**26
	DT	4058CECB8F27F4200F3AR	; 10**27
	DT	405C813F3978F8940984R	; 10**28
	DT	405FA18F07D736B90BE5R	; 10**29
	DT	4062C9F2C9CD04674EDFR	; 10**30
	DT	4065FC6F7C4045812296R	; 10**31

tab1	DT	40699DC5ADA82B70B59ER	; 10**32
	DT	40D3C2781F49FFCFA6D5R	; 10**64
	DT	413DEFB3AB16C59B14A3R	; 10**96
	DT	41A893BA47C980E98CE0R	; 10**128
	DT	4212B616A12B7FE617AAR	; 10**160
	DT	427CE070F78D3927556BR	; 10**192
	DT	42E78A5296FFE33CC930R	; 10**224
	DT	4351AA7EEBFB9DF9DE8ER	; 10**256
	DT	43BBD226FC195C6A2F8CR	; 10**288
	DT	442681842F29F2CCE376R	; 10**320
	DT	44909FA42700DB900AD2R	; 10**352
	DT	44FAC4C5E310AEF8AA17R	; 10**384
	DT	4564F28A9C07E9B09C59R	; 10**416
	DT	45CF957A4AE1EBF7F3D4R	; 10**448
	DT	4639B83ED8DC0795A262R	; 10**480

tab2	DT	46A3E319A0AEA60E91C7R	; 10**512
	DT	4D48C976758681750C17R	; 10**1024
	DT	53EDB2B8353B3993A7E4R	; 10**1536
	DT	5A929E8B3B5DC53D5DE5R	; 10**2048
	DT	61378CA554C020A1F0A6R	; 10**2560
	DT	67DBF9895D25D88B5A8BR	; 10**3072
	DT	6E80DD5DC8A2BF27F3F8R	; 10**3584
	DT	7525C46052028A20979BR	; 10**4096
	DT	7BCAAE3511626ED559F0R	; 10**4608
endif

_Pow10	ENDP

	END