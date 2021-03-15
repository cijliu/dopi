include ../../config.mk
.PHONY :all
LIBS_OUT_DIR = output
LIBS_DIR =


ifeq ($(CONFIG_APP_LIB_RTSP), y)
LIBS_DIR += rtsp
rtsp:
ifneq (librtsp, $(wildcard librtsp))
	@git clone $(CONFIG_APP_LIB_RTSP_URL) librtsp
endif
	@cd librtsp && $(MAKE) CROSS_COMPILE=$(CROSS_COMPILER) all
endif

all:$(LIBS_DIR)
	@mkdir -p $(LIBS_OUT_DIR)
ifeq ($(CONFIG_APP_LIB_RTSP), y)
	@cp librtsp/src/librtsp.a $(LIBS_OUT_DIR)/
endif