	.file	"AvrLib.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	.text.EnterAtomic,"ax",@progbits
.global	EnterAtomic
	.type	EnterAtomic, @function
EnterAtomic:
.LFB3:
	.file 1 "C:\\Users\\rolfl\\Documents\\GitHub\\Avr\\AvrLib\\Build\\AvrLib.c"
	.loc 1 145 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 146 0
/* #APP */
 ;  146 "C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\Build\AvrLib.c" 1
	cli
 ;  0 "" 2
	.loc 1 147 0
/* #NOAPP */
	lds r24,_enterAtomicNesting
	subi r24,lo8(-(1))
	sts _enterAtomicNesting,r24
	ret
	.cfi_endproc
.LFE3:
	.size	EnterAtomic, .-EnterAtomic
	.section	.text.LeaveAtomic,"ax",@progbits
.global	LeaveAtomic
	.type	LeaveAtomic, @function
LeaveAtomic:
.LFB4:
	.loc 1 151 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 152 0
	lds r24,_enterAtomicNesting
	subi r24,lo8(-(-1))
	sts _enterAtomicNesting,r24
	.loc 1 153 0
	cpse r24,__zero_reg__
	rjmp .L2
	.loc 1 155 0
/* #APP */
 ;  155 "C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\Build\AvrLib.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
.L2:
	ret
	.cfi_endproc
.LFE4:
	.size	LeaveAtomic, .-LeaveAtomic
	.section	.text.SetState,"ax",@progbits
.global	SetState
	.type	SetState, @function
SetState:
.LFB5:
	.loc 1 160 0
	.cfi_startproc
.LVL0:
	push r16
.LCFI0:
	.cfi_def_cfa_offset 3
	.cfi_offset 16, -2
	push r17
.LCFI1:
	.cfi_def_cfa_offset 4
	.cfi_offset 17, -3
	push r28
.LCFI2:
	.cfi_def_cfa_offset 5
	.cfi_offset 28, -4
	push r29
.LCFI3:
	.cfi_def_cfa_offset 6
	.cfi_offset 29, -5
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r28,r24
	movw r16,r22
	.loc 1 161 0
	call EnterAtomic
.LVL1:
	.loc 1 162 0
	std Y+4,r17
	std Y+3,r16
	.loc 1 163 0
	call LeaveAtomic
.LVL2:
/* epilogue start */
	.loc 1 164 0
	pop r29
	pop r28
.LVL3:
	pop r17
	pop r16
.LVL4:
	ret
	.cfi_endproc
.LFE5:
	.size	SetState, .-SetState
	.section	.text.RegisterFsm,"ax",@progbits
.global	RegisterFsm
	.type	RegisterFsm, @function
RegisterFsm:
.LFB6:
	.loc 1 176 0
	.cfi_startproc
.LVL5:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 179 0
	lds r30,_anchor
	lds r31,_anchor+1
.LVL6:
	.loc 1 180 0
	ldi r18,hi8(_anchor)
	cpi r30,lo8(_anchor)
	cpc r31,r18
	brne .L7
	rjmp .L6
.LVL7:
.L8:
	.loc 1 183 0
	movw r30,r18
.LVL8:
.L7:
	ld r18,Z
	ldd r19,Z+1
.LVL9:
	.loc 1 180 0
	ldi r20,hi8(_anchor)
	cpi r18,lo8(_anchor)
	cpc r19,r20
	brne .L8
.LVL10:
.L6:
	.loc 1 185 0
	std Z+1,r25
	st Z,r24
	.loc 1 186 0
	ldi r18,lo8(_anchor)
	ldi r19,hi8(_anchor)
	movw r30,r24
	std Z+1,r19
	st Z,r18
	ret
	.cfi_endproc
.LFE6:
	.size	RegisterFsm, .-RegisterFsm
	.section	.text.SendMessage,"ax",@progbits
.global	SendMessage
	.type	SendMessage, @function
SendMessage:
.LFB8:
	.loc 1 216 0
	.cfi_startproc
.LVL11:
	push r11
.LCFI4:
	.cfi_def_cfa_offset 3
	.cfi_offset 11, -2
	push r12
.LCFI5:
	.cfi_def_cfa_offset 4
	.cfi_offset 12, -3
	push r13
.LCFI6:
	.cfi_def_cfa_offset 5
	.cfi_offset 13, -4
	push r14
.LCFI7:
	.cfi_def_cfa_offset 6
	.cfi_offset 14, -5
	push r15
.LCFI8:
	.cfi_def_cfa_offset 7
	.cfi_offset 15, -6
	push r16
.LCFI9:
	.cfi_def_cfa_offset 8
	.cfi_offset 16, -7
	push r17
.LCFI10:
	.cfi_def_cfa_offset 9
	.cfi_offset 17, -8
	push r28
.LCFI11:
	.cfi_def_cfa_offset 10
	.cfi_offset 28, -9
	push r29
.LCFI12:
	.cfi_def_cfa_offset 11
	.cfi_offset 29, -10
/* prologue: function */
/* frame size = 0 */
/* stack size = 9 */
.L__stack_usage = 9
	.loc 1 217 0
	mov r28,r24
	ldi r29,0
	movw r30,r28
	subi r30,lo8(-(_capacity))
	sbci r31,hi8(-(_capacity))
	ld r16,Z
	ldi r17,0
	movw r30,r28
	subi r30,lo8(-(_nrOfEntries))
	sbci r31,hi8(-(_nrOfEntries))
	ld r15,Z
	mov r30,r15
	mov __tmp_reg__,r15
	lsl r0
	sbc r31,r31
	cp r30,r16
	cpc r31,r17
	brge .L9
	mov r13,r18
	mov r12,r20
	mov r11,r22
.LBB2:
	.loc 1 219 0
	call EnterAtomic
.LVL12:
	.loc 1 220 0
	movw r18,r28
	subi r18,lo8(-(_qIn))
	sbci r19,hi8(-(_qIn))
	movw r26,r18
	ld r30,X
.LVL13:
	.loc 1 221 0
	ldi r31,0
	movw r24,r30
	adiw r24,1
	movw r22,r16
	call __divmodhi4
	movw r26,r18
	st X,r24
.LVL14:
	.loc 1 222 0
	movw r26,r28
	lsl r26
	rol r27
	subi r26,lo8(-(_prioQueue))
	sbci r27,hi8(-(_prioQueue))
.LVL15:
	.loc 1 223 0
	lsl r30
	rol r31
	lsl r30
	rol r31
.LVL16:
	ld r24,X+
	ld r25,X
	add r30,r24
	adc r31,r25
	std Z+1,r11
	.loc 1 224 0
	st Z,r28
	.loc 1 225 0
	std Z+2,r12
	.loc 1 226 0
	std Z+3,r13
	.loc 1 227 0
	subi r28,lo8(-(_nrOfEntries))
	sbci r29,hi8(-(_nrOfEntries))
.LVL17:
	inc r15
	st Y,r15
.LVL18:
	.loc 1 229 0
	call LeaveAtomic
.LVL19:
.L9:
/* epilogue start */
.LBE2:
	.loc 1 231 0
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	ret
	.cfi_endproc
.LFE8:
	.size	SendMessage, .-SendMessage
	.section	.text.ProcessMessage,"ax",@progbits
.global	ProcessMessage
	.type	ProcessMessage, @function
ProcessMessage:
.LFB2:
	.loc 1 131 0
	.cfi_startproc
.LVL20:
	push r28
.LCFI13:
	.cfi_def_cfa_offset 3
	.cfi_offset 28, -2
	push r29
.LCFI14:
	.cfi_def_cfa_offset 4
	.cfi_offset 29, -3
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	.loc 1 132 0
	lds r25,_avrPoolOut
	lds r18,_avrPoolIn
	cp r25,r18
	breq .L11
	mov r28,r24
.LBB3:
	.loc 1 134 0
	mov r30,r25
	ldi r31,0
	subi r30,lo8(-(_avrMsgIndex))
	sbci r31,hi8(-(_avrMsgIndex))
	ld r29,Z
.LVL21:
	.loc 1 135 0
	subi r25,lo8(-(1))
	andi r25,lo8(7)
	sts _avrPoolOut,r25
	.loc 1 136 0
	mov r18,r29
	ldi r19,0
	movw r24,r18
.LVL22:
	lsl r24
	rol r25
	lsl r18
	rol r19
	lsl r18
	rol r19
	lsl r18
	rol r19
	add r24,r18
	adc r25,r19
	movw r30,r24
	subi r30,lo8(-(_avrMessagePool))
	sbci r31,hi8(-(_avrMessagePool))
	st Z,r28
	.loc 1 137 0
	std Z+1,r20
	.loc 1 138 0
	ldi r21,0
	subi r24,lo8(-(_avrMessagePool+2))
	sbci r25,hi8(-(_avrMessagePool+2))
	call memcpy
.LVL23:
	.loc 1 139 0
	mov r22,r28
	ori r22,lo8(-128)
	ldi r18,0
	mov r20,r29
	ldi r24,lo8(3)
	call SendMessage
.LVL24:
.L11:
/* epilogue start */
.LBE3:
	.loc 1 141 0
	pop r29
	pop r28
	ret
	.cfi_endproc
.LFE2:
	.size	ProcessMessage, .-ProcessMessage
	.section	.text.HandleMessage,"ax",@progbits
.global	HandleMessage
	.type	HandleMessage, @function
HandleMessage:
.LFB1:
	.loc 1 100 0
	.cfi_startproc
.LVL25:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 107 0
	lds r25,msgType.1855
	cpse r25,__zero_reg__
	rjmp .L14
	.loc 1 109 0
	sts msgType.1855,r24
	.loc 1 110 0
	sts msgLen.1856,__zero_reg__
	ret
.L14:
	.loc 1 112 0
	lds r20,msgLen.1856
	cpse r20,__zero_reg__
	rjmp .L16
	.loc 1 114 0
	subi r24,lo8(-(-2))
.LVL26:
	sts msgLen.1856,r24
	.loc 1 116 0
	sts bufferIndex.1854,__zero_reg__
	ret
.LVL27:
.L16:
	.loc 1 118 0
	lds r30,bufferIndex.1854
	cp r30,r20
	brsh .L13
	.loc 1 120 0
	ldi r18,lo8(1)
	add r18,r30
	sts bufferIndex.1854,r18
	ldi r31,0
	subi r30,lo8(-(msgBuffer.1853))
	sbci r31,hi8(-(msgBuffer.1853))
	st Z,r24
	.loc 1 121 0
	cpse r20,r18
	rjmp .L13
	.loc 1 123 0
	ldi r22,lo8(msgBuffer.1853)
	ldi r23,hi8(msgBuffer.1853)
	mov r24,r25
.LVL28:
	call ProcessMessage
.LVL29:
	.loc 1 124 0
	sts msgType.1855,__zero_reg__
	.loc 1 125 0
	sts bufferIndex.1854,__zero_reg__
.L13:
	ret
	.cfi_endproc
.LFE1:
	.size	HandleMessage, .-HandleMessage
	.section	.text.GetMessage,"ax",@progbits
.global	GetMessage
	.type	GetMessage, @function
GetMessage:
.LFB9:
	.loc 1 235 0
	.cfi_startproc
.LVL30:
	push r16
