## pixel-graphics-card

- For the file "pixel.asm": 

Graphic cards with 8 bits per colour intensity RGB require at least 24 bits per pixel. These are now almost always rounded up to 32 bits.

The pixel coordinates x and y are passed in the registers eax and ebx, the RGB value to be set in the register ecx. The sub-program set_pixel sets the pixel to the colour value.

- For the second file "pixel_mirror.asm":

In order to mirror a pixel graphic of the size 8x8 pixels in the working memory, the function "mirror" was developed. It should be possible to apply it to any address in the memory by means of a CALL call. 

The only parameter for this function is the start address of the pixel graphic to be mirrored passed in register EBX. There are no return values.The numbering of the total 64 bits of a pixel graphic starts in the upper left corner.
