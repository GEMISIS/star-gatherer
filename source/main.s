.include "defs.s"
.include "utils/init.s"
.include "utils/audio.s"

.code

;;; ----------------------------------------------------------------------------
;;; Reset handler

.proc reset
    ; Setup the stack pointer.
	ldx #$ff
	txs

    ; Setup the NES systems.
    jsr initialize

    ; Add our audio's period and volume to $200 and $201 to play later.
    lda #$01
    sta $200

    lda #$bf
    sta $201

	; Play audio forever.
    jsr playAudio

forever:
	jmp forever
.endproc

;;; ----------------------------------------------------------------------------
;;; NMI (vertical blank) handler

.proc nmi
    ; inc $200
	rti
.endproc

;;; ----------------------------------------------------------------------------
;;; IRQ handler

.proc irq
	rti
.endproc

;;; ----------------------------------------------------------------------------
;;; Vector table

.segment "VECTOR"
.addr nmi
.addr reset
.addr irq

;;; ----------------------------------------------------------------------------
;;; Empty CHR data, for now

.segment "CHR0a"
.segment "CHR0b"