.LCFI15:
	.cfi_def_cfa_offset 3
	.cfi_offset 16, -2
	push r17
.LCFI16:
	.cfi_def_cfa_offset 4
	.cfi_offset 17, -3
	push r28
.LCFI17:
	.cfi_def_cfa_offset 5
	.cfi_offset 28, -4
	push r29
.LCFI18:
	.cfi_def_cfa_offset 6
	.cfi_offset 29, -5
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r18,r24
.LVL31:
	.loc 1 239 0
	lds r25,_nrOfEntries
	cp __zero_reg__,r25
	brlt .L21
.LVL32:
	lds r25,_nrOfEntries+1
	cp __zero_reg__,r25
	brlt .L22
.LVL33:
	lds r25,_nrOfEntries+2
	cp __zero_reg__,r25
	brlt .L23
.LVL34:
	lds r25,_nrOfEntries+3
	cp __zero_reg__,r25
	brge .L24
	ldi r16,lo8(3)
	ldi r17,0
	rjmp .L18
.LVL35:
.L22:
	ldi r16,lo8(1)
	ldi r17,0
	rjmp .L18
.LVL36:
.L23:
	ldi r16,lo8(2)
	ldi r17,0
	rjmp .L18
.LVL37:
.L21:
	ldi r16,0
	ldi r17,0
.LVL38:
.L18:
	movw r28,r18
.LBB4:
	.loc 1 241 0
	call EnterAtomic
.LVL39:
	.loc 1 243 0
	movw r18,r16
	subi r18,lo8(-(_qOut))
	sbci r19,hi8(-(_qOut))
	movw r30,r18
	ld r20,Z
.LVL40:
	.loc 1 242 0
	movw r30,r16
	lsl r30
	rol r31
	subi r30,lo8(-(_prioQueue))
	sbci r31,hi8(-(_prioQueue))
.LVL41:
	.loc 1 244 0
	mov r24,r20
	ldi r25,0
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
.LVL42:
	ldi r21,lo8(4)
	mul r20,r21
	add r30,r0
	adc r31,r1
	clr __zero_reg__
.LVL43:
	ld r20,Z
	ldd r21,Z+1
	ldd r22,Z+2
	ldd r23,Z+3
.LVL44:
	st Y,r20
	std Y+1,r21
	std Y+2,r22
	std Y+3,r23
	.loc 1 245 0
	movw r30,r16
	subi r30,lo8(-(_nrOfEntries))
	sbci r31,hi8(-(_nrOfEntries))
	ld r20,Z
	subi r20,lo8(-(-1))
	st Z,r20
	.loc 1 246 0
	adiw r24,1
.LVL45:
	movw r30,r16
	subi r30,lo8(-(_capacity))
	sbci r31,hi8(-(_capacity))
	ld r22,Z
	ldi r23,0
	call __divmodhi4
	movw r30,r18
	st Z,r24
	.loc 1 247 0
	call LeaveAtomic
.LVL46:
	.loc 1 248 0
	ldi r24,lo8(1)
	rjmp .L20
.LVL47:
.L24:
.LBE4:
	.loc 1 251 0
	ldi r24,0
.LVL48:
.L20:
/* epilogue start */
	.loc 1 252 0
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.cfi_endproc
.LFE9:
	.size	GetMessage, .-GetMessage
	.section	.text.DispatchEvent,"ax",@progbits
.global	DispatchEvent
	.type	DispatchEvent, @function
DispatchEvent:
.LFB7:
	.loc 1 190 0
	.cfi_startproc
	push r15
.LCFI19:
	.cfi_def_cfa_offset 3
	.cfi_offset 15, -2
	push r16
.LCFI20:
	.cfi_def_cfa_offset 4
	.cfi_offset 16, -3
	push r17
.LCFI21:
	.cfi_def_cfa_offset 5
	.cfi_offset 17, -4
	push r28
.LCFI22:
	.cfi_def_cfa_offset 6
	.cfi_offset 28, -5
	push r29
.LCFI23:
	.cfi_def_cfa_offset 7
	.cfi_offset 29, -6
	rcall .
	rcall .
.LCFI24:
	.cfi_def_cfa_offset 11
	in r28,__SP_L__
	in r29,__SP_H__
.LCFI25:
	.cfi_def_cfa_register 28
/* prologue: function */
/* frame size = 4 */
/* stack size = 9 */
.L__stack_usage = 9
	.loc 1 192 0
	movw r24,r28
	adiw r24,1
	call GetMessage
.LVL49:
	tst r24
	breq .L26
.LBB5:
	.loc 1 194 0
	lds r16,_anchor
	lds r17,_anchor+1
.LVL50:
	.loc 1 195 0
	ldi r24,lo8(1)
	ldi r25,0
	ldd r0,Y+1
	rjmp 2f
	1:
	lsl r24
	rol r25
	2:
	dec r0
	brpl 1b
	mov r15,r24
.LVL51:
	.loc 1 196 0
	ldi r24,hi8(_anchor)
	cpi r16,lo8(_anchor)
	cpc r17,r24
	breq .L27
.L31:
	.loc 1 198 0
	movw r26,r16
	adiw r26,2
	ld r24,X
	sbiw r26,2
	and r24,r15
	breq .L28
	.loc 1 200 0
	adiw r26,3
	ld r30,X+
	ld r31,X
	sbiw r26,3+1
	movw r24,r28
	adiw r24,1
	icall
.LVL52:
.L28:
	.loc 1 202 0
	movw r30,r16
	ld r16,Z
	ldd r17,Z+1
.LVL53:
	.loc 1 196 0
	ldi r31,hi8(_anchor)
	cpi r16,lo8(_anchor)
	cpc r17,r31
	brne .L31
.L27:
	.loc 1 204 0
	ldd r24,Y+2
	tst r24
	brge .L30
	.loc 1 206 0
	lds r24,_avrPoolIn
	mov r30,r24
	ldi r31,0
	subi r30,lo8(-(_avrMsgIndex))
	sbci r31,hi8(-(_avrMsgIndex))
	ldd r25,Y+3
	st Z,r25
	.loc 1 207 0
	subi r24,lo8(-(1))
	andi r24,lo8(7)
	sts _avrPoolIn,r24
	.loc 1 209 0
	ldi r24,lo8(1)
	rjmp .L26
.L30:
	ldi r24,lo8(1)
.LVL54:
.L26:
/* epilogue start */
.LBE5:
	.loc 1 212 0
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	ret
	.cfi_endproc
.LFE7:
	.size	DispatchEvent, .-DispatchEvent
	.section	.text.Usart_Init,"ax",@progbits
.global	Usart_Init
	.type	Usart_Init, @function
Usart_Init:
.LFB10:
	.loc 1 257 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 259 0
	out 0x20,__zero_reg__
	.loc 1 261 0
	ldi r24,lo8(5)
	out 0x9,r24
	.loc 1 262 0
	ldi r24,lo8(-122)
	out 0x20,r24
	.loc 1 263 0
	ldi r24,lo8(-104)
	out 0xa,r24
	.loc 1 264 0
/* #APP */
 ;  264 "C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\Build\AvrLib.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ret
	.cfi_endproc
.LFE10:
	.size	Usart_Init, .-Usart_Init
	.section	.text.AllowUartRx,"ax",@progbits
.global	AllowUartRx
	.type	AllowUartRx, @function
AllowUartRx:
.LFB11:
	.loc 1 268 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 269 0
	sbi 0xa,7
	ret
	.cfi_endproc
.LFE11:
	.size	AllowUartRx, .-AllowUartRx
	.section	.text.DisallowUartRx,"ax",@progbits
.global	DisallowUartRx
	.type	DisallowUartRx, @function
DisallowUartRx:
.LFB12:
	.loc 1 273 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 274 0
	cbi 0xa,7
	ret
	.cfi_endproc
.LFE12:
	.size	DisallowUartRx, .-DisallowUartRx
	.section	.text.Usart_PutChar,"ax",@progbits
.global	Usart_PutChar
	.type	Usart_PutChar, @function
Usart_PutChar:
.LFB19:
	.loc 1 323 0
	.cfi_startproc
.LVL55:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 324 0
	out 0xc,r24
.L37:
	.loc 1 325 0 discriminator 1
	sbis 0xb,5
	rjmp .L37
/* epilogue start */
	.loc 1 326 0
	ret
	.cfi_endproc
.LFE19:
	.size	Usart_PutChar, .-Usart_PutChar
	.section	.text.InitializeStateEventFramework,"ax",@progbits
.global	InitializeStateEventFramework
	.type	InitializeStateEventFramework, @function
InitializeStateEventFramework:
.LFB0:
	.loc 1 79 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 81 0
	ldi r24,lo8(-54)
	call Usart_PutChar
.LVL56:
	.loc 1 82 0
	ldi r24,lo8(-2)
	call Usart_PutChar
.LVL57:
.L42:
	.loc 1 86 0
	call DispatchEvent
.LVL58:
	.loc 1 88 0
	lds r25,USART_rxBufferOut
	lds r24,USART_rxBufferIn
	cp r25,r24
	breq .L42
.L43:
.LBB6:
	.loc 1 90 0
	call EnterAtomic
.LVL59:
	.loc 1 91 0
	lds r30,USART_rxBufferOut
	ldi r24,lo8(1)
	add r24,r30
	sts USART_rxBufferOut,r24
	ldi r31,0
	subi r30,lo8(-(USART_rxBuffer))
	sbci r31,hi8(-(USART_rxBuffer))
	ld r28,Z
.LVL60:
	.loc 1 92 0
	lds r24,USART_rxBufferOut
	andi r24,lo8(31)
	sts USART_rxBufferOut,r24
	.loc 1 93 0
	call LeaveAtomic
.LVL61:
	.loc 1 94 0
	mov r24,r28
	call HandleMessage
.LVL62:
.LBE6:
	.loc 1 88 0
	lds r25,USART_rxBufferOut
	lds r24,USART_rxBufferIn
	cpse r25,r24
	rjmp .L43
	rjmp .L42
	.cfi_endproc
.LFE0:
	.size	InitializeStateEventFramework, .-InitializeStateEventFramework
	.section	.text.Usart_PutShort,"ax",@progbits
.global	Usart_PutShort
	.type	Usart_PutShort, @function
Usart_PutShort:
.LFB20:
	.loc 1 329 0
	.cfi_startproc
.LVL63:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 330 0
	out 0xc,r25
.L46:
	.loc 1 331 0 discriminator 1
	sbis 0xb,5
	rjmp .L46
	.loc 1 332 0
	out 0xc,r24
.L47:
	.loc 1 333 0 discriminator 1
	sbis 0xb,5
	rjmp .L47
/* epilogue start */
	.loc 1 334 0
	ret
	.cfi_endproc
.LFE20:
	.size	Usart_PutShort, .-Usart_PutShort
	.section	.text.Usart_TraceN,"ax",@progbits
.global	Usart_TraceN
	.type	Usart_TraceN, @function
Usart_TraceN:
.LFB13:
	.loc 1 281 0
	.cfi_startproc
.LVL64:
	push r14
.LCFI26:
	.cfi_def_cfa_offset 3
	.cfi_offset 14, -2
	push r15
.LCFI27:
	.cfi_def_cfa_offset 4
	.cfi_offset 15, -3
	push r16
.LCFI28:
	.cfi_def_cfa_offset 5
	.cfi_offset 16, -4
	push r17
