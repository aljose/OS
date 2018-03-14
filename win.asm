win:				;Label where the code starts.

	xor ax,ax		;Set ax register to zero.
	mov ds,ax		;Set ds register to zero.
	mov es,ax		;Set es register to zero.
	mov bx,0x8000

	mov ax,0x13		;Clears the screen
	int 0x10		;Call the bios video interrupt

	mov ah,05		;Clear the screen with big font
	int 0x10		;Call the bios to interrupt the display

	;Set the position of the cursor to print in the screen.
	mov ah,0x02	;Set value for change to cursor position
	mov bh,0x00		;Set the value of the page
	mov dh,0x06		;Set the row (Y)
	mov dl,0x09		;Set the colum (X)
	int 0x10		;Call the bios to print the screen
	;End of the cursor

	mov si, win_message	;Beginning of the intoduction String
	call print_mono_win	;Procedure to print the string
	
	mov ah,0h             	; get keyboard input
	int 16h               	; hold for input
	jmp start	      	;Jump to the menu when a key is pressed

;Strings
win_message db 'You W.I.N :)',0


print_mono_win:
	mov bl,4		;Initial value of the color
	mov ah, 0x0E		;Move the character to print

.repeat_next_char:
	lodsb			;Copy the character to print on screen
	cmp al, 0		;Compare if its zero
	je .done_print		;If the comparison is done, jump, else continue
	int 0x10		;Call the Bios to print on the screen
	jmp .repeat_next_char	;Repeat with the next char

.done_print:
	ret


