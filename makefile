ASM=gcc
ASMFLAGS=-c
LINK=gcc

all: count.out fact.out

count.out: count.o
	${LINK} $< -o $@
count.o: count.s
	${ASM} ${ASMFLAGS} $< -o $@

fact.out: fact.o
	${LINK} $< -o $@
fact.o: fact.s
	${ASM} ${ASMFLAGS} $< -o $@

clean:
	rm -r -f *.o *.out
