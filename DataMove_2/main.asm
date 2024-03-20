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

			mov.w	var1, R4	; Copy contents stored in var1 to R4
			mov.w	var2, var3	; Copy contents of var2 to var5

			mov.w	#var1, R5	; Copy var1 as address, store to R5
						; Notice that this does copy only
						; the address and NOT the content.

			mov.w	@R5, var4	; Using R5 as an address, copy its
						; contents to var6
						; Not much use by itself other than
						; adding an extra step for copying

						; But if combined with movement....
			mov.w	#var1, R4
						; R4+ increments the address value
						; stored at R4. As to how much it
						; increments is dictated by .w or .b
						; in the mov opcode, .w increments it
						; by 2-bytes, while .b increments it
						; by a byte address. Pointing is
						; as always, from the low-byte to
						; high-byte

			mov.w	@R4+, R5	; Copies 1010h to R5
			mov.w	@R4+, R6	; Copies DECAh to R6

			mov.b	@R4+, R7	; Copies low-byte of DECAh to R7
			mov.b	@R4+, R8	; Points to high-byte of DECAh then
						; copies it to R8


			jmp	main
			NOP



;-------------------------------------------------------------------------------
; Data Memory
;-------------------------------------------------------------------------------
			.data			; Notice that this is similar to the
						; init section in C programs, where
						; variables are initizalied and
						; ready to be used by the program
			.retain

var1:		.short	1010h
var2:		.short	0DECAh
var3:		.space	2			; create var5 but set all its content
						; to 0 (2-bytes), hence the 'space'
						; This makes sure that when something
						; is stored into var5, the stored data
						; is the data alone even if it is just
						; a low-byte, ex: 0041h
var4:		.space	2
                                            

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
            
