all: flex yacc compile start present

debug: flex-d yacc-d compile test

flex-d: mjs2dot.l
	flex -d mjs2dot.l
yacc-d: mjs2dot.y
	yacc -dtv mjs2dot.y
flex: mjs2dot.l
	flex mjs2dot.l
yacc: mjs2dot.y
	yacc -d mjs2dot.y
compile: lex.yy.c y.tab.c
	gcc -Wno-all lex.yy.c y.tab.c -o run.out
start: run.out test.txt 
	./run.out < test.txt > result.txt
present: test.txt result.txt
	echo -e '\nINPUT(MermaidJS):';cat test.txt;echo -e '\nOUTPUT(Graphviz):';cat result.txt
test: run.out test.txt
	./run.out < test.txt 
clean: 
	rm lex.yy.c run.out y.tab.c y.tab.h
