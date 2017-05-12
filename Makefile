CC = gcc

BINDIR = _build
OBJDIR = obj
SRCDIR = .
INCDIR = .
CFLAGS = -Wall -g
INC = -I $(INCDIR)

SRC = test.c
OBJ = $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRC))

CROSSOFLAGS = -ocamlc '-toolchain arm ocamlc' -ocamldep '-toolchain arm ocamldep' -ocamlopt '-toolchain arm ocamlopt'
.PHONY: all libtest clean

all: libtest.so test.native

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) -fPIC $(CFLAGS) $(INC) -c -o $@ $^

libtest.so: $(OBJ)
	mkdir -p $(BINDIR)
	mkdir -p $(OBJDIR)
	gcc -shared -o $(BINDIR)/$@ $^

test.native: test.ml
	ocamlbuild -use-ocamlfind -lflags -cclib,-ltest,-cclib,-L. $@

crossarm: test.ml
	ocamlbuild -use-ocamlfind $(CROSSFLAGS) -lflags -cclib,-ltest,-cclib,-L. test.native

test:
	LD_LIBRARY_PATH=./_build ./test.native

clean:
	rm -rf $(BINDIR) $(OBJDIR) test.native

	

	

