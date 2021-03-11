-include $(TOPDIR)/.config
ifeq ($(CONFIG_HI3516EV200), y)
CROSS_COMPILER=arm-himix100-linux-
endif
