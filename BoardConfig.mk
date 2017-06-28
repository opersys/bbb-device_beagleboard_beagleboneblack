#
# Copyright (C) 2011 The Android Open-Source Project
# Copyright (C) 2015 Chris Simmonds, chris@2net.co.uk
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

# Use beaglebone camera cape as default
BOARD_HAVE_CAMERA_CAPE := true

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := generic

BOARD_HAVE_BLUETOOTH := false
TARGET_NO_BOOTLOADER := true

TARGET_NO_RADIOIMAGE := true
TARGET_BOARD_PLATFORM := omap3
TARGET_BOOTLOADER_BOARD_NAME := beagleboneblack
BOARD_USB_CAMERA := true
USE_OPENGL_RENDERER := true

WITH_DEXPREOPT := true

BOARD_SEPOLICY_DIRS += device/beagleboard/beagleboneblack/sepolicy

ifneq ($(filter beagleboneblack_sd, $(TARGET_PRODUCT)),)
# Build version to boot from uSD card

TARGET_NO_RECOVERY := true
TARGET_NO_KERNEL := true

# Partition sizes suitable for uSD cards >= 4 GB
# system and cache are kept small, 512 MiB
# userdata is 3 GiB, taking up most of the remaining space but leaving
# a bit of free space to cater for different sized "4 GB" cards
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE :=    536870912
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3221225472
BOARD_CACHEIMAGE_PARTITION_SIZE :=     268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

else
# Build version for installation into internal eMMC

# kernel load address = BOARD_KERNEL_BASE + 0x8000 = 0x81080000
# Ramdisk load address = BOARD_KERNEL_BASE + 0x01000000 = 0x82000000
BOARD_KERNEL_BASE := 0x81000000

BOARD_KERNEL_CMDLINE := console=ttyS0,115200n8 androidboot.console=ttyS0 rootwait ro androidboot.hardware=am335xevm qemu=1 qemu.gles=0 cape_universal=enable security=selinux androidboot.selinux=permissive consoleblank=0

# Partition sizes for BBB with 2 GiB eMMC (rev A and B)
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE   :=  536870912
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1073741824
BOARD_CACHEIMAGE_PARTITION_SIZE    :=  268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

endif
