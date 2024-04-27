#1/bin/sh

gcc -O2 -I/usr/include/X11 -L/usr/lib -lX11 \
    -o FvwmTransFocus FvwmTransFocus.c
