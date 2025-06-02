/***************************************************************
Copyright © zuozhongkai Co., Ltd. 1998-2019. All rights reserved.
文件名	: 	 start.s
作者	   : 左忠凯
版本	   : V1.0
描述	   : ZERO-I.MX6UL/I.MX6ULL开发板启动文件，完成C环境初始化，
		 C环境初始化完成以后跳转到C代码。
其他	   : 无
日志	   : 初版 2019/1/3 左忠凯修改
**************************************************************/

.section .note.GNU-stack, "", %progbits  /* 添加此行：禁用可执行栈 */

.global _start  		/* 全局标号 */

/*
 * 描述：	_start函数，程序从此函数开始执行，此函数主要功能是设置C
 *		 运行环境。
 */
_start:

	/* 进入SVC模式 */
	mrs r0, cpsr
	bic r0, r0, #0x1f 	/* 将r0寄存器中的低5位清零，也就是cpsr的M0~M4 	*/
	orr r0, r0, #0x13 	/* r0或上0x13,表示使用SVC模式					*/
	msr cpsr, r0		/* 将r0 的数据写入到cpsr_c中 					*/

	ldr sp, =0X80200000	/* 设置栈指针			 */
    bl main				/* 跳转到main函数 		 */
	b .
	// b loop				/* 跳转到loop函数，进入死循环 */
	// b _ledasm		/* 跳转到_ledasm函数，完成LED灯点亮 */
	// bl _ledclkinitasm	/* 跳转到_ledclkinitasm函数，完成LED灯点亮 */
	// bl clk_enable	/* 跳转到clk_enable函数，完成时钟使能 */
	// bl led_init		/* 跳转到led_init函数，完成LED灯点亮 */
	// b loop		/* 跳转到loop函数，进入死循环 */
	// b _ledinitasm	/* 跳转到_ledinitasm函数，完成LED灯点亮 */


/*
 * 描述：	loop死循环
 */
loop:
	b loop 	


/*
 * @description	: 使能I.MX6U所有外设时钟
 * @param 		: 无
 * @return 		: 无
 */
_ledclkinitasm:
	/* 例程代码 */
	/* 1、使能所有时钟 */
	ldr r0, =0X020C4068 	/* CCGR0 */
	ldr r1, =0XFFFFFFFF  
	str r1, [r0]		
	
	ldr r0, =0X020C406C  	/* CCGR1 */
	str r1, [r0]

	ldr r0, =0X020C4070  	/* CCGR2 */
	str r1, [r0]
	
	ldr r0, =0X020C4074  	/* CCGR3 */
	str r1, [r0]
	
	ldr r0, =0X020C4078  	/* CCGR4 */
	str r1, [r0]
	
	ldr r0, =0X020C407C  	/* CCGR5 */
	str r1, [r0]
	
	ldr r0, =0X020C4080  	/* CCGR6 */
	str r1, [r0]

/*
 * @description	: 初始化LED对应的GPIO
 * @param 		: 无
 * @return 		: 无
 */
_ledinitasm:
	/* 2、设置GPIO1_IO03复用为GPIO1_IO03 */
	ldr r0, =0X020E0068	/* 将寄存器SW_MUX_GPIO1_IO03_BASE加载到r0中 */
	ldr r1, =0X5		/* 设置寄存器SW_MUX_GPIO1_IO03_BASE的MUX_MODE为5 */
	str r1,[r0]

	/* 3、配置GPIO1_IO03的IO属性	
	 *bit 16:0 HYS关闭
	 *bit [15:14]: 00 默认下拉
	 *bit [13]: 0 kepper功能
	 *bit [12]: 1 pull/keeper使能
	 *bit [11]: 0 关闭开路输出
	 *bit [7:6]: 10 速度100Mhz
	 *bit [5:3]: 110 R0/6驱动能力
	 *bit [0]: 0 低转换率
	 */
	ldr r0, =0X020E02F4	/*寄存器SW_PAD_GPIO1_IO03_BASE */
	ldr r1, =0X10B0
	str r1, [r0]

	/* 4、设置GPIO1_IO03为输出模式 */
	ldr r0, =0X0209C004 /* GPIO1_GDIR_BASE */
	mov r1, #1 << 3   /* GPIO1_IO03对应的位是3 */
	str r1, [r0]      /* 设置GPIO1_IO03为输出模式 */

	/* 5、将GPIO1_IO03输出低电平点亮LED灯 */
	ldr r0, =0X0209C000 /* GPIO1_DR_BASE */
	mov r1, #~(1 << 3) /* GPIO1_IO03对应的位是3，输出低电平点亮LED灯 */
	str r1, [r0]      /* 将GPIO1_IO03输出低电平点亮LED灯 */

	b loop			/* 跳转到loop函数，进入死循环 */


	/*
 * 描述：	_ledasm函数，程序从此函数开始执行此函数完成时钟使能、
 *		  GPIO初始化、最终控制GPIO输出低电平来点亮LED灯。
 */
_ledasm:
	/* 例程代码 */
	/* 1、使能所有时钟 */
	ldr r0, =0X020C4068 	/* CCGR0 */
	ldr r1, =0XFFFFFFFF  
	str r1, [r0]		
	
	ldr r0, =0X020C406C  	/* CCGR1 */
	str r1, [r0]

	ldr r0, =0X020C4070  	/* CCGR2 */
	str r1, [r0]
	
	ldr r0, =0X020C4074  	/* CCGR3 */
	str r1, [r0]
	
	ldr r0, =0X020C4078  	/* CCGR4 */
	str r1, [r0]
	
	ldr r0, =0X020C407C  	/* CCGR5 */
	str r1, [r0]
	
	ldr r0, =0X020C4080  	/* CCGR6 */
	str r1, [r0]
	

	/* 2、设置GPIO1_IO03复用为GPIO1_IO03 */
	ldr r0, =0X020E0068	/* 将寄存器SW_MUX_GPIO1_IO03_BASE加载到r0中 */
	ldr r1, =0X5		/* 设置寄存器SW_MUX_GPIO1_IO03_BASE的MUX_MODE为5 */
	str r1,[r0]

	/* 3、配置GPIO1_IO03的IO属性	
	 *bit 16:0 HYS关闭
	 *bit [15:14]: 00 默认下拉
     *bit [13]: 0 kepper功能
     *bit [12]: 1 pull/keeper使能
     *bit [11]: 0 关闭开路输出
     *bit [7:6]: 10 速度100Mhz
     *bit [5:3]: 110 R0/6驱动能力
     *bit [0]: 0 低转换率
     */
    ldr r0, =0X020E02F4	/*寄存器SW_PAD_GPIO1_IO03_BASE */
    ldr r1, =0X10B0
    str r1,[r0]

	/* 4、设置GPIO1_IO03为输出 */
    ldr r0, =0X0209C004	/*寄存器GPIO1_GDIR */
    ldr r1, =0X0000008		
    str r1,[r0]

	/* 5、打开LED0
	 * 设置GPIO1_IO03输出低电平
	 */
	ldr r0, =0X0209C000	/*寄存器GPIO1_DR */
    ldr r1, =0		
    str r1,[r0]