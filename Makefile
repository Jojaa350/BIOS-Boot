# © Copyright 2021 Josef Schönberger
#
# This file is part of BIOS Boot.
#
# BIOS Boot is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# BIOS Boot is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with BIOS Boot. If not, see <http://www.gnu.org/licenses/>.

CC=gcc
LD=ld
FLAGS=-g -O0
WFLAGS=-Wall -Wextra -Wpedantic

.PHONY: image.img

image.img: boot_sec.out link.ld
	$(LD) --oformat=binary -T link.ld -o $@ boot_sec.out

boot_sec.out: boot_sec.S
	$(CC) $(FLAGS) $(WFLAGS) -c -o $@ $^

.PHONY: run
run: image.img
	qemu-system-x86_64 -drive file=image.img,format=raw

.PHONY: clean
clean:
	rm -f boot_sec.out image.img 
