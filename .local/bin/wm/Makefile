BIN = getxkbmap

CC = c99
CFLAGS = -Wall -Wextra -pedantic
LDFLAGS = -lX11 -lxkbfile

.PHONY: all
all: $(BIN)

.PHONY: clean
clean:
	$(RM) $(BIN)
