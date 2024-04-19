			* = $c000
start:
            sei

            lda #$7f
            sta $dc0d
            and $d011
            sta $d011
            sta $dd0d

            lda #60             // set rasterline where interrupt shall occur
            sta $d012

            lda #<irq           // set interrupt vectors to the second interrupt service routine at irq2
            sta $0314
            lda #>irq
            sta $0315

            lda #1              // enable raster interrupt signals from vic
            sta $d01a

            cli                  // clear interrupt flag, allowing the CPU to respond to interrupt requests
            rts

irq:		
            lda #2              // red
			sta $d020            
            sta $d021

			ldx #$ff            // pause
pause1:		
            dex
            nop
            nop
            nop
            nop
			bne pause1

            lda #1            // white
			sta $d020            
            sta $d021
            
			ldx #$ff            // pause
pause2:		
            dex
            nop
            nop
            nop
            nop
			bne pause2

            lda #5            // green
			sta $d020            
            sta $d021
            
			ldx #$ff            // pause
pause3:		
            dex
            nop
            nop
            nop
            nop
			bne pause3

            lda #0            // black
			sta $d020            
            sta $d021

            lda #$01
			sta $d019            // acknowledge the interrupt by clearing the vic's interrupt flag
			jmp $ea31
