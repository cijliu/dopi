export TOPDIR := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
include config.mk


MENUCONFIG_PATH=tool/menuconfig
KCONFIG_PATH=Kconfig
AR=${CROSS_COMPILER}ar
RANLIB=${CROSS_COMPILER}ranlib
CROSS_COMPILER_VERSION = $(shell expr `$(CROSS_COMPILER)gcc -dumpversion | cut -f1 -d.` \>= 4)
.PHONY : bsp app

bsp:
ifeq ($(CROSS_COMPILER_VERSION),1)
	@rm ./bsp/images -rf
	@mkdir -p ./bsp/images
	@cd bsp;make all
else
	@echo -e "\033[31mNot Found $(CROSS_COMPILER)gcc\033[0m"
endif

bsp-uboot:
ifeq ($(CROSS_COMPILER_VERSION),1)
	@rm ./bsp/images/u-boot-*.bin -rf
	@mkdir -p ./bsp/images
	@cd bsp;make uboot
else
	@echo -e "\033[31mNot Found $(CROSS_COMPILER)gcc\033[0m"
endif

bsp-linux:
ifeq ($(CROSS_COMPILER_VERSION),1)
	@rm ./bsp/images/uImage -rf
	@mkdir -p ./bsp/images
	@cd bsp;make linux
else
	@echo -e "\033[31mNot Found $(CROSS_COMPILER)gcc\033[0m"
endif

bsp-rootfs:
ifeq ($(CROSS_COMPILER_VERSION),1)
	@rm ./bsp/images/rootfs* -rf
	@mkdir -p ./bsp/images
	@cd bsp;make rootfs
else
	@echo -e "\033[31mNot Found $(CROSS_COMPILER)gcc\033[0m"
endif

app:
	@cd app && $(MAKE) all

menuconfig:$(MENUCONFIG_PATH)/mconf
	$< $(KCONFIG_PATH)