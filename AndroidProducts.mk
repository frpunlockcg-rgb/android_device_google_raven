#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/omni_raven.mk \
    $(LOCAL_DIR)/twrp_raven.mk

COMMON_LUNCH_CHOICES := \
    omni_raven-ap2a-user \
    omni_raven-ap2a-userdebug \
    omni_raven-ap2a-eng \
    twrp_raven-ap2a-eng \
    twrp_raven-ap2a-userdebug
