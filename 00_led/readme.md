# IMX6ULL工程

## 烧写代码
1. Ubuntu系统安装USB驱动：sudo apt-get install libusb-1.0.0-dev libzip-dev libbz2-dev
2. USB连接开发板USB-OTG和电脑（切换连接到虚拟机）
3. 制作烧录文件：cat header led.bin >led.imx
4. 下载烧录文件：sudo -i $(PWD)/uuu $(PWD)/led.imx 