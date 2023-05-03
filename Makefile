all: deps gitclone setup build

deps:
	sudo apt install autoconf2.69

gitclone:
	git clone https://gcc.gnu.org/git/gcc.git

setup:
	cd gcc && ./contrib/download_prerequisites && git checkout releases/gcc-12.2.0 && git apply ../gcc-kot.diff
	cd gcc/libstdc++-v3 && autoconf2.69
	cp kot.h gcc/gcc/config/kot.h

build:
	mkdir -m 777 -p "Bin"
	sudo mkdir -m 777 -p "/usr/kot"
	cd Bin && ../gcc/configure --target=x86_64-kot --prefix="$(shell pwd)/Bin" --disable-nls --enable-languages=c,c++  --with-newlib --with-sysroot="/usr/kot" && make all-gcc

github-action: all