# Application Configuration
BOARD ?= flick
include boards/$(BOARD)/board.mk

TARGET = $(BOARD)_bootloader
SELF = $(BOARD)_update_bootloader

COMMON_SRC = \
	src/flash_$(CHIP_FAMILY).c \
	src/init_$(CHIP_FAMILY).c \
	src/startup_$(CHIP_FAMILY).c \
	src/usart_sam_ba.c \
	src/screen.c \
	src/images.c \
	src/utils.c

SOURCES = $(COMMON_SRC) \
	src/cdc_enumerate.c \
	src/fat.c \
	src/main.c \
	src/msc.c \
	src/sam_ba_monitor.c \
	src/uart_driver.c \
	src/hid.c \

SELF_SOURCES = $(COMMON_SRC) src/selfmain.c src/selfdata.c

BOOTLOADER_SIZE = 0x2000

CMSIS_DIR = ../lib/CMSIS
INCLUDES  = . inc inc/preprocessor boards/$(BOARD) lib/usb_msc
INCLUDES += ../lib/CMSIS/Include ../lib/CMSIS-Atmel ../lib/CMSIS-Atmel/samd21/include

COMPORT     ?= /dev/ttyACM0
BOSSAC      ?= bossac
BOSSAC_FLAGS = --erase --write --verify --reset --port=$(COMPORT)
OS          := $(shell uname -s)
ifeq ($(OS),Linux)
RESET_SCRIPT = ../scripts/reset-arduino-linux.sh -q $(COMPORT)
else
RESET_SCRIPT = ../scripts/ard-reset-arduino --zero $(COMPORT)
endif

# my bossa-git AUR package sets the version to the Arch pkgver, which is 1.8.rXX.gYYYYYYY since
# there hasn't been a v1.9 tag yet, so figure out the version by checking for the availability
# of the --arduino-erase option
BOSSA_19 := $(shell $(BOSSAC) --help 2>/dev/null | grep -q -e '--arduino-erase' && echo y || echo n)
ifeq ($(BOSSA_19),y)
# we have auto-erase available
BOSSAC_FLAGS := $(filter-out --erase,$(BOSSAC_FLAGS))
# BOSSA v1.8 hard-coded the flash starting address as 0x2000, so the command-line offset
# must be zero (the default) or else the program would get written to 0x4000.
# BOSSA v1.9 doesn't do that, so we must set the offset to 0x2000 or else the bootloader
# will get overwritten, bricking the board.
BOSSAC_FLAGS += --offset=$(BOOTLOADER_SIZE)
endif

# Tools Configuration
TOOLCHAIN_BIN ?=
CC      = $(TOOLCHAIN_BIN)arm-none-eabi-gcc
CXX     = $(TOOLCHAIN_BIN)arm-none-eabi-g++
AR      = $(TOOLCHAIN_BIN)arm-none-eabi-ar
OBJCOPY = $(TOOLCHAIN_BIN)arm-none-eabi-objcopy
OBJDUMP = $(TOOLCHAIN_BIN)arm-none-eabi-objdump
SIZE    = $(TOOLCHAIN_BIN)arm-none-eabi-size

OPENOCD = openocd
OPENOCD_CMD = -f ../openocd.cfg -c "program $(TARGET_BIN) verify reset exit"

VERSION    := $(shell ../scripts/get_version.sh --sam-ba)

LCPPFLAGS   = -DSAMD21 -D__SAMD21G18A__ -DUF2_VERSION_BASE='"$(VERSION)"'
LCPPFLAGS  += $(addprefix -I,$(INCLUDES)) -MMD -MP

# used in CFLAGS/LDFLAGS
CPUFLAGS    = -mcpu=cortex-m0plus -mthumb -ggdb3 -Os

# not used in LDFLAGS
LCFLAGS     = -std=gnu99 $(CPUFLAGS) -Wall -Wextra -Werror -Wno-expansion-to-defined
LCFLAGS    += -fno-exceptions -ffunction-sections -fdata-sections

LDSCRIPT      = scripts/samd21j18a.ld
SELF_LDSCRIPT = scripts/samd21j18a_self.ld

LLDFLAGS    = $(CPUFLAGS) --specs=nano.specs --specs=nosys.specs
LLDFLAGS   += -Wl,--cref -Wl,--check-sections -Wl,--gc-sections -Wl,--unresolved-symbols=report-all
LLDFLAGS   += -Wl,--warn-common -Wl,--warn-section-align
LLDFLAGS   += -Wl,-Map=$(TARGET).map
LLDFLAGS   += -L$(CMSIS_DIR)

