CROSS_COMPILE 	?= arm-none-linux-gnueabihf-
TARGETNAME		?= bsp

CC 				:= $(CROSS_COMPILE)gcc
LD				:= $(CROSS_COMPILE)ld
OBJCOPY 		:= $(CROSS_COMPILE)objcopy
OBJDUMP 		:= $(CROSS_COMPILE)objdump

CFLAGS = -g -Wall -nostdlib -O2

INCDIRS 		:= imx6ul \
				   bsp/clk \
				   bsp/led \
				   bsp/delay 
				   			   
SRCDIRS			:= project \
				   bsp/clk \
				   bsp/led \
				   bsp/delay 
				   
OUTPUTDIR		:= $(PWD)/Debug
TARGET			:= $(OUTPUTDIR)/$(TARGETNAME)

.PHONY: all 
all: $(TARGET).bin   # 声明为入口目标

$(OUTPUTDIR):
	@mkdir -p $@

INCLUDE			:= $(patsubst %, -I %, $(INCDIRS))

SFILES			:= $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.S))
CFILES			:= $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.c))

SFILENDIR		:= $(notdir  $(SFILES))
CFILENDIR		:= $(notdir  $(CFILES))

SOBJS			:= $(patsubst %, $(OUTPUTDIR)/%, $(SFILENDIR:.S=.o))
COBJS			:= $(patsubst %, $(OUTPUTDIR)/%, $(CFILENDIR:.c=.o))
OBJS			:= $(SOBJS) $(COBJS)

VPATH			:= $(SRCDIRS)

.PHONY: clean run
	
$(TARGET).bin : $(OBJS)
	$(LD) -Timx6ul.lds -o $(TARGET).elf $^
	$(OBJCOPY) -O binary -S $(TARGET).elf $@
	$(OBJDUMP) -D -m arm $(TARGET).elf > $(TARGET).dis

$(SOBJS) : $(OUTPUTDIR)/%.o : %.S | $(OUTPUTDIR)
	$(CC) $(CFLAGS) -c $(INCLUDE) -o $@ $<

$(COBJS) : $(OUTPUTDIR)/%.o : %.c | $(OUTPUTDIR)
	$(CC) $(CFLAGS) -c  $(INCLUDE) -o $@ $<
	
clean:
	rm -rf $(TARGET).elf $(TARGET).dis $(TARGET).bin $(COBJS) $(SOBJS) $(TARGET).imx

run: $(TARGET).bin
	cat header $< > $(TARGET).imx
	sudo -i $(PWD)/uuu $(TARGET).imx
	
