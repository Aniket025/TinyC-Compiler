
a.out: main.o libmyl.a
	gcc main.o -L. -lmyl

main.o: main.c myl.o
	gcc -c main.c

libmyl.a: myl.o
	ar -rcs libmyl.a myl.o

myl.o: ass2_16CS30017.c myl.h
	gcc -c ass2_16CS30017.c -o myl.o

clean:
	rm a.out main.o libmyl.a myl.o

