CYTHON = cython
CC = gcc
STRIP = strip

PYCFLAGS = $(shell pkg-config --cflags python3)
CFLAGS = -shared -fPIC -O3 -Wall -D_FORTIFY_SOURCE=1 -march=native -mtune=native

PYX_SRC = $(wildcard *.pyx)
PYX_C = $(patsubst %.pyx, build/%.c, $(PYX_SRC))
PYX_SO = $(patsubst %.pyx, build/%.so, $(PYX_SRC))

PY = $(wildcard *.py)

all: build $(PYX_SO)
	cp $(PY) build/

build:
	mkdir -p build

build/%.so: build/%.c
	$(CC) $(PYCFLAGS) $(CFLAGS) $< -o $@
	$(STRIP) $@

build/%.c: %.pyx
	$(CYTHON) -3 $< -o $@

#.SECONDARY: $(PYX_C)

clean:
	rm -rf build