#
# Copyright (C) 2011 The Android Open Source Project
# Copyright (C) 2015 Chris Simmonds, chris@2net.co.uk
# Copyright (C) 2019-2020 François-Denis Gonthier, francois-denis.gonthier@opersys.com
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

# Inherit from those products. Most specific first.
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_NAME := beagleboneblack_sd
PRODUCT_DEVICE := beagleboneblack
PRODUCT_BRAND := Android
PRODUCT_MODEL :=  BeagleBone Black on SD card
PRODUCT_MANUFACTURER := BeagleBoard.org
