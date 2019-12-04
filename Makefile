# Setup our targets first.
TARGET		:=	$(shell basename $(CURDIR))
BUILD		:=	build
SOURCES		:=	source source/configs
INCLUDES	:=	include

# Setup our compiler options next.
CC=cc65
AS=ca65
LD=ld65
CFLAGS=-O -t nes -I ../$(INCLUDES)
ASFLAGS=-t nes -I ../$(INCLUDES)
LDFLAGS=

#############################################################################################
# Check if we are on the build step.
ifneq ($(BUILD),$(notdir $(CURDIR)))

# Setup our file dependencies.
C_FILES			:=	$(foreach dir,$(SOURCES),$(wildcard $(CURDIR)/$(dir)/*.c))
ASM_FILES		:=	$(foreach dir,$(SOURCES),$(wildcard $(CURDIR)/$(dir)/*.s))

# Out exports.
export OUTPUT			:=	$(CURDIR)/$(TARGET)
export VPATH			:=	$(foreach dir,$(SOURCES),$(CURDIR)/$(dir))
export OFILES			:=	$(C_FILES:.c=.o) $(ASM_FILES:.s=.o) $(LINKER_FILE:.x=.o)
# Optional linker configuration file can be added to the sources folder with the ".x" extension.
export LINKER_FILE		:=	$(foreach dir,$(SOURCES),$(wildcard $(CURDIR)/$(dir)/*.x))

# Ensures we do a full buidl each time.
.PHONY: $(BUILD) clean
 
# Default build target, creates the build directory and then
# starts an actual build.
$(BUILD):
	@echo Building...
	@[ -d $(BUILD) ] || mkdir -p $(BUILD)
	@make --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile

clean:
	@echo Cleaning ...
	@echo 
	@rm -fr $(BUILD) $(TARGET).nes

#############################################################################################
else
#############################################################################################

# Actual binary output.
$(OUTPUT).nes: $(OFILES)
ifeq (,$(wildcard $(LINKER_FILE)))
	@echo Using default configuration options...
	$(LD) -t nes -o $@ *.o nes.lib $(LDFLAGS)
else
	@echo Using linker file $(LINKER_FILE)...
	$(LD) -C $(LINKER_FILE) -o $@ *.o $(LDFLAGS)
endif

# How we handle file types.
%.o: %.c
	$(CC) $< -o $(addsuffix .s, $(basename $(notdir $@))) $(CFLAGS)
	$(AS) $(addsuffix .s, $(basename $(notdir $@))) -o $(notdir $@) $(ASFLAGS)

%.o: %.s
	$(AS) $< -o $(notdir $@) $(ASFLAGS)

%.o: %.x
	cp $< $(CURDIR)/

endif

