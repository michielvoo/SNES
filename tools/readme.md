The development tools require Python 2.7. They have not been tested with Python 3.x. To execute all tests, run `python -m unittest discover -v` from the tools directory. To execute tests in a specific module you can usually just run that module with `python test_gif.py`.

The sprite tool converts a GIF image file to a palette file and a character file. The palette data can be stored in CGRAM. The character data can be stored in VRAM. The character data is not interleaved, so for sprites larger than 8×8 pixels you will have to either interleave the data before you transfer it, ot transfer the data one row of characters at a time.
The sprite tool only supports non-interlaced GIF89a image files with a global color table of up to 16 colors and a single image of up to 128×128 pixels. 24-bit RGB colors are converted to 15-bit RGB.