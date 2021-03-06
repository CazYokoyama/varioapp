# Makefile for sensord
#Some compiler stuff and flags
CFLAGS += -g -Wall
EXECUTABLE = variod
_OBJ = audiovario.o variod.o cmdline_parser.o configfile_parser.o nmea_parser.o stf.o 
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))
OBJ_CAL = $(patsubst %,$(ODIR)/%,$(_OBJ_CAL))
LIBS = -lasound -lm -lpthread
ODIR = obj
BINDIR = /opt/bin/

#targets

$(ODIR)/%.o: %.c
	mkdir -p $(ODIR)
	$(CXX) -c -o $@ $< $(CFLAGS)

all: variod
	
doc: 
	@echo Running doxygen to create documentation
	doxygen
	
variod: $(OBJ)
	$(CXX) $(LIBS) -g -o $@ $^
	
install: variod
	install -D variod $(BINDIR)/$(EXECUTABLE)
	
clean:
	rm -f $(ODIR)/*.o *~ core $(EXECUTABLE)
	rm -fr doc

.PHONY: clean all doc	
