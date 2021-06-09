all: boot_sector

boot_sector:
	mkdir -p ./bin && \
	nasm -fbin ./boot_sector.asm -o ./bin/boot_sector.bin

clean:
	rm -fr ./bin

.PHONY: all clean
