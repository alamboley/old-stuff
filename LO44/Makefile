COMPIL = gcc
FLAGS = -lm -Wall -O2 -g
SOURCES = src/algorithme.c src/traitement.c src/main.c
PROG = projet

$(PROG):$(SOURCES)
	$(COMPIL) $(FLAGS) -o $(PROG) $(SOURCES)
%.o:%.c
	$(COMPIL) -c $*.c
	$(COMPIL) -c src/$*.c

clean:
	@rm -f $(PROG) *.o
