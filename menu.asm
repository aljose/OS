start:									;Label where the code starts

	xor ax,ax							;Set the ax value to zero
	mov ds,ax							;Set the ds value to zero
	mov es,ax							;Set the es value to zero
	mov bx,0x8000

	mov ax,0x13						;Clear the screen with the bios.
	int 0x10							;Call the bios to clear the screen.

	;Set the position of the cursor.
	mov ah,0x02						;Set the value for change to cursor pos
	mov bh,0x00						;Set the value of the page.
	mov dh,0x06						;Set the value of the row (Y)
	mov dl,0x09						;Set the value of the column (X)
	int 0x10							;Call the Bios to print on the screen.

	mov si,snake_OS_title	;Print the first line of the screen
	call print_with_color	;Call a procedure to print.

	;Set the position of the cursor.
	mov ah,0x02						;Set the value for change to cursor pos
	mov bh,0x00						;Set the value of the page.
	mov dh,0x08						;Set the value of the row (Y)
	mov dl,0x11						;Set the value of the column (X)
	int 0x10							;Call the Bios to print on the screen.

	mov si,level1					;Print the second line on the screen
	call print_monocolor	;Call a procedure to print.

	;Set the position of the cursor.
	mov ah,0x02						;Set the value for change to cursor pos
	mov bh,0x00						;Set the value of the page.
	mov dh,0x0B						;Set the value of the row (Y)
	mov dl,0x13						;Set the value of the column (X)
	int 0x10							;Call the Bios to print on the screen.

	mov si,level2					;Print the third line on the screen
	call print_monocolor	;Call a procedure to print.

	;Set the position of the cursor.
	mov ah,0x02						;Set the value for change to cursor pos
	mov bh,0x00						;Set the value of the page.
	mov dh,0x0E						;Set the value of the row (Y)
	mov dl,0x15						;Set the value of the column (X)
	int 0x10							;Call the Bios to print on the screen.

	mov si,level3					;Print a fourth line on the screen
	call print_monocolor	;Call a procedure to print.

	;Set the position of the cursor.
	mov ah,0x02						;Set the value for change to cursor pos
	mov bh,0x00						;Set the value of the page.
	mov dh,0x15						;Set the value of the row (Y)
	mov dl,0x09						;Set the value of the column (X)
	int 0x10							;Call the Bios to print on the screen.

	mov si,select					;Print a fourth line on the screen
	call print_monocolor	;Call a procedure to print.

repeat:
	mov ah,00h             	; get keyboard input
	int 16h                	; hold for input
	cmp al,0x31							;Number 1
	je level_1
	cmp al,0x32							;Number 2
	je level_1
	cmp al,0x33							;Number 3
	je level_1
	jmp repeat

	;Define the strings in memory
	snake_OS_title db 'Snake_OS_1.0',0
	level1 db '1) Level 1',0
	level2 db '2) Level 2',0
	level3 db '3) Level 3',0
	select db 'Select level: ',0

print_with_color:
	mov bl,1							;Initial value of the color
	mov ah, 0x0E					;Move the character to print

.repeat_next_char:
	lodsb									;Copy the character to print on screen
	cmp al, 0							;Compare if its zero
	je .done_print				;If the comparison is done, jump, else continue
	add bl,6							;Increase the value of the color.
	int 0x10							;Call the Bios to print on the screen
	jmp .repeat_next_char	;Repeat with the next char

.done_print:
	ret

print_monocolor:
	mov bl,50							;Initial value of the color
	mov ah, 0x0E					;Move the character to print

.repeat_next_char:
	lodsb									;Copy the character to print on screen
	cmp al, 0							;Compare if its zero
	je .done_print				;If the comparison is done, jump, else continue
	int 0x10							;Call the Bios to print on the screen
	jmp .repeat_next_char	;Repeat with the next char

.done_print:
	ret

level_1:
	mov ah, 0x02           ; Load the second stage to memory
	mov al, 1              ; The numbers of sectors to read into memory
	mov dl, 0x80           ; Sector readed from fixed/usb disk
	mov ch, 0              ; The cylinder number
	mov dh, 0              ; The head number
	mov cl, 2              ; The sector number
	mov bx, snake				   ; To load into es
	int 0x13               ; disk I/O interrupt

	jmp snake     		     ; jump to second stage
