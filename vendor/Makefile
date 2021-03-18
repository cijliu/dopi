include ../config.mk
AR=${CROSS_COMPILER}ar
RANLIB=${CROSS_COMPILER}ranlib
VENDOR =
OUTPUT= output
HISILICON_SOC =
.PHONY :vendor-deps vendor-hisilicon

ifeq ($(CONFIG_HI3516EV200_MPP), y)
HISILICON_SOC += hisilicon-hi3516ev200
HI3516EV200_MPP_PATH = hisilicon/hi3516ev200/mpp
LIBMPP = libmpp.a
LIBMPP_OBJS += $(HI3516EV200_MPP_PATH)/lib/output/*.o
LIBMPP_OBJS_FULL = $(wildcard  $(LIBMPP_OBJS))
hisilicon-hi3516ev200:
	@cd $(HI3516EV200_MPP_PATH)/sample/vio && make clean > /dev/null 2>&1 && make -j2 > /dev/null 2>&1
	@cd $(HI3516EV200_MPP_PATH)/lib && sh output.sh
	@$(AR) cru $(LIBMPP) $(LIBMPP_OBJS_FULL) && $(RANLIB)  $(LIBMPP)
	@mv $(LIBMPP) $(OUTPUT)/
endif

ifeq ($(CONFIG_HISILICON), y)
VENDOR += vendor-hisilicon

vendor-hisilicon:$(HISILICON_SOC)

endif

vendor-deps:$(VENDOR)
	@echo -e "\033[31mHisilicon MPP library build in $(PWD)/$(OUTPUT)\033[0m"