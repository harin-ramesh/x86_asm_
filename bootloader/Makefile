ASM=nasm

SRC_DIR=src
BUILD_DIR=build


# $(BUILD_DIR)/main.img: $(BUILD_DIR)/main.bin
# 	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main.img
#	truncate -s 1140k $(BUILD_DIR)/main.img

# $(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
#	$(ASM) $(SRC_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.bin

floppy: $(BUILD_DIR)/main.img
#$(BUILD_DIR)/main.img: $(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/kernel.bin   
$(BUILD_DIR)/main.img: bootloader kernel
	dd if=/dev/zero of=$(BUILD_DIR)/main.img bs=512 count=2880
	mkfs.fat -F 12 -n "MyOS" $(BUILD_DIR)/main.img
	dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/main.img conv=notrunc
	mcopy -i $(BUILD_DIR)/main.img $(BUILD_DIR)/kernel.bin "::kernel.bin"

bootloader: $(BUILD_DIR)/bootloader.bin
$(BUILD_DIR)/bootloader.bin:
	$(ASM) $(SRC_DIR)/bootloader/boot.asm -f bin -o $@

kernel: $(BUILD_DIR)/kernel.bin
$(BUILD_DIR)/kernel.bin:
	$(ASM) $(SRC_DIR)/kernel/main.asm -f bin -o $@

clean:
	rm -r build/*
