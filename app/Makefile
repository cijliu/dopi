include ../config.mk
.PHONY :all
CC = @$(CROSS_COMPILER)gcc
STRIP = @$(CROSS_COMPILER)strip
PWD =$(shell pwd)
all:lib app
APP_NAME = $(shell echo $(CONFIG_APP_NAME))
LIB = -lpthread -lrt
ifeq ($(CONFIG_APP_LIB_RTSP), y)
APP_LIBS_INC += -I$(PWD)/libraries/librtsp/

endif
CFLAGS += $(APP_LIBS_INC)
ifeq ($(CONFIG_APP_TEST_RTSP), y)
LIB += -L$(PWD)/libraries/output/ -lrtsp
SRC = $(PWD)/src/rtsp-demo.c
endif
ifeq ($(CONFIG_APP_TEST_FFMPEG), y)
INCLUDE_PATH = $(PWD)/libraries/libav/build/include
INCLUDE = -I$(INCLUDE_PATH)/libavutil/ -I$(INCLUDE_PATH)/libavdevice/ \
			-I$(INCLUDE_PATH)/libavcodec/ -I$(INCLUDE_PATH)/libswresample/ \
			-I$(INCLUDE_PATH)/libavfilter/ -I$(INCLUDE_PATH)/libavformat/ \
			-I$(INCLUDE_PATH)/libswscale/ -I$(INCLUDE_PATH)/
CFLAGS += $(INCLUDE)
LIB += -L$(PWD)/libraries/output/ -lavcodec -lavdevice -lavfilter -lavformat -lavresample -lavutil -lswscale -lmpp -ldl -lm
SRC = $(PWD)/src/ffmpeg-demo.c
endif
lib:
ifeq ($(CONFIG_APP_LIB), y)
	@cd libraries && $(MAKE) all
endif

app:
	@rm -rf build
	@mkdir -p build
	$(CC) $(CFLAGS)  -o $(APP_NAME) $(SRC) $(LIB)
	$(STRIP) $(APP_NAME)
	@cp $(APP_NAME) build/
ifeq ($(CONFIG_APP_TEST_RTSP), y)
	@cp $(PWD)/libraries/librtsp/example/test.h264 build/
endif



