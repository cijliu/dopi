include ../config.mk
.PHONY :all
CC = @$(CROSS_COMPILER)gcc
PWD =$(shell pwd)
all:lib app
APP_NAME = $(shell echo $(CONFIG_APP_NAME))
LIB = -lpthread -lrt
ifeq ($(CONFIG_APP_LIB_RTSP), y)
APP_LIBS_INC += -I$(PWD)/libraries/librtsp/
LIB += -L$(PWD)/libraries/output/ -lrtsp
endif
CFLAGS += $(APP_LIBS_INC)

SRC = \
	$(PWD)/src/main.c
lib:
ifeq ($(CONFIG_APP_LIB), y)
	@cd libraries && $(MAKE) all
endif

app:lib
	@rm -rf build
	@mkdir -p build
	$(CC) $(CFLAGS)  -o $(APP_NAME) $(SRC) $(LIB)
	@cp $(APP_NAME) build/
ifeq ($(CONFIG_APP_LIB_RTSP), y)
	@cp $(PWD)/libraries/librtsp/example/test.h264 build/
endif



