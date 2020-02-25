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

LOCAL_PATH := device/beagleboard/beagleboneblack

# Configure the Dalvik heap for a device with 512 MiB RAM
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# Core
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Required for startup.
$(call inherit-product-if-exists, frameworks/base/data/fonts/fonts.mk)

# From media_system.mk
PRODUCT_SYSTEM_SERVER_JARS := \
	services \
	ethernet-service \
	wifi-service \
	com.android.location.provider \

PRODUCT_PACKAGES += \
	ethernet-service \
	libwebviewchromium_plat_support

PRODUCT_COPY_FILES += \
	system/core/rootdir/etc/public.libraries.android.txt:system/etc/public.libraries.txt

# From handheld_system.mk
PRODUCT_PACKAGES += \
	Telecom \
	TelephonyProvider \
	TeleService

#
# Local things start here
#

PRODUCT_CHARACTERISTICS := tablet,nosdcard

DEVICE_PACKAGE_OVERLAYS += \
	$(LOCAL_PATH)/overlay

PRODUCT_TAGS += dalvik.gc.type-precise

# Fstab(s)
# This assumes that the target ends with either _sd or _emmc.
ifneq (,$(findstring _sd,$(TARGET_PRODUCT)))
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/fstab.sd:root/fstab.am335xevm
else ifneq (,$(findstring _emmc, $(TARGET_PRODUCT)))
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/fstab.emmc:root/fstab.am335xevm
else
$(error "No fstab file for target $(TARGET_PRODUCT). Please fix your Makefiles.")
endif

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/vold.fstab:system/etc/vold.fstab \

# Init files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init.am335xevm.rc:root/init.am335xevm.rc \
	$(LOCAL_PATH)/init.am335xevm.usb.rc:root/init.am335xevm.usb.rc \
	$(LOCAL_PATH)/ueventd.am335xevm.rc:root/ueventd.am335xevm.rc \

# Media items
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
	$(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
	$(LOCAL_PATH)/mixer_paths.xml:system/etc/mixer_paths.xml

# Audio configuration (Copied from Google Wahoo)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
	frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml

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
	$(LOCAL_PATH)/ti-tsc.idc:system/usr/idc/ti-tsc.idcs

PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.low_ram=true \
	ro.product.serialnumber=123456789 \
	ro.hardware.hwcomposer=drm_minigbm \
	ro.hardware.gralloc=minigbm \
	ro.hardware.camera=v4l2 \
	ro.hardware.sensors=dynamic_sensor_hal \
	ro.lmk.low=1001 \
	ro.lmk.medium=1001 \
	debug.sf.nobootanimation=1 \
	debug.stagefright.ccodec=0 \
	ro.fw.multiuser.headless_system_user=true \
	ro.fw.system_user_split=true \
	ro.hardware.egl=swiftshader

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.strictmode.visual=0 \
	persist.sys.strictmode.disable=1

ifneq (,$(findstring eng,$(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES += \
	ro.lmk.debug=true
else
PRODUCT_PROPERTY_OVERRIDES += \
	ro.lmk.debug=false
endif

## PRODUCT PACKAGES

PRODUCT_PACKAGES += \
	librs_jni \
	com.android.future.usb.accessory

# This is necessary for the connection to work.
PRODUCT_PACKAGES += \
	OneTimeInitializer \
	Provision \
	Settings \
	frameworks-base-overlays

PRODUCT_PACKAGES_DEBUG += \
	frameworks-base-overlays-debug

PRODUCT_PACKAGES += \
	libaudioutils

PRODUCT_PACKAGES += \
        audio.primary.am335xevm \
        tinycap \
        tinymix \
        tinyplay

# Graphics
PRODUCT_PACKAGES += \
	minigbm \
	drm_hwcomposer \
	hwcomposer.drm_minigbm \
	swiftshader_top_release \
	swiftshader_top_debug \
	libEGL_swiftshader \
	libGLESv1_CM_swiftshader \
	libGLESv2_swiftshader

# Debug SwiftShader modules only for -eng builds.
PRODUCT_PACKAGES_DEBUG += \
	libEGL_swiftshader_debug \
	libGLESv1_CM_swiftshader_debug\
	libGLESv2_swiftshader_debug

PRODUCT_PACKAGES += \
	dhcpcd.conf

# Filesystem management tools
PRODUCT_PACKAGES += \
	make_ext4fs

# Backlight HAL (liblights)
PRODUCT_PACKAGES += \
	lights.am335xevm

# Use pixel flinger (libGLES_android.so) as a backup to SGX
PRODUCT_PACKAGES += \
        libGLES_android

# All VNDK libraries (HAL interfaces, VNDK, VNDK-SP, LL-NDK)
PRODUCT_PACKAGES += vndk_package

# Gatekeeper
PRODUCT_PACKAGES += \
	android.hardware.gatekeeper@1.0-service \
	android.hardware.gatekeeper@1.0-impl \
	gatekeeper \
	gatekeeperd \
	gatekeeper.beagleboneblack

# Memtrack
PRODUCT_PACKAGES += \
	android.hardware.memtrack@1.0-service \
	android.hardware.memtrack@1.0-impl \
	memtrack.default

# Keymaster HAL
PRODUCT_PACKAGES += \
	android.hardware.keymaster@3.0-impl \
	android.hardware.keymaster@3.0-service \
	android.hardware.drm@1.0-impl \
	android.hardware.drm@1.0-service

# Power
PRODUCT_PACKAGES += \
	android.hardware.power@1.1-impl \
	android.hardware.power@1.1-service.beagleboneblack

# Graphics
PRODUCT_PACKAGES += \
	android.hardware.graphics.mapper@2.0-impl \
	android.hardware.graphics.mapper@2.0-service \
	android.hardware.graphics.composer@2.1-impl \
	android.hardware.graphics.composer@2.1-service \
	android.hardware.graphics.allocator@2.0-impl \
	android.hardware.graphics.allocator@2.0-service

# Audio
PRODUCT_PACKAGES += \
	android.hardware.audio@5.0-impl:32 \
	android.hardware.audio.effect@5.0-impl:32 \
	android.hardware.soundtrigger@2.2-impl:32 \
	android.hardware.bluetooth.audio@2.0-impl \
	android.hardware.audio@2.0-service

# Camera
PRODUCT_PACKAGES += \
	android.hardware.camera.provider@2.4-impl \
	android.hardware.camera.provider@2.4-external-service \
	camera.default \
	camera.v4l2

# Sensors
PRODUCT_PACKAGES += \
	android.hardware.sensors@1.0-service \
	android.hardware.sensors@1.0-impl \
	sensors.dynamic_sensor_hal

# Health
PRODUCT_PACKAGES += \
	android.hardware.health@1.0-service \
	android.hardware.health@1.0-impl
