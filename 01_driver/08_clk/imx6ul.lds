ENTRY(_start)  /* 明确指定入口点为_start */

SECTIONS
{
	. = 0X87800000;
	.text :
	{
		*start.o(.text)
		*(.text)
	}
	.rodata ALIGN(4) : {*(.rodata*)}     
	.data ALIGN(4)   : { *(.data) }

	. = ALIGN(4);
	__bss_start = .;    
	.bss ALIGN(4)  : { *(.bss)  *(COMMON) }    
	__bss_end = .;
}