.LCFI29:
	.cfi_def_cfa_offset 6
	.cfi_offset 17, -5
	push r28
.LCFI30:
	.cfi_def_cfa_offset 7
	.cfi_offset 28, -6
	push r29
.LCFI31:
	.cfi_def_cfa_offset 8
	.cfi_offset 29, -7
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r28,r24
	mov r14,r22
	mov r15,r23
	mov r17,r20
	.loc 1 282 0
	call EnterAtomic
.LVL65:
	.loc 1 283 0
	ldi r24,lo8(-91)
	call Usart_PutChar
.LVL66:
	.loc 1 284 0
	mov r24,r17
	ori r24,lo8(-88)
	call Usart_PutChar
.LVL67:
	.loc 1 285 0
	movw r24,r28
	call Usart_PutShort
.LVL68:
	.loc 1 286 0
	ldi r28,lo8(-1)
.LVL69:
	add r28,r17
.LVL70:
	cp __zero_reg__,r17
	brge .L51
	mov r16,r14
	mov r17,r15
.LVL71:
.L52:
	.loc 1 288 0
	movw r30,r16
	ld r24,Z+
.LVL72:
	movw r16,r30
	call Usart_PutChar
.LVL73:
.LVL74:
	subi r28,1
	brcc .L52
.L51:
	.loc 1 290 0
	call LeaveAtomic
.LVL75:
/* epilogue start */
	.loc 1 291 0
	pop r29
	pop r28
.LVL76:
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.cfi_endproc
.LFE13:
	.size	Usart_TraceN, .-Usart_TraceN
	.section	.text.Usart_Trace0,"ax",@progbits
.global	Usart_Trace0
	.type	Usart_Trace0, @function
Usart_Trace0:
.LFB14:
	.loc 1 294 0
	.cfi_startproc
.LVL77:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 295 0
	ldi r20,0
	ldi r22,0
	ldi r23,0
	call Usart_TraceN
.LVL78:
	ret
	.cfi_endproc
.LFE14:
	.size	Usart_Trace0, .-Usart_Trace0
	.section	.text.Usart_Trace1,"ax",@progbits
.global	Usart_Trace1
	.type	Usart_Trace1, @function
Usart_Trace1:
.LFB15:
	.loc 1 300 0
	.cfi_startproc
.LVL79:
	push r28
.LCFI32:
	.cfi_def_cfa_offset 3
	.cfi_offset 28, -2
	push r29
.LCFI33:
	.cfi_def_cfa_offset 4
	.cfi_offset 29, -3
	push __zero_reg__
.LCFI34:
	.cfi_def_cfa_offset 5
	in r28,__SP_L__
	in r29,__SP_H__
.LCFI35:
	.cfi_def_cfa_register 28
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	std Y+1,r22
	.loc 1 301 0
	ldi r20,lo8(1)
	movw r22,r28
.LVL80:
	subi r22,-1
	sbci r23,-1
	call Usart_TraceN
.LVL81:
/* epilogue start */
	.loc 1 302 0
	pop __tmp_reg__
	pop r29
	pop r28
.LVL82:
	ret
	.cfi_endproc
.LFE15:
	.size	Usart_Trace1, .-Usart_Trace1
	.section	.text.Usart_Trace2,"ax",@progbits
.global	Usart_Trace2
	.type	Usart_Trace2, @function
Usart_Trace2:
.LFB16:
	.loc 1 305 0
	.cfi_startproc
.LVL83:
	push r28
.LCFI36:
	.cfi_def_cfa_offset 3
	.cfi_offset 28, -2
	push r29
.LCFI37:
	.cfi_def_cfa_offset 4
	.cfi_offset 29, -3
	rcall .
.LCFI38:
	.cfi_def_cfa_offset 6
	in r28,__SP_L__
	in r29,__SP_H__
.LCFI39:
	.cfi_def_cfa_register 28
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	.loc 1 306 0
	std Y+1,r22
	std Y+2,r20
	.loc 1 307 0
	ldi r20,lo8(2)
.LVL84:
	movw r22,r28
.LVL85:
	subi r22,-1
	sbci r23,-1
	call Usart_TraceN
.LVL86:
/* epilogue start */
	.loc 1 308 0
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.cfi_endproc
.LFE16:
	.size	Usart_Trace2, .-Usart_Trace2
	.section	.text.Usart_Trace3,"ax",@progbits
.global	Usart_Trace3
	.type	Usart_Trace3, @function
Usart_Trace3:
.LFB17:
	.loc 1 311 0
	.cfi_startproc
.LVL87:
	push r28
.LCFI40:
	.cfi_def_cfa_offset 3
	.cfi_offset 28, -2
	push r29
.LCFI41:
	.cfi_def_cfa_offset 4
	.cfi_offset 29, -3
	rcall .
	push __zero_reg__
.LCFI42:
	.cfi_def_cfa_offset 7
	in r28,__SP_L__
	in r29,__SP_H__
.LCFI43:
	.cfi_def_cfa_register 28
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	.loc 1 312 0
	std Y+1,r22
	std Y+2,r20
	std Y+3,r18
	.loc 1 313 0
	ldi r20,lo8(3)
.LVL88:
	movw r22,r28
.LVL89:
	subi r22,-1
	sbci r23,-1
	call Usart_TraceN
.LVL90:
/* epilogue start */
	.loc 1 314 0
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.cfi_endproc
.LFE17:
	.size	Usart_Trace3, .-Usart_Trace3
	.section	.text.Usart_Trace4,"ax",@progbits
.global	Usart_Trace4
	.type	Usart_Trace4, @function
Usart_Trace4:
.LFB18:
	.loc 1 317 0
	.cfi_startproc
.LVL91:
	push r16
.LCFI44:
	.cfi_def_cfa_offset 3
	.cfi_offset 16, -2
	push r28
.LCFI45:
	.cfi_def_cfa_offset 4
	.cfi_offset 28, -3
	push r29
.LCFI46:
	.cfi_def_cfa_offset 5
	.cfi_offset 29, -4
	rcall .
	rcall .
.LCFI47:
	.cfi_def_cfa_offset 9
	in r28,__SP_L__
	in r29,__SP_H__
.LCFI48:
	.cfi_def_cfa_register 28
/* prologue: function */
/* frame size = 4 */
/* stack size = 7 */
.L__stack_usage = 7
	.loc 1 318 0
	std Y+1,r22
	std Y+2,r20
	std Y+3,r18
	std Y+4,r16
	.loc 1 319 0
	ldi r20,lo8(4)
.LVL92:
	movw r22,r28
.LVL93:
	subi r22,-1
	sbci r23,-1
	call Usart_TraceN
.LVL94:
/* epilogue start */
	.loc 1 320 0
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r16
.LVL95:
	ret
	.cfi_endproc
.LFE18:
	.size	Usart_Trace4, .-Usart_Trace4
	.section	.text.__vector_13,"ax",@progbits
.global	__vector_13
	.type	__vector_13, @function
__vector_13:
.LFB21:
	.loc 1 338 0
	.cfi_startproc
	push r1
.LCFI49:
	.cfi_def_cfa_offset 3
	.cfi_offset 1, -2
	push r0
.LCFI50:
	.cfi_def_cfa_offset 4
	.cfi_offset 0, -3
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
.LCFI51:
	.cfi_def_cfa_offset 5
	.cfi_offset 18, -4
	push r24
.LCFI52:
	.cfi_def_cfa_offset 6
	.cfi_offset 24, -5
	push r25
.LCFI53:
	.cfi_def_cfa_offset 7
	.cfi_offset 25, -6
	push r30
.LCFI54:
	.cfi_def_cfa_offset 8
	.cfi_offset 30, -7
	push r31
.LCFI55:
	.cfi_def_cfa_offset 9
	.cfi_offset 31, -8
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 8 */
.L__stack_usage = 8
	.loc 1 340 0
	rjmp .L62
.L63:
.LBB7:
	.loc 1 342 0
	in r18,0xc
.LVL96:
	.loc 1 343 0
	lds r24,USART_rxBufferIn
	ldi r25,0
	adiw r24,1
	andi r24,31
	andi r25,128
	tst r25
	brge .L61
	sbiw r24,1
	ori r24,224
	ori r25,255
	adiw r24,1
.L61:
.LVL97:
	.loc 1 344 0
	lds r25,USART_rxBufferOut
	cp r24,r25
	breq .L62
	.loc 1 346 0
	lds r30,USART_rxBufferIn
	ldi r31,0
	subi r30,lo8(-(USART_rxBuffer))
	sbci r31,hi8(-(USART_rxBuffer))
	st Z,r18
	.loc 1 347 0
	sts USART_rxBufferIn,r24
.LVL98:
.L62:
.LBE7:
	.loc 1 340 0
	sbic 0xb,7
	rjmp .L63
/* epilogue start */
	.loc 1 350 0
	pop r31
	pop r30
	pop r25
	pop r24
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.cfi_endproc
.LFE21:
	.size	__vector_13, .-__vector_13
	.section	.bss.msgBuffer.1853,"aw",@nobits
	.type	msgBuffer.1853, @object
	.size	msgBuffer.1853, 14
msgBuffer.1853:
	.zero	14
	.section	.bss.bufferIndex.1854,"aw",@nobits
	.type	bufferIndex.1854, @object
	.size	bufferIndex.1854, 1
bufferIndex.1854:
	.zero	1
	.section	.bss.msgLen.1856,"aw",@nobits
	.type	msgLen.1856, @object
	.size	msgLen.1856, 1
msgLen.1856:
	.zero	1
	.section	.bss.msgType.1855,"aw",@nobits
	.type	msgType.1855, @object
	.size	msgType.1855, 1
msgType.1855:
	.zero	1
	.section	.rodata._capacity,"a",@progbits
	.type	_capacity, @object
	.size	_capacity, 4
_capacity:
	.byte	4
	.byte	8
	.byte	8
	.byte	16
	.section	.bss._nrOfEntries,"aw",@nobits
	.type	_nrOfEntries, @object
	.size	_nrOfEntries, 4
_nrOfEntries:
	.zero	4
	.section	.bss._qOut,"aw",@nobits
	.type	_qOut, @object
	.size	_qOut, 4
_qOut:
	.zero	4
	.section	.bss._qIn,"aw",@nobits
	.type	_qIn, @object
	.size	_qIn, 4
_qIn:
	.zero	4
	.section	.rodata._prioQueue,"a",@progbits
	.type	_prioQueue, @object
	.size	_prioQueue, 8
_prioQueue:
	.word	_highPrioQueue
	.word	_midPrioQueue
	.word	_lowPrioQueue
	.word	_veryLowPrioQueue
	.section	.bss._veryLowPrioQueue,"aw",@nobits
	.type	_veryLowPrioQueue, @object
	.size	_veryLowPrioQueue, 64
_veryLowPrioQueue:
	.zero	64
	.section	.bss._lowPrioQueue,"aw",@nobits
	.type	_lowPrioQueue, @object
	.size	_lowPrioQueue, 32
_lowPrioQueue:
	.zero	32
	.section	.bss._midPrioQueue,"aw",@nobits
	.type	_midPrioQueue, @object
	.size	_midPrioQueue, 32
