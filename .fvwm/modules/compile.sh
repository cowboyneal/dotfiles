#1/bin/sh

gcc -O2 -I/usr/include/X11 -L/usr/lib \
    -o FvwmTransFocus FvwmTransFocus.c -lX11
