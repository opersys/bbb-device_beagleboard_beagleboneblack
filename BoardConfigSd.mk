# Build version to boot from uSD card

TARGET_NO_RECOVERY := true
TARGET_NO_KERNEL := true

# Partition sizes suitable for uSD cards >= 4 GB
# system and cache are kept small, 512 MiB
# userdata is 3 GiB, taking up most of the remaining space but leaving
# a bit of free space to cater for different sized "4 GB" cards
TARGET_USERIMAGES_USE_EXT4 := true

BOARD_USERDATAIMAGE_PARTITION_SIZE := 1879048192 # 1792MB
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 1073741824 # 1024MB
BOARD_CACHEIMAGE_PARTITION_SIZE :=     268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096
#BOARD_VENDORIMAGE_PARTITION_SIZE := 10485760 # 10 M
#BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

BOARD_KERNEL_CMDLINE := console=ttyS0,115200n8 androidboot.console=ttyS0 rootwait ro androidboot.hardware=am335xevm qemu=1 qemu.gles=0 cape_universal=enable security=selinux androidboot.selinux=enforcing consoleblank=0 kgdboc=ttyS0,115200 kgdbcon
