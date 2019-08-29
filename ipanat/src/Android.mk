BOARD_PLATFORM_LIST := msm8909
BOARD_PLATFORM_LIST += msm8916
BOARD_PLATFORM_LIST += msm8917
TARGET_DISABLE_IPANAT := false

ifeq ($(TARGET_USES_QMAA),true)
ifneq ($(TARGET_USES_QMAA_OVERRIDE_DATA),true)
	TARGET_DISABLE_IPANAT := true
endif #TARGET_USES_QMAA_OVERRIDE_DATA
endif #TARGET_USES_QMAA

ifneq ($(TARGET_DISABLE_IPANAT),true)
ifneq ($(call is-board-platform-in-list,$(BOARD_PLATFORM_LIST)),true)
ifneq (,$(filter $(QCOM_BOARD_PLATFORMS),$(TARGET_BOARD_PLATFORM)))
ifneq (, $(filter aarch64 arm arm64, $(TARGET_ARCH)))

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../inc

LOCAL_HEADER_LIBRARIES := generated_kernel_headers

LOCAL_SRC_FILES := ipa_nat_drv.c \
                   ipa_nat_drvi.c

LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/../inc
LOCAL_VENDOR_MODULE := true
LOCAL_MODULE_PATH_64 := $(TARGET_OUT_VENDOR)/lib64
LOCAL_MODULE_PATH_32 := $(TARGET_OUT_VENDOR)/lib
ifneq (,$(filter eng, $(TARGET_BUILD_VARIANT)))
LOCAL_CFLAGS := -DDEBUG
endif
LOCAL_CFLAGS += -Wall -Werror
LOCAL_CFLAGS += -DFEATURE_IPA_ANDROID
LOCAL_MODULE := libipanat
LOCAL_MODULE_TAGS := optional
LOCAL_PRELINK_MODULE := false
LOCAL_CLANG := true
include $(BUILD_SHARED_LIBRARY)

endif # $(TARGET_ARCH)
endif
endif
endif
