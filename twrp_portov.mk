# 
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
# $(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
# $(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from portov device
$(call inherit-product, device/motorola/portov/device.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_NAME := twrp_portov
PRODUCT_DEVICE := portov
PRODUCT_MANUFACTURER := motorola
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola moto g67 power 5G
