# Makefile for sensord
CXX = g++-8

# Some compiler stuff and flags
CFLAGS += -g -Wall
EXECUTABLE = variod
_OBJ = audiovario.o variod.o cmdline_parser.o configfile_parser.o nmea_parser.o stf.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))
OBJ_CAL = $(patsubst %,$(ODIR)/%,$(_OBJ_CAL))
LIBS = -lasound -lm -lpthread
ODIR = obj
BINDIR = /opt/bin
CONFDIR = /opt/conf
systemd_unitdir = /lib/systemd/system

#targets

$(ODIR)/%.o: %.c
	mkdir -p $(ODIR)
	$(CXX) -c -o $@ $< $(CFLAGS)

all: variod

doc:
	@echo Running doxygen to create documentation
	doxygen

variod: $(OBJ)
	$(CXX) -g -o $@ $^ $(LIBS)

install: variod variod.conf
	install -d $(BINDIR) $(CONFDIR)
	install $(EXECUTABLE) $(BINDIR)
	install variod.conf $(CONFDIR)
	install -d $(systemd_unitdir)
	install -m 0644 variod.service $(systemd_unitdir)

uninstall:
	$(RM) -f $(BINDIR)/$(EXECUTABLE) $(CONFDIR)/variod.conf \
		$(systemd_unitdir)/variod.service

clean:
	rm -f $(ODIR)/*.o *~ core $(EXECUTABLE)
	rm -fr doc

.PHONY: clean all doc
