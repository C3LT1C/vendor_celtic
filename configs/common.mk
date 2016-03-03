KBUILD_BUILD_USER := $(shell git config user.name)

PACKAGE_TARGET_NAME := $(shell grep -r "EXTRAVERSION = -" $(ANDROID_BUILD_TOP)/$(PRODUCT_KERNEL_SOURCE)/Makefile | sed 's/EXTRAVERSION = -//')-$(shell git -C $(ANDROID_BUILD_TOP)/$(PRODUCT_KERNEL_SOURCE) log --pretty=format:'%h' -n 1)-$(BLACK_PRODUCT)-$(shell date -u +%m.%d).zip
