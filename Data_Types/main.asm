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

;-------------------------------------------------------------------------------
; Data Memory
;-------------------------------------------------------------------------------
			.data
			.retain

num1:		.float	122.25					; .FLOAT accepts x range of values.
num2:		.float -122.25					; 1.4 × 10^(-45) to 3.4028235×10^38
num3:		.float	-0.025					; IEEE 754 format 32-bits, 4-bytes

num5:		.int	122						; .INT can only accept integers, no
											; automatic rounding to integer only.
											; Numbers are represented in their
											; direct Hex form or binary.

num6:		.short	122						; .INT and .SHORT uses 2-bytes
num7:		.byte	122						; Use only .byte if sure that number
											; is does not go over a byte
num8:		.byte	300						; Out-of-range (>255) will be
											; truncated to a byte.
											; Number-256 = new number, truncated

str:		.string	"Hello"					; Stores characters per bytes, ASCII
											; Stored in the consecutive order,
											; first letter first.

chr0:		.char	'A'						; Characters are alson in ASCII
chr1:		.short	'A'						; Since ASCII, each char is a byte
chr2:		.string	'A'						; .SHORT uses an extra byte. Other
chr3:		.byte	'A'						; do not, best use .char or .byte

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
            
