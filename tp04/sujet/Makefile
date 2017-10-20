CC = mipsel-unknown-elf-gcc
AS = mipsel-unknown-elf-as
LD = mipsel-unknown-elf-ld
DU = mipsel-unknown-elf-objdump

SYS_OBJS = reset.o \
		   giet.o \
		   common.o \
		   ctx_handler.o \
		   drivers.o \
		   exc_handler.o \
		   irq_handler.o \
		   sys_handler.o

APP_OBJS = stdio.o main.o

GIET = /Infos/lmd/2017/licence/ue/3I004-2017oct/sesi-almo/soft/giet

SYS_PATH = $(GIET)/sys
APP_PATH = $(GIET)/app

SYS_CFLAGS = -Wall -ffreestanding -mno-gpopt -mips32 -I$(SYS_PATH) -I.
APP_CFLAGS = -Wall -ffreestanding -mno-gpopt -mips32 -I$(APP_PATH) -I.

all: sys.bin app.bin

sys.bin : sys.ld $(SYS_OBJS)
	mipsel-unknown-elf-ld -o $@ -T $^

giet.o : $(SYS_PATH)/giet.s
	mipsel-unknown-elf-as -mips32 -o giet.o $(SYS_PATH)/giet.s

reset.o : reset.s
	mipsel-unknown-elf-as -mips32 -o reset.o reset.s

app.bin : app.ld stdio.o main.o
	mipsel-unknown-elf-ld -o $@ -T $^

main.o : main.c
	mipsel-unknown-elf-gcc -ffreestanding -mno-gpopt -mips32 -I$(APP_PATH) -I. -c -o $@ $<

stdio.o : $(APP_PATH)/stdio.c
	mipsel-unknown-elf-gcc -ffreestanding -mno-gpopt -mips32 -I$(APP_PATH) -I. -c -o $@ $<

%.o : $(SYS_PATH)/%.c
	mipsel-unknown-elf-gcc -ffreestanding -mno-gpopt -mips32 -I$(SYS_PATH) -I. -c -o $@ $<

sys.bin.txt : sys.bin
	mipsel-unknown-elf-objdump -D sys.bin > sys.bin.txt

%.o.txt : %.o
	mipsel-unknown-elf-objdump -D $< > $@

clean:
	rm -f *.o *.bin proc0* *.txt

