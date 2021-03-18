# Hisilicon Hi35xx sample Makefile

include ../Makefile.param

SRCS := $(wildcard *.c)

TARGET := $(SRCS:%.c=%)

CFLAGS += -L$(REL_LIB) -lsecurec -Wl,-rpath=/usr/lib

SRCS += $(wildcard $(PWD)/adp/*.c)

TARGET_PATH := $(PWD)

# compile linux or HuaweiLite
include $(PWD)/../$(ARM_ARCH)_$(OSTYPE).mak