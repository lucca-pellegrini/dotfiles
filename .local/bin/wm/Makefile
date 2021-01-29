CC = c99
CFLAGS = -Wall -Wextra -pedantic

.PHONY: all
all: getxkbmap

.PHONY: clean
clean:
	$(RM) getxkbmap

getxkbmap: getxkbmap.c
	$(CC) $(CFLAGS) -o getxkbmap -lX11 -lxkbfile getxkbmap.c