define override_flags =
override $(1) := $$(strip $$(L$(1)) $$($(1)))
endef
$(foreach f,CPPFLAGS CFLAGS LDFLAGS,$(eval $(call override_flags,$(f))))

TARGET_OBJ  = $(SOURCES:.c=.o)
DEPS        = $(TARGET_OBJ:.o=.d)
TARGET_ELF  = $(TARGET).elf
TARGET_BIN  = $(TARGET).bin
TARGET_HEX  = $(TARGET).hex

SELF_OBJ    = $(SELF_SOURCES:.c=.o)
DEPS       += $(SELF_OBJ:.o=.d)
SELF_ELF    = $(SELF).elf
SELF_BIN    = $(SELF).bin
SELF_UF2    = $(SELF).uf2

V ?= 0
_V_CC_0     = @echo "  CC      " $<;
_V_CXX_0    = @echo "  CXX     " $<;
_V_AS_0     = @echo "  AS      " $<;
_V_LD_0     = @echo "  LD      " $@;
_V_AR_0     = @echo "  AR      " $@;
_V_BIN_0    = @echo "  BIN     " $@;
_V_HEX_0    = @echo "  HEX     " $@;
_V_GEN_0    = @echo "  GEN     " $@;
_V_UF2_0    = @echo "  UF2     " $@;
_V_SIZE_0   = @echo "Program Size:";
_V_RESET_0  = @echo "  RESET   " $(COMPORT);
_V_UPLOAD_0 = @echo "  UPLOAD  " $<;
_V_CLEAN_0  = @echo "  CLEAN";

CLEAN_FILES  = $(TARGET_OBJ) $(SELF_OBJ) $(DEPS) $(TARGET_ELF) $(TARGET_BIN) $(TARGET_HEX) $(TARGET).map .size_done
CLEAN_FILES += $(SELF_ELF) $(SELF_BIN) $(SELF_UF2) src/selfdata.c

.PHONY: all
all: $(TARGET_BIN) $(SELF_UF2) .size_done

SIZE_CMD = $(_V_SIZE_$(V))../scripts/print-size.py -q $(TARGET_ELF)
.PHONY: size
size: $(TARGET_ELF)
	$(SIZE_CMD)

.size_done: $(TARGET_ELF) | $(TARGET_BIN)
	$(SIZE_CMD)
	@touch $@

.PHONY: upload
upload: $(TARGET_BIN) all
	$(_V_UPLOAD_$(V))$(OPENOCD) $(OPENOCD_CMD)

.PHONY: upload-bossa
upload-bossa: $(SELF_BIN) all
	$(_V_RESET_$(V))$(RESET_SCRIPT)
	$(_V_UPLOAD_$(V))$(BOSSAC) $(BOSSAC_FLAGS) $<

.PHONY: hex
hex: $(TARGET_HEX)

.PHONY: clean
clean:
	$(_V_CLEAN_$(V))rm -f $(CLEAN_FILES)

$(TARGET_ELF): $(TARGET_OBJ) $(LDSCRIPT)
	$(_V_LD_$(V))$(CC) $(LDFLAGS) -T$(LDSCRIPT) -o $@ $(TARGET_OBJ)

$(TARGET_BIN): $(TARGET_ELF)
	$(_V_BIN_$(V))$(OBJCOPY) -O binary $< $@

$(TARGET_HEX): $(TARGET_ELF)
	$(_V_HEX_$(V))$(OBJCOPY) -O ihex $< $@

.PHONY: self
self: $(SELF_UF2)

src/selfdata.c: $(TARGET_BIN) scripts/gendata.py
	$(_V_GEN_$(V))scripts/gendata.py $(BOOTLOADER_SIZE) $(TARGET_BIN)

$(SELF_ELF): $(SELF_OBJ) $(SELF_LDSCRIPT)
	$(_V_LD_$(V))$(CC) $(LDFLAGS) -T$(SELF_LDSCRIPT) -o $@ $(SELF_OBJ)

$(SELF_BIN): $(SELF_ELF)
	$(_V_BIN_$(V))$(OBJCOPY) -O binary $< $@

$(SELF_UF2): $(SELF_BIN) ../scripts/uf2conv.py
	$(_V_UF2_$(V))../scripts/uf2conv.py -b $(BOOTLOADER_SIZE) -f SAMD21 -c -o $@ $(SELF_BIN)

%.o: %.c
	$(_V_CC_$(V))$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<


-include $(DEPS)
