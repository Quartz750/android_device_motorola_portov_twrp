# 
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Add common definitions for Qualcomm
# $(call inherit-product, hardware/qcom-caf/common/common.mk)

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Inherit generic_ramdisk product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script
    
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier
    
# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := 400dpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery
    
# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer3-V2-ndk.vendor \
    vendor.qti.hardware.display.composer3-V1-ndk.vendor \
    vendor.qti.hardware.display.config-V1-ndk.vendor \
    vendor.qti.hardware.display.config-V2-ndk.vendor \
    vendor.qti.hardware.display.config-V3-ndk.vendor \
    vendor.qti.hardware.display.config-V4-ndk.vendor \
    vendor.qti.hardware.display.config-V5-ndk.vendor \
    vendor.qti.hardware.display.config-V6-ndk.vendor \
    vendor.qti.hardware.display.config-V7-ndk.vendor \
    vendor.qti.hardware.display.config-V8-ndk.vendor \
    vendor.qti.hardware.display.config-V9-ndk.vendor \
    vendor.qti.hardware.display.config-V10-ndk.vendor \
    vendor.qti.hardware.display.config-V11-ndk.vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml
    
# Decrypt my Data plz
# PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root/vendor,vendor)

# Fastboot
# PRODUCT_PACKAGES += \
    android.hardware.fastboot-service.example_recovery \
    fastbootd
    
# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.health-service.qti_recovery
    
# IPACM
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml \
    IPACM_Filter_cfg.xml
    
# Init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(LOCAL_PATH)/init/etc/fstab.qcom.zram:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom.zram \
    $(LOCAL_PATH)/init/etc/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc

$(foreach f,$(wildcard $(LOCAL_PATH)/init/etc/init/hw/*.rc),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/$(notdir $f)))
$(foreach f,$(wildcard $(LOCAL_PATH)/init/etc/init/*.rc),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/$(notdir $f)))
$(foreach f,$(wildcard $(LOCAL_PATH)/init/bin/*.sh),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/bin/$(notdir $f)))

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:recovery/root/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.usb.rc:recovery/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/root/vendor/bin/init.qti.keymaster.sh:vendor/bin/init.qti.keymaster.sh \
    $(LOCAL_PATH)/recovery/root/prop.default:root/prop.default
    
# Keymint
PRODUCT_PACKAGES += \
    android.hardware.hardware_keystore_V3.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml
    
# Memtrack
PRODUCT_PACKAGES += \
    vendor.qti.hardware.memtrack-service

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    vendor_bt_firmware_mountpoint \
    vendor_dsp_mountpoint \
    vendor_firmware_mnt_mountpoint \
    vendor_fsg_mountpoint \
    vendor_super_fsg_mountpoint \
    vendor_super_modem_mountpoint

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service-qti

PRODUCT_COPY_FILES += \
    vendor/qcom/opensource/power/config/parrot/powerhint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.xml
    
# QTI fwk-detect
PRODUCT_PACKAGES += \
    libvndfwk_detect_jni.qti_vendor # Needed by CNE app

# Screen
TARGET_SCREEN_DENSITY := 390

# Shipping API Level
PRODUCT_SHIPPING_API_LEVEL := 35

# Soong namespaces
 PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/motorola
    
# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.qti

# Task_profiles
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/etc/task_profiles.json:system/etc/task_profiles.json

# Touch
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/boe_chipone_firmware.bin:vendor/firmware/boe_chipone_firmware.bin
    
# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti \
    init.qcom.usb.rc \
    init.qcom.usb.sh \
    usb_compositions.conf

PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/usb/etc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml
    
# Verified Boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml
    
# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service
    
PRODUCT_COPY_FILES += \
    vendor/qcom/opensource/vibrator/excluded-input-devices.xml:vendor/etc/excluded-input-devices.xml

# VNDK
PRODUCT_PACKAGES += \
    vndservicemanager

# Inherit from vendor blobs
# $(call inherit-product, vendor/motorola/portov/portov-vendor.mk)
