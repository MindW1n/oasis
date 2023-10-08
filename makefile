ASM=nasm
SRC_DIR=Src
BUILD_DIR=Build

.PHONY: all floppy_image kernel bootloader image clean always

#
#	Floppy image
#
floppy_image: $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main_floppy.img: bootloader kernel image
	dd if=/dev/zero of=$(BUILD_DIR)/main_floppy.img bs=1024 count=1440
	dd if=$(BUILD_DIR)/image.bin of=$(BUILD_DIR)/main_floppy.img seek=0 count=1140 conv=notrunc

#
#	Image
#
image: $(BUILD_DIR)/image.bin 

$(BUILD_DIR)/image.bin: always bootloader kernel
	cat $(BUILD_DIR)/boot.bin $(BUILD_DIR)/kernel.bin > $(BUILD_DIR)/image.bin

#
#	Bootloader
#
bootloader: $(BUILD_DIR)/boot.bin

$(BUILD_DIR)/boot.bin: always
	$(ASM) $(SRC_DIR)/Boot/main.asm -f bin -o $(BUILD_DIR)/boot.bin

#
#	Kernel
#
kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: always
	$(ASM) $(SRC_DIR)/Kernel/main.asm -f bin -o $(BUILD_DIR)/kernel.bin

#
#	Always
#
always:
	mkdir -p $(BUILD_DIR)

#
#	Clean
#
clean:
	rm -rf $(BUILD_DIR)/*

#
#	ATA
#
ata:
	mkdir -p $(BUILD_DIR)/ATA
	qemu-img create -f raw $(BUILD_DIR)/ATA/hdd0.img 1M
	qemu-img create -f raw $(BUILD_DIR)/ATA/hdd1.img 1M
	qemu-img create -f raw $(BUILD_DIR)/ATA/hdd2.img 1M
	qemu-img create -f raw $(BUILD_DIR)/ATA/hdd3.img 1M