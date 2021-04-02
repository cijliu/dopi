include ../../config.mk
.PHONY :all
LIBS_OUT_DIR = output
LIBS_DIR =
LIBAV_INDEV = 

ifeq ($(CONFIG_APP_LIB_RTSP), y)
LIBS_DIR += rtsp
rtsp:
ifneq (librtsp, $(wildcard librtsp))
	@git clone $(CONFIG_APP_LIB_RTSP_URL) librtsp
endif
	@cd librtsp && $(MAKE) CROSS_COMPILE=$(CROSS_COMPILER) all
endif

ifeq ($(CONFIG_APP_LIB_LIBAV), y)
LIBS_DIR += ffmpeg 
ifeq ($(CONFIG_LIBAV_DEVICES_HI3516EV200), y)
LIBAV_INDEV += hi3516ev200
endif
ifeq ($(CONFIG_LIBAV_DEVICES_V4L2), y)
LIBAV_INDEV += v4l2
endif
ffmpeg:
ifneq (libav, $(wildcard libav))
	@git clone -b dopi $(CONFIG_APP_LIB_LIBAV_URL) libav 
endif
	@cd libav && git pull origin dopi 
	@cd libav && ./build.sh -indev $(LIBAV_INDEV) -cross_orefix=$(CROSS_COMPILER)
	@cd libav && $(MAKE) install -j2
endif


all:$(LIBS_DIR)
	@mkdir -p $(LIBS_OUT_DIR)
ifeq ($(CONFIG_APP_LIB_RTSP), y)
	@cp librtsp/src/librtsp.a $(LIBS_OUT_DIR)/
endif
ifeq ($(CONFIG_APP_LIB_LIBAV), y)
	@cp libav/build/lib/*.a $(LIBS_OUT_DIR)/
endif
