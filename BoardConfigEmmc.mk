# Build version for installation into internal eMMC

# kernel load address = BOARD_KERNEL_BASE + 0x8000 = 0x81080000
# Ramdisk load address = BOARD_KERNEL_BASE + 0x01000000 = 0x82000000
BOARD_KERNEL_BASE := 0x81000000

#BOARD_KERNEL_CMDLINE := console=ttyS0,115200n8 androidboot.console=ttyS0 rootwait ro androidboot.hardware=am335xevm qemu=1 qemu.gles=0 cape_universal=enable security=selinux androidboot.selinux=permissive consoleblank=0
BOARD_KERNEL_CMDLINE := console=ttyS0,115200n8 androidboot.console=ttyS0 rootwait ro androidboot.hardware=am335xevm qemu=1 qemu.gles=0 cape_universal=enable security=selinux consoleblank=0

# Partition sizes for BBB with 2 GiB eMMC (rev A and B)
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1879048192 # 1792MB
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 1073741824 # 1024MB
BOARD_CACHEIMAGE_PARTITION_SIZE :=     268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096
