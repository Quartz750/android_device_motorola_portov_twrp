#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

DEVICE_PATH := device/motorola/portov
LOCAL_PATH := device/motorola/portov

# Kernel/Ramdisk
BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000
BOARD_KERNEL_PAGESIZE := 0x00001000
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
BOARD_KERNEL_IMAGE_NAME := kernel
BOARD_RAMDISK_USE_LZ4 := true
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)

# TWRP battery
TW_USES_SYSFS_BATTERY := true
TW_BATTERY_SYSFS_PATH := /sys/class/power_supply/mmi_battery
TW_BATTERY_SYSFS_CAPACITY := capacity
TW_BATTERY_SYSFS_STATUS := status

# Inherit from common
# -include $(COMMON_PATH)/BoardConfigCommon.mk

# To build minimal-manifest-twrp
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
BUILD_BROKEN_DUP_RULES := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 32)
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_KERNEL-GKI_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)
BOARD_DTBOIMG_PARTITION_SIZE := 24117248
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_SUPER_PARTITION_SIZE := 7516192768
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 7511998464
BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor vendor_dlkm product
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 7511998464

# Recovery
TARGET_OTA_ASSERT_DEVICE := portov

# TWRP specific build flags
TW_FRAMERATE := 120

# Vibrator
# TW_SUPPORT_INPUT_AIDL_HAPTICS := true
# TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
# TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/default"
TW_NO_HAPTICS := true
TW_USE_HARDWARE_VIBRATOR := true
TW_VIBRATOR_PATH := /sys/class/leds/vibrator/brightness

TARGET_RECOVERY_DEVICE_MODULES += libexpat
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libexpat.so

# TWRP thremal
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone50/temp"

# BOARD_SYSTEM_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/prebuilt/system_dlkm/*.ko)
# BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(patsubst %,$(DEVICE_PATH)/prebuilt/vendor_dlkm/%,$(shell cat $(DEVICE_PATH)/prebuilt/system_dlkm/modules.load))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/twrp/recovery/root/vendor/lib/modules/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(patsubst %,$(DEVICE_PATH)/twrp/recovery/root/vendor/lib/modules/%,$(shell cat $(DEVICE_PATH)/twrp/recovery/root/vendor/lib/modules/modules.load))
# BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/twrp/recovery/root/prebuilt/vendor_ramdisk/*.ko)
# BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(patsubst %,$(DEVICE_PATH)/prebuilt/vendor_dlkm/%,$(shell cat $(DEVICE_PATH)/prebuilt/vendor_ramdisk/modules.load))
# BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(patsubst %,$(DEVICE_PATH)/prebuilt/vendor_dlkm/%,$(shell cat $(DEVICE_PATH)/prebuilt/vendor_ramdisk/modules.load.recovery))
# BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD) $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)

TW_DEFAULT_LANGUAGE := en
TW_DEVICE_VERSION := MOTO G67 POWER

# ------------------Modified from BoardConfigCommon.mk------------------

# SDK
BOARD_SYSTEMSDK_VERSIONS := 31

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a-branchprot
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

# Bootloader
TARGET_NO_BOOTLOADER := false
TARGET_USES_UEFI := true
TARGET_USES_REMOTEPROC := true

# Partition Info
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_VENDOR_DLKMIMAGE := true
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
# BOARD_BOOTIMAGE_PARTITION_SIZE := 201326592
# BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
# BOARD_USERDATAIMAGE_PARTITION_SIZE := 15032385536
# BOARD_PERSISTIMAGE_PARTITION_SIZE := 67108864
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
# BOARD_METADATAIMAGE_PARTITION_SIZE := 16777216
# BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
# BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)

# Dynamic/Logical Partitions
# BOARD_SUPER_PARTITION_SIZE := 9126805504
# BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
# BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # BOARD_SUPER_PARTITION_SIZE - 4MB
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm

# BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor

# Rules
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
ALLOW_MISSING_DEPENDENCIES := true

# KEYSTONE(If43215c7f384f24e7adeeabdbbb1790f174b2ec1,b/147756744)
BUILD_BROKEN_NINJA_USES_ENV_VARS += SDCLANG_AE_CONFIG SDCLANG_CONFIG SDCLANG_SA_ENABLE

BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

# Recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.allocator@1.0 \
    android.hidl.memory@1.0 \
    android.hidl.memory.token@1.0 \
    libdmabufheap \
    libhidlmemory \
    libion \
    libnetutils \
    vendor.display.config@1.0 \
    vendor.display.config@2.0 \
    libdebuggerd_client
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery.fstab

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Encryption
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Extras
TARGET_SYSTEM_PROP += $(LOCAL_PATH)/system.prop
TARGET_VENDOR_PROP += $(LOCAL_PATH)/vendor.prop

# TWRP specific build flags
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := "/sys/devices/platform/soc/ae00000.qcom,mdss_mdp/backlight/panel0-backlight/brightness"
TW_STATUS_ICONS_ALIGN := center
TW_CUSTOM_CPU_POS := "50"
TW_CUSTOM_CLOCK_POS := "600"
TW_CUSTOM_BATTERY_POS := "800"
TW_DEFAULT_BRIGHTNESS := 420
TW_QCOM_ATS_OFFSET := 1666528204500
TW_EXCLUDE_APEX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_CRYPTO := true
TW_NO_EXFAT_FUSE := true
TW_INCLUDE_RESETPROP := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.fingerprint=ro.vendor.build.fingerprint;ro.build.version.incremental"
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.allocator@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.memory@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.memory.token@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libdmabufheap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhidlmemory.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libnetutils.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libdebuggerd_client.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko leds-qpnp-vibrator-ldo.ko qcom-hv-haptics.ko qti_battery_charger.ko  hwmon.ko msm_video.ko mmi_annotate.ko mmi_info.ko mmi_charger.ko mmi_relay.ko sensors_class.ko awinic_sar.ko ilitek_v4_mmi.ko chipone_tddi_v3_mmi.ko leds_aw99703.ko"
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
TW_HAS_USB_STORAGE := true
TW_USB_STORAGE_PATH := /usb_otg
TW_BACKUP_EXCLUDE_MEDIA := true

# TWRP Debug Flags
#TWRP_EVENT_LOGGING := true
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TARGET_RECOVERY_DEVICE_MODULES += debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace
#TARGET_RECOVERY_DEVICE_MODULES += twrpdec
#RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/twrpdec

#
# For local builds only
#
# TWRP zip installer
ifneq ($(wildcard bootable/recovery/installer/.),)
    USE_RECOVERY_INSTALLER := true
    RECOVERY_INSTALLER_PATH := bootable/recovery/installer
endif
# end local build flags
#