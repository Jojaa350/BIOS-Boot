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
 * along with BIOS Boot. If not, see <http://www.gnu.org/licenses/>.
 */

SECTIONS {
	. = 0x7c00;
	.text : {
		*(.boot)
		. = 0x1BE;
		FILL(0) /* No entry in MBR */
		. = 0x1FE;
		SHORT(0xAA55)
		*(.text)
		*(.data)
		FILL(DEAD)
		. = ALIGN(512);
	}
}
