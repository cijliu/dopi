include ../config.mk
.PHONY : uboot linux rootfs
all: uboot linux rootfs

ifeq ($(CONFIG_HI3516EV200), y)
SOC = hi3516ev200
UBOOT_BIN = reg_info_ev200.bin
UBOOT_CONFIG = hi3516ev200_config
LINUX_CONFIG = hi3516ev200_config
endif

ifeq ($(CONFIG_GIT), y)
uboot:
ifeq ($(CONFIG_GIT_UBOOT), y)
ifneq (uboot, $(wildcard uboot))
	@git clone $(CONFIG_UBOOT_GIT_URL) uboot
ifeq ($(CONFIG_V0_99), y)
	@cd uboot && git checkout -b 0.99 0.99
endif
endif


ifeq ($(CONFIG_FLASH_NAND), y)
	@echo -e "\033[31mUboot select Nand flash\033[0m"
	@cd uboot && echo "#define DOPI_SPI_NAND ">./include/configs/dopi.h
	@cd uboot && make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILER)  $(UBOOT_CONFIG)
	@cd uboot && make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILER)

ifneq ($(UBOOT_BIN), $(wildcard $(UBOOT_BIN)))
	@cd uboot && cp reg_info.bin .reg
else
	@cd uboot && cp $(UBOOT_BIN) .reg
endif

	@cd uboot && make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILER) u-boot-z.bin
	@cd uboot && cp u-boot-$(SOC).bin ../images/u-boot-$(SOC)-nand.bin
endif

ifeq ($(CONFIG_FLASH_NOR), y)
	@echo -e "\033[31mUboot select Nor flash\033[0m"
	@cd uboot && echo "#define DOPI_SPI_NOR ">./include/configs/dopi.h
	@cd uboot && make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILER)  $(UBOOT_CONFIG)
	@cd uboot && make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILER)
	@cd uboot && cp reg_info_ev200.bin .reg
	@cd uboot && make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILER) u-boot-z.bin
	@cd uboot && cp u-boot-$(SOC).bin ../images/u-boot-$(SOC)-nor.bin
endif

ifeq ($(CONFIG_FLASH_EMMC), y)
	@echo -e "\033[31mUboot select emmc flash\033[0m"
	@cd uboot && ./build.sh emmc
endif

endif
endif

linux:
ifeq ($(CONFIG_GIT_LINUX), y)
ifneq (linux, $(wildcard linux))
	@git clone $(CONFIG_LINUX_GIT_URL) linux
ifeq ($(CONFIG_V0_99), y)
	@cd linux && git checkout -b 0.99 0.99
endif
endif
	@echo -e "\033[31mBuild Linux\033[0m"
	@cd linux && make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILER) uImage -j2
	@cd linux && cp ./arch/arm/boot/uImage ../images/uImage
endif

rootfs:
ifeq ($(CONFIG_GIT_ROOTFS), y)
ifneq (rootfs, $(wildcard rootfs))
	@git clone $(CONFIG_ROOTFS_GIT_URL) rootfs
ifeq ($(CONFIG_V0_99), y)
	@cd rootfs && git checkout -b 0.99 0.99
endif
endif
	@echo -e "\033[31mBuild rootfs\033[0m"
ifeq ($(CONFIG_ROOTFS_YAFFS), y)
	@cd rootfs && ./mkyaffs2image100 ./rootfs_uclibc rootfs.img 1 2
	@cd rootfs && cp rootfs.img ../images/rootfs.img
endif
ifeq ($(CONFIG_ROOTFS_JFFS2), y)
	@cd rootfs && ./mkfs.jffs2 -d ./rootfs_uclibc -l -e 0x10000 -o rootfs.jffs2
	@cd rootfs && cp rootfs.jffs2 ../images/rootfs.jffs2
endif
endif