_midPrioQueue:
	.zero	32
	.section	.bss._highPrioQueue,"aw",@nobits
	.type	_highPrioQueue, @object
	.size	_highPrioQueue, 16
_highPrioQueue:
	.zero	16
	.section	.data._anchor,"aw",@progbits
	.type	_anchor, @object
	.size	_anchor, 5
_anchor:
	.word	_anchor
	.byte	0
	.word	0
	.section	.data._avrPoolOut,"aw",@progbits
	.type	_avrPoolOut, @object
	.size	_avrPoolOut, 1
_avrPoolOut:
	.byte	7
	.section	.data._avrPoolIn,"aw",@progbits
	.type	_avrPoolIn, @object
	.size	_avrPoolIn, 1
_avrPoolIn:
	.byte	7
	.section	.data._avrMsgIndex,"aw",@progbits
	.type	_avrMsgIndex, @object
	.size	_avrMsgIndex, 8
_avrMsgIndex:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.section	.bss._avrMessagePool,"aw",@nobits
	.type	_avrMessagePool, @object
	.size	_avrMessagePool, 80
_avrMessagePool:
	.zero	80
	.section	.bss.USART_rxBufferOut,"aw",@nobits
	.type	USART_rxBufferOut, @object
	.size	USART_rxBufferOut, 1
USART_rxBufferOut:
	.zero	1
	.section	.bss.USART_rxBufferIn,"aw",@nobits
	.type	USART_rxBufferIn, @object
	.size	USART_rxBufferIn, 1
USART_rxBufferIn:
	.zero	1
	.comm	USART_rxBuffer,32,1
	.section	.bss._enterAtomicNesting,"aw",@nobits
	.type	_enterAtomicNesting, @object
	.size	_enterAtomicNesting, 1
_enterAtomicNesting:
	.zero	1
	.text
