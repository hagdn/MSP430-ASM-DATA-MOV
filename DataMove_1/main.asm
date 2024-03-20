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
						; KEY NOTE - Registers are 16 bit
						; Notice that program memory starts
						; the memory address 0x00C400

main:		mov.b	R0, R4			; Operands are flipped for MSP430
						; From Z80 it is from right to left
						; MSP430 is left to right, i.e.
						; source -> destination

						; .w indicates 16-bit operation
						; .b indicates 8-bit operation
			mov.w	R0, R5

						; IMMEDIATE ADDRESSING with '#'
						; Values with '#' is the actual
						; value or data/information.

			mov.b	#'A', R6	; Store the Hex equivalent of ASCII
			mov.b	#'1', R7

			mov.w	#0FFFFh, R8	; #(value) dictates direct copy/move
       		mov.w	#0Fh, R9		; of the value to a destination

       		mov.b	#0FFAAh, R10		; low-byte is stored/read first

       						; ABSOLUTE ADDRESSING with '&'
       						; Values preceding '&' is the
       						; Actual address

       		mov.b	&2000h, R4		; ASCII is a byte, copy it to R4
       		mov.w	&2002h, R5		; Although ASCII is a byte,
       						; it still takes 2 bytes in memory
       						; this explains instead of ending
       						; at 2000h, it still ends at 2001h
       						; hence, FACEh, starts at 2002h

       						; MEMORY-MEMORY data movement
       		mov.w	&2002h, &2004h		; And next address in data memory
       						; is at 2004h.

			mov.b	R4, &2006h	; REGISTER-MEMORY data movement
						; noting that the low-byte of
						; data stored at memory &2006h
						; is the only one overwritten.
						; So high-byte is kept/untouched.

			jmp main
			NOP
                                            
;-------------------------------------------------------------------------------
; Data Memory
;-------------------------------------------------------------------------------
			.data			; Access data memory
			.retain			; Notice data memory
						; starts at 0x002000

var1:		.short	'C'			; Store 'C' into the first address
var2:		.short	0FACEh			; Store this to the next address
						; after 'C' or the previous

						; Notice that data are stored
						; automatically in an orderlly
						; fashion from the start of
						; data memory

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
            
