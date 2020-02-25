$(PRODUCT_OUT)/uEnv.txt:
	echo "uname_r=4.19.59-bone36" > $@
	echo "fdtfile=am335x-boneblack-android.dtb" >> $@
	echo "devtype=mmc" >> $@
	echo "bootpart=0" >> $@
	echo "cmdline=$(BOARD_KERNEL_CMDLINE)" >> $@
	echo "bootcmd=run uname_boot" >> $@

ALL_DEFAULT_INSTALLED_MODULES += $(PRODUCT_OUT)/uEnv.txt
