#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := bootctrl.gs101.recovery
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/lib64
LOCAL_SRC_FILES := bootctrl.gs101.recovery.so
LOCAL_STRIP_MODULE := false
include $(BUILD_PREBUILT)