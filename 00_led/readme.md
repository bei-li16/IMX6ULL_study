# IMX6ULL工程

## 烧写代码
1. Ubuntu系统安装USB驱动：sudo apt-get install libusb-1.0.0-dev libzip-dev libbz2-dev
2. USB连接开发板USB-OTG和电脑（切换连接到虚拟机）
3. 制作烧录文件：cat header led.bin >led.imx
4. 下载烧录文件：sudo -i $(PWD)/uuu $(PWD)/led.imx 

## 02_ledc工程
1. 新建target作为下载依赖
2. 跳转main依然使用bl main, 后面添加b ./b loop
3. 有子函数的跳转不使用b而使用bl