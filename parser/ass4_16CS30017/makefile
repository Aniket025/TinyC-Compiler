a.out: lex.yy.o y.tab.o ass4_16CS30017_main.o
	gcc lex.yy.o y.tab.o ass4_16CS30017_main.o -lfl

lex.yy.c: ass4_16CS30017.l y.tab.h
		flex ass4_16CS30017.l

y.tab.c: ass4_16CS30017.y
			yacc -dtv ass4_16CS30017.y -W

ass4_16CS30017_main.o: ass4_16CS30017_main.c
	gcc -c ass4_16CS30017_main.c

y.tab.h: ass4_16CS30017.y
		yacc -dtv ass4_16CS30017.y -W

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

y.tab.o: y.tab.c
	gcc -c y.tab.c

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass4_16CS30017_main.o y.output a.out

test:
	./a.out < ass4_16CS30017_test1.c
