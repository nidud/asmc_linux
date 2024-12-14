#
# Makefile for Asmc
#

all: asmc clean

asmc:
	gcc -c src/*.s && gcc -Wl,-pie,-z,now,-z,noexecstack -s -o $@ *.o

clean:
	rm *.o

install:
	sudo install ./asmc /usr/bin

uninstall:
	sudo rm -f /usr/bin/asmc
