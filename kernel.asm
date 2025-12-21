bits 16

kernel_start:

mov si, str_kernel
call cursor_break;
call print_string

jmp $

%include "video.asm"

str_kernel: db 'Hello World from Kernel!$'

times 512 - ($-$$) db 0