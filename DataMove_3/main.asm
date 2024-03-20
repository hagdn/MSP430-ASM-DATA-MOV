;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
main:

			mov.w	#array1, R4	; Takes the address of the firstmost
						; data of array1 then set it as
						; value of R4, this address is 16-bit

						; Notice that awareness on how much
						; bytes a data uses is important as
						; the n in n(Rx) dictates the amount
						; of steps the index must move for the
						; Moving by twos when data are acutally
						; separate 1-bytes, and only one is
						; needed to be copied results to
						; copying/moving of the two data
						; While moving by 1's when 2-bytes are
						; needed to be copied results to
						; only the low-byte being copied
			mov.w	0(R4), R5
			mov.w	2(R4), R6
			mov.w	4(R4), R7
			mov.w	6(R4), R8
			mov.w	8(R4), R9

			mov.b	7(R4), R10	; Copies only the high-byte of DECAh
						; It is a byte-access so it is possible
						; to do this.

			mov.w	8(R4), R11	; It is expected here that the high-byte
						; of DECAh is first copied then the
						; low-byte of 00AAh, but in MSP430
						; word-access and byte-access has
						; different endianess. In byte-access
						; the low-bytes are read/stored first.
						; for word access, it is the whole
						; 2-bytes with the high-byte taken
						; as a priority.


			jmp		main
			NOP


;-------------------------------------------------------------------------------
; Data Memory
;-------------------------------------------------------------------------------
			.data
			.retain

array1:		.short	'A','1','@',0DECAh,0AAAAh
						; 00 01, 02 03, 04 05, 06 07, 08 09
res:		.space	8

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
