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
ifneq ($(filter beagleboneblack_sd, $(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES := \
        $(LOCAL_PATH)/fstab.am335xevm-sd:root/fstab.am335xevm
else
PRODUCT_COPY_FILES := \
	$(LOCAL_PATH)/zImage-dtb:kernel \
        $(LOCAL_PATH)/fstab.am335xevm:root/fstab.am335xevm
endif

# dtbo files for capemanager (Linux 4.1)
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*.dtbo,$(LOCAL_PATH)/dtbo,root/lib/firmware)

# kernel modules
# Note: when operating with an LCD screen, tilcdc must be started after
# cape manager has loaded the corresponding dtbo file. Hence, it is
# a module, not a built-in. The backlight and touch screen drivers could
# be built-ins, but it makes more sense for everything associated with the lcd
# panel to be modular
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/modules/pwm-tiehrpwm.ko:system/modules/pwm-tiehrpwm.ko \
	$(LOCAL_PATH)/modules/ti_am335x_tsc.ko:system/modules/ti_am335x_tsc.ko \
	$(LOCAL_PATH)/modules/ti_am335x_tscadc.ko:system/modules/ti_am335x_tscadc.ko \
	$(LOCAL_PATH)/modules/tilcdc.ko:system/modules/tilcdc.ko \
	$(LOCAL_PATH)/modules/tda998x.ko:system/modules/tda998x.ko

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init.am335xevm.rc:root/init.am335xevm.rc \
	$(LOCAL_PATH)/init.am335xevm.usb.rc:root/init.am335xevm.usb.rc \
	$(LOCAL_PATH)/vold.fstab:system/etc/vold.fstab \
	$(LOCAL_PATH)/ueventd.am335xevm.rc:root/ueventd.am335xevm.rc \
	$(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
	$(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
	$(LOCAL_PATH)/mixer_paths.xml:system/etc/mixer_paths.xml \
	$(LOCAL_PATH)/audio_policy.conf:system/etc/audio_policy.conf

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml

# Need AppWidget permission to prevent Launcher[2|3] crashing
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml

# KeyPads
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gpio-keys.kl:system/usr/keylayout/gpio_keys.kl \
    $(LOCAL_PATH)/ti-tsc.idc:system/usr/idc/ti-tsc.idc

# BeagleBone Black only has 512 MiB RAM
PRODUCT_PROPERTY_OVERRIDES := \
      ro.config.low_ram=true

# Explicitly specify dpi, otherwise the icons don't show up correctly with SGX enabled
PRODUCT_PROPERTY_OVERRIDES += \
       ro.sf.lcd_density=160

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.strictmode.visual=0 \
	persist.sys.strictmode.disable=1

PRODUCT_CHARACTERISTICS := tablet,nosdcard

DEVICE_PACKAGE_OVERLAYS := \
	$(LOCAL_PATH)/overlay

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PACKAGES += \
	librs_jni \
	com.android.future.usb.accessory

PRODUCT_PACKAGES += \
	libaudioutils

PRODUCT_PACKAGES += \
        audio.primary.am335xevm \
        tinycap \
        tinymix \
        tinyplay

PRODUCT_PACKAGES += \
	dhcpcd.conf

# Filesystem management tools
PRODUCT_PACKAGES += \
	make_ext4fs

# Backlight HAL (liblights)
PRODUCT_PACKAGES += \
	lights.am335xevm

PRODUCT_PACKAGES += \
	androidvncserver

PRODUCT_PACKAGES += \
	camera.omap3

# Use pixel flinger (libGLES_android.so) as a backup to SGX
PRODUCT_PACKAGES += \
        libGLES_android

# Configure the Dalvik heap for a device with 512 MiB RAM
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

