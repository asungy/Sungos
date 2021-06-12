all: binary

binary:
	mkdir -p ./bin && \
	nasm -f bin ./source/boot_sector.asm -o ./bin/boot_sector.bin

image: binary
	dd if=/dev/zero of=./bin/sungos.img bs=1024 count=1440 \
		&& dd if=./bin/boot_sector.bin of=./bin/sungos.img seek=0 count=1 conv=notrunc

clean:
	rm -fr ./bin

.PHONY: all clean
