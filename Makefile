all: boot_sector

boot_sector:
	mkdir -p ./bin && \
	nasm -f bin ./source/boot_sector.asm -o ./bin/boot_sector.bin

clean:
	rm -fr ./bin

.PHONY: all clean
