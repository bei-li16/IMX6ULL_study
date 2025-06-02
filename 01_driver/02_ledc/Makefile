
CC = arm-none-linux-gnueabihf-gcc
LD = arm-none-linux-gnueabihf-ld
OBJCOPY = arm-none-linux-gnueabihf-objcopy
OBJDUMP = arm-none-linux-gnueabihf-objdump

CFLAGS = -g -Wall -nostdlib -O2
objs := start.o main.o
bins := ledc.bin
target := ledc.imx

$(bins):$(objs)
	$(LD) -Timx6ul.lds -o ledc.elf $^
	$(OBJCOPY) -O binary -S ledc.elf $@
	$(OBJDUMP) -D -m arm ledc.elf > ledc.dis

$(target): $(bins)
#为代码加入IVT BOOT DCD数据头 header文件在官方imx文件中提前即可
	cat header $< > $@

%.o:%.s
	$(CC) $(CFLAGS) -c -o $@ $<
	
%.o:%.S
	$(CC) $(CFLAGS) -c -o $@ $<
	
%.o:%.c
	$(CC) $(CFLAGS) -c -o $@ $<
	
clean:
	rm -rf *.o *.bin *.elf *.dis *.imx
	
run: $(target)
	sudo -i $(PWD)/uuu $(PWD)/$<
	
.PHONY: clean run