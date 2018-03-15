snake:
  mov ax,0x0013           ;Set Graphic mode and 320x200 pixels and 40x25 = 256 colors
  int 0x10                ;Call bios interrupt to set the graphic mode
  jmp game_loop           ;Jump to the loop of the game.


game_loop:
  call print             ;Procedure to clean the screen.




                          ;int 0x10 Call the bios
                          ;ah = Change the pixel color
                          ;al = Pixel color
                          ;cx = column
                          ;dx = row
print:
  mov cx,0x0000           ;Number of column (begining)
  mov dx,0x0000           ;Number or row    (begining)
  jmp second_print        ;Jump to for algorithm print

second_print:
  mov ah,0x0c             ;Choose to change the color of a pixel
  mov al,cl               ;Set the color of the pixel
  int 0x10                ;Call the bios to print the pixel
  inc dx                  ;Increase by one ('1') the row value
  cmp dx,200              ;Compare if we finish the row
  jne second_print        ;If we dont finish the row, iterate.

  ;If we doesn't finish the row,increase the column
  mov dx,0x0000           ;Row set to cero
  inc cx                  ;Increase the column value
  cmp cx,256              ;Compare if we finish the columns
  jne second_print        ;If not, just jump
  
  
