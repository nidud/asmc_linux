#
# Makefile for Asmc
#

.PHONY: asmc

all: asmc clean

asmc:
	gcc -c src/*.s && gcc -Wl,-pie,-z,now,-z,noexecstack -s -o $@ *.o

clean:
	rm -f *.o

distclean:
	rm -f *.o asmc

install:
	sudo install ./asmc /usr/bin

uninstall:
	sudo rm -f /usr/bin/asmc