.Letext0:
	.file 2 "c:\\users\\rolfl\\documents\\github\\avr\\toolchain\\avr8-gnu-toolchain-win32_x86\\avr\\include\\stdint.h"
	.file 3 "C:\\Users\\rolfl\\Documents\\GitHub\\Avr\\ToolChain\\AvrLib\\include/AvrLib.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xc44
	.word	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF98
	.byte	0xc
	.long	.LASF99
	.long	.Ldebug_ranges0+0
	.long	0
	.long	0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.long	.LASF2
	.byte	0x2
	.byte	0x7d
	.long	0x37
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF1
	.uleb128 0x3
	.long	.LASF3
	.byte	0x2
	.byte	0x7e
	.long	0x49
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x4
	.byte	0x2
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.long	.LASF5
	.byte	0x2
	.byte	0x80
	.long	0x25
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.long	.LASF6
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF7
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF9
	.uleb128 0x5
	.byte	0x1
	.long	0x49
	.byte	0x3
	.byte	0x1a
	.long	0x97
	.uleb128 0x6
	.long	.LASF10
	.byte	0
	.uleb128 0x6
	.long	.LASF11
	.byte	0x1
	.byte	0
	.uleb128 0x3
	.long	.LASF12
	.byte	0x3
	.byte	0x1d
	.long	0x7e
	.uleb128 0x5
	.byte	0x1
	.long	0x49
	.byte	0x3
	.byte	0x20
	.long	0xc7
	.uleb128 0x6
	.long	.LASF13
	.byte	0
	.uleb128 0x6
	.long	.LASF14
	.byte	0x1
	.uleb128 0x6
	.long	.LASF15
	.byte	0x2
	.uleb128 0x6
	.long	.LASF16
	.byte	0x3
	.byte	0
	.uleb128 0x5
	.byte	0x1
	.long	0x49
	.byte	0x3
	.byte	0x29
	.long	0xf2
	.uleb128 0x6
	.long	.LASF17
	.byte	0
	.uleb128 0x6
	.long	.LASF18
	.byte	0x2
	.uleb128 0x6
	.long	.LASF19
	.byte	0x3
	.uleb128 0x6
	.long	.LASF20
	.byte	0xa8
	.uleb128 0x6
	.long	.LASF21
	.byte	0xa5
	.byte	0
	.uleb128 0x3
	.long	.LASF22
	.byte	0x3
	.byte	0x2f
	.long	0xc7
	.uleb128 0x7
	.long	.LASF30
	.byte	0xa
	.byte	0x3
	.byte	0x32
	.long	0x134
	.uleb128 0x8
	.long	.LASF23
	.byte	0x3
	.byte	0x34
	.long	0xf2
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x8
	.long	.LASF24
	.byte	0x3
	.byte	0x35
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0x8
	.long	.LASF25
	.byte	0x3
	.byte	0x36
	.long	0x134
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0
	.uleb128 0x9
	.long	0x3e
	.long	0x144
	.uleb128 0xa
	.long	0x144
	.byte	0x7
	.byte	0
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF26
	.uleb128 0x3
	.long	.LASF27
	.byte	0x3
	.byte	0x37
	.long	0xfd
	.uleb128 0xb
	.byte	0x2
	.byte	0x3
	.byte	0x45
	.long	0x17b
	.uleb128 0x8
	.long	.LASF28
	.byte	0x3
	.byte	0x47
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x8
	.long	.LASF29
	.byte	0x3
	.byte	0x48
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.byte	0
	.uleb128 0xc
	.byte	0x2
	.byte	0x3
	.byte	0x43
	.long	0x194
	.uleb128 0xd
	.long	0x156
	.uleb128 0xe
	.string	"Ptr"
	.byte	0x3
	.byte	0x4a
	.long	0x194
	.byte	0
	.uleb128 0xf
	.byte	0x2
	.uleb128 0x7
	.long	.LASF31
	.byte	0x4
	.byte	0x3
	.byte	0x3f
	.long	0x1c6
	.uleb128 0x8
	.long	.LASF32
	.byte	0x3
	.byte	0x41
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x10
	.string	"Id"
	.byte	0x3
	.byte	0x42
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0x11
	.long	0x17b
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0
	.uleb128 0x3
	.long	.LASF33
	.byte	0x3
	.byte	0x4d
	.long	0x196
	.uleb128 0x3
	.long	.LASF34
	.byte	0x3
	.byte	0x53
	.long	0x1dc
	.uleb128 0x12
	.byte	0x2
	.long	0x1e2
	.uleb128 0x13
	.byte	0x1
	.long	0x1ee
	.uleb128 0x14
	.long	0x1ee
	.byte	0
	.uleb128 0x12
	.byte	0x2
	.long	0x1f4
	.uleb128 0x15
	.long	0x1c6
	.uleb128 0x7
	.long	.LASF35
	.byte	0x5
	.byte	0x3
	.byte	0x5f
	.long	0x230
	.uleb128 0x8
	.long	.LASF36
	.byte	0x3
	.byte	0x61
	.long	0x230
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x8
	.long	.LASF37
	.byte	0x3
	.byte	0x62
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x8
	.long	.LASF38
	.byte	0x3
	.byte	0x63
	.long	0x1d1
	.byte	0x2
	.byte	0x23
	.uleb128 0x3
	.byte	0
	.uleb128 0x12
	.byte	0x2
	.long	0x1f9
	.uleb128 0x16
	.string	"Fsm"
	.byte	0x3
	.byte	0x64
	.long	0x1f9
	.uleb128 0x17
	.byte	0x1
	.long	.LASF39
	.byte	0x1
	.byte	0x90
	.byte	0x1
	.long	.LFB3
	.long	.LFE3
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF40
	.byte	0x1
	.byte	0x96
	.byte	0x1
	.long	.LFB4
	.long	.LFE4
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.uleb128 0x18
	.byte	0x1
	.long	.LASF42
	.byte	0x1
	.byte	0x9f
	.byte	0x1
	.long	.LFB5
	.long	.LFE5
	.long	.LLST0
	.byte	0x1
	.long	0x2b8
	.uleb128 0x19
	.string	"fsm"
	.byte	0x1
	.byte	0x9f
	.long	0x2b8
	.long	.LLST1
	.uleb128 0x1a
	.long	.LASF41
	.byte	0x1
	.byte	0x9f
	.long	0x1d1
	.long	.LLST2
	.uleb128 0x1b
	.long	.LVL1
	.long	0x241
	.uleb128 0x1b
	.long	.LVL2
	.long	0x257
	.byte	0
	.uleb128 0x12
	.byte	0x2
	.long	0x236
	.uleb128 0x1c
	.byte	0x1
	.long	.LASF43
	.byte	0x1
	.byte	0xaf
	.byte	0x1
	.long	.LFB6
	.long	.LFE6
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x305
	.uleb128 0x1d
	.string	"fsm"
	.byte	0x1
	.byte	0xaf
	.long	0x2b8
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.uleb128 0x1e
	.string	"p"
	.byte	0x1
	.byte	0xb2
	.long	0x2b8
	.long	.LLST3
	.uleb128 0x1e
	.string	"q"
	.byte	0x1
	.byte	0xb3
	.long	0x2b8
	.long	.LLST4
	.byte	0
	.uleb128 0x18
	.byte	0x1
	.long	.LASF44
	.byte	0x1
	.byte	0xd7
	.byte	0x1
	.long	.LFB8
	.long	.LFE8
	.long	.LLST5
	.byte	0x1
	.long	0x393
	.uleb128 0x1a
	.long	.LASF45
	.byte	0x1
	.byte	0xd7
	.long	0x3e
	.long	.LLST6
	.uleb128 0x19
	.string	"id"
	.byte	0x1
	.byte	0xd7
	.long	0x3e
	.long	.LLST7
	.uleb128 0x1a
	.long	.LASF46
	.byte	0x1
	.byte	0xd7
	.long	0x3e
	.long	.LLST8
	.uleb128 0x1a
	.long	.LASF47
	.byte	0x1
	.byte	0xd7
	.long	0x3e
	.long	.LLST9
	.uleb128 0x1f
	.long	.LBB2
	.long	.LBE2
	.uleb128 0x20
	.long	.LASF48
	.byte	0x1
	.byte	0xdc
	.long	0x3e
	.long	.LLST10
	.uleb128 0x1e
	.string	"q"
	.byte	0x1
	.byte	0xde
	.long	0x393
	.long	.LLST11
	.uleb128 0x1b
	.long	.LVL12
	.long	0x241
	.uleb128 0x1b
	.long	.LVL19
	.long	0x257
	.byte	0
	.byte	0
	.uleb128 0x12
	.byte	0x2
	.long	0x1c6
	.uleb128 0x18
	.byte	0x1
	.long	.LASF49
	.byte	0x1
	.byte	0x82
	.byte	0x1
	.long	.LFB2
	.long	.LFE2
	.long	.LLST12
	.byte	0x1
	.long	0x437
	.uleb128 0x1a
	.long	.LASF50
	.byte	0x1
	.byte	0x82
	.long	0x3e
	.long	.LLST13
	.uleb128 0x19
	.string	"msg"
	.byte	0x1
	.byte	0x82
	.long	0x437
	.long	.LLST14
	.uleb128 0x1a
	.long	.LASF51
	.byte	0x1
	.byte	0x82
	.long	0x3e
	.long	.LLST15
	.uleb128 0x1f
	.long	.LBB3
	.long	.LBE3
	.uleb128 0x20
	.long	.LASF52
	.byte	0x1
	.byte	0x86
	.long	0x3e
	.long	.LLST16
	.uleb128 0x21
	.long	.LVL23
	.long	0xc3c
	.long	0x412
	.uleb128 0x22
	.byte	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.byte	0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0
	.uleb128 0x23
	.long	.LVL24
	.long	0x305
	.uleb128 0x22
	.byte	0x1
	.byte	0x68
	.byte	0x1
	.byte	0x33
	.uleb128 0x22
	.byte	0x1
	.byte	0x66
	.byte	0x5
	.byte	0x8c
	.sleb128 0
	.byte	0x9
	.byte	0x80
	.byte	0x21
	.uleb128 0x22
	.byte	0x1
	.byte	0x64
	.byte	0x2
	.byte	0x8d
	.sleb128 0
	.uleb128 0x22
	.byte	0x1
	.byte	0x62
	.byte	0x1
	.byte	0x30
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
	.byte	0x2
	.long	0x3e
	.uleb128 0x1c
	.byte	0x1
	.long	.LASF53
	.byte	0x1
	.byte	0x63
	.byte	0x1
	.long	.LFB1
	.long	.LFE1
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x4c3
	.uleb128 0x1a
	.long	.LASF54
	.byte	0x1
	.byte	0x63
	.long	0x4c3
	.long	.LLST17
	.uleb128 0x24
	.long	.LASF55
	.byte	0x1
	.byte	0x67
	.long	0x4ca
	.byte	0x5
	.byte	0x3
	.long	msgBuffer.1853
	.uleb128 0x24
	.long	.LASF56
	.byte	0x1
	.byte	0x68
	.long	0x3e
	.byte	0x5
	.byte	0x3
	.long	bufferIndex.1854
	.uleb128 0x24
	.long	.LASF50
	.byte	0x1
	.byte	0x69
	.long	0x3e
	.byte	0x5
	.byte	0x3
	.long	msgType.1855
	.uleb128 0x24
	.long	.LASF51
	.byte	0x1
	.byte	0x6a
	.long	0x3e
	.byte	0x5
	.byte	0x3
	.long	msgLen.1856
	.uleb128 0x23
	.long	.LVL29
	.long	0x399
	.uleb128 0x22
	.byte	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.byte	0x5
	.byte	0x3
	.long	msgBuffer.1853
	.byte	0
	.byte	0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF57
	.uleb128 0x9
	.long	0x3e
	.long	0x4da
	.uleb128 0xa
	.long	0x144
	.byte	0xd
	.byte	0
	.uleb128 0x25
	.byte	0x1
	.long	.LASF58
	.byte	0x1
	.byte	0xea
	.byte	0x1
	.long	0x97
	.long	.LFB9
	.long	.LFE9
	.long	.LLST18
	.byte	0x1
	.long	0x54f
	.uleb128 0x19
	.string	"msg"
	.byte	0x1
	.byte	0xea
	.long	0x393
	.long	.LLST19
	.uleb128 0x20
	.long	.LASF45
	.byte	0x1
	.byte	0xec
	.long	0x3e
	.long	.LLST20
	.uleb128 0x1f
	.long	.LBB4
	.long	.LBE4
	.uleb128 0x1e
	.string	"q"
	.byte	0x1
	.byte	0xf2
	.long	0x393
	.long	.LLST21
	.uleb128 0x20
	.long	.LASF48
	.byte	0x1
	.byte	0xf3
	.long	0x3e
	.long	.LLST22
	.uleb128 0x1b
	.long	.LVL39
	.long	0x241
	.uleb128 0x1b
	.long	.LVL46
	.long	0x257
	.byte	0
	.byte	0
	.uleb128 0x25
	.byte	0x1
	.long	.LASF59
	.byte	0x1
	.byte	0xbd
	.byte	0x1
	.long	0x97
	.long	.LFB7
	.long	.LFE7
	.long	.LLST23
	.byte	0x1
	.long	0x5c8
	.uleb128 0x26
	.string	"msg"
	.byte	0x1
	.byte	0xbf
	.long	0x1c6
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x27
	.long	.LBB5
	.long	.LBE5
	.long	0x5b2
	.uleb128 0x1e
	.string	"p"
	.byte	0x1
	.byte	0xc2
	.long	0x2b8
	.long	.LLST24
	.uleb128 0x28
	.long	.LASF100
	.byte	0x1
	.byte	0xc3
	.long	0x3e
	.uleb128 0x29
	.long	.LVL52
	.uleb128 0x22
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.byte	0
	.byte	0
	.uleb128 0x23
	.long	.LVL49
	.long	0x4da
	.uleb128 0x22
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.byte	0
	.byte	0
	.uleb128 0x2a
	.byte	0x1
	.long	.LASF60
	.byte	0x1
	.word	0x100
	.byte	0x1
	.long	.LFB10
	.long	.LFE10
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.uleb128 0x2a
	.byte	0x1
	.long	.LASF61
	.byte	0x1
	.word	0x10b
	.byte	0x1
	.long	.LFB11
	.long	.LFE11
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.uleb128 0x2a
	.byte	0x1
	.long	.LASF62
	.byte	0x1
	.word	0x110
	.byte	0x1
	.long	.LFB12
	.long	.LFE12
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.uleb128 0x2b
	.byte	0x1
	.long	.LASF63
	.byte	0x1
	.word	0x142
	.byte	0x1
	.long	.LFB19
	.long	.LFE19
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x636
	.uleb128 0x2c
	.string	"ch"
	.byte	0x1
	.word	0x142
	.long	0x4c3
	.byte	0x1
	.byte	0x68
	.byte	0
	.uleb128 0x2d
	.byte	0x1
	.long	.LASF64
	.byte	0x1
	.byte	0x4e
	.byte	0x1
	.byte	0x1
	.long	.LFB0
	.long	.LFE0
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x6c0
	.uleb128 0x27
	.long	.LBB6
	.long	.LBE6
	.long	0x68e
	.uleb128 0x24
	.long	.LASF54
	.byte	0x1
	.byte	0x5b
	.long	0x4c3
	.byte	0x1
	.byte	0x6c
	.uleb128 0x1b
	.long	.LVL59
	.long	0x241
	.uleb128 0x1b
	.long	.LVL61
	.long	0x257
	.uleb128 0x23
	.long	.LVL62
	.long	0x43d
	.uleb128 0x22
	.byte	0x1
	.byte	0x68
	.byte	0x2
	.byte	0x8c
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0x21
	.long	.LVL56
	.long	0x60d
	.long	0x6a2
	.uleb128 0x22
	.byte	0x1
	.byte	0x68
	.byte	0x2
	.byte	0x9
	.byte	0xca
	.byte	0
	.uleb128 0x21
	.long	.LVL57
	.long	0x60d
	.long	0x6b6
	.uleb128 0x22
	.byte	0x1
	.byte	0x68
	.byte	0x2
	.byte	0x9
	.byte	0xfe
	.byte	0
	.uleb128 0x1b
	.long	.LVL58
	.long	0x54f
	.byte	0
	.uleb128 0x2b
	.byte	0x1
	.long	.LASF65
	.byte	0x1
	.word	0x148
	.byte	0x1
	.long	.LFB20
	.long	.LFE20
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x6ef
	.uleb128 0x2c
	.string	"val"
	.byte	0x1
	.word	0x148
	.long	0x57
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0
	.uleb128 0x2e
	.byte	0x1
	.long	.LASF66
	.byte	0x1
	.word	0x118
	.byte	0x1
	.long	.LFB13
	.long	.LFE13
	.long	.LLST25
	.byte	0x1
	.long	0x799
	.uleb128 0x2f
	.string	"id"
	.byte	0x1
	.word	0x118
	.long	0x57
	.long	.LLST26
	.uleb128 0x30
	.long	.LASF67
	.byte	0x1
	.word	0x118
	.long	0x799
	.long	.LLST27
	.uleb128 0x2f
	.string	"len"
	.byte	0x1
	.word	0x118
	.long	0x2c
	.long	.LLST28
	.uleb128 0x1b
	.long	.LVL65
	.long	0x241
	.uleb128 0x21
	.long	.LVL66
	.long	0x60d
	.long	0x756
	.uleb128 0x22
	.byte	0x1
	.byte	0x68
	.byte	0x2
	.byte	0x9
	.byte	0xa5
	.byte	0
	.uleb128 0x21
	.long	.LVL67
	.long	0x60d
	.long	0x76d
	.uleb128 0x22
	.byte	0x1
	.byte	0x68
	.byte	0x5
	.byte	0x81
	.sleb128 0
	.byte	0x9
	.byte	0xa8
	.byte	0x21
	.byte	0
	.uleb128 0x21
	.long	.LVL68
	.long	0x6c0
	.long	0x786
	.uleb128 0x22
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x2
	.byte	0x8c
	.sleb128 0
	.byte	0
	.uleb128 0x1b
	.long	.LVL73
	.long	0x60d
	.uleb128 0x1b
	.long	.LVL75
	.long	0x257
	.byte	0
	.uleb128 0x12
	.byte	0x2
	.long	0x79f
	.uleb128 0x15
	.long	0x3e
	.uleb128 0x2b
	.byte	0x1
	.long	.LASF68
	.byte	0x1
	.word	0x125
	.byte	0x1
	.long	.LFB14
	.long	.LFE14
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x7f4
	.uleb128 0x2f
	.string	"id"
	.byte	0x1
	.word	0x125
	.long	0x57
	.long	.LLST29
	.uleb128 0x23
	.long	.LVL78
	.long	0x6ef
	.uleb128 0x22
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.uleb128 0x22
	.byte	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.byte	0x1
	.byte	0x30
	.uleb128 0x22
	.byte	0x1
	.byte	0x64
	.byte	0x1
	.byte	0x30
	.byte	0
	.byte	0
	.uleb128 0x2e
	.byte	0x1
	.long	.LASF69
	.byte	0x1
	.word	0x12b
	.byte	0x1
	.long	.LFB15
	.long	.LFE15
	.long	.LLST30
	.byte	0x1
	.long	0x854
	.uleb128 0x2f
	.string	"id"
	.byte	0x1
	.word	0x12b
	.long	0x57
	.long	.LLST31
	.uleb128 0x2f
	.string	"ch"
	.byte	0x1
	.word	0x12b
	.long	0x3e
	.long	.LLST32
	.uleb128 0x23
	.long	.LVL81
	.long	0x6ef
	.uleb128 0x22
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.uleb128 0x22
	.byte	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x22
	.byte	0x1
	.byte	0x64
	.byte	0x1
	.byte	0x31
	.byte	0
	.byte	0
	.uleb128 0x2e
	.byte	0x1
	.long	.LASF70
	.byte	0x1
	.word	0x130
	.byte	0x1
	.long	.LFB16
	.long	.LFE16
	.long	.LLST33
	.byte	0x1
	.long	0x8d4
	.uleb128 0x2f
	.string	"id"
	.byte	0x1
	.word	0x130
	.long	0x57
	.long	.LLST34
	.uleb128 0x30
	.long	.LASF71
	.byte	0x1
	.word	0x130
	.long	0x3e
	.long	.LLST35
	.uleb128 0x30
	.long	.LASF72
	.byte	0x1
	.word	0x130
	.long	0x3e
	.long	.LLST36
	.uleb128 0x31
	.long	.LASF73
	.byte	0x1
	.word	0x132
	.long	0x8d4
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x23
	.long	.LVL86
	.long	0x6ef
	.uleb128 0x22
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.uleb128 0x22
	.byte	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x22
	.byte	0x1
	.byte	0x64
	.byte	0x1
	.byte	0x32
	.byte	0
	.byte	0
	.uleb128 0x9
	.long	0x3e
	.long	0x8e4
	.uleb128 0xa
	.long	0x144
	.byte	0x1
	.byte	0
	.uleb128 0x2e
	.byte	0x1
	.long	.LASF74
	.byte	0x1
	.word	0x136
	.byte	0x1
	.long	.LFB17
	.long	.LFE17
	.long	.LLST37
	.byte	0x1
	.long	0x974
	.uleb128 0x2f
	.string	"id"
	.byte	0x1
	.word	0x136
	.long	0x57
	.long	.LLST38
	.uleb128 0x30
	.long	.LASF71
	.byte	0x1
	.word	0x136
	.long	0x3e
	.long	.LLST39
	.uleb128 0x30
	.long	.LASF72
	.byte	0x1
	.word	0x136
	.long	0x3e
	.long	.LLST40
	.uleb128 0x30
	.long	.LASF75
	.byte	0x1
	.word	0x136
	.long	0x3e
	.long	.LLST41
	.uleb128 0x31
	.long	.LASF73
	.byte	0x1
	.word	0x138
	.long	0x974
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x23
	.long	.LVL90
	.long	0x6ef
	.uleb128 0x22
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.uleb128 0x22
	.byte	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x22
	.byte	0x1
	.byte	0x64
	.byte	0x1
	.byte	0x33
	.byte	0
	.byte	0
	.uleb128 0x9
	.long	0x3e
	.long	0x984
	.uleb128 0xa
	.long	0x144
	.byte	0x2
	.byte	0
	.uleb128 0x2e
	.byte	0x1
	.long	.LASF76
	.byte	0x1
	.word	0x13c
	.byte	0x1
	.long	.LFB18
	.long	.LFE18
	.long	.LLST42
	.byte	0x1
	.long	0xa24
	.uleb128 0x2f
	.string	"id"
	.byte	0x1
	.word	0x13c
	.long	0x57
	.long	.LLST43
	.uleb128 0x30
	.long	.LASF71
	.byte	0x1
	.word	0x13c
	.long	0x3e
	.long	.LLST44
	.uleb128 0x30
	.long	.LASF72
	.byte	0x1
	.word	0x13c
	.long	0x3e
	.long	.LLST45
	.uleb128 0x30
	.long	.LASF75
	.byte	0x1
	.word	0x13c
	.long	0x3e
	.long	.LLST46
	.uleb128 0x30
	.long	.LASF77
	.byte	0x1
	.word	0x13c
	.long	0x3e
	.long	.LLST47
	.uleb128 0x31
	.long	.LASF73
	.byte	0x1
	.word	0x13e
	.long	0xa24
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x23
	.long	.LVL94
	.long	0x6ef
	.uleb128 0x22
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.uleb128 0x22
	.byte	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x22
	.byte	0x1
	.byte	0x64
	.byte	0x1
	.byte	0x34
	.byte	0
	.byte	0
	.uleb128 0x9
	.long	0x3e
	.long	0xa34
	.uleb128 0xa
	.long	0x144
	.byte	0x3
	.byte	0
	.uleb128 0x2e
	.byte	0x1
	.long	.LASF78
	.byte	0x1
	.word	0x151
	.byte	0x1
	.long	.LFB21
	.long	.LFE21
	.long	.LLST48
	.byte	0x1
	.long	0xa7a
	.uleb128 0x1f
	.long	.LBB7
	.long	.LBE7
	.uleb128 0x32
	.long	.LASF79
	.byte	0x1
	.word	0x156
	.long	0x4c3
	.long	.LLST49
	.uleb128 0x32
	.long	.LASF80
	.byte	0x1
	.word	0x157
	.long	0x3e
	.long	.LLST50
	.byte	0
	.byte	0
	.uleb128 0x24
	.long	.LASF81
	.byte	0x1
	.byte	0x16
	.long	0x3e
	.byte	0x5
	.byte	0x3
	.long	_enterAtomicNesting
	.uleb128 0x24
	.long	.LASF82
	.byte	0x1
	.byte	0x1b
	.long	0xa9c
	.byte	0x5
	.byte	0x3
	.long	USART_rxBufferIn
	.uleb128 0x33
	.long	0x3e
	.uleb128 0x24
	.long	.LASF83
	.byte	0x1
	.byte	0x1c
	.long	0xa9c
	.byte	0x5
	.byte	0x3
	.long	USART_rxBufferOut
	.uleb128 0x9
	.long	0x14b
	.long	0xac2
	.uleb128 0xa
	.long	0x144
	.byte	0x7
	.byte	0
	.uleb128 0x24
	.long	.LASF84
	.byte	0x1
	.byte	0x1e
	.long	0xab2
	.byte	0x5
	.byte	0x3
	.long	_avrMessagePool
	.uleb128 0x24
	.long	.LASF85
	.byte	0x1
	.byte	0x1f
	.long	0x134
	.byte	0x5
	.byte	0x3
	.long	_avrMsgIndex
	.uleb128 0x24
	.long	.LASF86
	.byte	0x1
	.byte	0x20
	.long	0x3e
	.byte	0x5
	.byte	0x3
	.long	_avrPoolIn
	.uleb128 0x24
	.long	.LASF87
	.byte	0x1
	.byte	0x21
	.long	0x3e
	.byte	0x5
	.byte	0x3
	.long	_avrPoolOut
	.uleb128 0x24
	.long	.LASF88
	.byte	0x1
	.byte	0x23
	.long	0x236
	.byte	0x5
	.byte	0x3
	.long	_anchor
	.uleb128 0x9
	.long	0x1c6
	.long	0xb27
	.uleb128 0xa
	.long	0x144
	.byte	0x3
	.byte	0
	.uleb128 0x24
	.long	.LASF89
	.byte	0x1
	.byte	0x25
	.long	0xb17
	.byte	0x5
	.byte	0x3
	.long	_highPrioQueue
	.uleb128 0x9
	.long	0x1c6
	.long	0xb48
	.uleb128 0xa
	.long	0x144
	.byte	0x7
	.byte	0
	.uleb128 0x24
	.long	.LASF90
	.byte	0x1
	.byte	0x26
	.long	0xb38
	.byte	0x5
	.byte	0x3
	.long	_midPrioQueue
	.uleb128 0x24
	.long	.LASF91
	.byte	0x1
	.byte	0x27
	.long	0xb38
	.byte	0x5
	.byte	0x3
	.long	_lowPrioQueue
	.uleb128 0x9
	.long	0x1c6
	.long	0xb7a
	.uleb128 0xa
	.long	0x144
	.byte	0xf
	.byte	0
	.uleb128 0x24
	.long	.LASF92
	.byte	0x1
	.byte	0x28
	.long	0xb6a
	.byte	0x5
	.byte	0x3
	.long	_veryLowPrioQueue
	.uleb128 0x9
	.long	0x393
	.long	0xb9b
	.uleb128 0xa
	.long	0x144
	.byte	0x3
	.byte	0
	.uleb128 0x24
	.long	.LASF93
	.byte	0x1
	.byte	0x2a
	.long	0xbac
	.byte	0x5
	.byte	0x3
	.long	_prioQueue
	.uleb128 0x15
	.long	0xb8b
	.uleb128 0x24
	.long	.LASF94
	.byte	0x1
	.byte	0x2c
	.long	0xa24
	.byte	0x5
	.byte	0x3
	.long	_qIn
	.uleb128 0x24
	.long	.LASF95
	.byte	0x1
	.byte	0x2d
	.long	0xa24
	.byte	0x5
	.byte	0x3
	.long	_qOut
	.uleb128 0x9
	.long	0x2c
	.long	0xbe3
	.uleb128 0xa
	.long	0x144
	.byte	0x3
	.byte	0
	.uleb128 0x24
	.long	.LASF96
	.byte	0x1
	.byte	0x2e
	.long	0xbd3
	.byte	0x5
	.byte	0x3
	.long	_nrOfEntries
	.uleb128 0x9
	.long	0x79f
	.long	0xc04
	.uleb128 0xa
	.long	0x144
	.byte	0x3
	.byte	0
	.uleb128 0x24
	.long	.LASF97
	.byte	0x1
	.byte	0x2f
	.long	0xc15
	.byte	0x5
	.byte	0x3
	.long	_capacity
	.uleb128 0x15
	.long	0xbf4
	.uleb128 0x9
	.long	0x4c3
	.long	0xc2a
	.uleb128 0xa
	.long	0x144
	.byte	0x1f
	.byte	0
	.uleb128 0x34
	.long	.LASF101
	.byte	0x1
	.byte	0x1a
	.long	0xc1a
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	USART_rxBuffer
	.uleb128 0x35
	.byte	0x1
	.byte	0x1
	.long	.LASF102
	.long	.LASF102
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x4
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xd
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xd
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x87
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x30
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x33
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x34
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x35
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.uleb128 0x2007
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB5
	.long	.LCFI0
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI0
	.long	.LCFI1
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI1
	.long	.LCFI2
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI2
	.long	.LCFI3
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI3
	.long	.LFE5
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	0
	.long	0
