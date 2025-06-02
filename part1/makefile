CC = gcc
GCOV = gcov
CFLAGS = -g -Wall -fprofile-arcs -ftest-coverage
LDFLAGS = -lgcov
# This Makefile is used to compile a C program with gcov support for code coverage analysis.

main : main.o
	$(CC) $(CFLAGS) -o main main.o
main.o : main.c
	$(CC) $(CFLAGS) -c main.c
clean :
	rm -f *.o main *.gcno *.gcda *.gcov
run : main
	./main
coverage :
	$(GCOV) main.c
	cat *.gcov


.PHONY : clean coverage
# This is a simple Makefile for compiling a C program.