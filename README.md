## pixel-graphics-card

Graphic cards with 8 bits per colour intensity RGB require at least 24 bits per pixel. These are now almost always rounded up to 32 bits.

The pixel coordinates x and y are passed in the registers eax and ebx, the RGB value to be set in the register ecx. The sub-program set_pixel sets the pixel to the colour value.
