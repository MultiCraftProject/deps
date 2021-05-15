APP_PLATFORM := ${APP_PLATFORM}
APP_ABI := ${TARGET_ABI}
APP_STL := ${APP_STL}
NDK_TOOLCHAIN_VERSION := ${COMPILER_VERSION}
APP_MODULES := Irrlicht

APP_CPPFLAGS := ${TARGET_CPPFLAGS_ADDON}
APP_CFLAGS   := $(APP_CPPFLAGS) -DPNG_ARM_NEON_OPT=0
APP_CPPFLAGS += -std=gnu++17
APP_CXXFLAGS := $(APP_CPPFLAGS)
