ENTRY(_binary_bl32_bin_start);

SECTIONS
{
    . = 0x08400000;
    .data : {
        *(.data)
    }
}
