bits 16
org 0x7c00

mov si, str_welcome
call print_string

call load_next_sector

mov ax, 0x7e00
mov cs, ax
mov ds, ax
mov es, ax
mov ss, ax

jmp 0x7e00:0x0000

%include "video.asm"

reset_floppy:
	mov ah, 0x00
	mov dl, 0x00
	int 0x13
	jc .err
	jmp .end
.err:
	mov si, str_err_flp_rst
	call print_string
.end:
	ret

load_next_sector:
	call reset_floppy
	mov ax, 0x7e00
	mov es, ax	 ; read to memory location
	mov ah, 0x02 ; read disk sectors
	mov al, 0x01 ; amount sectors to read
	mov ch, 0x00 ; track/cylinder number
	mov cl, 0x02 ; sector number
	mov dh, 0x00 ; head number
	mov dl, 0x00 ; drive number (floppy a)
	mov bx, 0x0000 ; no offset
	int 0x13
	jc .err
	jmp .end
.err:
	mov si, str_err_flp_ld_nxt
	call print_string
	call load_next_sector
.end:
	ret


str_welcome: 			db 'Hello World from Bootloader!$'
str_err_flp_rst:		db 'Error: Could not reset drive A$'
str_err_flp_ld_nxt:		db 'Error: Could not load next sector$'

times 510 - ($-$$) db 0

dw 0xaa55