.LLST1:
	.long	.LVL0
	.long	.LVL1-1
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL1-1
	.long	.LVL3
	.word	0x6
	.byte	0x6c
	.byte	0x93
	.uleb128 0x1
	.byte	0x6d
	.byte	0x93
	.uleb128 0x1
	.long	.LVL3
	.long	.LFE5
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST2:
	.long	.LVL0
	.long	.LVL1-1
	.word	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.long	.LVL1-1
	.long	.LVL4
	.word	0x6
	.byte	0x60
	.byte	0x93
	.uleb128 0x1
	.byte	0x61
	.byte	0x93
	.uleb128 0x1
	.long	.LVL4
	.long	.LFE5
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0x9f
	.long	0
	.long	0
.LLST3:
	.long	.LVL7
	.long	.LVL10
	.word	0x6
	.byte	0x6e
	.byte	0x93
	.uleb128 0x1
	.byte	0x6f
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST4:
	.long	.LVL6
	.long	.LVL7
	.word	0x6
	.byte	0x6e
	.byte	0x93
	.uleb128 0x1
	.byte	0x6f
	.byte	0x93
	.uleb128 0x1
	.long	.LVL7
	.long	.LVL8
	.word	0x6
	.byte	0x62
	.byte	0x93
	.uleb128 0x1
	.byte	0x63
	.byte	0x93
	.uleb128 0x1
	.long	.LVL8
	.long	.LVL9
	.word	0x6
	.byte	0x6e
	.byte	0x93
	.uleb128 0x1
	.byte	0x6f
	.byte	0x93
	.uleb128 0x1
	.long	.LVL9
	.long	.LVL10
	.word	0x6
	.byte	0x62
	.byte	0x93
	.uleb128 0x1
	.byte	0x63
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST5:
	.long	.LFB8
	.long	.LCFI4
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI4
	.long	.LCFI5
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI5
	.long	.LCFI6
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI6
	.long	.LCFI7
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI7
	.long	.LCFI8
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI8
	.long	.LCFI9
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI9
	.long	.LCFI10
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 8
	.long	.LCFI10
	.long	.LCFI11
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 9
	.long	.LCFI11
	.long	.LCFI12
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 10
	.long	.LCFI12
	.long	.LFE8
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 11
	.long	0
	.long	0
