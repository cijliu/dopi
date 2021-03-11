export TOPDIR := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
include config.mk


MENUCONFIG_PATH=tool/menuconfig
KCONFIG_PATH=Kconfig
AR=${CROSS_COMPILER}ar 
RANLIB=${CROSS_COMPILER}ranlib

.PHONY : bsp

bsp:
	@echo $(CROSS_COMPILER)
	@rm ./bsp/images -rf
	@mkdir -p ./bsp/images
	@cd bsp;make all
	
bsp-uboot:
	@rm ./bsp/images/u-boot-hi3516ev200*.bin -rf
	@mkdir -p ./bsp/images
	@cd bsp;make uboot

bsp-linux:
	@rm ./bsp/images/uImage -rf
	@mkdir -p ./bsp/images
	@cd bsp;make linux

bsp-rootfs:
	@rm ./bsp/images/rootfs* -rf
	@mkdir -p ./bsp/images
	@cd bsp;make rootfs

menuconfig:$(MENUCONFIG_PATH)/mconf
	$< $(KCONFIG_PATH)