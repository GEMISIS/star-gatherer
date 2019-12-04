; Initialize the NES systems. Specifically disable interrupts, setup the PPU, and clear the memory to 0.
; Input: None
; Output: None
initialize:
	sei			; Disable interrupts
	cld			; Clear decimal mode
	ldx #$00
	stx PPUCTRL		; PPUCTRL = 0
	stx PPUMASK		; PPUMASK = 0
	stx APUSTATUS	; APUSTATUS = 0

	;; PPU warmup, wait two frames, plus a third later.
	;; http://forums.nesdev.com/viewtopic.php?f=2&t=3958
:	bit PPUSTATUS
	bpl :-
:	bit PPUSTATUS
	bpl :-

	;; Zero ram.
    jsr clearRam

	;; Final wait for PPU warmup.
:	bit PPUSTATUS
	bpl :-

    ;; Return
    rts 

; Clear the ram to the value stored in the X register.
; Input: x -> value to clear to
; Output: None
clearRam:
	txa
	; Clear out the zero page.
:	sta $000, x
	; Do not clear the memory from $100-$1ff, as that
	; is where the stack is stored in memory and we need
	; that to return right now.
	; sta $100, x
	; Clear out the rest of the memory.
	sta $200, x
	sta $300, x
	sta $400, x
	sta $500, x
	sta $600, x
	sta $700, x
	inx
	bne :-
    rts