.LLST6:
	.long	.LVL11
	.long	.LVL12-1
	.word	0x1
	.byte	0x68
	.long	.LVL12-1
	.long	.LVL17
	.word	0x1
	.byte	0x6c
	.long	.LVL17
	.long	.LVL18
	.word	0x2
	.byte	0x8e
	.sleb128 0
	.long	.LVL18
	.long	.LFE8
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST7:
	.long	.LVL11
	.long	.LVL12-1
	.word	0x1
	.byte	0x66
	.long	.LVL12-1
	.long	.LVL19
	.word	0x1
	.byte	0x5b
	.long	.LVL19
	.long	.LFE8
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0x9f
	.long	0
	.long	0
.LLST8:
	.long	.LVL11
	.long	.LVL12-1
	.word	0x1
	.byte	0x64
	.long	.LVL12-1
	.long	.LVL19
	.word	0x1
	.byte	0x5c
	.long	.LVL19
	.long	.LFE8
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x64
	.byte	0x9f
	.long	0
	.long	0
.LLST9:
	.long	.LVL11
	.long	.LVL12-1
	.word	0x1
	.byte	0x62
	.long	.LVL12-1
	.long	.LVL19
	.word	0x1
	.byte	0x5d
	.long	.LVL19
	.long	.LFE8
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x62
	.byte	0x9f
	.long	0
	.long	0
.LLST10:
	.long	.LVL13
	.long	.LVL16
	.word	0x1
	.byte	0x6e
	.long	0
	.long	0
.LLST11:
	.long	.LVL14
	.long	.LVL15
	.word	0xa
	.byte	0x8c
	.sleb128 0
	.byte	0x31
	.byte	0x24
	.byte	0x3
	.long	_prioQueue
	.byte	0x22
	.long	.LVL15
	.long	.LVL19-1
	.word	0x2
	.byte	0x8a
	.sleb128 0
	.long	.LVL19-1
	.long	.LVL19
	.word	0x10
	.byte	0x8c
	.sleb128 0
	.byte	0x3
	.long	_nrOfEntries
	.byte	0x1c
	.byte	0x31
	.byte	0x24
	.byte	0x3
	.long	_prioQueue
	.byte	0x22
	.long	0
	.long	0
.LLST12:
	.long	.LFB2
	.long	.LCFI13
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI13
	.long	.LCFI14
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI14
	.long	.LFE2
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	0
	.long	0
.LLST13:
	.long	.LVL20
	.long	.LVL22
	.word	0x1
	.byte	0x68
	.long	.LVL22
	.long	.LVL24
	.word	0x1
	.byte	0x6c
	.long	.LVL24
	.long	.LFE2
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST14:
	.long	.LVL20
	.long	.LVL23-1
	.word	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.long	.LVL23-1
	.long	.LFE2
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0x9f
	.long	0
	.long	0
.LLST15:
	.long	.LVL20
	.long	.LVL23-1
	.word	0x1
	.byte	0x64
	.long	.LVL23-1
	.long	.LFE2
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x64
	.byte	0x9f
	.long	0
	.long	0
.LLST16:
	.long	.LVL21
	.long	.LVL24
	.word	0x1
	.byte	0x6d
	.long	0
	.long	0
.LLST17:
	.long	.LVL25
	.long	.LVL26
	.word	0x1
	.byte	0x68
	.long	.LVL26
	.long	.LVL27
	.word	0x3
	.byte	0x88
	.sleb128 2
	.byte	0x9f
	.long	.LVL27
	.long	.LVL28
	.word	0x1
	.byte	0x68
	.long	.LVL28
	.long	.LVL29-1
	.word	0x2
	.byte	0x8e
	.sleb128 0
	.long	.LVL29-1
	.long	.LFE1
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST18:
	.long	.LFB9
	.long	.LCFI15
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI15
	.long	.LCFI16
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI16
	.long	.LCFI17
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI17
	.long	.LCFI18
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI18
	.long	.LFE9
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	0
	.long	0
.LLST19:
	.long	.LVL30
	.long	.LVL39-1
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL39-1
	.long	.LVL47
	.word	0x6
	.byte	0x6c
	.byte	0x93
	.uleb128 0x1
	.byte	0x6d
	.byte	0x93
	.uleb128 0x1
	.long	.LVL47
	.long	.LVL48
	.word	0x6
	.byte	0x62
	.byte	0x93
	.uleb128 0x1
	.byte	0x63
	.byte	0x93
	.uleb128 0x1
	.long	.LVL48
	.long	.LFE9
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST20:
	.long	.LVL31
	.long	.LVL32
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL32
	.long	.LVL33
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.long	.LVL33
	.long	.LVL34
	.word	0x2
	.byte	0x32
	.byte	0x9f
	.long	.LVL34
	.long	.LVL35
	.word	0x2
	.byte	0x33
	.byte	0x9f
	.long	.LVL35
	.long	.LVL36
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.long	.LVL36
	.long	.LVL37
	.word	0x2
	.byte	0x32
	.byte	0x9f
	.long	.LVL37
	.long	.LVL38
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL47
	.long	.LVL48
	.word	0x2
	.byte	0x33
	.byte	0x9f
	.long	0
	.long	0
.LLST21:
	.long	.LVL39
	.long	.LVL41
	.word	0xa
	.byte	0x80
	.sleb128 0
	.byte	0x31
	.byte	0x24
	.byte	0x3
	.long	_prioQueue
	.byte	0x22
	.long	.LVL41
	.long	.LVL42
	.word	0x2
	.byte	0x8e
	.sleb128 0
	.long	.LVL42
	.long	.LVL43
	.word	0x6
	.byte	0x6e
	.byte	0x93
	.uleb128 0x1
	.byte	0x6f
	.byte	0x93
	.uleb128 0x1
	.long	.LVL43
	.long	.LVL47
	.word	0xa
	.byte	0x80
	.sleb128 0
	.byte	0x31
	.byte	0x24
	.byte	0x3
	.long	_prioQueue
	.byte	0x22
	.long	0
	.long	0
.LLST22:
	.long	.LVL40
	.long	.LVL44
	.word	0x1
	.byte	0x64
	.long	.LVL44
	.long	.LVL45
	.word	0x1
	.byte	0x68
	.long	0
	.long	0
.LLST23:
	.long	.LFB7
	.long	.LCFI19
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI19
	.long	.LCFI20
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI20
	.long	.LCFI21
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI21
	.long	.LCFI22
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI22
	.long	.LCFI23
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI23
	.long	.LCFI24
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI24
	.long	.LCFI25
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 11
	.long	.LCFI25
	.long	.LFE7
	.word	0x2
	.byte	0x8c
	.sleb128 11
	.long	0
	.long	0
.LLST24:
	.long	.LVL50
	.long	.LVL54
	.word	0x6
	.byte	0x60
	.byte	0x93
	.uleb128 0x1
	.byte	0x61
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST25:
	.long	.LFB13
	.long	.LCFI26
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI26
	.long	.LCFI27
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI27
	.long	.LCFI28
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI28
	.long	.LCFI29
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI29
	.long	.LCFI30
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI30
	.long	.LCFI31
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI31
	.long	.LFE13
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 8
	.long	0
	.long	0
.LLST26:
	.long	.LVL64
	.long	.LVL65-1
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL65-1
	.long	.LVL69
	.word	0x6
	.byte	0x6c
	.byte	0x93
	.uleb128 0x1
	.byte	0x6d
	.byte	0x93
	.uleb128 0x1
	.long	.LVL69
	.long	.LFE13
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST27:
	.long	.LVL64
	.long	.LVL65-1
	.word	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.long	.LVL65-1
	.long	.LVL68
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0x9f
	.long	.LVL68
	.long	.LVL71
	.word	0x6
	.byte	0x5e
	.byte	0x93
	.uleb128 0x1
	.byte	0x5f
	.byte	0x93
	.uleb128 0x1
	.long	.LVL71
	.long	.LVL72
	.word	0x3
	.byte	0x80
	.sleb128 1
	.byte	0x9f
	.long	.LVL72
	.long	.LVL73-1
	.word	0x6
	.byte	0x6e
	.byte	0x93
	.uleb128 0x1
	.byte	0x6f
	.byte	0x93
	.uleb128 0x1
	.long	.LVL73-1
	.long	.LVL74
	.word	0x6
	.byte	0x60
	.byte	0x93
	.uleb128 0x1
	.byte	0x61
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST28:
	.long	.LVL64
	.long	.LVL65-1
	.word	0x1
	.byte	0x64
	.long	.LVL65-1
	.long	.LVL70
	.word	0x1
	.byte	0x61
	.long	.LVL70
	.long	.LVL76
	.word	0x1
	.byte	0x6c
	.long	0
	.long	0
.LLST29:
	.long	.LVL77
	.long	.LVL78-1
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL78-1
	.long	.LFE14
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST30:
	.long	.LFB15
	.long	.LCFI32
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI32
	.long	.LCFI33
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI33
	.long	.LCFI34
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI34
	.long	.LCFI35
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI35
	.long	.LFE15
	.word	0x2
	.byte	0x8c
	.sleb128 5
	.long	0
	.long	0
.LLST31:
	.long	.LVL79
	.long	.LVL81-1
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL81-1
	.long	.LFE15
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST32:
	.long	.LVL79
	.long	.LVL80
	.word	0x1
	.byte	0x66
	.long	.LVL80
	.long	.LVL82
	.word	0x2
	.byte	0x8c
	.sleb128 1
	.long	.LVL82
	.long	.LFE15
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 -2
	.long	0
	.long	0
.LLST33:
	.long	.LFB16
	.long	.LCFI36
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI36
	.long	.LCFI37
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI37
	.long	.LCFI38
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI38
	.long	.LCFI39
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI39
	.long	.LFE16
	.word	0x2
	.byte	0x8c
	.sleb128 6
	.long	0
	.long	0
.LLST34:
	.long	.LVL83
	.long	.LVL86-1
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL86-1
	.long	.LFE16
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST35:
	.long	.LVL83
	.long	.LVL85
	.word	0x1
	.byte	0x66
	.long	.LVL85
	.long	.LVL86-1
	.word	0x2
	.byte	0x8c
	.sleb128 1
	.long	.LVL86-1
	.long	.LFE16
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0x9f
	.long	0
	.long	0
.LLST36:
	.long	.LVL83
	.long	.LVL84
	.word	0x1
	.byte	0x64
	.long	.LVL84
	.long	.LVL86-1
	.word	0x2
	.byte	0x8c
	.sleb128 2
	.long	.LVL86-1
	.long	.LFE16
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x64
	.byte	0x9f
	.long	0
	.long	0
.LLST37:
	.long	.LFB17
	.long	.LCFI40
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI40
	.long	.LCFI41
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI41
	.long	.LCFI42
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI42
	.long	.LCFI43
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI43
	.long	.LFE17
	.word	0x2
	.byte	0x8c
	.sleb128 7
	.long	0
	.long	0
