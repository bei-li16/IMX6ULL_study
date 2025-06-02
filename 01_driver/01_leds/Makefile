CC = arm-none-linux-gnueabihf-gcc
LD = arm-none-linux-gnueabihf-ld
OBJCOPY = arm-none-linux-gnueabihf-objcopy
OBJDUMP = arm-none-linux-gnueabihf-objdump

CFLAGS = -g -Wall -nostdlib
objs = led.o

led.bin: $(objs)
#编译链接代码
	$(LD) -Ttext 0X87800000 $< -o led.elf
	$(OBJCOPY) -O binary -S -g led.elf $@
	$(OBJDUMP) -D -m arm led.elf > led.dis
#为代码加入IVT BOOT DCD数据头 header文件在官方imx文件中提前即可
	cat header led.bin > led.imx

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf *.o led.bin led.elf led.dis
	
run:
	sudo -i $(PWD)/uuu $(PWD)/led.imx 
	
