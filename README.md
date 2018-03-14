# Snake

Pasos para crear el binario con el booteable:

1)Compilar y generar el binario usando nasm (bootloader.asm es el codigo ensamblador)
	nasm -f bin bootloader.asm -p menu.asm -p snake.asm -p lose.asm -p win.asm -o boot.bin

2)Para probar en qemu
	qemu-system-x86_64 boot.bin

3)Para cargar el binario en un pendrive (USB). Usar sudo.
	3.1)Ver las unidades y darle formato a la unidad.
		lsblk  = Para ver las unidades montadas y no montadas.
		mkfs.vfat -I /dev/sdb
	3.2)Bootear el archivo binario en la unidad usando el comando dd.
		dd if=bootloader.bin of/dev/sdb
