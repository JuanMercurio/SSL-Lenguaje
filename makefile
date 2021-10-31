BIN = Parser 
LEXOUTPUTFILE = lex.c
SCANNER = scanner.l
PARSER = parser.y
OUTPUTFILE = output.txt 
INPUTFILE = prueba.lenguaje 
BISONOUTPUTFILE = parser.tab.c

all: $(BIN) 

run: $(BIN)
	@echo
	@rm -fr $(BISONOUTPUTFILE) $(LEXOUTPUTFILE) parser.tab.h
	./$(BIN) $(INPUTFILE) 
	@echo

clean: 
	rm -fr $(BIN) $(BISONOUTPUTFILE) $(LEXOUTPUTFILE) parser.tab.h

$(BIN): $(LEXOUTPUTFILE) $(BISONOUTPUTFILE)
	@echo
	gcc $(LEXOUTPUTFILE) $(BISONOUTPUTFILE) -lfl -ly -o $(BIN) 

$(LEXOUTPUTFILE): $(SCANNER)
	@flex -o $(LEXOUTPUTFILE) $(SCANNER)

$(BISONOUTPUTFILE):$(PARSER)
	@bison -d $(PARSER)
.PHONY: all clean

