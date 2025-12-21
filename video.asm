print_string:
.loop:
	lodsb
	cmp al, 0x24
	je .end
	call print_char
	jmp .loop 
.end:
	ret

print_char:
	mov ah, 0x0e
	mov bh, 0x00
	mov cx, 0x0001
	int 0x10
	ret

cursor_break:
	mov ah, 0x03
	int 0x10
	mov bh, 0x00
	mov dl, 0x00
	inc dh
	mov ah, 0x02
	int 0x10
	ret