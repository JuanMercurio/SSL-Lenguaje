
# Files 
BINARY     = parser 
BISONCFILE = $(GENDIR)/parser.c
BISONHFILE = $(GENDIR)/parser.h
LEXCFILE   = $(GENDIR)/lex.c
PARSER     = $(SRCDIR)/parser.y
SCANNER    = $(SRCDIR)/scanner.l

# Directories
SRCDIR=src
BINDIR=bin
GENDIR=.gen

# Compiler options
CC = gcc
CFLAGS = -lfl -ly

# ===========================================================

all: $(BISONCFILE) $(LEXCFILE) 
	gcc $(LEXCFILE) $(BISONCFILE) $(CFLAGS) -o $(BINARY) 

$(LEXCFILE): $(SCANNER)
	@flex -o $(LEXCFILE) $(SCANNER)

$(BISONCFILE):$(PARSER) $(GENDIR)
	@bison -d $(PARSER) -o $(BISONCFILE) 

$(GENDIR):
	mkdir $(GENDIR) 

clean: 
	rm -fr $(GENDIR) $(BINARY)

.PHONY: all clean