.LLST38:
	.long	.LVL87
	.long	.LVL90-1
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL90-1
	.long	.LFE17
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST39:
	.long	.LVL87
	.long	.LVL89
	.word	0x1
	.byte	0x66
	.long	.LVL89
	.long	.LVL90-1
	.word	0x2
	.byte	0x8c
	.sleb128 1
	.long	.LVL90-1
	.long	.LFE17
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0x9f
	.long	0
	.long	0
.LLST40:
	.long	.LVL87
	.long	.LVL88
	.word	0x1
	.byte	0x64
	.long	.LVL88
	.long	.LVL90-1
	.word	0x2
	.byte	0x8c
	.sleb128 2
	.long	.LVL90-1
	.long	.LFE17
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x64
	.byte	0x9f
	.long	0
	.long	0
.LLST41:
	.long	.LVL87
	.long	.LVL90-1
	.word	0x1
	.byte	0x62
	.long	.LVL90-1
	.long	.LFE17
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x62
	.byte	0x9f
	.long	0
	.long	0
.LLST42:
	.long	.LFB18
	.long	.LCFI44
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI44
	.long	.LCFI45
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI45
	.long	.LCFI46
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI46
	.long	.LCFI47
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI47
	.long	.LCFI48
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 9
	.long	.LCFI48
	.long	.LFE18
	.word	0x2
	.byte	0x8c
	.sleb128 9
	.long	0
	.long	0
.LLST43:
	.long	.LVL91
	.long	.LVL94-1
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL94-1
	.long	.LFE18
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST44:
	.long	.LVL91
	.long	.LVL93
	.word	0x1
	.byte	0x66
	.long	.LVL93
	.long	.LVL94-1
	.word	0x2
	.byte	0x8c
	.sleb128 1
	.long	.LVL94-1
	.long	.LFE18
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0x9f
	.long	0
	.long	0
.LLST45:
	.long	.LVL91
	.long	.LVL92
	.word	0x1
	.byte	0x64
	.long	.LVL92
	.long	.LVL94-1
	.word	0x2
	.byte	0x8c
	.sleb128 2
	.long	.LVL94-1
	.long	.LFE18
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x64
	.byte	0x9f
	.long	0
	.long	0
.LLST46:
	.long	.LVL91
	.long	.LVL94-1
	.word	0x1
	.byte	0x62
	.long	.LVL94-1
	.long	.LFE18
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x62
	.byte	0x9f
	.long	0
	.long	0
.LLST47:
	.long	.LVL91
	.long	.LVL95
	.word	0x1
	.byte	0x60
	.long	.LVL95
	.long	.LFE18
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x60
	.byte	0x9f
	.long	0
	.long	0
.LLST48:
	.long	.LFB21
	.long	.LCFI49
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI49
	.long	.LCFI50
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI50
	.long	.LCFI51
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI51
	.long	.LCFI52
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI52
	.long	.LCFI53
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI53
	.long	.LCFI54
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI54
	.long	.LCFI55
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 8
	.long	.LCFI55
	.long	.LFE21
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 9
	.long	0
	.long	0
.LLST49:
	.long	.LVL96
	.long	.LVL98
	.word	0x1
	.byte	0x62
	.long	0
	.long	0
.LLST50:
	.long	.LVL97
	.long	.LVL98
	.word	0x1
	.byte	0x68
	.long	0
	.long	0
	.section	.debug_aranges,"",@progbits
	.long	0xc4
	.word	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.word	0
	.word	0
	.long	.LFB3
	.long	.LFE3-.LFB3
	.long	.LFB4
	.long	.LFE4-.LFB4
	.long	.LFB5
	.long	.LFE5-.LFB5
	.long	.LFB6
	.long	.LFE6-.LFB6
	.long	.LFB8
	.long	.LFE8-.LFB8
	.long	.LFB2
	.long	.LFE2-.LFB2
	.long	.LFB1
	.long	.LFE1-.LFB1
	.long	.LFB9
	.long	.LFE9-.LFB9
	.long	.LFB7
	.long	.LFE7-.LFB7
	.long	.LFB10
	.long	.LFE10-.LFB10
	.long	.LFB11
	.long	.LFE11-.LFB11
	.long	.LFB12
	.long	.LFE12-.LFB12
	.long	.LFB19
	.long	.LFE19-.LFB19
	.long	.LFB0
	.long	.LFE0-.LFB0
	.long	.LFB20
	.long	.LFE20-.LFB20
	.long	.LFB13
	.long	.LFE13-.LFB13
	.long	.LFB14
	.long	.LFE14-.LFB14
	.long	.LFB15
	.long	.LFE15-.LFB15
	.long	.LFB16
	.long	.LFE16-.LFB16
	.long	.LFB17
	.long	.LFE17-.LFB17
	.long	.LFB18
	.long	.LFE18-.LFB18
	.long	.LFB21
	.long	.LFE21-.LFB21
	.long	0
	.long	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.LFB3
	.long	.LFE3
	.long	.LFB4
	.long	.LFE4
	.long	.LFB5
	.long	.LFE5
	.long	.LFB6
	.long	.LFE6
	.long	.LFB8
	.long	.LFE8
	.long	.LFB2
	.long	.LFE2
	.long	.LFB1
	.long	.LFE1
	.long	.LFB9
	.long	.LFE9
	.long	.LFB7
	.long	.LFE7
	.long	.LFB10
	.long	.LFE10
	.long	.LFB11
	.long	.LFE11
	.long	.LFB12
	.long	.LFE12
	.long	.LFB19
	.long	.LFE19
	.long	.LFB0
	.long	.LFE0
	.long	.LFB20
	.long	.LFE20
	.long	.LFB13
	.long	.LFE13
	.long	.LFB14
	.long	.LFE14
	.long	.LFB15
	.long	.LFE15
	.long	.LFB16
	.long	.LFE16
	.long	.LFB17
	.long	.LFE17
	.long	.LFB18
	.long	.LFE18
	.long	.LFB21
	.long	.LFE21
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF85:
	.string	"_avrMsgIndex"
.LASF51:
	.string	"msgLen"
.LASF59:
	.string	"DispatchEvent"
.LASF53:
	.string	"HandleMessage"
.LASF83:
	.string	"USART_rxBufferOut"
.LASF32:
	.string	"Priority"
.LASF2:
	.string	"int8_t"
.LASF48:
	.string	"index"
.LASF92:
	.string	"_veryLowPrioQueue"
.LASF94:
	.string	"_qIn"
.LASF26:
	.string	"sizetype"
.LASF30:
	.string	"AvrMessage_tag"
.LASF56:
	.string	"bufferIndex"
.LASF58:
	.string	"GetMessage"
.LASF70:
	.string	"Usart_Trace2"
.LASF74:
	.string	"Usart_Trace3"
.LASF27:
	.string	"AvrMessage"
.LASF102:
	.string	"memcpy"
.LASF14:
	.string	"Priority_Medium"
.LASF90:
	.string	"_midPrioQueue"
.LASF100:
	.string	"prioFlag"
.LASF41:
	.string	"handler"
.LASF95:
	.string	"_qOut"
.LASF49:
	.string	"ProcessMessage"
.LASF23:
	.string	"MsgType"
.LASF29:
	.string	"MsgParamHigh"
.LASF3:
	.string	"uint8_t"
.LASF17:
	.string	"PacketType_Undefined"
.LASF61:
	.string	"AllowUartRx"
.LASF96:
	.string	"_nrOfEntries"
.LASF22:
	.string	"AvrPacketType"
.LASF19:
	.string	"PacketType_TestCommand"
.LASF68:
	.string	"Usart_Trace0"
.LASF69:
	.string	"Usart_Trace1"
.LASF52:
	.string	"msgIndex"
.LASF76:
	.string	"Usart_Trace4"
.LASF18:
	.string	"PacketType_LiftSimulatorButton"
.LASF84:
	.string	"_avrMessagePool"
.LASF8:
	.string	"long long int"
.LASF10:
	.string	"False"
.LASF28:
	.string	"MsgParamLow"
.LASF86:
	.string	"_avrPoolIn"
.LASF89:
	.string	"_highPrioQueue"
.LASF6:
	.string	"long int"
.LASF62:
	.string	"DisallowUartRx"
.LASF44:
	.string	"SendMessage"
.LASF66:
	.string	"Usart_TraceN"
.LASF35:
	.string	"Fsm_tag"
.LASF54:
	.string	"receivedData"
.LASF87:
	.string	"_avrPoolOut"
.LASF79:
	.string	"receivedChar"
.LASF65:
	.string	"Usart_PutShort"
.LASF4:
	.string	"unsigned char"
.LASF81:
	.string	"_enterAtomicNesting"
.LASF42:
	.string	"SetState"
.LASF40:
	.string	"LeaveAtomic"
.LASF1:
	.string	"signed char"
.LASF9:
	.string	"long long unsigned int"
.LASF37:
	.string	"RxMask"
.LASF0:
	.string	"unsigned int"
.LASF71:
	.string	"val1"
.LASF5:
	.string	"uint16_t"
.LASF75:
	.string	"val3"
.LASF77:
	.string	"val4"
.LASF38:
	.string	"CurrentState"
.LASF34:
	.string	"StateHandler"
.LASF45:
	.string	"prio"
.LASF25:
	.string	"Payload"
.LASF16:
	.string	"Priority_VeryLow"
.LASF57:
	.string	"char"
.LASF20:
	.string	"PacketType_TraceMassagePadLen"
.LASF43:
	.string	"RegisterFsm"
.LASF88:
	.string	"_anchor"
.LASF24:
	.string	"Length"
.LASF91:
	.string	"_lowPrioQueue"
.LASF99:
	.string	"C:\\Users\\rolfl\\Documents\\GitHub\\Avr\\AvrLib\\Build\\AvrLib.c"
.LASF39:
	.string	"EnterAtomic"
.LASF64:
	.string	"InitializeStateEventFramework"
.LASF50:
	.string	"msgType"
.LASF73:
	.string	"buffer"
.LASF67:
	.string	"pVal"
.LASF21:
	.string	"PacketType_TraceMessage"
.LASF78:
	.string	"__vector_13"
.LASF7:
	.string	"long unsigned int"
.LASF82:
	.string	"USART_rxBufferIn"
.LASF31:
	.string	"Message_tag"
.LASF98:
	.string	"GNU C99 5.4.0 -mn-flash=1 -mno-skip-bug -mmcu=avr5 -g2 -O1 -std=gnu99 -funsigned-char -funsigned-bitfields -ffunction-sections -fdata-sections -fpack-struct -fshort-enums"
.LASF80:
	.string	"nextInput"
.LASF93:
	.string	"_prioQueue"
.LASF13:
	.string	"Priority_High"
.LASF60:
	.string	"Usart_Init"
.LASF97:
	.string	"_capacity"
.LASF11:
	.string	"True"
.LASF15:
	.string	"Priority_Low"
.LASF46:
	.string	"msgLow"
.LASF33:
	.string	"Message"
.LASF47:
	.string	"msgHigh"
.LASF72:
	.string	"val2"
.LASF63:
	.string	"Usart_PutChar"
.LASF101:
	.string	"USART_rxBuffer"
.LASF36:
	.string	"Next"
.LASF55:
	.string	"msgBuffer"
.LASF12:
	.string	"Bool"
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_3.6.2_1759) 5.4.0"
.global __do_copy_data
.global __do_clear_bss
