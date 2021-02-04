/*
 * © Copyright 2021 Josef Schönberger
 *
 * This file is part of BIOS Boot.
 *
 * BIOS Boot is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BIOS Boot is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Debian-Setup.  If not, see <http://www.gnu.org/licenses/>.
 */

.intel_syntax noprefix

.section .boot
.code16
	xor ax, ax
	mov es, ax
	lea bx, .text
	mov ax, 0x0201 // Load (ah) one (al) sement
	mov cx, 0x0002 // From cylinder 0, sector 2
	mov dh, 0x00 // From head 0
	// keep dl
	int 0x13
	jc halt

	// set video mode to 80x25 16-color text mode
	mov ax, 0x0003
	int 0x10

	mov bx, 0x0000
	lea si, [msg]
	mov ah, 0x0e // Output character
loop:
	lodsb // mov al, BYTE PTR [si]; inc si
	test al, al
	jz halt
	int 0x10
	jmp loop
halt:
	// disable interrupts before sleeping to ignore e.g. keypresses
	cli
	hlt

.data
msg:
	.asciz "Successfully booted\r\nHello World!\r\n"
