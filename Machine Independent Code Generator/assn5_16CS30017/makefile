tests: a.out
	./a.out < assign5_16CS30017_test1.c > assign5_16CS30017_quads1.out
	./a.out < assign5_16CS30017_test2.c > assign5_16CS30017_quads2.out
	./a.out < assign5_16CS30017_test3.c > assign5_16CS30017_quads3.out
	./a.out < assign5_16CS30017_test4.c > assign5_16CS30017_quads4.out
	./a.out < assign5_16CS30017_test5.c > assign5_16CS30017_quads5.out


a.out: y.tab.o lex.yy.o assign5_16CS30017_translator.o
	g++ lex.yy.o y.tab.o assign5_16CS30017_translator.o -lfl

assign5_16CS30017_translator.o: assign5_16CS30017_translator.cxx assign5_16CS30017_translator.h
	g++ -c assign5_16CS30017_translator.h
	g++ -c assign5_16CS30017_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.c: assign5_16CS30017.l y.tab.h assign5_16CS30017_translator.h
	flex assign5_16CS30017.l

y.tab.c: assign5_16CS30017.y
	yacc -dtv assign5_16CS30017.y -W

y.tab.h: assign5_16CS30017.y
	yacc -dtv assign5_16CS30017.y -W

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o assign5_16CS30017_translator.o a.out y.output

ctests:
	rm assign5_16CS30017_quads1.out assign5_16CS30017_quads2.out assign5_16CS30017_quads3.out assign5_16CS30017_quads4.out assign5_16CS30017_quads5.out
