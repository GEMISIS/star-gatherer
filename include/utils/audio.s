; Plays an audio tone with a chosen period and volume on Pulse 1.
; Input: $200: ppvv -> Period and Volume, 1 byte each.
; Output: None
playAudio:
	lda #$01		; enable pulse 1
	sta APUSTATUS

	; Store the period from register X into $4002
	lda $200		; period
	ldx #$02
	sta PULSE1,X

	; Store a value of 2 into $4003
	lda #$02
	ldx #$03
	sta PULSE1,X

	; Store the volume from register Y into $4000
	lda $201		; volume
	sta PULSE1

	; Return
    rts 
	